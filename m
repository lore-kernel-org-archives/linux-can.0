From: swapnil <patilswa@gmail.com>
Subject: Re: J1939 Interpacket Delay
Date: Thu, 17 Apr 2014 03:18:44 +0000 (UTC)
Message-ID: <loom.20140417T051332-76@post.gmane.org>
References: <loom.20140409T155830-71@post.gmane.org> <20140409194939.GD15221@vandijck-laurijssen.be> <loom.20140410T155519-838@post.gmane.org> <20140411083139.GB449@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48411 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161377AbaDQDTC (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 16 Apr 2014 23:19:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Wacqk-0002LG-Ui
	for linux-can@vger.kernel.org; Thu, 17 Apr 2014 05:18:57 +0200
Received: from 99-153-234-13.lightspeed.iplsin.sbcglobal.net ([99.153.234.13])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 17 Apr 2014 05:18:54 +0200
Received: from patilswa by 99-153-234-13.lightspeed.iplsin.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 17 Apr 2014 05:18:54 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:

> 
> Hey,
> 
> > > Hey,
> > > 
> > > Part 1 of the answer...
> > > 
> > > On Wed, Apr 09, 2014 at 02:17:11PM +0000, swapnil wrote:
> > > > Hi All,
> > > > 
> > > >         Hey Kurt I am using the J1939 stack on begalbone 
> > > > I am halfway through. I am getting some issue while testing with 
> > different 
> > > > engine control modules
> > > > 
> > > > 1. Is it possible to add inter packet delay in 2 frames. Now the gap 
> > between 
> > > > two frame is 540 to 555 uSec which is very fast. My other engine 
control 
> > > > module is not that fast ..
> > > 
> > > You're ECU supports transport protocol with flow control, but cannot
> > > hanle back-to-back CAN frames?
> > > That is weird at least.
> > > The requirements are orthogonal. Fast vs. not too fast.
> > > 
> > > That is beyond j1939, and I did not integrate any support for such 
> > usecase.
> > > > 
> [...]
> > > > The other End is not sending message if i use adapter It receive EOM
> > > >    i want to make difference between to packet is 600uSec
> > > 
> > > I tend to believe that this can be solved with traffic shaping
> > > on CAN, regardless of CAN.
> > > 
> > > But I'm not very familiar with traffic shaping. Oliver?
> > I will keep searching on how to use this option (traffic shaping) for 
can
> > Is it possible that i can modify the code for j1939 for adding some 
delay 
> > for my use only -- if yes
> 
> yes, you can. It's GPL
> 
> > can u tell in which function can i add that delay.
> > This is the most important part in my project..
> 
> You can patch the code like shown below.
> If that helps you releasing a product, don't hesitate.
> 
> I'll keep your usecase in mind for the future.
> 
> > actually i am able to 
> > monitor the parameters using j1939 stack but if i want to calibrate ECU
> > it fails.
> 
> in net/can/j1939/transport.c, around line 1046, add this.
> 
> 	case tp_cmd_bam:
> 		...
> 		while (session->pkt.tx < pkt_end) {
> 			...
> 			if (j1939cb_is_broadcast(session->cb)) {
> 				if (session->pkt.tx < session->pkt.total)
> 					j1939tp_schedule_txtimer(session, 
50);
> 				break;
> +			} else {
> +				j1939tp_schedule_txtimer(session, 1);
> +				break;
> 			}
> 		}
> 
> this will add 1+ msec delay between packets.
> You may need to use bigger delays, like 5msec, as this is the delay
> that is used to schedule the packet into the queue, and you want to
> delay the point that the CAN frames leave the queue onto the CAN bus.
> 
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Thanks Kurt i merged this change and it is showing delay of 1 ms in each 
packet from my test program .I will try this on ECU.
log from candump
1387768377.823498) can0 18EC00F9#10B2001A1A00EF00
(1387768377.824306) can0 1CECF900#111A01FFFF00EF00
(1387768377.825045) can0 18EB00F9#0100112233445566
(1387768377.826136) can0 18EB00F9#0200112233445566
(1387768377.827230) can0 18EB00F9#0300112233445566
(1387768377.828566) can0 18EB00F9#0400112233445566
(1387768377.829635) can0 18EB00F9#0544556600112233
(1387768377.830779) can0 18EB00F9#0644556644556600
(1387768377.831878) can0 18EB00F9#0711223344556644
(1387768377.832988) can0 18EB00F9#0855660011223344
(1387768377.834063) can0 18EB00F9#0955664455660011
(1387768377.835134) can0 18EB00F9#0A22334455664455
(1387768377.836277) can0 18EB00F9#0B66001122334455
(1387768377.837373) can0 18EB00F9#0C66445566001122
(1387768377.838451) can0 18EB00F9#0D33445566445566
(1387768377.839655) can0 18EB00F9#0E00112233445566
(1387768377.840645) can0 18EB00F9#0F44556600112233
(1387768377.841721) can0 18EB00F9#1044556644556600
(1387768377.842796) can0 18EB00F9#1111223344556644
(1387768377.843926) can0 18EB00F9#1255660011223344
(1387768377.845020) can0 18EB00F9#1355664455660011
(1387768377.846148) can0 18EB00F9#1422334455664455
(1387768377.847236) can0 18EB00F9#1566001122334455
(1387768377.848366) can0 18EB00F9#1666445566001122
(1387768377.849429) can0 18EB00F9#1733445566445566
(1387768377.850531) can0 18EB00F9#1800112233445566
(1387768377.851619) can0 18EB00F9#1944556600112233
(1387768377.852570) can0 18EB00F9#1A445566
(1387768377.853316) can0 1CECF900#13B2001AFF00EF00
Thanks once again 


