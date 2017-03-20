From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: at91 driver lost CAN messages
Date: Mon, 20 Mar 2017 08:38:24 +0100
Message-ID: <3175996.kn8FdFnuFm@ws-stein>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de> <5803815.9246bLnB9A@ws-stein> <85ad9a0c-50be-f7b1-4465-ecfdce02df75@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:53321 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752626AbdCTHim (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Mar 2017 03:38:42 -0400
In-Reply-To: <85ad9a0c-50be-f7b1-4465-ecfdce02df75@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org

On Thursday 16 March 2017 11:18:33, Marc Kleine-Budde wrote:
> On 03/16/2017 10:58 AM, Alexander Stein wrote:
> >>> Let's see if I get time to cook rx-offload on a USB driver.
> >> 
> >> That would be highly appreciated :-)
> > 
> > Mh, at a first glance I don't know how to do that, actually. AFAICS
> > rx-offload does not support 'pushing' struct can_frame into the
> > queue, only pulling from rx-offload. There is no fixed connection
> > bewteen the internal can device structure and CAN frames, like
> > hardware message boxes. In order to use
> > can_rx_offload_irq_offload_fifo() to insert (mostly) a single
> > can_frame I would need to store the last urb. I think I need to add a
> > function similar to can_rx_offload_irq_queue_err_skb(), e.g.
> > can_rx_offload_irq_queue_skb, but without scheduling. This should be
> > done once the urb was completly read.
> 
> Does your device support multiple CAN frames per USB?

Yes, it does. Although this will happen rarely actually. As several URBs are 
submitted at once, each URB should only deliver a single CAN frame as this is 
much faster. So in order to receive more CAN frames per URB the USB host (or 
driver) needs to be delayed for long time so the CAN frames queue up on the 
device itself.

> Maybe rename
> 
> > int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload,
> > struct sk_buff *skb)
> into can_rx_offload_irq_queue_skb() or
> 
> can_rx_offload_irq_queue_skb_schedule() and fix the race condition:
> > int can_rx_offload_irq_queue_skb(struct can_rx_offload *offload, struct
> > sk_buff *skb) {
> 
> take spinlock
> 
> >         if (skb_queue_len(&offload->skb_queue) >
> >         
> >             offload->skb_queue_len_max)
> 
> release in case of error
> 
> >                 return -ENOMEM;
> >         
> >         skb_queue_tail(&offload->skb_queue, skb);
> 
> use unlocked variant of skb_queue_tail, i.e. __skb_queue_tail()
> 
> release spin lock
> 
> >         can_rx_offload_schedule(offload);
> >         
> >         return 0;
> > 
> > }
> 
> Then factor all but the can_rx_offload_schedule(offload) call into a
> separate function.

I will think about this. I'm afraid but currently I can't do anything about 
that. But this will only work for (USB) CAN drivers though. Ethernet USB 
drivers also suffer from the out-of-order issue as they also push their SKB in 
IRQ context. I've seen reorder warnings in wireshark on a direct link iperf 
transfer.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

