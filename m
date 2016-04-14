From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: bit-timing and sample point
Date: Thu, 14 Apr 2016 12:26:08 +0200
Message-ID: <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
References: <570E205B.7030900@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:43080 "EHLO
	relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbcDNK3F (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 06:29:05 -0400
Content-Disposition: inline
In-Reply-To: <570E205B.7030900@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>

Hey Marc,

> currently I'm reworking the bit timing algorithm.
Waauw, that's ambitious.

> I've changed the
> algorithm to minimize first the bit rate error and then the sample point
> error within the best bit rate.
> 
> The old algorithm always picks a sample point less than the target
> sample point. My question to the CAN exports: Is it better to stay below
> the sample point or minimize the error (and pick a sample point slightly
> above the nominal sample point)?

I haven't been doing this for a while :-)

The sample point is not put to 100% since nodes are not guaranteed to be
completely in sync. This may interfere when "slightly" in your
definition becomes more than expected. I'm not qualified anymore to
quantify "slightly" in terms of bittiming, yet the sample point is
specified to the back as far as possible for the wiring. Going "slightly"
above 'eats' the margin you have there, the margin which you may not need
for most wirings out there.

> 
> See the below table for the output of the calculation. There are three
> entries per bit rate:
> 1) original algorithm
> 2) improved algorithm, smaple point is always below nominal sample point
> 3) improved algorithm, sample point error is minimized
> 
> > Bit timing parameters for mscan with 66.666666 MHz ref clock
> > nominal                                 real Bitrt   nom  real SampP
> > Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Error BTR0 BTR1
> > 1000000     90   3    4    3   1   6 1010101  1.0% 75.0% 72.7%  3.1% 0x05 0x26
> > 1000000     90   3    4    3   1   6 1010101  1.0% 75.0% 72.7%  3.1% 0x05 0x26
> > 1000000     45   8    8    5   1   3 1010101  1.0% 75.0% 77.2%  2.9% 0x02 0x4f
> 
> >  800000    180   2    2    2   1  12  793650  0.8% 80.0% 71.4% 10.8% 0x0b 0x13
> >  800000     90   5    5    3   1   6  793650  0.8% 80.0% 78.5%  1.9% 0x05 0x29
> >  800000     60   8    8    4   1   4  793650  0.8% 80.0% 80.9%  1.1% 0x03 0x3f
> 
> >  500000    285   2    2    2   1  19  501253  0.3% 87.5% 71.4% 18.4% 0x12 0x13
> >  500000    105   7    8    3   1   7  501253  0.3% 87.5% 84.2%  3.8% 0x06 0x2e
> >  500000    105   8    8    2   1   7  501253  0.3% 87.5% 89.4%  2.2% 0x06 0x1f
> 
> >  250000    570   2    2    2   1  38  250626  0.3% 87.5% 71.4% 18.4% 0x25 0x13
> >  250000    285   5    6    2   1  19  250626  0.3% 87.5% 85.7%  2.1% 0x12 0x1a
> >  250000    285   5    6    2   1  19  250626  0.3% 87.5% 85.7%  2.1% 0x12 0x1a
> 
> Which algorithm is preferred?

I prefer (2).
The improvement over (1) is significant!!

Kind regards,
Kurt
