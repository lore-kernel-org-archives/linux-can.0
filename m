From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Interpacket Delay
Date: Wed, 9 Apr 2014 21:49:39 +0200
Message-ID: <20140409194939.GD15221@vandijck-laurijssen.be>
References: <loom.20140409T155830-71@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:50815 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933643AbaDITuE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Apr 2014 15:50:04 -0400
Content-Disposition: inline
In-Reply-To: <loom.20140409T155830-71@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: swapnil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hey,

Part 1 of the answer...

On Wed, Apr 09, 2014 at 02:17:11PM +0000, swapnil wrote:
> Hi All,
> 
>         Hey Kurt I am using the J1939 stack on begalbone 
> I am halfway through. I am getting some issue while testing with different 
> engine control modules
> 
> 1. Is it possible to add inter packet delay in 2 frames. Now the gap between 
> two frame is 540 to 555 uSec which is very fast. My other engine control 
> module is not that fast ..

You're ECU supports transport protocol with flow control, but cannot
hanle back-to-back CAN frames?
That is weird at least.
The requirements are orthogonal. Fast vs. not too fast.

That is beyond j1939, and I did not integrate any support for such usecase.

>     please check the Log 
> 1387762862.278774) can0 18EC00F9#104906E6E600EF00
> (1387762862.279388) can0 18ECF900#11E601FFFF00EF00
> (1387762862.280160) can0 18EB00F9#014D000010800000
> (1387762862.280705) can0 18EB00F9#020640FB05FFFFFF
> (1387762862.281284) can0 18EB00F9#03FFFFFF00000000
>                         .
>                         .
>                         .  
> (1387762862.566022) can0 18EB00F9#E45F4D0000000841
> (1387762862.566574) can0 18EB00F9#E55850325F4E0000
> (1387762862.567091) can0 18EB00F9#E6000841585431
> (1387762863.822072) can0 18EC00F9#FF03FFFFFF00EF00
> 
> The other End is not sending message if i use adapter It receive EOM
>    i want to make difference between to packet is 600uSec

I tend to believe that this can be solved with traffic shaping
on CAN, regardless of CAN.

But I'm not very familiar with traffic shaping. Oliver?

Kind regards,
Kurt
