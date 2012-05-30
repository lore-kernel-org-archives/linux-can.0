From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 14:29:49 +0200
Message-ID: <jq53rt$uqu$1@dough.gmane.org>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <4FC60FA7.2000600@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34568 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185Ab2E3MaI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 30 May 2012 08:30:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1SZi2P-0007FB-Tr
	for linux-can@vger.kernel.org; Wed, 30 May 2012 14:30:05 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 14:30:05 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 30 May 2012 14:30:05 +0200
In-Reply-To: <4FC60FA7.2000600@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dne 30.5.2012 14:16, Marc Kleine-Budde napsal(a):
> On 05/30/2012 02:05 PM, Martin Kozusky wrote:
>>> Why do you want to use can4linux? Socketcan is the official CAN Stack
>>> for Linux. Be sure you use the latest kernel, because the flexcan driver
>>> has some bugs and problems prior to v3.4.
>>>
>>> Regards, Marc
>
>> Hello Marc,
>> I wanted to try if it will be faster than socketcan (which is dropping
>> some CAN frames on my HW under heavy load). I need the closest way to
>
> Have you debugged which component is dropping frames? Is it the hardware
> or the socket because your application is to slow?

I tried to solve this 19.4.2012 (thread "CAN messages being lost on 
i.MX25 with flexcan") and when I changed rcvbuf_size to 10000000 it 
helped, but still sometimes few CAN frames are dropped (and many more 
when I try to write to SD card or internal flash). So I think it's not 
HW problem.
The best for me would be some kernel module which would just put the CAN 
frame into some big "from userspace available" buffer in the interrupt 
and nothing more. My app would check if there is anything new and read 
it out.
There are around 1500/sec (at 250kbit) can frames on the bus when the 
problem arise, I think it's not that much.

Martin

>> the controller, and I thought that when can4linux is not using sockets
>> layer it could be faster. I also wanted to try LinCAN (which is compared
>> to SocketCAN here:
>> http://dce.felk.cvut.cz/hanzalek/publications/Hanzalek10_168894.pdf  )
>> but I think it doesn't support Flexcan
>
> Good luck :)
>
> Marc
>


