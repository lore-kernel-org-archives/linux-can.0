From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RESEND] [PATCH] net: CAN: at91_can.c: decrease likelyhood of RX overruns
Date: Tue, 07 Oct 2014 13:36:42 +0200
Message-ID: <1539665.hhtdYGgEle@ws-stein>
References: <1403775686-19352-1-git-send-email-david@protonic.nl> <3545685.3jS4Whu5tJ@ws-stein> <20141007103148.5404a4cd@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:58482 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753751AbaJGLf4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Oct 2014 07:35:56 -0400
In-Reply-To: <20141007103148.5404a4cd@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>

On Tuesday 07 October 2014 10:31:48, David Jander wrote:
> > I had done similar tests with i.MX28-EVK which also has only a 16-bit DDR
> > interface. The rusults were horrible. Even without that ethernet bug... 
> 
> Horrible seems a bit of a stretch... I have an i.MX28 board on my desk (with
> 16-bit 200MHz DDR2), which is capable of spewing out 12200 messages per second
> at 1Mbaud when idle. The theoretical maximum bus load (DLC=1) would be around
> 20000 messages per second, so at least I am able to keep up with the bandwidth
> corresponding to a 500kbaud bus at 100% load.

I wasn't refering to CAN handling, more number cunching and memory access.

> From my PC (with a Peak USB CAN dongle) I can send only 5200 messages per
> second (and this is a Core-i7 with 128bit DDR3 memory interface clocked at
> 800MHz ;-), so if the interfaces from SYS-Tec are significantly better than
> that we might have a deal... ;-)

When using a dual channel interface where can0 is connected with can1: If I run 'cangen -L 1 -g 0 -i can1', 'canbusload can0@1000000 -r -t -b -c -e' shows
can0@1000000  9643  549790  77144  54% |XXXXXXXXXX..........|
which would mean ~9600 frames/s.

> > > > embedded device send ~1000 CAN frames/s, each which is an average
> > > > busload of 20%, but in burst time, it should be 100%.
> > > 
> > > You mean the bursts of 250 messages you talked about earlier should
> > > produce a bus load of 100%? I think it is important to get some certainty
> > > about what's really going on on the bus, specially if we see things we
> > > cannot explain. You don't have access to a PC with a CAN interface or an
> > > oscilloscope, do you?
> > 
> > My PC has our USB-CAN-Modules attached (single or dual channel), so what do
> > you want to see? a candump log? My access to oscilloscopes rather limited
> > and not reliable.
> 
> You can try this (which is what I do):
> 
> $ time cangen -g 0 -I 123 -L 1 -D i -p 2 -n 10000 can0
> 
> If you tx-queue is smallish compared to the 10000 messages sent, then the
> "real" time reported by "time" will correspond approximately to the amount of
> time it took to actually transmit 10000 messages.

% time cangen -g 0 -I 123 -L 1 -D i -p 2 -n 10000 can0
cangen -g 0 -I 123 -L 1 -D i -p 2 -n 10000 can0  0,15s user 0,81s system 99% cpu 0,960 tota

This seem to match the output of canbusload.

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

