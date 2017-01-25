From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [PATCH v2 1/1] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
Date: Wed, 25 Jan 2017 11:40:47 +0100
Message-ID: <CAKT-o-eNdewrUV==EoQ5CQDQeP7QpMTX0sTNq1+E=5Xs1uX1mg@mail.gmail.com>
References: <20170119122949.30488-1-remigiusz.kollataj@mobica.com>
 <20170119122949.30488-2-remigiusz.kollataj@mobica.com> <034e0cec-6179-b9e0-256b-d1ae46e4fb14@pengutronix.de>
 <CAKT-o-du56JbYczGF7cTn5MRvn3Rsp0sd3MBykfkhf9mjC1mFw@mail.gmail.com> <94b84a9c-50a1-93ee-c2d5-740b3e6956f7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35957 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdAYKlO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2017 05:41:14 -0500
Received: by mail-vk0-f50.google.com with SMTP id t8so130949028vke.3
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2017 02:41:08 -0800 (PST)
In-Reply-To: <94b84a9c-50a1-93ee-c2d5-740b3e6956f7@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

I am preparing third patch that will address all items you have
mentioned before.

On 20 January 2017 at 13:55, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 01/20/2017 01:32 PM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
>
> >>> +     u16 rx_lost;     /* LE */
> >>
> >> __le16
> >
> > ok. I realize LE here is odd. However I have rechecked it in firmware
> > code and this is correct.
>
> Thanks.
>
> >>> +/* Send data to device */
> >>> +static netdev_tx_t mcba_usb_xmit(struct mcba_priv *priv,
> >>> +                              struct mcba_usb_msg *usb_msg,
> >>> +                              struct sk_buff *skb)
> >>> +{
> >>> +     struct net_device_stats *stats =3D &priv->netdev->stats;
> >>> +     struct mcba_usb_ctx *ctx =3D NULL;
> >>> +     struct urb *urb;
> >>> +     u8 *buf;
> >>> +     int err;
> >>> +
> >>> +     ctx =3D mcba_usb_get_free_ctx(priv);
> >>> +     if (!ctx) {
> >>> +             /* Slow down tx path */
> >>> +             netif_stop_queue(priv->netdev);
> >>
> >> Call netif_stop_queue if use use the last tx buffer, not when it's too
> >> late. This makes no sense here, as this function is not exclusively us=
ed
> >> by to send CAN frames. Why do you use this function for sending non CA=
N
> >> frames? usb_8dev has usb_8dev_send_cmd().
> >
> > Unfortunately the device has only one common USB endpoint. 8dev has
> > separate endpoints for cmd and frames. Shall I remove netif_stop_queue
> > in such case and leave NETDEV_TX_BUSY return only?
>
> Oh, I see. Only one USB endpoint is the problem here. Let me think of a
> nice solution.
>

The driver have in fact only 4 commands that are sent to the device:
- mcba_usb_xmit_change_bitrate
- mcba_usb_xmit_read_fw_ver
- mcba_set_termination

bitrate is sent only when device is down (i.e. CAN frames are not
transmitted), fw version reading is invoked only once at the USB
startup. So the only message that can in fact influence CAN data flow
is setting the termination. I do no expect that it will be called too
often. Taking this into consideration I would treat the endpoint as
CAN data "exclusive".


>
> [...]
>
> >>> +static inline void convert_can2usb_msg(const struct can_frame *in,
> >>> +                                    struct mcba_usb_msg_can *out)
> >>> +{
> >>> +     u32 tmp;
> >>> +
> >>> +     if (MCBA_CAN_IS_EXID(in)) {
> >>> +             out->sidl =3D MCBA_SIDL_EXID_MASK;
> >>> +
> >>> +             tmp =3D in->can_id & MCBA_CAN_E_SID0_SID2_MASK;
> >>> +             tmp >>=3D MCBA_CAN_E_SID0_SID2_SHIFT - MCBA_SIDL_SID0_S=
ID2_SHIFT;
> >>> +             out->sidl |=3D tmp;
> >>> +
> >>> +             tmp =3D in->can_id & MCBA_CAN_EID16_EID17_MASK;
> >>> +             tmp >>=3D MCBA_CAN_EID16_EID17_SHIFT;
> >>> +             out->sidl |=3D tmp;
> >>
> >> Why don't you combine both sift and mask operations?
> >
> > I decided to keep it to distinguish between shifting SIDL part from
> > shift inside the register itself. Anyway I was probably sticking too
> > much to previous implementation of CAN ID handling. I will rethink and
> > simplify it further.
>
> Ok

I have simplified CAN ID conversion in the latest patch. I hope it
will be easier to understand it now.

>
> >>> +
> >>> +             tmp =3D in->can_id & MCBA_CAN_E_SID3_SID10_MASK;
> >>> +             tmp >>=3D MCBA_CAN_E_SID3_SID10_SHIFT;
> >>> +             out->sidh =3D tmp;
> >>> +
> >>> +             out->eidl =3D in->can_id & MCBA_CAN_EID0_EID7_MASK;
> >>> +
> >>> +             tmp =3D in->can_id & MCBA_CAN_EID8_EID15_MASK;
> >>> +             tmp >>=3D MCBA_CAN_EID8_EID15_SHIFT;
> >>> +             out->eidh =3D tmp;
> >>
> >> I've illustrated where which bit goes to:
> >>
> >> struct __packed mcba_usb_msg_can {
> >>         u8 cmd_id;
> >>         u8 eidh;                // D
> >>         u8 eidl;                // C
> >>         u8 sidh;                // B
> >>         u8 sidl;                // A
> >>         u8 dlc;
> >>         u8 data[8];
> >>         u8 timestamp[4];
> >>         u8 checksum;
> >> };
> >>
> >>
> >> Bits if can_id:
> >> 3 3 2 2  2 2 2 2  2 2 2 2  1 1 1 1  1 1 1 1  1 1
> >> 1 0 9 8  7 6 5 4  3 2 1 0  9 8 7 6  5 4 3 2  1 0 9 8  7 6 5 4  3 2 1 0
> >>
> >> - - - B  B B B B  B B B A  A A A A  D D D D  D D D D  C C C C  C C C C
> >>                         4  3 2 1 0
> >>
> >> Only the bits of A are noted here.
> >>
> >>
> >> This boils down to:
> >>
> >>         u8 eidh =3D can_id >> 8;
> >>         u8 eidl =3D can_id >> 0;
> >>         u8 sidh =3D can_id >> 21;
> >>         u8 sidl =3D (can_id >> 16) & 0x1f;
> >>
> >> Can you confirm this odd bit alginment for the sidh and sidl registers=
?
> >> When combining eif to a be16 registers this even simplifies to:
> >>
> >
> > CAN ID register layout for PIC18F2680.
> >
> > Standard:
> > SIDH  | SIDL
> > 10 - 3 | 2 1 0 x x x x x
> >
> > Extended:
> > SIDH    |  SIDL                |  EIDH  | EIDL
> > 28 - 21 | 20 19 18 x x x 17 16 | 15 - 8 | 7 - 0
>
> Ok for SIDH, EID and EIDL.
> Let me re-read your code for SIDL.
>
>
> 0x001c0000 >> (18 - 5) =3D 0xe0
> 0x00030000 >>  16      =3D 0x03
>                          0xe3
>
> Which is what your diagram shows. Sorry, I was wrong here.
>
>         u8 eidh =3D can_id >> 8;
>         u8 eidl =3D can_id >> 0;
>         u8 sidh =3D can_id >> 21;
>         u8 sidl =3D (can_id >> 16) & 0x03 |
>                   (can_id >> 13) & 0xe0;
>
> >
> >>         __be16 eid;
> >>         put_unaligned_be16(can_id, &eid);
> >>
> >>> +     } else {
> >>> +             tmp =3D in->can_id & MCBA_CAN_S_SID0_SID2_MASK;
> >>> +             tmp <<=3D MCBA_SIDL_SID0_SID2_SHIFT;
> >>> +             out->sidl =3D tmp;
> >>> +
> >>> +             tmp =3D in->can_id & MCBA_CAN_S_SID3_SID10_MASK;
> >>> +             tmp >>=3D MCBA_CAN_S_SID3_SID10_SHIFT;
> >>> +             out->sidh =3D tmp;
> >>> +
> >>> +             out->eidl =3D 0;
> >>> +             out->eidh =3D 0;
> >>> +     }
> >>
> >> 3 3 2 2  2 2 2 2  2 2 2 2  1 1 1 1  1 1 1 1  1 1
> >> 1 0 9 8  7 6 5 4  3 2 1 0  9 8 7 6  5 4 3 2  1 0 9 8  7 6 5 4  3 2 1 0
> >>
> >>                                                B B B  B B B B  B A A A
> >>                                                                  7 6 5
> >>
> >> Can you again confirm this strange alignment of bits, espeically in th=
e
> >> sidl register. As only the upper bits a re filled.
> >
> > See above.
>
> Strange assembly of the bits - but I read your code and your diagram the
> same.
>
> >
> >>
> >> It boils down to:
> >>
> >>         u8 eidh =3D 0;
> >>         u8 eidl =3D 0;
> >>         u8 sidh =3D can_id >> 3;
> >>         u8 sidl =3D can_id << 5;
> >>
> >>> +
> >>> +     out->dlc =3D get_can_dlc(in->can_dlc);
> >>
> >> This function is only used in the rx-path, just use can_dlc here.
> > ok
> >
> >>
> >>> +
> >>> +     memcpy(out->data, in->data, out->dlc);
> >>> +
> >>> +     if (MCBA_CAN_IS_RTR(in))
> >>> +             out->dlc |=3D MCBA_DLC_RTR_MASK;
> >>> +}
> >>> +
> >>> +/* Send data to device */
> >>> +static netdev_tx_t mcba_usb_start_xmit(struct sk_buff *skb,
> >>> +                                    struct net_device *netdev)
> >>> +{
> >>> +     struct mcba_priv *priv =3D netdev_priv(netdev);
> >>> +     struct can_frame *cf =3D (struct can_frame *)skb->data;
> >>> +     struct mcba_usb_msg_can usb_msg;
> >>> +
> >>
> >>         if (can_dropped_invalid_skb(dev, skb))
> >>                 return NETDEV_TX_OK;
> >
> > ok
> >
> >>
> >>> +     usb_msg.cmd_id =3D MBCA_CMD_TRANSMIT_MESSAGE_EV;
> >>> +
> >>> +     convert_can2usb_msg(cf, &usb_msg);
> >>
> >> Can you include this function here. Please convert the skb
> >
> > Ok, I will inline the function here. What do you mean by converting the=
 skb?
>
> The one endpoint problem makes it more difficult here. But I meant
> converting all information from the skb into the usb_msg and then call
> mcba_usb_xmit(). Which is not possible, due to the one-endpoint.
>

I have excluded "netdev" part from mcba_usb_xmit in the newest patch.
It is purely USB related now.

> >>> +
> >>> +     return mcba_usb_xmit(priv, (struct mcba_usb_msg *)&usb_msg, skb=
);
> >>> +}
> >>> +
> >>> +/* Send data to device */
> >>> +static void mcba_usb_xmit_cmd(struct mcba_priv *priv,
> >>> +                           struct mcba_usb_msg *usb_msg)
> >>> +{
> >>> +     mcba_usb_xmit(priv, usb_msg, 0);
> >>> +}
> >>> +
> >>> +static void mcba_usb_xmit_change_bitrate(struct mcba_priv *priv, u16=
 bitrate)
> >>> +{
> >>> +     struct mcba_usb_msg_change_bitrate usb_msg;
> >>> +
> >>> +     usb_msg.cmd_id =3D MBCA_CMD_CHANGE_BIT_RATE;
> >>> +     put_unaligned_be16(bitrate, &usb_msg.bitrate);
> >>> +
> >>> +     mcba_usb_xmit_cmd(priv, (struct mcba_usb_msg *)&usb_msg);
> >>> +}
> >>> +
> >>> +static void mcba_usb_xmit_read_fw_ver(struct mcba_priv *priv, u8 pic=
)
> >>> +{
> >>> +     struct mcba_usb_msg_fw_ver usb_msg;
> >>> +
> >>> +     usb_msg.cmd_id =3D MBCA_CMD_READ_FW_VERSION;
> >>> +     usb_msg.pic =3D pic;
> >>> +
> >>> +     mcba_usb_xmit_cmd(priv, (struct mcba_usb_msg *)&usb_msg);
> >>> +}
> >>> +
> >>> +static inline void convert_usb2can_msg(const struct mcba_usb_msg_can=
 *in,
> >>> +                                    struct can_frame *out)
> >>> +{
> >>> +     u32 tmp;
> >>> +
> >>> +     if (MCBA_USB_IS_EXID(in)) {
> >>> +             out->can_id =3D in->eidl;
> >>> +
> >>> +             tmp =3D in->eidh;
> >>> +             tmp <<=3D MCBA_CAN_EID8_EID15_SHIFT;
> >>> +             out->can_id |=3D tmp;
> >>> +
> >>> +             tmp =3D in->sidl & MCBA_SIDL_EID16_EID17_MASK;
> >>> +             tmp <<=3D MCBA_CAN_EID16_EID17_SHIFT;
> >>> +             out->can_id |=3D tmp;
> >>> +
> >>> +             tmp =3D in->sidl & MCBA_SIDL_SID0_SID2_MASK;
> >>> +             tmp <<=3D MCBA_CAN_E_SID0_SID2_SHIFT - MCBA_SIDL_SID0_S=
ID2_SHIFT;
> >>> +             out->can_id |=3D tmp;
> >>> +
> >>> +             tmp =3D in->sidh;
> >>> +             tmp <<=3D MCBA_CAN_E_SID3_SID10_SHIFT;
> >>> +             out->can_id |=3D tmp;
> >>> +
> >>> +             out->can_id |=3D CAN_EFF_FLAG;
> >>> +     } else {
> >>> +             out->can_id =3D in->sidl & MCBA_SIDL_SID0_SID2_MASK;
> >>> +             out->can_id >>=3D MCBA_SIDL_SID0_SID2_SHIFT;
> >>> +
> >>> +             tmp =3D in->sidh;
> >>> +             tmp <<=3D MCBA_CAN_S_SID3_SID10_SHIFT;
> >>> +             out->can_id |=3D tmp;
> >>> +     }
> >>
> >> Please convert the bit-fiddling here, too.
> >
> > Do you mean to simplify it as discussed above for convert_can2usb_msg?
> > If so then ok.
>
> yes.
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>

Cheers,
Remik

--=20
____________________
Remigiusz Ko=C5=82=C5=82=C4=85taj
Mobica Ltd
Technology Consultant
Skype: remigiusz.kollataj
www.mobica.com
