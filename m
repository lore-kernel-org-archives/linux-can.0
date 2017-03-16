From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: at91 driver lost CAN messages
Date: Thu, 16 Mar 2017 10:58 +0100
Message-ID: <5803815.9246bLnB9A@ws-stein>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de> <3117407.TP9DfUe48K@ws-stein> <c05c554a-c76c-f6d0-7327-f459d807ab3e@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:41584 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751137AbdCPJ6K (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 05:58:10 -0400
In-Reply-To: <c05c554a-c76c-f6d0-7327-f459d807ab3e@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org

On Thursday 16 March 2017 10:09:30, Oliver Hartkopp wrote:
> On 16.03.2017 10:06, Alexander Stein wrote:
> > On Thursday 16 March 2017 09:34:38, Marc Kleine-Budde wrote:
> >> On 03/16/2017 09:01 AM, Oliver Hartkopp wrote:
> >>> On 13.03.2017 10:47, Marc Kleine-Budde wrote:
> >>>> On 03/13/2017 07:54 AM, Alexander Stein wrote:
> >>>>>> @Marc: What was the reason to implement NAPI that days? Has it ever
> >>>>>> been
> >>>>>> proved that NAPI had a remarkable positive effect in opposite to a
> >>>>>> direct CAN frame processing in the interrupt context?
> >>>>> 
> >>>>> One reason to use NAPI is out-of-order issues on SMP systems :-( You
> >>>>> know the problem: http://marc.info/?l=linux-can&m=143642135416355&w=2
> >>>>> If this is not resolved, things get even worse.
> >>>>> Well, now that there is generic FIFO-offload feature (drivers may need
> >>>>> changes to use it) there is an easy way to read CAN frames with low
> >>>>> latency while processing them in non-IRQ context.
> >>>>> IMHO reading CAN frames in softirq (NAPI) may be too late in some
> >>>>> cases,
> >>>>> in RT kernels this may be even worse.
> >>>> 
> >>>> ACK.
> >>> 
> >>> Would then implementing CAN rx-offload on all(!) CAN drivers fix the
> >>> NAPI-too-late and the out-of-order issue?
> >> 
> >> Implementing rx-offload on the drivers using NAPI, will fix the
> >> NAPI-too-late issue (and turn it into a IRQ too late issue).
> >> 
> >> Implementing rx-offload on the drivers passing skbs in the IRQ handler
> >> will probably fix the out-of-order issue.
> >> 
> >> I'm not sure if the USB and SPI drivers are affected by the out-of-order
> >> issue.
> > 
> > IMO all drivers using netif_rx (IRQ context) rather han netif_receive_skb
> > (NAPI poll context) are suffering from out-of-order issue. And I guess
> > every USB CAN driver is using netif_rx in the URB callback function,
> > which is essentially IRQ context. MCP2512 uses netif_rx_ni instead, dunno
> > what is the actual difference to netif_rx.
> > 
> > Let's see if I get time to cook rx-offload on a USB driver.
> 
> That would be highly appreciated :-)

Mh, at a first glance I don't know how to do that, actually. AFAICS rx-offload 
does not support 'pushing' struct can_frame into the queue, only pulling from 
rx-offload. There is no fixed connection bewteen the internal can device 
structure and CAN frames, like hardware message boxes.
In order to use can_rx_offload_irq_offload_fifo() to insert (mostly) a single 
can_frame I would need to store the last urb. I think I need to add a function 
similar to can_rx_offload_irq_queue_err_skb(), e.g. 
can_rx_offload_irq_queue_skb, but without scheduling. This should be done once 
the urb was completly read.

Marc: Does that sound reasonable?

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

