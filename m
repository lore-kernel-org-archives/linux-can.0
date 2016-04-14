From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: bit-timing and sample point
Date: Thu, 14 Apr 2016 14:19:32 +0200
Message-ID: <20160414121932.GA7409@airbook.vandijck-laurijssen.be>
References: <570E205B.7030900@pengutronix.de>
 <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
 <570F7547.8030805@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:43366 "EHLO
	relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbcDNMWa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 08:22:30 -0400
Content-Disposition: inline
In-Reply-To: <570F7547.8030805@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>

> :D - The original algorithm is a simple bute force algorithm. My
> improvement is to check all sample points (if the bitrate doesn't match
> 100%).
> 
> >> I've changed the
> >> algorithm to minimize first the bit rate error and then the sample point
> >> error within the best bit rate.
> >>
> >> The old algorithm always picks a sample point less than the target
> >> sample point. My question to the CAN exports: Is it better to stay below
> >> the sample point or minimize the error (and pick a sample point slightly
> >> above the nominal sample point)?
> > 
> > I haven't been doing this for a while :-)
> 
> I've _never_ done this. :D
> 
> > The sample point is not put to 100% since nodes are not guaranteed to be
> > completely in sync. This may interfere when "slightly" in your
> > definition becomes more than expected. I'm not qualified anymore to
> > quantify "slightly" in terms of bittiming, yet the sample point is
> > specified to the back as far as possible for the wiring. Going "slightly"
> > above 'eats' the margin you have there, the margin which you may not need
> > for most wirings out there.
> 
> This example illustrates the "slightly":
> 
> >>>> nominal                                 real Bitrt   nom  real SampP
> >>>> Bitrate TQ[ns] PrS PhS1 PhS2 SJW BRP Bitrate Error SampP SampP Error BTR0 BTR1
> >>>>  800000    180   2    2    2   1  12  793650  0.8% 80.0% 71.4% 10.8% 0x0b 0x13
> >>>>  800000     90   5    5    3   1   6  793650  0.8% 80.0% 78.5%  1.9% 0x05 0x29
> >>>>  800000     60   8    8    4   1   4  793650  0.8% 80.0% 80.9%  1.1% 0x03 0x3f
> 
> For 800kbit/s the nominal sample point is 80%.
> The original algorithm chooses 71.4%.
> The improved (but stays below) chooses 78.5% (error=1.9%).
> But there exists a sample point with a smaller error: 80.9% (error=1.1%).

I understood the example :-)
What I meant with "slightly" being hard to quantify was especially with
regard to the bus characteristics. What is the maximal propagation delay
on the bus?
There is a point within a node's bit-time after which it is not certain
that remotes may have moved on to the next bit-time.
If you allow samplepoint deviations to both sides, then you assume that
the advertised sample point is in the middle of the time fragment where
sampling is ideal. If you allow samplepoint deviations only to below,
then you assume that the advertised sample point is the corner case and
raising it would introduce troubles.
Both assumptions are wrong, the truth is in between, and the advertised
sample points mostly are "rules of thumb".
IMHO, the assumption of going below only makes sense.
Of course, you can (easily) find examples where the sample point may
grow over it.
If I understand the algoritm correctly, there's no limitation in how far
beyond the advertised sample point you may get, as long as it's the
closest. And there, I think, you should put a limit, and until someone
comes up with a better one, I just take 0 as limit, meaning you go only
below :-)
