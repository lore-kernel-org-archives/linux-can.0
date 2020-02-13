From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: FW: [PATCH] can/peak_canfd: fix echo management when loopback is on
Date: Thu, 13 Feb 2020 15:42:22 +0000
Message-ID: <DB6PR03MB3093B69C542061D1AE7DE745D61A0@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <20200204153357.25424-1-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:8952
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729821AbgBMPm1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 13 Feb 2020 10:42:27 -0500
In-Reply-To: <20200204153357.25424-1-s.grosjean@peak-system.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>

Hello,

AFAIK I have no news about that patch...

Best regards,

- St=E9phane

> -----Original Message-----
> From: Stephane Grosjean <s.grosjean@peak-system.com>
> Sent: mardi 4 f=E9vrier 2020 16:34
> To: linux-can Mailing List <linux-can@vger.kernel.org>
> Cc: St=E9phane Grosjean <s.grosjean@peak-system.com>
> Subject: [PATCH] can/peak_canfd: fix echo management when loopback is
> on
>
> Echo management is driven by PUCAN_MSG_LOOPED_BACK bit, while
> loopback frames are identified with PUCAN_MSG_SELF_RECEIVE bit. Those
> bits are set for each outgoing frame written to the IP core so that a cop=
y of
> each one will be placed into the rx path. Thus,
>
> - when PUCAN_MSG_LOOPED_BACK is set then the rx frame is an echo of a
>   previously sent frame,
> - when PUCAN_MSG_LOOPED_BACK+PUCAN_MSG_SELF_RECEIVE are set,
> then the rx
>   frame is an echo AND a loopback frame. Therefore, this frame must be
>   put into the socket rx path too.
>
> This patch fixes how CAN frames are handled when these are sent while the
> CAN interface is configured in "loopback on" mode.
>
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/peak_canfd/peak_canfd.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/peak_canfd/peak_canfd.c
> b/drivers/net/can/peak_canfd/peak_canfd.c
> index 10aa3e457c33..40c33b8a5fda 100644
> --- a/drivers/net/can/peak_canfd/peak_canfd.c
> +++ b/drivers/net/can/peak_canfd/peak_canfd.c
> @@ -262,8 +262,7 @@ static int pucan_handle_can_rx(struct
> peak_canfd_priv *priv,
>                 cf_len =3D get_can_dlc(pucan_msg_get_dlc(msg));
>
>         /* if this frame is an echo, */
> -       if ((rx_msg_flags & PUCAN_MSG_LOOPED_BACK) &&
> -           !(rx_msg_flags & PUCAN_MSG_SELF_RECEIVE)) {
> +       if (rx_msg_flags & PUCAN_MSG_LOOPED_BACK) {
>                 unsigned long flags;
>
>                 spin_lock_irqsave(&priv->echo_lock, flags); @@ -277,7 +27=
6,13 @@
> static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
>                 netif_wake_queue(priv->ndev);
>
>                 spin_unlock_irqrestore(&priv->echo_lock, flags);
> -               return 0;
> +
> +               /* if this frame is only an echo, stop here. Otherwise,
> +                * continue to push this application self-received frame =
into
> +                * its own rx queue.
> +                */
> +               if (!(rx_msg_flags & PUCAN_MSG_SELF_RECEIVE))
> +                       return 0;
>         }
>
>         /* otherwise, it should be pushed into rx fifo */
> --
> 2.20.1
>
>
> --
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt - HRB 9183
> Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm Unsere
> Datenschutzerklaerung mit wichtigen Hinweisen zur Behandlung
> personenbezogener Daten finden Sie unter www.peak-
> system.com/Datenschutz.483.0.html

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
