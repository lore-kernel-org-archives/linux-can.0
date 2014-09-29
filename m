From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue instead of FIFO
Date: Mon, 29 Sep 2014 17:02:39 +0200
Message-ID: <5017123.OgYMn6dde4@ws-stein>
References: <1411995175-13540-1-git-send-email-david@protonic.nl> <8124948.gcTnPkg5PL@ws-stein> <20140929163932.055fae8f@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:49246 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753656AbaI2PBy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Sep 2014 11:01:54 -0400
In-Reply-To: <20140929163932.055fae8f@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Monday 29 September 2014 16:39:32, David Jander wrote:
> 
> Dear Alexander,
> 
> On Mon, 29 Sep 2014 15:29:28 +0200
> Alexander Stein <alexander.stein@systec-electronic.com> wrote:
> 
> > On Monday 29 September 2014 14:52:55, David Jander wrote:
> > > The FlexCAN controller has a RX FIFO that is only 6 messages deep, and a
> > > mailbox space capable of holding up to 63 messages.
> > > 
> > > This space was largely unused, limiting the permissible latency from
> > > interrupt to NAPI to only 6 messages. This patch uses all available MBs
> > > for message reception and frees the MBs in the IRQ handler to greatly
> > > decrease the likelihood of receive overruns.
> > > 
> > > Signed-off-by: David Jander <david@protonic.nl>
> > 
> > AFAICT, If you disable Rx FIFO mode, you essentially break RTR reception on
> > (at least) i.MX3. Please refere to the reference manual 24.4.8.1 Remote
> > Frames. Vybrid and i.MX6 (not sure about i.MX5) seem to have more features
> > about RTR reception.
> 
> Argh! Looks like you are right!
> RTR reception did not work for i.MX6 either, but that is because I forgot to
> set RRS bit in CTRL2... which does not exist on i.MX53 nor i.MX35.
> What's strange is the fact that the i.MX53 RM does not contain the chapter you
> mention (it is contained in the i.MX35 RM though), and this is the only place
> that clearly seems to indicate that this indeed will not work on the i.MX3:
> 
> "A received remote request frame is not stored in a receive buffer. It is only
> used to trigger a transmission of a frame in response."

Yep, it seems that the FlexCAN part of the RM is even more shorter in i.MX5 than i.MX3 or i.MX6...

> AFAICS, we have little choice but to use the Rx FIFO, at least for i.MX3/5 or
> older IPs...
> 
> Maybe I can re-factor the code in such a way that the same construction is
> used outside the IRQ context, but the IRQ routine will either empty the FIFO
> (for revision 3 and older flexcan) or the while MB area (for revision 10 and
> newer).
> 
> The BIG drawback of using the RX FIFO is that it is really tiny. Not using it
> is really a big win for i.MX6 and newer... which I'd like to keep.

I don't know how the MB actually work, but I know about race conditions in C_CAN (actually pch can) with the pseudo FIFO implemented using message boxes. May this also happen here? That's a reason I'm really happy there is a real FIFO in hardware.

> Nevertheless, emptying the FIFO in the IRQ handler will still be a big
> improvement, since the only thing that could still kill the driver and cause
> message loss is interrupt latency, which normally should not be so high. NAPI
> scheduling latency is probably much worse, and this is the biggest issue with
> the current driver.
> 
> Any suggestion on what to do?

Get rid of NAPI and use RT-preempt with proper priorities :) But joke aside, which workload does increase the NAPI latency so much, an overrun occurs? I tested CAN bursts on i.MX35 without any loss.

Best regards
Alexander

-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

