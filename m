From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [PATCH v2 1/1] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
Date: Fri, 20 Jan 2017 13:32:40 +0100
Message-ID: <CAKT-o-du56JbYczGF7cTn5MRvn3Rsp0sd3MBykfkhf9mjC1mFw@mail.gmail.com>
References: <20170119122949.30488-1-remigiusz.kollataj@mobica.com>
 <20170119122949.30488-2-remigiusz.kollataj@mobica.com> <034e0cec-6179-b9e0-256b-d1ae46e4fb14@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35885 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdATMdC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2017 07:33:02 -0500
Received: by mail-ua0-f176.google.com with SMTP id 96so58918172uaq.3
        for <linux-can@vger.kernel.org>; Fri, 20 Jan 2017 04:33:02 -0800 (PST)
In-Reply-To: <034e0cec-6179-b9e0-256b-d1ae46e4fb14@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

Thanks for your comments.

On 20 January 2017 at 10:08, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 01/19/2017 01:29 PM, Remigiusz Ko=C5=82=C5=82=C4=85taj wrote:
> > SocketCAN driver for Microchip CAN BUS Analyzer
> > (http://www.microchip.com/development-tools/)
> >
> > Changes since v1:
> > - Termination handling reimplemented to fit new netlink API
> > (IFLA_CAN_TERMINATION)
> > - Bitrate handling reimplemented to fit new netlink API
> > (IFLA_CAN_BITRATE)
> > - CAN ID conversion refactored (changed from macro to inline functions)
> > - CAN DLC handling using get_can_dlc()
> > - Endianess handling for can_speed introduced
> > - Debugging removed
> > - Redundant error prints removed
> > - Style/cosmetic corrections (i.e. macro names, redefs, inits etc.)
> >
> > Signed-off-by: Remigiusz Ko=C5=82=C5=82=C4=85taj <remigiusz.kollataj@mo=
bica.com>
> > ---
> >  drivers/net/can/usb/Kconfig    |   6 +
> >  drivers/net/can/usb/Makefile   |   1 +
> >  drivers/net/can/usb/mcba_usb.c | 911 +++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 918 insertions(+)
> >  create mode 100644 drivers/net/can/usb/mcba_usb.c
> >
> > diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> > index 8483a40e7e9e..2d0313eb31c0 100644
> > --- a/drivers/net/can/usb/Kconfig
> > +++ b/drivers/net/can/usb/Kconfig
> > @@ -81,4 +81,10 @@ config CAN_8DEV_USB
> >         This driver supports the USB2CAN interface
> >         from 8 devices (http://www.8devices.com).
> >
> > +config CAN_MCBA_USB
> > +     tristate "Microchip CAN BUS Analyzer interface"
> > +     ---help---
> > +       This driver supports the CAN BUS Analyzer interface
> > +       from Microchip (http://www.microchip.com/development-tools/).
> > +
> >  endmenu
> > diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefil=
e
> > index a64cf983fb87..164453fd55d0 100644
> > --- a/drivers/net/can/usb/Makefile
> > +++ b/drivers/net/can/usb/Makefile
> > @@ -8,3 +8,4 @@ obj-$(CONFIG_CAN_GS_USB) +=3D gs_usb.o
> >  obj-$(CONFIG_CAN_KVASER_USB) +=3D kvaser_usb.o
> >  obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb/
> >  obj-$(CONFIG_CAN_8DEV_USB) +=3D usb_8dev.o
> > +obj-$(CONFIG_CAN_MCBA_USB) +=3D mcba_usb.o
> > diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_=
usb.c
> > new file mode 100644
> > index 000000000000..075d59ccdd62
> > --- /dev/null
> > +++ b/drivers/net/can/usb/mcba_usb.c
> > @@ -0,0 +1,911 @@
> > +/* SocketCAN driver for Microchip CAN BUS Analyzer Tool
> > + *
> > + * Copyright (C) 2016 Mobica Limited
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published
> > + * by the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long
> > + * with this program.
> > + *
> > + * This driver is inspired by the 4.6.2 version of net/can/usb/usb_8de=
v.c
> > + */
> > +
> > +#include <linux/can.h>
> > +#include <linux/can/dev.h>
> > +#include <linux/can/error.h>
> > +#include <linux/module.h>
> > +#include <linux/netdevice.h>
> > +#include <linux/signal.h>
> > +#include <linux/slab.h>
> > +#include <linux/unaligned/be_byteshift.h>
>                              ^^^^^^^^^^^^^^
>
> this looks wrong.

Changed to #include <asm/unaligned.h>

>
> > +#include <linux/usb.h>
> > +
> > +/* vendor and product id */
> > +#define MCBA_MODULE_NAME "mcba_usb"
> > +#define MCBA_VENDOR_ID 0x04d8
> > +#define MCBA_PRODUCT_ID 0x0a30
> > +
> > +/* driver constants */
> > +#define MCBA_MAX_RX_URBS 20
> > +#define MCBA_MAX_TX_URBS 20
> > +#define MCBA_CTX_FREE MCBA_MAX_TX_URBS
> > +
> > +/* RX buffer must be bigger than msg size since at the
> > + * beggining USB messages are stacked.
> > + */
> > +#define MCBA_USB_RX_BUFF_SIZE 64
> > +#define MCBA_USB_TX_BUFF_SIZE (sizeof(struct mcba_usb_msg))
> > +
> > +/* MCBA endpoint numbers */
> > +#define MCBA_USB_EP_IN 1
> > +#define MCBA_USB_EP_OUT 1
> > +
> > +/* Microchip command id */
> > +#define MBCA_CMD_RECEIVE_MESSAGE 0xE3
> > +#define MBCA_CMD_I_AM_ALIVE_FROM_CAN 0xF5
> > +#define MBCA_CMD_I_AM_ALIVE_FROM_USB 0xF7
> > +#define MBCA_CMD_CHANGE_BIT_RATE 0xA1
> > +#define MBCA_CMD_TRANSMIT_MESSAGE_EV 0xA3
> > +#define MBCA_CMD_SETUP_TERMINATION_RESISTANCE 0xA8
> > +#define MBCA_CMD_READ_FW_VERSION 0xA9
> > +#define MBCA_CMD_NOTHING_TO_SEND 0xFF
> > +#define MBCA_CMD_TRANSMIT_MESSAGE_RSP 0xE2
> > +
> > +#define MCBA_VER_REQ_USB 1
> > +#define MCBA_VER_REQ_CAN 2
> > +
> > +#define MCBA_CAN_S_SID0_SID2_MASK 0x7
> > +#define MCBA_CAN_S_SID3_SID10_MASK 0x7F8
> > +#define MCBA_CAN_S_SID3_SID10_SHIFT 3
> > +
> > +#define MCBA_CAN_EID0_EID7_MASK 0xff
> > +#define MCBA_CAN_EID8_EID15_MASK 0xff00
> > +#define MCBA_CAN_EID16_EID17_MASK 0x30000
> > +#define MCBA_CAN_E_SID0_SID2_MASK 0x1c0000
> > +#define MCBA_CAN_E_SID3_SID10_MASK 0x1fe00000
> > +#define MCBA_CAN_EID8_EID15_SHIFT 8
> > +#define MCBA_CAN_EID16_EID17_SHIFT 16
> > +#define MCBA_CAN_E_SID0_SID2_SHIFT 18
> > +#define MCBA_CAN_E_SID3_SID10_SHIFT 21
> > +
> > +#define MCBA_SIDL_SID0_SID2_MASK 0xe0
> > +#define MCBA_SIDL_EXID_MASK 0x8
> > +#define MCBA_SIDL_EID16_EID17_MASK 0x3
> > +#define MCBA_SIDL_SID0_SID2_SHIFT 5
> > +
> > +#define MCBA_DLC_MASK 0xf
> > +#define MCBA_DLC_RTR_MASK 0x40
> > +
> > +#define MCBA_USB_IS_EXID(usb_msg) ((usb_msg)->sidl & MCBA_SIDL_EXID_MA=
SK)
> > +#define MCBA_USB_IS_RTR(usb_msg) ((usb_msg)->dlc & MCBA_DLC_RTR_MASK)
> > +#define MCBA_CAN_IS_EXID(can_frame) ((can_frame)->can_id & CAN_EFF_FLA=
G)
> > +#define MCBA_CAN_IS_RTR(can_frame) ((can_frame)->can_id & CAN_RTR_FLAG=
)
>
> Please convert these into ststic inline functions.

As each of these macros are used just in one place now I will remove
it completely.

>
> > +
> > +#define MCBA_CAN_STATE_WRN_TH 95
> > +#define MCBA_CAN_STATE_ERR_PSV_TH 127
> > +
> > +#define MCBA_TERMINATION_DISABLED CAN_TERMINATION_DISABLED
> > +#define MCBA_TERMINATION_ENABLED 120
> > +
> > +struct mcba_usb_ctx {
> > +     struct mcba_priv *priv;
> > +     u32 ndx;
> > +     u8 dlc;
> > +     bool can;
> > +};
> > +
> > +/* Structure to hold all of our device specific stuff */
> > +struct mcba_priv {
> > +     struct can_priv can; /* must be the first member */
> > +     struct sk_buff *echo_skb[MCBA_MAX_TX_URBS];
> > +     struct mcba_usb_ctx tx_context[MCBA_MAX_TX_URBS];
> > +     struct usb_device *udev;
> > +     struct net_device *netdev;
> > +     struct usb_anchor tx_submitted;
> > +     struct usb_anchor rx_submitted;
> > +     struct can_berr_counter bec;
> > +     bool usb_ka_first_pass;
> > +     bool can_ka_first_pass;
> > +     bool can_speed_check;
> > +};
> > +
> > +/* CAN frame */
> > +struct __packed mcba_usb_msg_can {
> > +     u8 cmd_id;
> > +     u8 eidh;
> > +     u8 eidl;
>
> __be16

ok

>
> > +     u8 sidh;
> > +     u8 sidl;
>
> __be16

ok

>
> > +     u8 dlc;
> > +     u8 data[8];
> > +     u8 timestamp[4];
> > +     u8 checksum;
> > +};
> > +
> > +/* command frame */
> > +struct __packed mcba_usb_msg {
> > +     u8 cmd_id;
> > +     u8 unused[18];
> > +};
> > +
> > +struct __packed mcba_usb_msg_ka_usb {
> > +     u8 cmd_id;
> > +     u8 termination_state;
> > +     u8 soft_ver_major;
> > +     u8 soft_ver_minor;
> > +     u8 unused[15];
> > +};
> > +
> > +struct __packed mcba_usb_msg_ka_can {
> > +     u8 cmd_id;
> > +     u8 tx_err_cnt;
> > +     u8 rx_err_cnt;
> > +     u8 rx_buff_ovfl;
> > +     u8 tx_bus_off;
> > +     u16 can_bitrate; /* BE */
>
> __be16

ok

>
> > +     u16 rx_lost;     /* LE */
>
> __le16

ok. I realize LE here is odd. However I have rechecked it in firmware
code and this is correct.

>
> > +     u8 can_stat;
> > +     u8 soft_ver_major;
> > +     u8 soft_ver_minor;
> > +     u8 debug_mode;
> > +     u8 test_complete;
> > +     u8 test_result;
> > +     u8 unused[4];
> > +};
> > +
> > +struct __packed mcba_usb_msg_change_bitrate {
> > +     u8 cmd_id;
> > +     u16 bitrate; /* BE */
>
> __be16

ok

>
> > +     u8 unused[16];
> > +};
> > +
> > +struct __packed mcba_usb_msg_terminaton {
> > +     u8 cmd_id;
> > +     u8 termination;
> > +     u8 unused[17];
> > +};
> > +
> > +struct __packed mcba_usb_msg_fw_ver {
> > +     u8 cmd_id;
> > +     u8 pic;
> > +     u8 unused[17];
> > +};
> > +
> > +static const struct usb_device_id mcba_usb_table[] =3D {
> > +     { USB_DEVICE(MCBA_VENDOR_ID, MCBA_PRODUCT_ID) },
> > +     {} /* Terminating entry */
> > +};
> > +
> > +MODULE_DEVICE_TABLE(usb, mcba_usb_table);
> > +
> > +static const u16 mcba_termination[] =3D { MCBA_TERMINATION_DISABLED,
> > +                                     MCBA_TERMINATION_ENABLED };
> > +
> > +static const u32 mcba_bitrate[] =3D { 20000,  33333,  50000,  80000,  =
83333,
> > +                                 100000, 125000, 150000, 175000, 20000=
0,
> > +                                 225000, 250000, 275000, 300000, 50000=
0,
> > +                                 625000, 800000, 1000000 };
> > +
> > +static inline void mcba_init_ctx(struct mcba_priv *priv)
> > +{
> > +     int i =3D 0;
> > +
> > +     for (i =3D 0; i < MCBA_MAX_TX_URBS; i++)
> > +             priv->tx_context[i].ndx =3D MCBA_CTX_FREE;
> > +}
> > +
> > +static inline struct mcba_usb_ctx *mcba_usb_get_free_ctx(struct mcba_p=
riv *priv)
> > +{
> > +     int i =3D 0;
> > +     struct mcba_usb_ctx *ctx =3D NULL;
> > +
> > +     for (i =3D 0; i < MCBA_MAX_TX_URBS; i++) {
> > +             if (priv->tx_context[i].ndx =3D=3D MCBA_CTX_FREE) {
> > +                     ctx =3D &priv->tx_context[i];
> > +                     ctx->ndx =3D i;
> > +                     ctx->priv =3D priv;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return ctx;
> > +}
> > +
> > +static inline void mcba_usb_free_ctx(struct mcba_usb_ctx *ctx)
> > +{
> > +     ctx->ndx =3D MCBA_CTX_FREE;
> > +     ctx->priv =3D NULL;
> > +     ctx->dlc =3D 0;
> > +     ctx->can =3D false;
> > +}
> > +
> > +static void mcba_usb_write_bulk_callback(struct urb *urb)
> > +{
> > +     struct mcba_usb_ctx *ctx =3D urb->context;
> > +     struct net_device *netdev;
> > +
> > +     WARN_ON(!ctx);
> > +
> > +     netdev =3D ctx->priv->netdev;
> > +
> > +     if (ctx->can) {
> > +             if (!netif_device_present(netdev))
> > +                     return;
> > +
> > +             netdev->stats.tx_packets++;
> > +             netdev->stats.tx_bytes +=3D ctx->dlc;
> > +
> > +             can_get_echo_skb(netdev, ctx->ndx);
> > +
> > +             netif_wake_queue(netdev);
> > +     }
> > +
> > +     /* free up our allocated buffer */
> > +     usb_free_coherent(urb->dev, urb->transfer_buffer_length,
> > +                       urb->transfer_buffer, urb->transfer_dma);
> > +
> > +     if (urb->status)
> > +             netdev_info(netdev, "Tx URB aborted (%d)\n", urb->status)=
;
> > +
> > +     /* Release context */
> > +     mcba_usb_free_ctx(ctx);
> > +}
> > +
> > +/* Send data to device */
> > +static netdev_tx_t mcba_usb_xmit(struct mcba_priv *priv,
> > +                              struct mcba_usb_msg *usb_msg,
> > +                              struct sk_buff *skb)
> > +{
> > +     struct net_device_stats *stats =3D &priv->netdev->stats;
> > +     struct mcba_usb_ctx *ctx =3D NULL;
> > +     struct urb *urb;
> > +     u8 *buf;
> > +     int err;
> > +
> > +     ctx =3D mcba_usb_get_free_ctx(priv);
> > +     if (!ctx) {
> > +             /* Slow down tx path */
> > +             netif_stop_queue(priv->netdev);
>
> Call netif_stop_queue if use use the last tx buffer, not when it's too
> late. This makes no sense here, as this function is not exclusively used
> by to send CAN frames. Why do you use this function for sending non CAN
> frames? usb_8dev has usb_8dev_send_cmd().

Unfortunately the device has only one common USB endpoint. 8dev has
separate endpoints for cmd and frames. Shall I remove netif_stop_queue
in such case and leave NETDEV_TX_BUSY return only?

>
> > +
> > +             return NETDEV_TX_BUSY;
> > +     }
> > +
> > +     if (skb) {
> > +             ctx->dlc =3D
> > +                 ((struct mcba_usb_msg_can *)usb_msg)->dlc & MCBA_DLC_=
MASK;
> > +             can_put_echo_skb(skb, priv->netdev, ctx->ndx);
> > +             ctx->can =3D true;
> > +     } else {
> > +             ctx->can =3D false;
> > +     }
> > +
> > +     /* create a URB, and a buffer for it, and copy the data to the UR=
B */
> > +     urb =3D usb_alloc_urb(0, GFP_ATOMIC);
> > +     if (!urb)
> > +             goto nomem;
> > +
> > +     buf =3D usb_alloc_coherent(priv->udev, MCBA_USB_TX_BUFF_SIZE, GFP=
_ATOMIC,
> > +                              &urb->transfer_dma);
> > +     if (!buf)
> > +             goto nomembuf;
> > +
> > +     memcpy(buf, usb_msg, MCBA_USB_TX_BUFF_SIZE);
> > +
> > +     usb_fill_bulk_urb(
>
> please move the arguments into the line of the function and rewrap at a
> width of <80.
>

ok

> > +         urb, priv->udev, usb_sndbulkpipe(priv->udev, MCBA_USB_EP_OUT)=
, buf,
> > +         MCBA_USB_TX_BUFF_SIZE, mcba_usb_write_bulk_callback, ctx);
> > +
> > +     urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> > +     usb_anchor_urb(urb, &priv->tx_submitted);
> > +
> > +     err =3D usb_submit_urb(urb, GFP_ATOMIC);
> > +     if (unlikely(err))
> > +             goto failed;
> > +
> > +     /* Release our reference to this URB, the USB core will eventuall=
y free
> > +      * it entirely.
> > +      */
> > +     usb_free_urb(urb);
> > +
> > +     return NETDEV_TX_OK;
> > +
> > +failed:
> > +     usb_unanchor_urb(urb);
> > +     usb_free_coherent(priv->udev, MCBA_USB_TX_BUFF_SIZE, buf,
> > +                       urb->transfer_dma);
> > +
> > +     if (err =3D=3D -ENODEV)
> > +             netif_device_detach(priv->netdev);
> > +     else
> > +             netdev_warn(priv->netdev, "failed tx_urb %d\n", err);
> > +
> > +nomembuf:
> > +     usb_free_urb(urb);
> > +
> > +nomem:
> > +     can_free_echo_skb(priv->netdev, ctx->ndx);
> > +     dev_kfree_skb(skb);
> > +     stats->tx_dropped++;
> > +
> > +     return NETDEV_TX_OK;
> > +}
> > +
> > +static inline void convert_can2usb_msg(const struct can_frame *in,
> > +                                    struct mcba_usb_msg_can *out)
> > +{
> > +     u32 tmp;
> > +
> > +     if (MCBA_CAN_IS_EXID(in)) {
> > +             out->sidl =3D MCBA_SIDL_EXID_MASK;
> > +
> > +             tmp =3D in->can_id & MCBA_CAN_E_SID0_SID2_MASK;
> > +             tmp >>=3D MCBA_CAN_E_SID0_SID2_SHIFT - MCBA_SIDL_SID0_SID=
2_SHIFT;
> > +             out->sidl |=3D tmp;
> > +
> > +             tmp =3D in->can_id & MCBA_CAN_EID16_EID17_MASK;
> > +             tmp >>=3D MCBA_CAN_EID16_EID17_SHIFT;
> > +             out->sidl |=3D tmp;
>
> Why don't you combine both sift and mask operations?

I decided to keep it to distinguish between shifting SIDL part from
shift inside the register itself. Anyway I was probably sticking too
much to previous implementation of CAN ID handling. I will rethink and
simplify it further.
>
> > +
> > +             tmp =3D in->can_id & MCBA_CAN_E_SID3_SID10_MASK;
> > +             tmp >>=3D MCBA_CAN_E_SID3_SID10_SHIFT;
> > +             out->sidh =3D tmp;
> > +
> > +             out->eidl =3D in->can_id & MCBA_CAN_EID0_EID7_MASK;
> > +
> > +             tmp =3D in->can_id & MCBA_CAN_EID8_EID15_MASK;
> > +             tmp >>=3D MCBA_CAN_EID8_EID15_SHIFT;
> > +             out->eidh =3D tmp;
>
> I've illustrated where which bit goes to:
>
> struct __packed mcba_usb_msg_can {
>         u8 cmd_id;
>         u8 eidh;                // D
>         u8 eidl;                // C
>         u8 sidh;                // B
>         u8 sidl;                // A
>         u8 dlc;
>         u8 data[8];
>         u8 timestamp[4];
>         u8 checksum;
> };
>
>
> Bits if can_id:
> 3 3 2 2  2 2 2 2  2 2 2 2  1 1 1 1  1 1 1 1  1 1
> 1 0 9 8  7 6 5 4  3 2 1 0  9 8 7 6  5 4 3 2  1 0 9 8  7 6 5 4  3 2 1 0
>
> - - - B  B B B B  B B B A  A A A A  D D D D  D D D D  C C C C  C C C C
>                         4  3 2 1 0
>
> Only the bits of A are noted here.
>
>
> This boils down to:
>
>         u8 eidh =3D can_id >> 8;
>         u8 eidl =3D can_id >> 0;
>         u8 sidh =3D can_id >> 21;
>         u8 sidl =3D (can_id >> 16) & 0x1f;
>
> Can you confirm this odd bit alginment for the sidh and sidl registers?
> When combining eif to a be16 registers this even simplifies to:
>

CAN ID register layout for PIC18F2680.

Standard:
SIDH  | SIDL
10 - 3 | 2 1 0 x x x x x

Extended:
SIDH    |  SIDL                        | EIDH  | EIDL
28 - 21 | 20 19 18 x x x 17 16 | 15 - 8 | 7 - 0

>         __be16 eid;
>         put_unaligned_be16(can_id, &eid);
>
> > +     } else {
> > +             tmp =3D in->can_id & MCBA_CAN_S_SID0_SID2_MASK;
> > +             tmp <<=3D MCBA_SIDL_SID0_SID2_SHIFT;
> > +             out->sidl =3D tmp;
> > +
> > +             tmp =3D in->can_id & MCBA_CAN_S_SID3_SID10_MASK;
> > +             tmp >>=3D MCBA_CAN_S_SID3_SID10_SHIFT;
> > +             out->sidh =3D tmp;
> > +
> > +             out->eidl =3D 0;
> > +             out->eidh =3D 0;
> > +     }
>
> 3 3 2 2  2 2 2 2  2 2 2 2  1 1 1 1  1 1 1 1  1 1
> 1 0 9 8  7 6 5 4  3 2 1 0  9 8 7 6  5 4 3 2  1 0 9 8  7 6 5 4  3 2 1 0
>
>                                                B B B  B B B B  B A A A
>                                                                  7 6 5
>
> Can you again confirm this strange alignment of bits, espeically in the
> sidl register. As only the upper bits a re filled.

See above.

>
> It boils down to:
>
>         u8 eidh =3D 0;
>         u8 eidl =3D ;
>         u8 sidh =3D can_id >> 3;
>         u8 sidl =3D can_id << 5;
>
> > +
> > +     out->dlc =3D get_can_dlc(in->can_dlc);
>
> This function is only used in the rx-path, just use can_dlc here.
ok

>
> > +
> > +     memcpy(out->data, in->data, out->dlc);
> > +
> > +     if (MCBA_CAN_IS_RTR(in))
> > +             out->dlc |=3D MCBA_DLC_RTR_MASK;
> > +}
> > +
> > +/* Send data to device */
> > +static netdev_tx_t mcba_usb_start_xmit(struct sk_buff *skb,
> > +                                    struct net_device *netdev)
> > +{
> > +     struct mcba_priv *priv =3D netdev_priv(netdev);
> > +     struct can_frame *cf =3D (struct can_frame *)skb->data;
> > +     struct mcba_usb_msg_can usb_msg;
> > +
>
>         if (can_dropped_invalid_skb(dev, skb))
>                 return NETDEV_TX_OK;

ok

>
> > +     usb_msg.cmd_id =3D MBCA_CMD_TRANSMIT_MESSAGE_EV;
> > +
> > +     convert_can2usb_msg(cf, &usb_msg);
>
> Can you include this function here. Please convert the skb

Ok, I will inline the function here. What do you mean by converting the skb=
?

>
> > +
> > +     return mcba_usb_xmit(priv, (struct mcba_usb_msg *)&usb_msg, skb);
> > +}
> > +
> > +/* Send data to device */
> > +static void mcba_usb_xmit_cmd(struct mcba_priv *priv,
> > +                           struct mcba_usb_msg *usb_msg)
> > +{
> > +     mcba_usb_xmit(priv, usb_msg, 0);
> > +}
> > +
> > +static void mcba_usb_xmit_change_bitrate(struct mcba_priv *priv, u16 b=
itrate)
> > +{
> > +     struct mcba_usb_msg_change_bitrate usb_msg;
> > +
> > +     usb_msg.cmd_id =3D MBCA_CMD_CHANGE_BIT_RATE;
> > +     put_unaligned_be16(bitrate, &usb_msg.bitrate);
> > +
> > +     mcba_usb_xmit_cmd(priv, (struct mcba_usb_msg *)&usb_msg);
> > +}
> > +
> > +static void mcba_usb_xmit_read_fw_ver(struct mcba_priv *priv, u8 pic)
> > +{
> > +     struct mcba_usb_msg_fw_ver usb_msg;
> > +
> > +     usb_msg.cmd_id =3D MBCA_CMD_READ_FW_VERSION;
> > +     usb_msg.pic =3D pic;
> > +
> > +     mcba_usb_xmit_cmd(priv, (struct mcba_usb_msg *)&usb_msg);
> > +}
> > +
> > +static inline void convert_usb2can_msg(const struct mcba_usb_msg_can *=
in,
> > +                                    struct can_frame *out)
> > +{
> > +     u32 tmp;
> > +
> > +     if (MCBA_USB_IS_EXID(in)) {
> > +             out->can_id =3D in->eidl;
> > +
> > +             tmp =3D in->eidh;
> > +             tmp <<=3D MCBA_CAN_EID8_EID15_SHIFT;
> > +             out->can_id |=3D tmp;
> > +
> > +             tmp =3D in->sidl & MCBA_SIDL_EID16_EID17_MASK;
> > +             tmp <<=3D MCBA_CAN_EID16_EID17_SHIFT;
> > +             out->can_id |=3D tmp;
> > +
> > +             tmp =3D in->sidl & MCBA_SIDL_SID0_SID2_MASK;
> > +             tmp <<=3D MCBA_CAN_E_SID0_SID2_SHIFT - MCBA_SIDL_SID0_SID=
2_SHIFT;
> > +             out->can_id |=3D tmp;
> > +
> > +             tmp =3D in->sidh;
> > +             tmp <<=3D MCBA_CAN_E_SID3_SID10_SHIFT;
> > +             out->can_id |=3D tmp;
> > +
> > +             out->can_id |=3D CAN_EFF_FLAG;
> > +     } else {
> > +             out->can_id =3D in->sidl & MCBA_SIDL_SID0_SID2_MASK;
> > +             out->can_id >>=3D MCBA_SIDL_SID0_SID2_SHIFT;
> > +
> > +             tmp =3D in->sidh;
> > +             tmp <<=3D MCBA_CAN_S_SID3_SID10_SHIFT;
> > +             out->can_id |=3D tmp;
> > +     }
>
> Please convert the bit-fiddling here, too.

Do you mean to simplify it as discussed above for convert_can2usb_msg?
If so then ok.

>
> > +
> > +     if (MCBA_USB_IS_RTR(in))
> > +             out->can_id |=3D CAN_RTR_FLAG;
> > +
> > +     out->can_dlc =3D get_can_dlc(in->dlc & MCBA_DLC_MASK);
> > +
> > +     memcpy(out->data, in->data, out->can_dlc);
> > +}
> > +
> > +static void mcba_usb_process_can(struct mcba_priv *priv,
> > +                              struct mcba_usb_msg_can *msg)
> > +{
> > +     struct can_frame *cf;
> > +     struct sk_buff *skb;
> > +     struct net_device_stats *stats =3D &priv->netdev->stats;
> > +
> > +     skb =3D alloc_can_skb(priv->netdev, &cf);
> > +     if (!skb)
> > +             return;
> > +
> > +     convert_usb2can_msg(msg, cf);
>
> please move this function here.

ok

>
> > +
> > +     stats->rx_packets++;
> > +     stats->rx_bytes +=3D cf->can_dlc;
> > +
> > +     netif_rx(skb);
> > +}
> > +
> > +static void mcba_usb_process_ka_usb(struct mcba_priv *priv,
> > +                                 struct mcba_usb_msg_ka_usb *msg)
> > +{
> > +     if (unlikely(priv->usb_ka_first_pass)) {
> > +             netdev_info(priv->netdev, "PIC USB version %hhu.%hhu\n",
> > +                         msg->soft_ver_major, msg->soft_ver_minor);
> > +
> > +             priv->usb_ka_first_pass =3D false;
> > +     }
> > +
> > +     if (msg->termination_state)
> > +             priv->can.termination =3D MCBA_TERMINATION_ENABLED;
> > +     else
> > +             priv->can.termination =3D MCBA_TERMINATION_DISABLED;
> > +}
> > +
> > +static u32 convert_can2host_bitrate(struct mcba_usb_msg_ka_can *msg)
> > +{
> > +     const u32 bitrate =3D get_unaligned_be16(&msg->can_bitrate);
> > +
> > +     if ((bitrate =3D=3D 33) || (bitrate =3D=3D 83))
> > +             return bitrate * 1000 + 333;
> > +     else
> > +             return bitrate * 1000;
> > +}
> > +
> > +static void mcba_usb_process_ka_can(struct mcba_priv *priv,
> > +                                 struct mcba_usb_msg_ka_can *msg)
> > +{
> > +     if (unlikely(priv->can_ka_first_pass)) {
> > +             netdev_info(priv->netdev, "PIC CAN version %hhu.%hhu\n",
> > +                         msg->soft_ver_major, msg->soft_ver_minor);
> > +
> > +             priv->can_ka_first_pass =3D false;
> > +     }
> > +
> > +     if (unlikely(priv->can_speed_check)) {
> > +             const u32 bitrate =3D convert_can2host_bitrate(msg);
> > +
> > +             priv->can_speed_check =3D false;
> > +
> > +             if (bitrate !=3D priv->can.bittiming.bitrate)
> > +                     netdev_err(
> > +                         priv->netdev,
> > +                         "Wrong bitrate reported by the device (%u). E=
xpected %u",
> > +                         bitrate, priv->can.bittiming.bitrate);
> > +     }
> > +
> > +     priv->bec.txerr =3D msg->tx_err_cnt;
> > +     priv->bec.rxerr =3D msg->rx_err_cnt;
> > +
> > +     if (msg->tx_bus_off)
> > +             priv->can.state =3D CAN_STATE_BUS_OFF;
> > +
> > +     else if ((priv->bec.txerr > MCBA_CAN_STATE_ERR_PSV_TH) ||
> > +              (priv->bec.rxerr > MCBA_CAN_STATE_ERR_PSV_TH))
> > +             priv->can.state =3D CAN_STATE_ERROR_PASSIVE;
> > +
> > +     else if ((priv->bec.txerr > MCBA_CAN_STATE_WRN_TH) ||
> > +              (priv->bec.rxerr > MCBA_CAN_STATE_WRN_TH))
> > +             priv->can.state =3D CAN_STATE_ERROR_WARNING;
> > +}
> > +
> > +static void mcba_usb_process_rx(struct mcba_priv *priv,
> > +                             struct mcba_usb_msg *msg)
> > +{
> > +     switch (msg->cmd_id) {
> > +     case MBCA_CMD_I_AM_ALIVE_FROM_CAN:
> > +             mcba_usb_process_ka_can(priv,
> > +                                     (struct mcba_usb_msg_ka_can *)msg=
);
> > +             break;
> > +
> > +     case MBCA_CMD_I_AM_ALIVE_FROM_USB:
> > +             mcba_usb_process_ka_usb(priv,
> > +                                     (struct mcba_usb_msg_ka_usb *)msg=
);
> > +             break;
> > +
> > +     case MBCA_CMD_RECEIVE_MESSAGE:
> > +             mcba_usb_process_can(priv, (struct mcba_usb_msg_can *)msg=
);
> > +             break;
> > +
> > +     case MBCA_CMD_NOTHING_TO_SEND:
> > +             /* Side effect of communication between PIC_USB and PIC_C=
AN.
> > +              * PIC_CAN is telling us that it has nothing to send
> > +              */
> > +             break;
> > +
> > +     case MBCA_CMD_TRANSMIT_MESSAGE_RSP:
> > +             /* Transmission response from the device containing times=
tamp */
> > +             break;
> > +
> > +     default:
> > +             netdev_warn(priv->netdev, "Unsupported msg (0x%hhX)",
> > +                         msg->cmd_id);
> > +             break;
> > +     }
> > +}
> > +
> > +/* Callback for reading data from device
> > + *
> > + * Check urb status, call read function and resubmit urb read operatio=
n.
> > + */
> > +static void mcba_usb_read_bulk_callback(struct urb *urb)
> > +{
> > +     struct mcba_priv *priv =3D urb->context;
> > +     struct net_device *netdev;
> > +     int retval;
> > +     int pos =3D 0;
> > +
> > +     netdev =3D priv->netdev;
> > +
> > +     if (!netif_device_present(netdev))
> > +             return;
> > +
> > +     switch (urb->status) {
> > +     case 0: /* success */
> > +             break;
> > +
> > +     case -ENOENT:
> > +     case -ESHUTDOWN:
> > +             return;
> > +
> > +     default:
> > +             netdev_info(netdev, "Rx URB aborted (%d)\n", urb->status)=
;
> > +
> > +             goto resubmit_urb;
> > +     }
> > +
> > +     while (pos < urb->actual_length) {
> > +             struct mcba_usb_msg *msg;
> > +
> > +             if (pos + sizeof(struct mcba_usb_msg) > urb->actual_lengt=
h) {
> > +                     netdev_err(priv->netdev, "format error\n");
> > +                     break;
> > +             }
> > +
> > +             msg =3D (struct mcba_usb_msg *)(urb->transfer_buffer + po=
s);
> > +             mcba_usb_process_rx(priv, msg);
> > +
> > +             pos +=3D sizeof(struct mcba_usb_msg);
> > +     }
> > +
> > +resubmit_urb:
> > +
> > +     usb_fill_bulk_urb(urb, priv->udev,
> > +                       usb_rcvbulkpipe(priv->udev, MCBA_USB_EP_OUT),
> > +                       urb->transfer_buffer, MCBA_USB_RX_BUFF_SIZE,
> > +                       mcba_usb_read_bulk_callback, priv);
> > +
> > +     retval =3D usb_submit_urb(urb, GFP_ATOMIC);
> > +
> > +     if (retval =3D=3D -ENODEV)
> > +             netif_device_detach(netdev);
> > +     else if (retval)
> > +             netdev_err(netdev, "failed resubmitting read bulk urb: %d=
\n",
> > +                        retval);
> > +}
> > +
> > +/* Start USB device */
> > +static int mcba_usb_start(struct mcba_priv *priv)
> > +{
> > +     struct net_device *netdev =3D priv->netdev;
> > +     int err, i;
> > +
> > +     for (i =3D 0; i < MCBA_MAX_RX_URBS; i++) {
> > +             struct urb *urb =3D NULL;
> > +             u8 *buf;
> > +
> > +             /* create a URB, and a buffer for it */
> > +             urb =3D usb_alloc_urb(0, GFP_KERNEL);
> > +             if (!urb) {
> > +                     err =3D -ENOMEM;
> > +                     break;
> > +             }
> > +
> > +             buf =3D usb_alloc_coherent(priv->udev, MCBA_USB_RX_BUFF_S=
IZE,
> > +                                      GFP_KERNEL, &urb->transfer_dma);
> > +             if (!buf) {
> > +                     netdev_err(netdev, "No memory left for USB buffer=
\n");
> > +                     usb_free_urb(urb);
> > +                     err =3D -ENOMEM;
> > +                     break;
> > +             }
> > +
> > +             usb_fill_bulk_urb(urb, priv->udev,
> > +                               usb_rcvbulkpipe(priv->udev, MCBA_USB_EP=
_IN),
> > +                               buf, MCBA_USB_RX_BUFF_SIZE,
> > +                               mcba_usb_read_bulk_callback, priv);
> > +             urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> > +             usb_anchor_urb(urb, &priv->rx_submitted);
> > +
> > +             err =3D usb_submit_urb(urb, GFP_KERNEL);
> > +             if (err) {
> > +                     usb_unanchor_urb(urb);
> > +                     usb_free_coherent(priv->udev, MCBA_USB_RX_BUFF_SI=
ZE,
> > +                                       buf, urb->transfer_dma);
> > +                     usb_free_urb(urb);
> > +                     break;
> > +             }
> > +
> > +             /* Drop reference, USB core will take care of freeing it =
*/
> > +             usb_free_urb(urb);
> > +     }
> > +
> > +     /* Did we submit any URBs */
> > +     if (i =3D=3D 0) {
> > +             netdev_warn(netdev, "couldn't setup read URBs\n");
> > +             return err;
> > +     }
> > +
> > +     /* Warn if we've couldn't transmit all the URBs */
> > +     if (i < MCBA_MAX_RX_URBS)
> > +             netdev_warn(netdev, "rx performance may be slow\n");
> > +
> > +     mcba_init_ctx(priv);
> > +     mcba_usb_xmit_read_fw_ver(priv, MCBA_VER_REQ_USB);
> > +     mcba_usb_xmit_read_fw_ver(priv, MCBA_VER_REQ_CAN);
> > +
> > +     return err;
> > +}
> > +
> > +/* Open USB device */
> > +static int mcba_usb_open(struct net_device *netdev)
> > +{
> > +     struct mcba_priv *priv =3D netdev_priv(netdev);
> > +     int err;
> > +
> > +     /* common open */
> > +     err =3D open_candev(netdev);
> > +     if (err)
> > +             return err;
> > +
> > +     priv->can_speed_check =3D true;
> > +     priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> > +
> > +     netif_start_queue(netdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static void mcba_urb_unlink(struct mcba_priv *priv)
> > +{
> > +     usb_kill_anchored_urbs(&priv->rx_submitted);
> > +     usb_kill_anchored_urbs(&priv->tx_submitted);
> > +}
> > +
> > +/* Close USB device */
> > +static int mcba_usb_close(struct net_device *netdev)
> > +{
> > +     struct mcba_priv *priv =3D netdev_priv(netdev);
> > +
> > +     priv->can.state =3D CAN_STATE_STOPPED;
> > +
> > +     netif_stop_queue(netdev);
> > +
> > +     /* Stop polling */
> > +     mcba_urb_unlink(priv);
> > +
> > +     close_candev(netdev);
> > +
> > +     return 0;
> > +}
> > +
> > +/* Set network device mode
> > + *
> > + * Maybe we should leave this function empty, because the device
> > + * set mode variable with open command.
> > + */
> > +static int mcba_net_set_mode(struct net_device *netdev, enum can_mode =
mode)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int mcba_net_get_berr_counter(const struct net_device *netdev,
> > +                                  struct can_berr_counter *bec)
> > +{
> > +     struct mcba_priv *priv =3D netdev_priv(netdev);
> > +
> > +     bec->txerr =3D priv->bec.txerr;
> > +     bec->rxerr =3D priv->bec.rxerr;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct net_device_ops mcba_netdev_ops =3D {
> > +     .ndo_open =3D mcba_usb_open,
> > +     .ndo_stop =3D mcba_usb_close,
> > +     .ndo_start_xmit =3D mcba_usb_start_xmit,
> > +};
> > +
> > +/* Microchip CANBUS has hardcoded bittiming values by default.
> > + * This function sends request via USB to change the speed and align b=
ittiming
> > + * values for presentation purposes only
> > + */
> > +static int mcba_net_set_bittiming(struct net_device *netdev)
> > +{
> > +     struct mcba_priv *priv =3D netdev_priv(netdev);
> > +     const u16 bitrate_kbps =3D (u16)(priv->can.bittiming.bitrate / 10=
00);
>
> cast not needed
ok

>
> > +
> > +     mcba_usb_xmit_change_bitrate(priv, bitrate_kbps);
> > +
> > +     return 0;
> > +}
> > +
> > +static int mcba_set_termination(struct net_device *netdev, u16 term)
> > +{
> > +     struct mcba_priv *priv =3D netdev_priv(netdev);
> > +     struct mcba_usb_msg_terminaton usb_msg;
> > +
> > +     usb_msg.cmd_id =3D MBCA_CMD_SETUP_TERMINATION_RESISTANCE;
> > +
> > +     if (term =3D=3D MCBA_TERMINATION_ENABLED)
> > +             usb_msg.termination =3D 1;
> > +     else
> > +             usb_msg.termination =3D 0;
> > +
> > +     mcba_usb_xmit_cmd(priv, (struct mcba_usb_msg *)&usb_msg);
> > +
> > +     return 0;
> > +}
> > +
> > +static int mcba_usb_probe(struct usb_interface *intf,
> > +                       const struct usb_device_id *id)
> > +{
> > +     struct net_device *netdev;
> > +     struct mcba_priv *priv;
> > +     int err =3D -ENOMEM;
> > +     struct usb_device *usbdev =3D interface_to_usbdev(intf);
> > +
> > +     dev_info(&intf->dev, "Microchip CAN BUS analizer connected\n");
>
> If you want to print, then after successfull registration.

ok

>
> > +
> > +     netdev =3D alloc_candev(sizeof(struct mcba_priv), MCBA_MAX_TX_URB=
S);
> > +     if (!netdev) {
> > +             dev_err(&intf->dev, "Couldn't alloc candev\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     priv =3D netdev_priv(netdev);
> > +
> > +     priv->udev =3D usbdev;
> > +     priv->netdev =3D netdev;
> > +     priv->usb_ka_first_pass =3D true;
> > +     priv->can_ka_first_pass =3D true;
> > +     priv->can_speed_check =3D false;
> > +
> > +     init_usb_anchor(&priv->rx_submitted);
> > +     init_usb_anchor(&priv->tx_submitted);
> > +
> > +     usb_set_intfdata(intf, priv);
> > +
> > +     /* Init CAN device */
> > +     priv->can.state =3D CAN_STATE_STOPPED;
> > +     priv->can.termination_const =3D mcba_termination;
> > +     priv->can.termination_const_cnt =3D ARRAY_SIZE(mcba_termination);
> > +     priv->can.bitrate_const =3D mcba_bitrate;
> > +     priv->can.bitrate_const_cnt =3D ARRAY_SIZE(mcba_bitrate);
> > +
> > +     priv->can.do_set_termination =3D mcba_set_termination;
> > +     priv->can.do_set_mode =3D mcba_net_set_mode;
> > +     priv->can.do_get_berr_counter =3D mcba_net_get_berr_counter;
> > +     priv->can.do_set_bittiming =3D mcba_net_set_bittiming;
> > +
> > +     netdev->netdev_ops =3D &mcba_netdev_ops;
> > +
> > +     netdev->flags |=3D IFF_ECHO; /* we support local echo */
> > +
> > +     SET_NETDEV_DEV(netdev, &intf->dev);
> > +
> > +     err =3D register_candev(netdev);
> > +     if (err) {
> > +             netdev_err(netdev, "couldn't register CAN device: %d\n", =
err);
> > +
> > +             netif_device_detach(priv->netdev);
> > +
> > +             goto cleanup_candev;
> > +     }
> > +
> > +     /* Start USB device only if we have successfuly registered CAN de=
vice */
> > +     err =3D mcba_usb_start(priv);
> > +     if (err) {
> > +             if (err =3D=3D -ENODEV)
> > +                     netif_device_detach(priv->netdev);
> > +
> > +             netdev_warn(netdev, "couldn't start device: %d\n", err);
> > +
> > +             goto cleanup_candev;
> > +     }
> > +
> > +     return err;
> > +
> > +cleanup_candev:
> > +     free_candev(netdev);
> > +
> > +     return err;
> > +}
> > +
> > +/* Called by the usb core when driver is unloaded or device is removed=
 */
> > +static void mcba_usb_disconnect(struct usb_interface *intf)
> > +{
> > +     struct mcba_priv *priv =3D usb_get_intfdata(intf);
> > +
> > +     usb_set_intfdata(intf, NULL);
> > +
> > +     netdev_info(priv->netdev, "device disconnected\n");
> > +
> > +     unregister_candev(priv->netdev);
> > +     free_candev(priv->netdev);
> > +
> > +     mcba_urb_unlink(priv);
> > +}
> > +
> > +static struct usb_driver mcba_usb_driver =3D {
> > +     .name =3D MCBA_MODULE_NAME,
> > +     .probe =3D mcba_usb_probe,
> > +     .disconnect =3D mcba_usb_disconnect,
> > +     .id_table =3D mcba_usb_table,
> > +};
> > +
> > +module_usb_driver(mcba_usb_driver);
> > +
> > +MODULE_AUTHOR("Remigiusz Ko=C5=82=C5=82=C4=85taj <remigiusz.kollataj@m=
obica.com>");
> > +MODULE_DESCRIPTION("SocketCAN driver for Microchip CAN BUS Analyzer To=
ol");
> > +MODULE_LICENSE("GPL v2");
> >
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>

Regards,
Remik

--=20
____________________
Remigiusz Ko=C5=82=C5=82=C4=85taj
Mobica Ltd
Technology Consultant
Skype: remigiusz.kollataj
www.mobica.com
