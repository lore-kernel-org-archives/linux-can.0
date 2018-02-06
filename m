From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH] can: ucan: add driver for Theobroma Systems UCAN devices
Date: Tue, 06 Feb 2018 11:58:17 +0000
Message-ID: <151791829759.10539.108405894622744980@maxwell>
References: <20180202105949.35468-1-jakob.unterwurzacher@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:43520
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752952AbeBFL63 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 6 Feb 2018 06:58:29 -0500
In-Reply-To: <20180202105949.35468-1-jakob.unterwurzacher@theobroma-systems.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Hi Jakob

I like this idea! This is a lot better idea than to use CDC-ACM with slcan.

Quoting Jakob Unterwurzacher (2018-02-02 10:59:49)
> +The UCAN Protocol
> +-----------------
> +
> +UCAN is an microcontroller-based USB-CAN interface that is
> +integrated on System-on-Modules from Theobroma Systems and that
> +is also available as a standalone USB stick.
Great! Where can I buy one?

> +
> +The UCAN protocol has been designed to be hardware-independent.
> +It is modeled closely after how Linux represents CAN devices
> +internally. All multi-byte integers are encoded as Little Endian.
> +
> +All structures mentioned in this document are defined in
> +drivers/net/can/usb/ucan.h .
> +
> +
> +USB Endpoints
> +-------------
> +
> +An UCAN device uses three USB endpoints:
Even tough "U" is a vowel, in this case, most english speaking people will =
read
this as "Yoocan", which makes it awkward to say "An" in front of it. I reco=
mmend
that you change the "An" to an "A".

[...]

Nitpick: Is it not evident by the function's name what it does?
> +/* Request the device Information */
> +static int ucan_get_device_info(struct ucan *up)
> +{
[...]

Missing one "t" in the word "state":
> +/* Callback when the device sends the IRQ sate *
> + *
> + * This function simply stores the current TX fifo state for flow
> + * control
> + */
> +static void ucan_read_irq_callback(struct urb *urb)
> +{

[...]

> +/* Callback on reception of a can frame via the IN endpoint
> + *
s/transferres/transfers here:
> + * This function allocates an skb and transferres it to the Linux
> + * network stack
> + */
> +static void ucan_rx_can_msg(struct ucan *up, struct ucan_message_in *m)
> +{
[...]
> +
> +       /* handle can error frames */
> +       if (cf->can_id & CAN_ERR_FLAG) {
> +               if (cf->can_id & CAN_ERR_BUSOFF) {
> +                       up->can.can_stats.bus_off++;
> +                       can_bus_off(up->netdev);
> +               }
> +
> +               if (cf->data[1] &
> +                   (CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING)) {
> +                       up->can.can_stats.error_warning++;
> +               }
> +
> +               if (cf->data[1] &
I think you mean to say CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE:
> +                   (CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING)) {
> +                       up->can.can_stats.error_passive++;
> +               }

Question: Does UCAN send CAN_ERR_CRTL_ACTIVE when the controller has recove=
red
back to error active?

It seems that up->can.state is not set anywhere. The state should be set so=
 that
it can be reported via netlink.
> +
> +               if (cf->data[1] & CAN_ERR_CRTL_RX_OVERFLOW)
> +                       stats->rx_over_errors++;
> +
> +               if (cf->can_id & CAN_ERR_LOSTARB)
> +                       up->can.can_stats.arbitration_lost++;
> +
> +               if (cf->can_id & CAN_ERR_BUSERROR)
> +                       up->can.can_stats.bus_error++;
> +
> +               if (cf->data[2] & CAN_ERR_PROT_TX)
> +                       stats->tx_errors++;
> +               else
> +                       stats->rx_errors++;
> +
> +               cf->can_id |=3D CAN_ERR_FLAG;
> +       }
[...] =


Nitpick: This function has a lot of code segments with comments that explain
what they do. It might be a good idea to turn those segments into their own
functions. This applies to other functions aswell. Anyhow, this is one of t=
hose
things that some people would call "a matter of taste", so don't sweat it.
> +/* callback when Linux needs to send a can frame */
> +static netdev_tx_t ucan_start_xmit(struct sk_buff *skb,
> +                                  struct net_device *netdev)
> +{
[...]

What is the purpose of having a separate message struct for RTR? Does it not
just complicate things? Sure, you can shave off 8 bytes, but what's the poi=
nt?
> +               /***************************************************
> +                * Transmit CAN frame
> +                * (type =3D=3D UCAN_TX) && ((msg.can_msg.id & CAN_RTR_FL=
AG) =3D=3D 0)
> +                ***************************************************/
> +               struct {
> +                        /* note DLC is computed by
> +                         *    msg.len - sizeof (msg.len)
> +                         *            - sizeof (msg.type)
> +                         *            - sizeof (msg.can_msg.id)
> +                         */
> +                       u32 id;
> +                       u8 data[8];
> +                       /* ensure data alignment to 4
> +                        * by moving dlc after data
> +                        */
> +               } __packed can_msg;
> +
> +               /***************************************************
> +                * Transmit RTR CAN frame
> +                * (type =3D=3D UCAN_TX) && ((msg.can_msg.id & CAN_RTR_FL=
AG) !=3D 0)
> +                ***************************************************/
> +               struct {
> +                       u32 id;
> +                       u8 dlc;
> +               } __packed can_rtr_msg;
> +
[...]

Same comment as above for the RTR:
> +               /***************************************************
> +                * CAN Frame received
> +                * (type =3D=3D UCAN_IN_RX)
> +                * && ((msg.can_msg.id & CAN_RTR_FLAG) =3D=3D 0)
> +                ***************************************************/
> +               struct {
> +                        /* note DLC is computed by
> +                         *    msg.len - sizeof (msg.len)
> +                         *            - sizeof (msg.type)
> +                         *            - sizeof (msg.can_msg.id)
> +                         */
> +                       u32 id;
> +                       u8 data[8];
> +                       /* ensure data alignment to 4
> +                        * by moving dlc after data
> +                        */
> +               } __packed can_msg;
> +
> +               /***************************************************
> +                * CAN RTR Frame received
> +                * (type =3D=3D UCAN_IN_RX)
> +                * && ((msg.can_msg.id & CAN_RTR_FLAG) !=3D 0)
> +                ***************************************************/
> +               struct {
> +                       u32 id;
> +                       u8 dlc;
> +               } __packed can_rtr_msg;
> +
> +       } __aligned(0x4) msg;
> +} __packed;

Like I said before, this seems like a good idea and I'm looking forward to
seeing the USB stick on the market, and to see this driver develop further.

By the way, I'm curious, will it be possible to update the firmware on the =
USB
stick via the USB?

Best regards,
Andri
