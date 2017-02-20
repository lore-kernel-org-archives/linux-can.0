From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: ti_hecc: canfdtest rx freeze
Date: Mon, 20 Feb 2017 15:40:30 +0100
Message-ID: <d27ec4f1-1c6c-f7d1-05f8-c5b3d202fd6c@grandegger.com>
References: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:42116 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbdBTOr3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2017 09:47:29 -0500
In-Reply-To: <CAGm1_kux90=SkCquSB3Rdh0rJdQA1DPgt42849sw-pvnNWBAXA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "Grim, Dennis" <Dennis.Grim@teejet.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Hello Yegor,

Am 20.02.2017 um 10:08 schrieb Yegor Yefremov:
> I have a trouble with ti_hecc driver. When doing tx I have no
> problems, but rx path freezes after about 18 frames.
>
> The problem is that in ti_hecc_rx_poll() the while loop will be left
> when we flip the mailboxes:
>
>                 } else if (priv->rx_next == HECC_MAX_TX_MBOX - 1) {
>                         priv->rx_next = HECC_RX_FIRST_MBOX;
>                         break;
>                 }
>
> but, if there are still unhandled packets we leave the routine without
> enabling RX mailbox interrupts. So if we don't receive any other
> interrupts CAN interface "freezes". So removing break fixes this
> issue.
>
> But when running canfdtest -vv can0 for example against PEAK's USB-CAN
> ti_hecc stops to receive frames after about 1 minute. Invoking "ip
> link set can0 down" freezes the system.
>
> I've applied Wolfgang's patch from 12.12.2016 with multiple spin_lock
> fixes, but it didn't improve the situation.
>
> Any idea?
>
> Should I submit at least the break removing patch?

I have done a fix for similar for the at91_can driver, I think. The 
break is OK if the quota is exceeded. Then the poll function will re-enter:

 From 43200a4480cbbe660309621817f54cbb93907108 Mon Sep 17 00:00:00 2001
From: Wolfgang Grandegger <wg@grandegger.com>
Date: Mon, 13 Jun 2016 15:44:19 +0200
Subject: [PATCH] can: at91_can: RX queue could get stuck at high bus load

At high bus load it could happen that "at91_poll()" enters with all RX
message boxes filled up. If then at the end the "quota" is exceeded as
well, "rx_next" will not be reset to the first RX mailbox and hence the
interrupts remain disabled.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Tested-by: Amr Bekhit <amrbekhit@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
  drivers/net/can/at91_can.c | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 8b3275d..8f5e93c 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -712,9 +712,10 @@ static int at91_poll_rx(struct net_device *dev, int 
quota)

  	/* upper group completed, look again in lower */
  	if (priv->rx_next > get_mb_rx_low_last(priv) &&
-	    quota > 0 && mb > get_mb_rx_last(priv)) {
+	    mb > get_mb_rx_last(priv)) {
  		priv->rx_next = get_mb_rx_first(priv);
-		goto again;
+		if (quota > 0)
+			goto again;
  	}

  	return received;
-- 
1.9.1


Wolfgang.
