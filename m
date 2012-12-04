From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 04 Dec 2012 22:45:50 +0100
Message-ID: <50BE6F0E.80308@pengutronix.de>
References: <50BE6092.9050602@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB9AEB48178B72FD5B642FCB5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56591 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab2LDVqA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Dec 2012 16:46:00 -0500
In-Reply-To: <50BE6092.9050602@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9AEB48178B72FD5B642FCB5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/04/2012 09:44 PM, krumboeck@universalnet.at wrote:
> Add device driver for USB2CAN interface from "8 devices"
> (http://www.8devices.com).

Please use git send-email to send patches, your mailer does strange thing=
s.

>=20
> Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>
> ---
>  drivers/net/can/usb/Kconfig    |    6 +
>  drivers/net/can/usb/Makefile   |    1 +
>  drivers/net/can/usb/usb_8dev.c | 1093
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1100 insertions(+)
>  create mode 100644 drivers/net/can/usb/usb_8dev.c
>=20
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index a4e4bee..2162233 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -48,4 +48,10 @@ config CAN_PEAK_USB
>        This driver supports the PCAN-USB and PCAN-USB Pro adapters
>        from PEAK-System Technik (http://www.peak-system.com).
>  +config CAN_8DEV_USB
> +    tristate "8 devices USB2CAN interface"
> +    ---help---
> +      This driver supports the USB2CAN interface
> +      from 8 devices (http://www.8devices.com).
> +
>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefil=
e
> index 80a2ee4..becef46 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -6,5 +6,6 @@ obj-$(CONFIG_CAN_EMS_USB) +=3D ems_usb.o
>  obj-$(CONFIG_CAN_ESD_USB2) +=3D esd_usb2.o
>  obj-$(CONFIG_CAN_KVASER_USB) +=3D kvaser_usb.o
>  obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb/
> +obj-$(CONFIG_CAN_8DEV_USB) +=3D usb_8dev.o
>   ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
> diff --git a/drivers/net/can/usb/usb_8dev.c
> b/drivers/net/can/usb/usb_8dev.c
> new file mode 100644
> index 0000000..9202a12
> --- /dev/null
> +++ b/drivers/net/can/usb/usb_8dev.c
> @@ -0,0 +1,1093 @@
> +/*
> + * CAN driver for "8 devices" USB2CAN converter
> + *
> + * Copyright (C) 2012 Bernd Krumboeck (krumboeck@universalnet.at)
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but=

> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License a=
long
> + * with this program; if not, write to the Free Software Foundation, I=
nc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + * This driver is inspired by the 3.2.0 version of
> drivers/net/can/usb/ems_usb.c
> + * and drivers/net/can/usb/esd_usb2.c
> + *
> + * Many thanks to Gerhard Bertelsmann (info@gerhard-bertelsmann.de)
> + * for testing and fixing this driver. Also many thanks to "8 devices"=
,
> + * who were very cooperative and answered my questions.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/signal.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/usb.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +
> +/* driver constants */
> +#define MAX_RX_URBS            10
> +#define MAX_TX_URBS            10
> +#define RX_BUFFER_SIZE            64
> +
> +/* vendor and product id */
> +#define USB_8DEV_VENDOR_ID        0x0483
> +#define USB_8DEV_PRODUCT_ID        0x1234
> +
> +/* endpoints */
> +enum usb_8dev_endpoint {
> +    USB_8DEV_ENDP_DATA_RX =3D 1,
> +    USB_8DEV_ENDP_DATA_TX,
> +    USB_8DEV_ENDP_CMD_RX,
> +    USB_8DEV_ENDP_CMD_TX
> +};
> +
> +/* bittiming constants */
> +#define USB_8DEV_ABP_CLOCK        32000000
> +#define USB_8DEV_BAUD_MANUAL        0x09
> +#define USB_8DEV_TSEG1_MIN        1
> +#define USB_8DEV_TSEG1_MAX        16
> +#define USB_8DEV_TSEG2_MIN        1
> +#define USB_8DEV_TSEG2_MAX        8
> +#define USB_8DEV_SJW_MAX        4
> +#define USB_8DEV_BRP_MIN        1
> +#define USB_8DEV_BRP_MAX        1024
> +#define USB_8DEV_BRP_INC        1
> +
> +/* setup flags */
> +#define USB_8DEV_SILENT            0x01
> +#define USB_8DEV_LOOPBACK        0x02
> +#define USB_8DEV_DISABLE_AUTO_RESTRANS    0x04
> +#define USB_8DEV_STATUS_FRAME        0x08
> +
> +/* commands */
> +enum usb_8dev_cmd {
> +    USB_8DEV_RESET =3D 1,
> +    USB_8DEV_OPEN,
> +    USB_8DEV_CLOSE,
> +    USB_8DEV_SET_SPEED,
> +    USB_8DEV_SET_MASK_FILTER,
> +    USB_8DEV_GET_STATUS,
> +    USB_8DEV_GET_STATISTICS,
> +    USB_8DEV_GET_SERIAL,
> +    USB_8DEV_GET_SOFTW_VER,
> +    USB_8DEV_GET_HARDW_VER,
> +    USB_8DEV_RESET_TIMESTAMP,
> +    USB_8DEV_GET_SOFTW_HARDW_VER
> +};
> +
> +#define USB_8DEV_CMD_START        0x11
> +#define USB_8DEV_CMD_END        0x22
> +
> +#define USB_8DEV_CMD_SUCCESS        0
> +#define USB_8DEV_CMD_ERROR        255
> +
> +#define USB_8DEV_CMD_TIMEOUT        1000
> +
> +/* frames */
> +#define USB_8DEV_DATA_START        0x55
> +#define USB_8DEV_DATA_END        0xAA
> +
> +#define USB_8DEV_TYPE_CAN_FRAME        0
> +#define USB_8DEV_TYPE_ERROR_FRAME    3
> +
> +#define USB_8DEV_EXTID            0x01
> +#define USB_8DEV_RTR            0x02
> +#define USB_8DEV_ERR_FLAG        0x04
> +
> +/* status */
> +#define USB_8DEV_STATUSMSG_OK        0x00  /* Normal condition. */
> +#define USB_8DEV_STATUSMSG_OVERRUN    0x01  /* Overrun occured when
> sending */
> +#define USB_8DEV_STATUSMSG_BUSLIGHT    0x02  /* Error counter has
> reached 96 */
> +#define USB_8DEV_STATUSMSG_BUSHEAVY    0x03  /* Error count. has
> reached 128 */
> +#define USB_8DEV_STATUSMSG_BUSOFF    0x04  /* Device is in BUSOFF */
> +#define USB_8DEV_STATUSMSG_STUFF    0x20  /* Stuff Error */
> +#define USB_8DEV_STATUSMSG_FORM        0x21  /* Form Error */
> +#define USB_8DEV_STATUSMSG_ACK        0x23  /* Ack Error */
> +#define USB_8DEV_STATUSMSG_BIT0        0x24  /* Bit1 Error */
> +#define USB_8DEV_STATUSMSG_BIT1        0x25  /* Bit0 Error */
> +#define USB_8DEV_STATUSMSG_CRC        0x26  /* CRC Error */
> +
> +#define USB_8DEV_RP_MASK        0x7F  /* Mask for Receive Error Bit */=

> +
> +
> +/* table of devices that work with this driver */
> +static const struct usb_device_id usb_8dev_table[] =3D {
> +    { USB_DEVICE(USB_8DEV_VENDOR_ID, USB_8DEV_PRODUCT_ID) },
> +    { }                    /* Terminating entry */
> +};
> +
> +MODULE_DEVICE_TABLE(usb, usb_8dev_table);
> +
> +struct usb_8dev_tx_urb_context {
> +    struct usb_8dev *dev;
> +
> +    u32 echo_index;
> +    u8 dlc;
> +};
> +
> +/* Structure to hold all of our device specific stuff */
> +struct usb_8dev {
> +    struct can_priv can; /* must be the first member */
> +
> +    struct sk_buff *echo_skb[MAX_TX_URBS];
> +
> +    struct usb_device *udev;
> +    struct net_device *netdev;
> +
> +    atomic_t active_tx_urbs;
> +    struct usb_anchor tx_submitted;
> +    struct usb_8dev_tx_urb_context tx_contexts[MAX_TX_URBS];
> +
> +    struct usb_anchor rx_submitted;
> +
> +    struct can_berr_counter bec;
> +
> +    u8 *cmd_msg_buffer;
> +
> +    unsigned int free_slots; /* remember number of available slots */
> +
> +    struct mutex usb_8dev_cmd_lock;
> +
> +};
> +
> +/* tx frame */
> +struct __packed usb_8dev_tx_msg {
> +    u8 begin;
> +    u8 flags;    /* RTR and EXT_ID flag */
> +    __be32 id;    /* upper 3 bits not used */
> +    u8 dlc;        /* data length code 0-8 bytes */
> +    u8 data[8];    /* 64-bit data */
> +    u8 end;
> +};
> +
> +/* rx frame */
> +struct __packed usb_8dev_rx_msg {
> +    u8 begin;
> +    u8 type;        /* frame type */
> +    u8 flags;        /* RTR and EXT_ID flag */
> +    __be32 id;        /* upper 3 bits not used */
> +    u8 dlc;            /* data length code 0-8 bytes */
> +    u8 data[8];        /* 64-bit data */
> +    __be32 timestamp;    /* 32-bit timestamp */
> +    u8 end;
> +};
> +
> +/* command frame */
> +struct __packed usb_8dev_cmd_msg {
> +    u8 begin;
> +    u8 channel;    /* unkown - always 0 */
> +    u8 command;    /* command to execute */
> +    u8 opt1;    /* optional parameter / return value */
> +    u8 opt2;    /* optional parameter 2 */
> +    u8 data[10];    /* optional parameter and data */
> +    u8 end;
> +};
> +
> +static struct usb_driver usb_8dev_driver;

There should be no need for this forward declaration.

> +
> +static int usb_8dev_send_cmd_msg(struct usb_8dev *dev, u8 *msg, int si=
ze)
> +{
> +    int actual_length;
> +
> +    return usb_bulk_msg(dev->udev,
> +                usb_sndbulkpipe(dev->udev, USB_8DEV_ENDP_CMD_TX),
> +                msg, size, &actual_length, USB_8DEV_CMD_TIMEOUT);
> +}
> +
> +static int usb_8dev_wait_cmd_msg(struct usb_8dev *dev, u8 *msg, int si=
ze,
> +                int *actual_length)
> +{
> +    return usb_bulk_msg(dev->udev,
> +                usb_rcvbulkpipe(dev->udev, USB_8DEV_ENDP_CMD_RX),
> +                msg, size, actual_length, USB_8DEV_CMD_TIMEOUT);
> +}
> +
> +/*
> + * Send command to device and receive result.
> + * Command was successful when opt1 =3D 0.
> + */
> +static int usb_8dev_send_cmd(struct usb_8dev *dev, struct
> usb_8dev_cmd_msg *out,
> +                struct usb_8dev_cmd_msg *in)
> +{
> +    int err;
> +    int num_bytes_read;
> +    struct net_device *netdev;
> +
> +    netdev =3D dev->netdev;
> +
> +    out->begin =3D USB_8DEV_CMD_START;
> +    out->end =3D USB_8DEV_CMD_END;
> +
> +    mutex_lock(&dev->usb_8dev_cmd_lock);
> +
> +    memcpy(dev->cmd_msg_buffer, out,
> +        sizeof(struct usb_8dev_cmd_msg));
> +
> +    err =3D usb_8dev_send_cmd_msg(dev, dev->cmd_msg_buffer,
> +                    sizeof(struct usb_8dev_cmd_msg));
> +    if (err < 0) {
> +        netdev_err(netdev, "sending command message failed\n");
> +        return err;
> +    }
> +
> +    err =3D usb_8dev_wait_cmd_msg(dev, dev->cmd_msg_buffer,
> +                    sizeof(struct usb_8dev_cmd_msg),
> +                    &num_bytes_read);
> +    if (err < 0) {
> +        netdev_err(netdev, "no command message answer\n");
> +        return err;
> +    }
> +
> +    memcpy(in, dev->cmd_msg_buffer, sizeof(struct usb_8dev_cmd_msg));
> +
> +    mutex_unlock(&dev->usb_8dev_cmd_lock);
> +
> +    if (in->begin !=3D USB_8DEV_CMD_START || in->end !=3D USB_8DEV_CMD=
_END ||
> +            num_bytes_read !=3D 16 || in->opt1 !=3D 0)
> +        return -EPROTO;
> +
> +    return 0;
> +}
> +
> +/* Send open command to device */
> +static int usb_8dev_cmd_open(struct usb_8dev *dev)
> +{
> +    struct can_bittiming *bt =3D &dev->can.bittiming;
> +    struct usb_8dev_cmd_msg outmsg;
> +    struct usb_8dev_cmd_msg inmsg;
> +    u32 flags =3D 0;
> +    u32 beflags;
> +    u16 bebrp;
> +    u32 ctrlmode =3D dev->can.ctrlmode;
> +
> +    if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +        flags |=3D USB_8DEV_LOOPBACK;
> +    if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +        flags |=3D USB_8DEV_SILENT;
> +    if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +        flags |=3D USB_8DEV_DISABLE_AUTO_RESTRANS;
> +
> +    flags |=3D USB_8DEV_STATUS_FRAME;
> +
> +    memset(&outmsg, 0, sizeof(struct usb_8dev_cmd_msg));
> +    outmsg.command =3D USB_8DEV_OPEN;
> +    outmsg.opt1 =3D USB_8DEV_BAUD_MANUAL;
> +    outmsg.data[0] =3D (bt->prop_seg + bt->phase_seg1);
> +    outmsg.data[1] =3D bt->phase_seg2;
> +    outmsg.data[2] =3D bt->sjw;
> +
> +    /* BRP */
> +    bebrp =3D cpu_to_be16((u16) bt->brp);
                                ^
remove this space, please

> +    memcpy(&outmsg.data[3], &bebrp, sizeof(bebrp));
> +
> +    /* flags */
> +    beflags =3D cpu_to_be32(flags);
> +    memcpy(&outmsg.data[5], &beflags, sizeof(beflags));
> +
> +    return usb_8dev_send_cmd(dev, &outmsg, &inmsg);
> +}
> +
> +/* Send close command to device */
> +static int usb_8dev_cmd_close(struct usb_8dev *dev)
> +{
> +    struct usb_8dev_cmd_msg inmsg;
> +    struct usb_8dev_cmd_msg outmsg =3D {
> +        .channel =3D 0,
> +        .command =3D USB_8DEV_CLOSE,
> +        .opt1 =3D 0,
> +        .opt2 =3D 0
> +        };
> +
> +    return usb_8dev_send_cmd(dev, &outmsg, &inmsg);
> +}
> +
> +/* Get firmware and hardware version */
> +static int usb_8dev_cmd_version(struct usb_8dev *dev, u32 *res)
> +{
> +    struct usb_8dev_cmd_msg    inmsg;
> +    struct usb_8dev_cmd_msg    outmsg =3D {
> +        .channel =3D 0,
> +        .command =3D USB_8DEV_GET_SOFTW_HARDW_VER,
> +        .opt1 =3D 0,
> +        .opt2 =3D 0
> +        };
> +
> +    int err =3D usb_8dev_send_cmd(dev, &outmsg, &inmsg);
> +    if (err)
> +        return err;
> +
> +    *res =3D be32_to_cpu(*(u32 *)inmsg.data);

use be32_to_cpup

> +
> +    return err;
> +}
> +
> +/* Get firmware version */
> +static ssize_t show_firmware(struct device *d, struct device_attribute=

> *attr,
> +                 char *buf)
> +{
> +    struct usb_interface *intf =3D to_usb_interface(d);
> +    struct usb_8dev *dev =3D usb_get_intfdata(intf);
> +    u16 result;
> +    struct usb_8dev_cmd_msg inmsg;
> +    struct usb_8dev_cmd_msg outmsg =3D {
> +        .channel =3D 0,
> +        .command =3D USB_8DEV_GET_SOFTW_VER,
> +        .opt1 =3D 0,
> +        .opt2 =3D 0
> +        };
> +
> +    int err =3D usb_8dev_send_cmd(dev, &outmsg, &inmsg);
> +    if (err)
> +        return -EIO;
> +
> +    result =3D be16_to_cpu(*(u16 *)inmsg.data);

be16_to_cpup

> +
> +    return sprintf(buf, "%d.%d\n", (u8)(result>>8), (u8)result);
> +}
> +
> +/* Get hardware version */
> +static ssize_t show_hardware(struct device *d, struct device_attribute=

> *attr,
> +                 char *buf)
> +{
> +    struct usb_interface *intf =3D to_usb_interface(d);
> +    struct usb_8dev *dev =3D usb_get_intfdata(intf);
> +    u16 result;
> +    struct usb_8dev_cmd_msg inmsg;
> +    struct usb_8dev_cmd_msg outmsg =3D {
> +        .channel =3D 0,
> +        .command =3D USB_8DEV_GET_HARDW_VER,
> +        .opt1 =3D 0,
> +        .opt2 =3D 0
> +        };
> +
> +    int err =3D usb_8dev_send_cmd(dev, &outmsg, &inmsg);
> +    if (err)
> +        return -EIO;
> +
> +    result =3D be16_to_cpu(*(u16 *)inmsg.data);

be16_to_cpup

> +
> +    return sprintf(buf, "%d.%d\n", (u8)(result>>8), (u8)result);
> +}
> +
> +static DEVICE_ATTR(firmware, S_IRUGO, show_firmware, NULL);
> +static DEVICE_ATTR(hardware, S_IRUGO, show_hardware, NULL);
> +
> +/*
> + * Set network device mode
> + *
> + * Maybe we should leave this function empty, because the device
> + * set mode variable with open command.
> + */
> +static int usb_8dev_set_mode(struct net_device *netdev, enum can_mode
> mode)
> +{
> +    struct usb_8dev *dev =3D netdev_priv(netdev);
> +    int err =3D 0;
> +
> +    switch (mode) {
> +    case CAN_MODE_START:
> +        err =3D usb_8dev_cmd_open(dev);
> +        if (err)
> +            netdev_warn(netdev, "couldn't start device");
> +        break;
> +
> +    default:
> +        return -EOPNOTSUPP;
> +    }
> +
> +    return 0;

=2E..you will return 0 in case of a failure.

> +}
> +
> +/* Read data and status frames */
> +static void usb_8dev_rx_can_msg(struct usb_8dev *dev,
> +                struct usb_8dev_rx_msg *msg)
> +{
> +    struct can_frame *cf;
> +    struct sk_buff *skb;
> +    struct net_device_stats *stats =3D &dev->netdev->stats;
> +
> +    if (msg->type =3D=3D USB_8DEV_TYPE_CAN_FRAME) {
> +        skb =3D alloc_can_skb(dev->netdev, &cf);
> +        if (!skb)
> +            return;
> +
> +        cf->can_id =3D be32_to_cpu(msg->id);
> +        cf->can_dlc =3D get_can_dlc(msg->dlc & 0xF);
> +
> +        if (msg->flags & USB_8DEV_EXTID)
> +            cf->can_id |=3D CAN_EFF_FLAG;
> +
> +        if (msg->flags & USB_8DEV_RTR)
> +            cf->can_id |=3D CAN_RTR_FLAG;
> +        else
> +            memcpy(cf->data, msg->data, cf->can_dlc);
> +    } else if (msg->type =3D=3D USB_8DEV_TYPE_ERROR_FRAME &&
> +           msg->flags =3D=3D USB_8DEV_ERR_FLAG) {

can you please move error handling to a sub-function?

> +
> +        /*
> +         * Error message:
> +         * byte 0: Status
> +         * byte 1: bit   7: Receive Passive
> +         * byte 1: bit 0-6: Receive Error Counter
> +         * byte 2: Transmit Error Counter
> +         * byte 3: Always 0 (maybe reserved for future use)
> +         */
> +
> +        u8 state =3D msg->data[0];
> +        u8 rxerr =3D msg->data[1] & USB_8DEV_RP_MASK;
> +        u8 txerr =3D msg->data[2];
> +        int rx_errors =3D 0;
> +        int tx_errors =3D 0;
> +
> +        skb =3D alloc_can_err_skb(dev->netdev, &cf);
> +        if (!skb)
> +            return;
> +
> +        dev->can.can_stats.bus_error++;
> +
> +        switch (state) {
> +        case USB_8DEV_STATUSMSG_OK:
> +            dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +            cf->can_id |=3D CAN_ERR_PROT;
> +            cf->data[2] =3D CAN_ERR_PROT_ACTIVE;
> +            break;
> +        case USB_8DEV_STATUSMSG_BUSOFF:
> +            dev->can.state =3D CAN_STATE_BUS_OFF;
> +            cf->can_id |=3D CAN_ERR_BUSOFF;
> +            can_bus_off(dev->netdev);
> +            break;
> +        case USB_8DEV_STATUSMSG_OVERRUN:
> +        case USB_8DEV_STATUSMSG_BUSLIGHT:
> +        case USB_8DEV_STATUSMSG_BUSHEAVY:
> +            dev->can.state =3D CAN_STATE_ERROR_WARNING;
> +            cf->can_id |=3D CAN_ERR_CRTL;
> +            break;
> +        default:
> +            dev->can.state =3D CAN_STATE_ERROR_WARNING;
> +            cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +            break;
> +        }
> +
> +        switch (state) {
> +        case USB_8DEV_STATUSMSG_ACK:
> +            cf->can_id |=3D CAN_ERR_ACK;
> +            tx_errors =3D 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_CRC:
> +            cf->data[2] |=3D CAN_ERR_PROT_BIT;
> +            rx_errors =3D 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_BIT0:
> +            cf->data[2] |=3D CAN_ERR_PROT_BIT0;
> +            tx_errors =3D 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_BIT1:
> +            cf->data[2] |=3D CAN_ERR_PROT_BIT1;
> +            tx_errors =3D 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_FORM:
> +            cf->data[2] |=3D CAN_ERR_PROT_FORM;
> +            rx_errors =3D 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_STUFF:
> +            cf->data[2] |=3D CAN_ERR_PROT_STUFF;
> +            rx_errors =3D 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_OVERRUN:
> +            cf->data[1] =3D (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_OVERFLOW :
> +                CAN_ERR_CRTL_RX_OVERFLOW;
> +            cf->data[2] |=3D CAN_ERR_PROT_OVERLOAD;
> +            stats->rx_over_errors++;
> +            break;
> +        case USB_8DEV_STATUSMSG_BUSLIGHT:
> +            cf->data[1] =3D (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_WARNING :
> +                CAN_ERR_CRTL_RX_WARNING;
> +            dev->can.can_stats.error_warning++;
> +            break;
> +        case USB_8DEV_STATUSMSG_BUSHEAVY:
> +            cf->data[1] =3D (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_PASSIVE :
> +                CAN_ERR_CRTL_RX_PASSIVE;
> +            dev->can.can_stats.error_passive++;
> +            break;
> +        default:
> +            cf->data[2] |=3D CAN_ERR_PROT_UNSPEC;
> +            break;
> +        }
> +
> +        if (tx_errors) {
> +            cf->data[2] |=3D CAN_ERR_PROT_TX;
> +            stats->tx_errors++;
> +        }
> +
> +        if (rx_errors)
> +            stats->rx_errors++;
> +
> +        cf->data[6] =3D txerr;
> +        cf->data[7] =3D rxerr;
> +
> +        dev->bec.txerr =3D txerr;
> +        dev->bec.rxerr =3D rxerr;
> +
> +    } else {
> +        netdev_warn(dev->netdev, "frame type %d unknown",
> +             msg->type);
> +        return;
> +    }
> +
> +    netif_rx(skb);
> +
> +    stats->rx_packets++;
> +    stats->rx_bytes +=3D cf->can_dlc;
> +}
> +
> +/*
> + * Callback for reading data from device
> + *
> + * Check urb status, call read function and resubmit urb read operatio=
n.
> + */
> +static void usb_8dev_read_bulk_callback(struct urb *urb)
> +{
> +    struct usb_8dev *dev =3D urb->context;
> +    struct net_device *netdev;
> +    int retval;
> +    int pos =3D 0;
> +
> +    netdev =3D dev->netdev;
> +
> +    if (!netif_device_present(netdev))
> +        return;
> +
> +    switch (urb->status) {
> +    case 0: /* success */
> +        break;
> +
> +    case -ENOENT:
> +    case -ESHUTDOWN:
> +        return;
> +
> +    default:
> +        netdev_info(netdev, "Rx URB aborted (%d)\n",
> +             urb->status);
> +        goto resubmit_urb;
> +    }
> +
> +    while (pos < urb->actual_length) {
> +        struct usb_8dev_rx_msg *msg;
> +
> +        if (pos + sizeof(struct usb_8dev_rx_msg) > urb->actual_length)=
 {
> +            netdev_err(dev->netdev, "format error\n");
> +            break;

is resubmitting the urb the correct way to handle this problem?

> +        }
> +
> +        msg =3D (struct usb_8dev_rx_msg *)(urb->transfer_buffer + pos)=
;
> +        usb_8dev_rx_can_msg(dev, msg);
> +
> +        pos +=3D sizeof(struct usb_8dev_rx_msg);
> +    }
> +
> +resubmit_urb:
> +    usb_fill_bulk_urb(urb, dev->udev,
> +              usb_rcvbulkpipe(dev->udev, USB_8DEV_ENDP_DATA_RX),
> +              urb->transfer_buffer, RX_BUFFER_SIZE,
> +              usb_8dev_read_bulk_callback, dev);
> +
> +    retval =3D usb_submit_urb(urb, GFP_ATOMIC);
> +
> +    if (retval =3D=3D -ENODEV)
> +        netif_device_detach(netdev);
> +    else if (retval)
> +        netdev_err(netdev,
> +            "failed resubmitting read bulk urb: %d\n", retval);
> +}
> +
> +/*
> + * Callback handler for write operations
> + *
> + * Free allocated buffers, check transmit status and
> + * calculate statistic.
> + */
> +static void usb_8dev_write_bulk_callback(struct urb *urb)
> +{
> +    struct usb_8dev_tx_urb_context *context =3D urb->context;
> +    struct usb_8dev *dev;
> +    struct net_device *netdev;
> +
> +    BUG_ON(!context);
> +
> +    dev =3D context->dev;
> +    netdev =3D dev->netdev;
> +
> +    /* free up our allocated buffer */
> +    usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> +              urb->transfer_buffer, urb->transfer_dma);
> +
> +    atomic_dec(&dev->active_tx_urbs);
> +
> +    if (!netif_device_present(netdev))
> +        return;
> +
> +    if (urb->status)
> +        netdev_info(netdev, "Tx URB aborted (%d)\n",
> +             urb->status);
> +
> +    netdev->stats.tx_packets++;
> +    netdev->stats.tx_bytes +=3D context->dlc;
> +
> +    can_get_echo_skb(netdev, context->echo_index);
> +
> +    /* Release context */
> +    context->echo_index =3D MAX_TX_URBS;
> +
> +    netif_wake_queue(netdev);
> +}
> +
> +/* Send data to device */
> +static netdev_tx_t usb_8dev_start_xmit(struct sk_buff *skb,
> +                      struct net_device *netdev)
> +{
> +    struct usb_8dev *dev =3D netdev_priv(netdev);
> +    struct net_device_stats *stats =3D &netdev->stats;
> +    struct can_frame *cf =3D (struct can_frame *) skb->data;
> +    struct usb_8dev_tx_msg *msg;
> +    struct urb *urb;
> +    struct usb_8dev_tx_urb_context *context =3D NULL;
> +    u8 *buf;
> +    int i, err;
> +    size_t size =3D sizeof(struct usb_8dev_tx_msg);
> +
> +    if (can_dropped_invalid_skb(netdev, skb))
> +        return NETDEV_TX_OK;
> +
> +    /* create a URB, and a buffer for it, and copy the data to the URB=
 */
> +    urb =3D usb_alloc_urb(0, GFP_ATOMIC);
> +    if (!urb) {
> +        netdev_err(netdev, "No memory left for URBs\n");
> +        goto nomem;
> +    }
> +
> +    buf =3D usb_alloc_coherent(dev->udev, size, GFP_ATOMIC,
> +                 &urb->transfer_dma);
> +    if (!buf) {
> +        netdev_err(netdev, "No memory left for USB buffer\n");
> +        usb_free_urb(urb);

can you move the usb_free_usb to the error handling at the end of this
function

> +        goto nomem;
> +    }
> +
> +    memset(buf, 0, size);
> +
> +    msg =3D (struct usb_8dev_tx_msg *)buf;
> +    msg->begin =3D USB_8DEV_DATA_START;
> +    msg->flags =3D 0x00;
> +
> +    if (cf->can_id & CAN_RTR_FLAG)
> +        msg->flags |=3D USB_8DEV_RTR;
> +
> +    if (cf->can_id & CAN_EFF_FLAG)
> +        msg->flags |=3D USB_8DEV_EXTID;
> +
> +    msg->id =3D cpu_to_be32(cf->can_id & CAN_ERR_MASK);
> +    msg->dlc =3D cf->can_dlc;
> +    memcpy(msg->data, cf->data, cf->can_dlc);
> +    msg->end =3D USB_8DEV_DATA_END;
> +
> +    for (i =3D 0; i < MAX_TX_URBS; i++) {
> +        if (dev->tx_contexts[i].echo_index =3D=3D MAX_TX_URBS) {
> +            context =3D &dev->tx_contexts[i];
> +            break;
> +        }
> +    }
> +
> +    /*
> +     * May never happen! When this happens we'd more URBs in flight as=

> +     * allowed (MAX_TX_URBS).
> +     */
> +    if (!context) {
> +        usb_unanchor_urb(urb);
> +        usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);

make use of the error handling at the end of the function.

> +
> +        netdev_warn(netdev, "couldn't find free context");
> +
> +        return NETDEV_TX_BUSY;
> +    }
> +
> +    context->dev =3D dev;
> +    context->echo_index =3D i;
> +    context->dlc =3D cf->can_dlc;
> +
> +    usb_fill_bulk_urb(urb, dev->udev,
> +              usb_sndbulkpipe(dev->udev, USB_8DEV_ENDP_DATA_TX),
> +              buf, size, usb_8dev_write_bulk_callback, context);
> +    urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> +    usb_anchor_urb(urb, &dev->tx_submitted);
> +
> +    can_put_echo_skb(skb, netdev, context->echo_index);
> +
> +    atomic_inc(&dev->active_tx_urbs);
> +
> +    err =3D usb_submit_urb(urb, GFP_ATOMIC);
> +    if (unlikely(err)) {
> +        can_free_echo_skb(netdev, context->echo_index);
> +
> +        usb_unanchor_urb(urb);
> +        usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
> +        dev_kfree_skb(skb);

can you move this to the end of the function, too?
> +
> +        atomic_dec(&dev->active_tx_urbs);
> +
> +        if (err =3D=3D -ENODEV) {
> +            netif_device_detach(netdev);
> +        } else {
> +            netdev_warn(netdev, "failed tx_urb %d\n", err);
> +
> +            stats->tx_dropped++;
> +        }
> +    } else {
> +        /* Slow down tx path */
> +        if (atomic_read(&dev->active_tx_urbs) >=3D MAX_TX_URBS ||
> +            dev->free_slots < 5) {

where's the 5 coming from?

> +            netif_stop_queue(netdev);
> +        }
> +    }
> +
> +    /*
> +     * Release our reference to this URB, the USB core will eventually=

> free
> +     * it entirely.
> +     */
> +    usb_free_urb(urb);
> +
> +    return NETDEV_TX_OK;
> +
> +nomem:
> +    dev_kfree_skb(skb);
> +    stats->tx_dropped++;
> +
> +    return NETDEV_TX_OK;
> +}
> +
> +static int usb_8dev_get_berr_counter(const struct net_device *netdev,
> +                     struct can_berr_counter *bec)
> +{
> +    struct usb_8dev *dev =3D netdev_priv(netdev);
> +
> +    bec->txerr =3D dev->bec.txerr;
> +    bec->rxerr =3D dev->bec.rxerr;
> +
> +    return 0;
> +}
> +
> +/* Start USB device */
> +static int usb_8dev_start(struct usb_8dev *dev)
> +{
> +    struct net_device *netdev =3D dev->netdev;
> +    int err, i;
> +
> +    dev->free_slots =3D 15; /* initial size */

there does the 15 come from?

> +
> +    for (i =3D 0; i < MAX_RX_URBS; i++) {
> +        struct urb *urb =3D NULL;
> +        u8 *buf =3D NULL;

the =3D NULL is not needed here.

> +
> +        /* create a URB, and a buffer for it */
> +        urb =3D usb_alloc_urb(0, GFP_KERNEL);
> +        if (!urb) {
> +            netdev_err(netdev, "No memory left for URBs\n");
> +            return -ENOMEM;

who will free the already allocated urbs if i !=3D 0 ?

> +        }
> +
> +        buf =3D usb_alloc_coherent(dev->udev, RX_BUFFER_SIZE, GFP_KERN=
EL,
> +                     &urb->transfer_dma);
> +        if (!buf) {
> +            netdev_err(netdev, "No memory left for USB buffer\n");
> +            usb_free_urb(urb);

same problem here for coherent

> +            return -ENOMEM;
> +        }
> +
> +        usb_fill_bulk_urb(urb, dev->udev,
> +                  usb_rcvbulkpipe(dev->udev,
> +                          USB_8DEV_ENDP_DATA_RX),
> +                  buf, RX_BUFFER_SIZE,
> +                  usb_8dev_read_bulk_callback, dev);
> +        urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> +        usb_anchor_urb(urb, &dev->rx_submitted);
> +
> +        err =3D usb_submit_urb(urb, GFP_KERNEL);
> +        if (err) {
> +            if (err =3D=3D -ENODEV)
> +                netif_device_detach(dev->netdev);
> +
> +            usb_unanchor_urb(urb);
> +            usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
> +                      urb->transfer_dma);
same here

add a loop that runs backwards at the end of the function

> +            break;
> +        }
> +
> +        /* Drop reference, USB core will take care of freeing it */
> +        usb_free_urb(urb);
> +    }
> +
> +    /* Did we submit any URBs */
> +    if (i =3D=3D 0) {
> +        netdev_warn(netdev, "couldn't setup read URBs\n");
> +        return err;
> +    }
> +
> +    /* Warn if we've couldn't transmit all the URBs */
> +    if (i < MAX_RX_URBS)
> +        netdev_warn(netdev, "rx performance may be slow\n");
> +
> +    err =3D usb_8dev_cmd_open(dev);
> +    if (err)
> +        goto failed;
> +
> +    dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +    return 0;
> +
> +failed:
> +    if (err =3D=3D -ENODEV)
> +        netif_device_detach(dev->netdev);
> +
> +    netdev_warn(netdev, "couldn't submit control: %d\n", err);
> +
> +    return err;
> +}
> +
> +/* Open USB device */
> +static int usb_8dev_open(struct net_device *netdev)
> +{
> +    struct usb_8dev *dev =3D netdev_priv(netdev);
> +    int err;
> +
> +    /* common open */
> +    err =3D open_candev(netdev);
> +    if (err)
> +        return err;
> +
> +    /* finally start device */
> +    err =3D usb_8dev_start(dev);
> +    if (err) {
> +        if (err =3D=3D -ENODEV)
> +            netif_device_detach(dev->netdev);
> +
> +        netdev_warn(netdev, "couldn't start device: %d\n",
> +             err);
> +
> +        close_candev(netdev);
> +
> +        return err;
> +    }
> +
> +    netif_start_queue(netdev);
> +
> +    return 0;
> +}
> +
> +static void unlink_all_urbs(struct usb_8dev *dev)
> +{
> +    int i;
> +
> +    usb_kill_anchored_urbs(&dev->rx_submitted);
> +
> +    usb_kill_anchored_urbs(&dev->tx_submitted);
> +    atomic_set(&dev->active_tx_urbs, 0);
> +
> +    for (i =3D 0; i < MAX_TX_URBS; i++)
> +        dev->tx_contexts[i].echo_index =3D MAX_TX_URBS;
> +}
> +
> +/* Close USB device */
> +static int usb_8dev_close(struct net_device *netdev)
> +{
> +    struct usb_8dev *dev =3D netdev_priv(netdev);
> +    int err =3D 0;
> +
> +    /* Send CLOSE command to CAN controller */
> +    err =3D usb_8dev_cmd_close(dev);
> +    if (err)
> +        netdev_warn(netdev, "couldn't stop device");
> +
> +    dev->can.state =3D CAN_STATE_STOPPED;
> +
> +    /* Stop polling */
> +    unlink_all_urbs(dev);
> +
> +    netif_stop_queue(netdev);

you should probably first stop the queue. this function shoud do the
inverse of open

> +
> +    close_candev(netdev);
> +
> +    return err;
> +}
> +
> +static const struct net_device_ops usb_8dev_netdev_ops =3D {
> +    .ndo_open =3D usb_8dev_open,
> +    .ndo_stop =3D usb_8dev_close,
> +    .ndo_start_xmit =3D usb_8dev_start_xmit,
> +};
> +
> +static const struct can_bittiming_const usb_8dev_bittiming_const =3D {=

> +    .name =3D "usb_8dev",
> +    .tseg1_min =3D USB_8DEV_TSEG1_MIN,
> +    .tseg1_max =3D USB_8DEV_TSEG1_MAX,
> +    .tseg2_min =3D USB_8DEV_TSEG2_MIN,
> +    .tseg2_max =3D USB_8DEV_TSEG2_MAX,
> +    .sjw_max =3D USB_8DEV_SJW_MAX,
> +    .brp_min =3D USB_8DEV_BRP_MIN,
> +    .brp_max =3D USB_8DEV_BRP_MAX,
> +    .brp_inc =3D USB_8DEV_BRP_INC,
> +};
> +
> +/*
> + * Probe USB device
> + *
> + * Check device and firmware.
> + * Set supported modes and bittiming constants.
> + * Allocate some memory.
> + */
> +static int usb_8dev_probe(struct usb_interface *intf,
> +             const struct usb_device_id *id)
> +{
> +    struct net_device *netdev;
> +    struct usb_8dev *dev;
> +    int i, err =3D -ENOMEM;
> +    u32 version;
> +    char buf[18];

where does this 18 come from?

> +    struct usb_device *usbdev =3D interface_to_usbdev(intf);
> +
> +    /* product id looks strange, better we also check iProdukt string =
*/

iProduct?

> +    if (usb_string(usbdev, usbdev->descriptor.iProduct, buf,
> +               sizeof(buf)) > 0 && strcmp(buf, "USB2CAN converter")) {=

> +        dev_info(&usbdev->dev, "ignoring: not an USB2CAN converter\n")=
;
> +        return -ENODEV;
> +    }
> +
> +    netdev =3D alloc_candev(sizeof(struct usb_8dev), MAX_TX_URBS);
> +    if (!netdev) {
> +        dev_err(&intf->dev, "Couldn't alloc candev\n");
> +        return -ENOMEM;
> +    }
> +
> +    dev =3D netdev_priv(netdev);
> +
> +    dev->udev =3D usbdev;
> +    dev->netdev =3D netdev;
> +
> +    dev->can.state =3D CAN_STATE_STOPPED;
> +    dev->can.clock.freq =3D USB_8DEV_ABP_CLOCK;
> +    dev->can.bittiming_const =3D &usb_8dev_bittiming_const;
> +    dev->can.do_set_mode =3D usb_8dev_set_mode;
> +    dev->can.do_get_berr_counter =3D usb_8dev_get_berr_counter;
> +    dev->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
> +                      CAN_CTRLMODE_LISTENONLY |
> +                      CAN_CTRLMODE_ONE_SHOT;

Have you actually tested one shot? What happens if a can frame cannot be
transmitted?

> +
> +    netdev->netdev_ops =3D &usb_8dev_netdev_ops;
> +
> +    netdev->flags |=3D IFF_ECHO; /* we support local echo */
> +
> +    init_usb_anchor(&dev->rx_submitted);
> +
> +    init_usb_anchor(&dev->tx_submitted);
> +    atomic_set(&dev->active_tx_urbs, 0);
> +
> +    for (i =3D 0; i < MAX_TX_URBS; i++)
> +        dev->tx_contexts[i].echo_index =3D MAX_TX_URBS;
> +
> +    dev->cmd_msg_buffer =3D kzalloc(sizeof(struct usb_8dev_cmd_msg),
> +                      GFP_KERNEL);
> +    if (!dev->cmd_msg_buffer) {
> +        netdev_err(netdev, "Couldn't alloc Tx buffer\n");
> +        goto cleanup_candev;
> +    }
> +
> +    usb_set_intfdata(intf, dev);
> +
> +    SET_NETDEV_DEV(netdev, &intf->dev);
> +
> +    mutex_init(&dev->usb_8dev_cmd_lock);
> +
> +    err =3D usb_8dev_cmd_version(dev, &version);
> +    if (err) {
> +        netdev_err(netdev, "can't get firmware version\n");
> +        goto cleanup_cmd_msg_buffer;
> +    } else {
> +        netdev_info(netdev,
> +             "firmware: %d.%d, hardware: %d.%d\n",
> +             (version>>24) & 0xff, (version>>16) & 0xff,
> +             (version>>8) & 0xff, version & 0xff);
> +    }
> +
> +    err =3D register_candev(netdev);
> +    if (err) {
> +        netdev_err(netdev,
> +            "couldn't register CAN device: %d\n", err);
> +        goto cleanup_cmd_msg_buffer;
> +    }
> +
> +    if (device_create_file(&intf->dev, &dev_attr_firmware))
> +        netdev_err(netdev,
> +            "Couldn't create device file for firmware\n");
> +
> +    if (device_create_file(&intf->dev, &dev_attr_hardware))
> +        netdev_err(netdev,
> +            "Couldn't create device file for hardware\n");
> +
> +    /* let the user know what node this device is now attached to */
> +    netdev_info(netdev, "device registered as %s\n", netdev->name);

netdev_info should already print netdev->name

> +    return 0;
> +
> +cleanup_cmd_msg_buffer:
> +    kfree(dev->cmd_msg_buffer);
> +
> +cleanup_candev:
> +    free_candev(netdev);
> +
> +    return err;
> +
> +}
> +
> +/* Called by the usb core when driver is unloaded or device is removed=
 */
> +static void usb_8dev_disconnect(struct usb_interface *intf)
> +{
> +    struct usb_8dev *dev =3D usb_get_intfdata(intf);
> +
> +    device_remove_file(&intf->dev, &dev_attr_firmware);
> +    device_remove_file(&intf->dev, &dev_attr_hardware);
> +
> +    usb_set_intfdata(intf, NULL);
> +
> +    if (dev) {
> +        netdev_info(dev->netdev, "disconnect %s\n", dev->netdev->name)=
;
> +
> +        unregister_netdev(dev->netdev);
> +        free_candev(dev->netdev);
> +
> +        unlink_all_urbs(dev);
> +    }
> +
> +}
> +
> +static struct usb_driver usb_8dev_driver =3D {
> +    .name =3D        "usb_8dev",
> +    .probe =3D    usb_8dev_probe,
> +    .disconnect =3D    usb_8dev_disconnect,
> +    .id_table =3D    usb_8dev_table,
> +};
> +
> +module_usb_driver(usb_8dev_driver);
> +
> +MODULE_AUTHOR("Bernd Krumboeck <krumboeck@universalnet.at>");
> +MODULE_DESCRIPTION("CAN driver for 8 devices USB2CAN interfaces");
> +MODULE_LICENSE("GPL v2");

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB9AEB48178B72FD5B642FCB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC+bxIACgkQjTAFq1RaXHNmbwCfQtaM3NVtlweDYUMst4eTku4A
3FcAn2kC5w1pRSwGRy4GJAbIXDKWn7Rf
=1J1T
-----END PGP SIGNATURE-----

--------------enigB9AEB48178B72FD5B642FCB5--
