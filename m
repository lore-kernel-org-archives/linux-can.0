From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Interpacket Delay
Date: Thu, 17 Apr 2014 22:18:35 +0200
Message-ID: <20140417201835.GA12665@vandijck-laurijssen.be>
References: <loom.20140409T155830-71@post.gmane.org>
 <20140409194939.GD15221@vandijck-laurijssen.be>
 <loom.20140410T155519-838@post.gmane.org>
 <20140411083139.GB449@vandijck-laurijssen.be>
 <loom.20140417T051332-76@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:53776 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736AbaDQUSl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 16:18:41 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140417T051332-76@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

On Thu, Apr 17, 2014 at 03:18:44AM +0000, swapnil wrote:
> Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:
> 
> > 
> > Hey,
> > 
> > > > Hey,
> > > > 
[...]
> > > Is it possible that i can modify the code for j1939 for adding some 
> delay 
> > > for my use only -- if yes
> > 
> > yes, you can. It's GPL
> > 
> > > can u tell in which function can i add that delay.
> > > This is the most important part in my project..
> > 
> > You can patch the code like shown below.
> > If that helps you releasing a product, don't hesitate.
> > 
> > I'll keep your usecase in mind for the future.
> > 
> > > actually i am able to 
> > > monitor the parameters using j1939 stack but if i want to calibrate ECU
> > > it fails.
> > 
> > in net/can/j1939/transport.c, around line 1046, add this.
> > 
> > 	case tp_cmd_bam:
> > 		...
> > 		while (session->pkt.tx < pkt_end) {
> > 			...
> > 			if (j1939cb_is_broadcast(session->cb)) {
> > 				if (session->pkt.tx < session->pkt.total)
> > 					j1939tp_schedule_txtimer(session, 
> 50);
> > 				break;
> > +			} else {
> > +				j1939tp_schedule_txtimer(session, 1);
> > +				break;
> > 			}
> > 		}
> > 
> > this will add 1+ msec delay between packets.
> > You may need to use bigger delays, like 5msec, as this is the delay
> > that is used to schedule the packet into the queue, and you want to
> > delay the point that the CAN frames leave the queue onto the CAN bus.
> > 
> 
> Thanks Kurt i merged this change and it is showing delay of 1 ms in each 
> packet from my test program .I will try this on ECU.
> log from candump
> 1387768377.823498) can0 18EC00F9#10B2001A1A00EF00
> (1387768377.824306) can0 1CECF900#111A01FFFF00EF00
> (1387768377.825045) can0 18EB00F9#0100112233445566
> (1387768377.826136) can0 18EB00F9#0200112233445566
> (1387768377.827230) can0 18EB00F9#0300112233445566
> (1387768377.828566) can0 18EB00F9#0400112233445566
> (1387768377.829635) can0 18EB00F9#0544556600112233
> (1387768377.830779) can0 18EB00F9#0644556644556600
> (1387768377.831878) can0 18EB00F9#0711223344556644
> (1387768377.832988) can0 18EB00F9#0855660011223344
> (1387768377.834063) can0 18EB00F9#0955664455660011
> (1387768377.835134) can0 18EB00F9#0A22334455664455
> (1387768377.836277) can0 18EB00F9#0B66001122334455
> (1387768377.837373) can0 18EB00F9#0C66445566001122
> (1387768377.838451) can0 18EB00F9#0D33445566445566
> (1387768377.839655) can0 18EB00F9#0E00112233445566
> (1387768377.840645) can0 18EB00F9#0F44556600112233
> (1387768377.841721) can0 18EB00F9#1044556644556600
> (1387768377.842796) can0 18EB00F9#1111223344556644
> (1387768377.843926) can0 18EB00F9#1255660011223344
> (1387768377.845020) can0 18EB00F9#1355664455660011
> (1387768377.846148) can0 18EB00F9#1422334455664455
> (1387768377.847236) can0 18EB00F9#1566001122334455
> (1387768377.848366) can0 18EB00F9#1666445566001122
> (1387768377.849429) can0 18EB00F9#1733445566445566
> (1387768377.850531) can0 18EB00F9#1800112233445566
> (1387768377.851619) can0 18EB00F9#1944556600112233
> (1387768377.852570) can0 18EB00F9#1A445566
> (1387768377.853316) can0 1CECF900#13B2001AFF00EF00
> Thanks once again 

I'm glad it works as expected!

I'll investigate to add a decent API to control such thing from userspace
via sockets, some day.

Kind regards,
Kurt
