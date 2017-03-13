From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: at91 driver lost CAN messages
Date: Mon, 13 Mar 2017 07:54:30 +0100
Message-ID: <3972105.9n1vzaBFN5@ws-stein>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de> <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:38916 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750726AbdCMGyn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Mar 2017 02:54:43 -0400
In-Reply-To: <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Efim Monjak <emonjak@lipowsky.de>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

On Sunday 12 March 2017 00:06:02, Oliver Hartkopp wrote:
> Hi Efim,
> 
> On 03/10/2017 02:48 PM, Efim Monjak wrote:
> > If napi polling is deactivated by follow change no more receive overflow
> > error occurs.
> 
> thanks for the patch!
> 
> In fact I always thought NAPI is too heavy for CAN controllers. NAPI was
> intended for a very high interrupt load on some ethernet controllers
> with some considerable RX FIFO.
> 
> I have a 20 CAN interfaces (SJA1000 driver) Core i7 system receiving
> ~22.000 frames/s without any problems, with an one-element FIFO and
> without NAPI.
> 
> @Marc: What was the reason to implement NAPI that days? Has it ever been
> proved that NAPI had a remarkable positive effect in opposite to a
> direct CAN frame processing in the interrupt context?

One reason to use NAPI is out-of-order issues on SMP systems :-( You know the 
problem: http://marc.info/?l=linux-can&m=143642135416355&w=2
If this is not resolved, things get even worse.
Well, now that there is generic FIFO-offload feature (drivers may need changes 
to use it) there is an easy way to read CAN frames with low latency while 
processing them in non-IRQ context.
IMHO reading CAN frames in softirq (NAPI) may be too late in some cases, in RT 
kernels this may be even worse.

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

