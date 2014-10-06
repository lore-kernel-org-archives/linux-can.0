From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RESEND] [PATCH] net: CAN: at91_can.c: decrease likelyhood of RX overruns
Date: Mon, 06 Oct 2014 16:14:05 +0200
Message-ID: <3545685.3jS4Whu5tJ@ws-stein>
References: <1403775686-19352-1-git-send-email-david@protonic.nl> <2417882.RxeThGvgsF@ws-stein> <20141006133942.0f1c820b@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:48266 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752750AbaJFONT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Oct 2014 10:13:19 -0400
In-Reply-To: <20141006133942.0f1c820b@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>

On Monday 06 October 2014 13:39:42, David Jander wrote:
> > > One interesting control-metric would be to monitor the amount of
> > > messages/second your test-devices are able to generate.
> > 
> > I just noticed that this testing hardware has a DDR2 with only 16bit
> > interface. I think this will also reduce performance considerably. The
> 
> 16-bit DDR2 (even at its lowest clock of 200MHz) is not exactly slow... why do
> you think that could be a bottleneck?

It's a 133MHz clock, so 266MHz effective.
I had done similar tests with i.MX28-EVK which also has only a 16-bit DDR interface. The rusults were horrible. Even without that ethernet bug...
Now, doing the same tests (also CPU and Memory) again, it is worse than a AT91SAM9G20 with 32-bit SDR RAM, which also has 400 MHz. I expected both would be equally.
If you're correct and the RAM is not the bottleneck it seems that the cache (16kByte each, 32kByte on AT91SAM9G20) would be it.

> > embedded device send ~1000 CAN frames/s, each which is an average busload of
> > 20%, but in burst time, it should be 100%.
> 
> You mean the bursts of 250 messages you talked about earlier should produce a
> bus load of 100%? I think it is important to get some certainty about what's
> really going on on the bus, specially if we see things we cannot explain. You
> don't have access to a PC with a CAN interface or an oscilloscope, do you?

My PC has our USB-CAN-Modules attached (single or dual channel), so what do you want to see? a candump log?
My access to oscilloscopes rather limited and not reliable.

Best regards,
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

