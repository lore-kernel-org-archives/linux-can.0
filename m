From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Thu, 24 Jul 2014 13:33:48 +0200
Message-ID: <53D0EF1C.4010909@pengutronix.de>
References: <1406196706-4548-1-git-send-email-sbabic@denx.de> <1406196706-4548-4-git-send-email-sbabic@denx.de> <53D0ED0C.4080400@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ml1RaxrQ6OS6MhWEjwjpKoRwI9JEtQIgM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57287 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbaGXLd4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Jul 2014 07:33:56 -0400
In-Reply-To: <53D0ED0C.4080400@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ml1RaxrQ6OS6MhWEjwjpKoRwI9JEtQIgM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2014 01:25 PM, Varka Bhadram wrote:
> On 07/24/2014 03:41 PM, Stefano Babic wrote:
>=20
> (...)
>=20
>> +#include <linux/netdevice.h>
>> +#include <linux/can.h>
>> +#include <linux/can/dev.h>
>> +#include <linux/can/error.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/mutex.h>
>> +#include <linux/wait.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/kthread.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/can/platform/spi_can.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/gpio.h>
>> +#include <linux/net_tstamp.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_gpio.h>
>> +
>=20
> It looks good if all headers sorted in alphabetical order..  :-)
>=20
>> +#define MAX_CAN_CHANNELS    16
>> +#define CFG_CHANNEL        0xFF
>> +#define DRV_NAME        "spican"
>> +#define DRV_VERSION        "0.10"
>> +
>> +/* SPI constants */
>> +#define SPI_MAX_FRAME_LEN    1472    /* max total length of a SPI
>> frame */
>> +#define BITS_X_WORD        32    /* 4 bytes */
>> +#define SPI_MIN_TRANSFER_LENGTH    32    /* Minimum SPI frame length =
*/
>> +#define CAN_FRAME_MAX_DATA_LEN    8    /* max data lenght in a CAN
>> message */
>> +#define MAX_ITERATIONS        100    /* Used to check if GPIO stucks =
*/
>> +#define SPI_CAN_ECHO_SKB_MAX    4
>> +#define SLAVE_CLK_FREQ        100000000
>> +#define SLAVE_SUPERVISOR_FREQ    ((u32)1000000)
>> +
>> +#define IS_GPIO_ACTIVE(p)    (!!gpio_get_value(p->gpio) =3D=3D
>> p->gpio_active)
>> +#define MS_TO_US(ms)        ((ms) * 1000)
>> +
>> +/* more RX buffers are required for delayed processing */
>> +#define    SPI_RX_NBUFS        MAX_CAN_CHANNELS
>> +
>> +/* Provide a way to disable checksum */
>> +static unsigned int chksum_en =3D 1;
>> +
>> +static unsigned int freq;
>> +module_param(freq, uint, 0);
>> +MODULE_PARM_DESC(freq,
>> +    "SPI clock frequency (default is set by platform device)");
>> +static unsigned int slow_freq;
>> +module_param(slow_freq, uint, 0);
>> +MODULE_PARM_DESC(slow_freq,
>> +    "SPI clock frequency to be used in supervisor mode (default 1
>> Mhz)");
>> +
>> +/* CAN channel status to drop not required frames */
>> +enum {
>> +    CAN_CHANNEL_DISABLED =3D 0,
>> +    CAN_CHANNEL_ENABLED    =3D 1,
>> +};
>> +
>> +/* operational mode to set the SPI frequency */
>> +enum {
>> +    SLAVE_SUPERVISOR_MODE    =3D 0,
>> +    SLAVE_USER_MODE        =3D 1,
>> +};
>> +
>> +/* Message between Master and Slave
>> + *
>> + * see spi_can_spi.txt for details
>> + *
>> + *    ,'''''''','''''''''''''''','''''''''''''''''''''''','''''''''''=
''|
>> + *    |MSG ID  |  Length(16 bit)|    DATA                |  CHECKSUM =
  |
>> + *    L________|________________|________________________|___________=
__|
>> + */
>> +struct spi_can_frame_header {
>> +    u8    msgid;
>> +    u16    length;
>> +} __packed;
>> +
>> +struct spi_can_frame {
>> +    struct spi_can_frame_header    header;
>> +    u8    data[1];
>> +} __packed;
>> +
>> +/* Message IDs for SPI Frame */
>> +enum msg_type {
>> +    SPI_MSG_STATUS_REQ    =3D 0x01,
>> +    SPI_MSG_SEND_DATA    =3D 0x02,
>> +    SPI_MSG_SYNC        =3D 0x03,
>> +    SPI_MSG_CFG_SET        =3D 0x04,
>> +    SPI_MSG_REQ_DATA    =3D 0x05,
>> +    SPI_MSG_CFG_GET        =3D 0x06
>> +};
>> +
>> +/* CAN data sent inside a
>> + * SPI_MSG_SEND_DATA message
>> + *
>> + *  _____,________________
>> + * |     |                ,''''''''''''''''',''''''''''''|     =20
>> ,'''''''|
>> + * |ID=3D2 | LENGTH         | CAN MESSAGE     |CAN MESSAGE |     =20
>> |CHECKSUM
>> + * |_____L________________|_________________|____________|     =20
>> L_______|
>> + *                    _.-'                  `--._
>> + *               _,,-'                           ``-.._
>> + *           _.-'                                      `--._
>> + *      _,--'                                               ``-.._
>> + *  ,.-'                                                          `-.=
=2E_
>> + *  ,'''''',''''''''''''','''''''''''''','''''',''''''|     ,''''''''=
'|
>> + *  | CH   |TIMESTAMP    |  CAN ID      |DLC   |D[0]  |     |D[dlc-1]=
 |
>> + *  L______L_____________|______________L______|______|     L________=
_|
>> + */
>> +
>> +struct msg_channel_data {
>> +    u8    channel;
>> +    u32    timestamp;
>> +    u32    can_id;
>> +    u8    dlc;
>> +    u8    data[8];
>> +} __packed;
>> +
>> +/* CFG message */
>> +struct msg_cfg_set_data {
>> +    u8    channel;
>> +    u8    enabled;
>> +    struct can_bittiming bt;
>> +} __packed;
>> +
>> +struct msg_cfg_get_data {
>> +    u8    channel;
>> +    u8    tseg1_min;
>> +    u8    tseg1_max;
>> +    u8    tseg2_min;
>> +    u8    tseg2_max;
>> +    u8    sjw_max;
>> +    u32    brp_min;
>> +    u32    brp_max;
>> +    u32    brp_inc;
>> +    u8    ctrlmode;
>> +    u32    clock_hz;
>> +} __packed;
>> +
>> +/* Status message */
>> +struct msg_status_data {
>> +    u16    length;
>> +} __packed;
>> +
>> +/* The ndo_start_xmit entry point
>> + * insert the CAN messages into a list that
>> + * is then read by the working thread.
>> + */
>> +struct msg_queue_tx {
>> +    struct list_head    list;
>> +    u32            channel;
>> +    u32            enabled;
>> +    struct sk_buff        *skb;
>> +    enum msg_type        type;
>> +};
>> +
>> +struct msg_queue_rx {
>> +    struct list_head    list;
>> +    struct spi_can_frame    *frame;
>> +    u32            len;
>> +    u32            bufindex;
>> +};
>> +
>> +struct spi_rx_data {
>> +    u8 __aligned(4) spi_rx_buf[SPI_MAX_FRAME_LEN];
>> +    u32        msg_in_buf;
>> +    struct mutex    bufmutex;
>> +};
>> +
>> +/* Private data for the SPI device. */
>> +struct spi_can_data {
>> +    struct spi_device    *spi;
>> +    u32            gpio;
>> +    u32            gpio_active;
>> +    u32            num_channels;
>> +    u32            freq;
>> +    u32            slow_freq;
>> +    u32            max_freq;
>> +    u32            slave_op_mode;
>> +    struct net_device    *can_dev[MAX_CAN_CHANNELS + 1];
>> +    spinlock_t        lock;
>> +    struct msg_queue_tx    msgtx;
>> +    struct msg_queue_rx    msgrx;
>> +    struct mutex        lock_wqlist;
>> +    wait_queue_head_t    wait;
>> +    struct workqueue_struct *wq;
>> +    struct work_struct    work;
>> +    /* buffers must be 32-bit aligned  ! */
>> +    u8 __aligned(4)        spi_tx_buf[SPI_MAX_FRAME_LEN];
>> +    struct spi_rx_data    rx_data[SPI_RX_NBUFS];
>> +    struct timeval        ref_time;
>> +};
>> +
>> +/* Private data of the CAN devices */
>> +struct spi_can_priv {
>> +    struct can_priv        can;
>> +    struct net_device    *dev;
>> +    struct spi_can_data    *spi_priv;
>> +    struct can_bittiming_const spi_can_bittiming_const;
>> +    u32            channel;
>> +    u32            devstatus;
>> +    u32            ctrlmode;
>> +};
>> +
>=20
> better to move all these into new local header file ...

Nope, as long as these structs are only used in this file, keep it here.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Ml1RaxrQ6OS6MhWEjwjpKoRwI9JEtQIgM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPQ7xwACgkQjTAFq1RaXHNkVgCfYo2LdkoKvALz4ciu3FzQGCod
jugAnRk0ceHE3OntqBf211sSBEwv9JJV
=IWMD
-----END PGP SIGNATURE-----

--Ml1RaxrQ6OS6MhWEjwjpKoRwI9JEtQIgM--
