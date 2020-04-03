From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Fwd: usb_8dev - WARN_ON(in_irq()) Ticket #00560
Date: Fri, 3 Apr 2020 15:26:14 +0200
Message-ID: <f17f8d95-96b4-4d51-4390-1fb6a1e47fc8@grandegger.com>
References: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy06.manitu.net ([217.11.48.70]:50112 "EHLO
        mailproxy06.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCN0R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 09:26:17 -0400
In-Reply-To: <CAFnz-BWK_c63YyZ2KzMq=EWn6yfEQyyX+Vo7WSh4SddyY7PCfQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andrejus_Fal=c4=8dikas?= <andrejus.f@8devices.com>, socketcan@hartkopp.net
Cc: michal.sojka@cvut.cz, linux-can@vger.kernel.org

Hello Andrejus,

please do not remove the history of this conversation! It's very
difficult to follow what you are speaking about...

Am 03.04.20 um 15:04 schrieb Andrejus Falčikas:
> Hello Mr. Oliver Hartkopp,
> 
> I would like to notify you that the case described as the issue is
> caused by non-standard use of the device and protocol.
> 
> Firstly, the model situation with only a single device on the CAN bus
> is invalid and very rarely occurs in real life due to the purpose and
> underlying principles of the CAN2.0 protocol. Every CAN message sent
> to the bus should be acknowledged by other bus node(s) or it will
> increment the error counter and will be retransmitted.
> 
> The proper usage of a single device (e. g. for testing or
> self-diagnostic purposes) would be to enable loopback mode on when
> initialising the device in question, as that will ensure that the
> device acknowledges the messages it sends to the bus.
> 
> Secondly, usage of termination resistors is a must on a CAN bus, and
> according to ISO 11898-2 (CAN High Speed) standard the bus is a linear
> bus that must be terminated at each end with 120 Ohm resistors. The
> termination resistors are needed to suppress reflections as well as
> return the bus to its recessive or idle state.
> 
> Moreover, the kernel warnings appear to be caused by the socketCAN
> layer using netif_rx() function inside an interrupt, they can be
> easily recreated using the obsoleted first generation USB2CAN device
> and most likely any other device using socketCAN.

I observe a similar problem with the GS_USB CAN controller and I have
posted a patch recently here:

  https://marc.info/?l=linux-can&m=158504888512764&w=2

Could you please give the patch for your device below a try:

diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 8fa224b..c9bb225 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -575,7 +575,7 @@ static void usb_8dev_write_bulk_callback(struct urb *urb)
 
 	atomic_dec(&priv->active_tx_urbs);
 
-	if (!netif_device_present(netdev))
+	if (!netif_device_present(netdev) || !netif_running(netdev))
 		return;
 
 	if (urb->status)


Wolfgang
