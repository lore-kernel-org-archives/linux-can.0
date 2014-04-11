From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Interpacket Delay
Date: Fri, 11 Apr 2014 10:31:39 +0200
Message-ID: <20140411083139.GB449@vandijck-laurijssen.be>
References: <loom.20140409T155830-71@post.gmane.org>
 <20140409194939.GD15221@vandijck-laurijssen.be>
 <loom.20140410T155519-838@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:51847 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751932AbaDKIbv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:31:51 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140410T155519-838@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hey,

> > Hey,
> > 
> > Part 1 of the answer...
> > 
> > On Wed, Apr 09, 2014 at 02:17:11PM +0000, swapnil wrote:
> > > Hi All,
> > > 
> > >         Hey Kurt I am using the J1939 stack on begalbone 
> > > I am halfway through. I am getting some issue while testing with 
> different 
> > > engine control modules
> > > 
> > > 1. Is it possible to add inter packet delay in 2 frames. Now the gap 
> between 
> > > two frame is 540 to 555 uSec which is very fast. My other engine control 
> > > module is not that fast ..
> > 
> > You're ECU supports transport protocol with flow control, but cannot
> > hanle back-to-back CAN frames?
> > That is weird at least.
> > The requirements are orthogonal. Fast vs. not too fast.
> > 
> > That is beyond j1939, and I did not integrate any support for such 
> usecase.
> > > 
[...]
> > > The other End is not sending message if i use adapter It receive EOM
> > >    i want to make difference between to packet is 600uSec
> > 
> > I tend to believe that this can be solved with traffic shaping
> > on CAN, regardless of CAN.
> > 
> > But I'm not very familiar with traffic shaping. Oliver?
> I will keep searching on how to use this option (traffic shaping) for can
> Is it possible that i can modify the code for j1939 for adding some delay 
> for my use only -- if yes

yes, you can. It's GPL

> can u tell in which function can i add that delay.
> This is the most important part in my project..

You can patch the code like shown below.
If that helps you releasing a product, don't hesitate.

I'll keep your usecase in mind for the future.

> actually i am able to 
> monitor the parameters using j1939 stack but if i want to calibrate ECU
> it fails.

in net/can/j1939/transport.c, around line 1046, add this.

	case tp_cmd_bam:
		...
		while (session->pkt.tx < pkt_end) {
			...
			if (j1939cb_is_broadcast(session->cb)) {
				if (session->pkt.tx < session->pkt.total)
					j1939tp_schedule_txtimer(session, 50);
				break;
+			} else {
+				j1939tp_schedule_txtimer(session, 1);
+				break;
			}
		}

this will add 1+ msec delay between packets.
You may need to use bigger delays, like 5msec, as this is the delay
that is used to schedule the packet into the queue, and you want to
delay the point that the CAN frames leave the queue onto the CAN bus.

Kurt
