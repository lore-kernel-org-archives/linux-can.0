From: swapnil <patilswa@gmail.com>
Subject: Re: J1939 Interpacket Delay
Date: Thu, 10 Apr 2014 14:12:20 +0000 (UTC)
Message-ID: <loom.20140410T155519-838@post.gmane.org>
References: <loom.20140409T155830-71@post.gmane.org> <20140409194939.GD15221@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42753 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934020AbaDJOMi (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 10 Apr 2014 10:12:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WYFiV-0000M7-Uj
	for linux-can@vger.kernel.org; Thu, 10 Apr 2014 16:12:35 +0200
Received: from 192.158.48.18 ([192.158.48.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 10 Apr 2014 16:12:35 +0200
Received: from patilswa by 192.158.48.18 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 10 Apr 2014 16:12:35 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:

> 
> Hey,
> 
> Part 1 of the answer...
> 
> On Wed, Apr 09, 2014 at 02:17:11PM +0000, swapnil wrote:
> > Hi All,
> > 
> >         Hey Kurt I am using the J1939 stack on begalbone 
> > I am halfway through. I am getting some issue while testing with 
different 
> > engine control modules
> > 
> > 1. Is it possible to add inter packet delay in 2 frames. Now the gap 
between 
> > two frame is 540 to 555 uSec which is very fast. My other engine control 
> > module is not that fast ..
> 
> You're ECU supports transport protocol with flow control, but cannot
> hanle back-to-back CAN frames?
> That is weird at least.
> The requirements are orthogonal. Fast vs. not too fast.
> 
> That is beyond j1939, and I did not integrate any support for such 
usecase.
> 
> >     please check the Log 
> > 1387762862.278774) can0 18EC00F9#104906E6E600EF00
> > (1387762862.279388) can0 18ECF900#11E601FFFF00EF00
> > (1387762862.280160) can0 18EB00F9#014D000010800000
> > (1387762862.280705) can0 18EB00F9#020640FB05FFFFFF
> > (1387762862.281284) can0 18EB00F9#03FFFFFF00000000
> >                         .
> >                         .
> >                         .  
> > (1387762862.566022) can0 18EB00F9#E45F4D0000000841
> > (1387762862.566574) can0 18EB00F9#E55850325F4E0000
> > (1387762862.567091) can0 18EB00F9#E6000841585431
> > (1387762863.822072) can0 18EC00F9#FF03FFFFFF00EF00
> > 
> > The other End is not sending message if i use adapter It receive EOM
> >    i want to make difference between to packet is 600uSec
> 
> I tend to believe that this can be solved with traffic shaping
> on CAN, regardless of CAN.
> 
> But I'm not very familiar with traffic shaping. Oliver?
I will keep searching on how to use this option (traffic shaping) for can
Is it possible that i can modify the code for j1939 for adding some delay 
for my use only -- if yes
can u tell in which function can i add that delay.
This is the most important part in my project.. actually i am able to 
monitor the parameters using j1939 stack but if i want to calibrate ECU
it fails.




