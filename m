From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Kvaser socketCAN support
Date: Thu, 01 May 2014 10:56:27 +0200
Message-ID: <53620C3B.9080402@hartkopp.net>
References: <f0331cq3H1VPknv.RZmta@smtp.rzone.de> <535559FC.70506@hartkopp.net> <r049e3q3UHfiSQJ.RZmta@smtp.rzone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:30595 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaEAI4b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 May 2014 04:56:31 -0400
In-Reply-To: <r049e3q3UHfiSQJ.RZmta@smtp.rzone.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Adams, Shawn - 0999 - MITLL" <shawn.adams@ll.mit.edu>

Christopher,

On 30.04.2014 19:41, Smith, Christopher - 0999 - MITLL wrote:
> Oliver, 
> 
> After digging around a bit more it seems like I'm having the same problem
> that was mentioned here:
> 
> http://comments.gmane.org/gmane.network.socketcan.user/1445

What exactly do you refer to from this thread?

> 
> can0 never comes up

???

Does can0 apprear in dmesg or in /proc/net/dev

??

Pls post the dmesg output of the relevant lines here.
And the lsusb output.

> even though dmesg seems to indicate that other
> initialization has gone smoothly.  Is this a problem where one type of
> kvaser hardware is working but perhaps another variant does not?

I'm still not the right person to ask these kind of questions - that's why I
tried to forward your request to Olivier (not Oliver) last time (see below in
this mail).

The only I know about the Kvaser driver and it's supported hardware is what
you can determine yourself from the Kvasers Kconfig section or the driver itself:

http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/drivers/net/can/usb/Kconfig?h=linux-3.14.y#n16

http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/drivers/net/can/usb/kvaser_usb.c?h=linux-3.14.y#n33

Regards,
Oliver


  If so
> maybe more information about what was working well would allow me to use
> similar hardware.
> 
> Thanks,
> 
> Chris
> 
> -----Original Message-----
> From: Oliver Hartkopp [mailto:socketcan@hartkopp.net] 
> Sent: Monday, April 21, 2014 1:49 PM
> To: Smith, Christopher - 0999 - MITLL
> Cc: Kvaser Support (support@kvaser.com); linux-can@vger.kernel.org; Olivier
> Sobrie
> Subject: Re: Kvaser socketCAN support
> 
> Hello Christopher,
> 
> the Kvaser Leaf USB driver has been contributed by Olivier Sobrie (see CC).
> 
> See log messages of the driver in the Linux Mainline repository:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers/n
> et/can/usb/kvaser_usb.c
> 
> The initial support was added at 2012-11-27 and emerged in Linux 3.8.
> 
> Regards,
> Oliver
> 
> ps. feel free to ask this kind of questions on the linux-can mailing list
> which I added in CC. Tnx
> 
> 
> On 17.04.2014 03:31, Smith, Christopher - 0999 - MITLL wrote:
>> Hi, I was just looking to get confirmation and a few points for 
>> getting the initial install figured out.
>>
>>  
>>
>> I have a kvaser leaf device that I'd like to use with socketCAN.  Is 
>> this in fact supported?
>>
>>  
>>
>> I noticed the general process for setting up socketCAN documented on 
>> wikipedia <http://en.wikipedia.org/wiki/SocketCAN>.  When I issue the
> following command:
>>
>>  
>>
>> ip link add dev vcan0 type vcan
>>
>>  
>>
>> What do I replace vcan0 with?  I've tried can0 with no luck.  Is there 
>> a way to check which devices are registered?  I'm not entirely sure 
>> that when I plugged in the USB device the proper drivers were 
>> recognized.  I may need some of the lower level drivers distributed by
> Kvaser.
>>
>>  
>>
>> Thank you,
>>
>>  
>>
>> Chris
>>
>>  
>>
>> -----Original Message-----
>> From: Kvaser Support [mailto:support@kvaser.com]
>> Sent: Monday, April 14, 2014 3:24 PM
>> To: Smith, Christopher - 0999 - MITLL
>> Subject: Re: (Case 14217) Linux driver support
>>
>>  
>>
>> Did the response below answer your questions?
>>
>>  
>>
>> Or do you need more information?
>>
>>  
>>
>> Best regards,
>>
>>  
>>
>> Troy
>>
>> --
>>
>> Kvaser Support
>>
>> support@kvaser.com <mailto:support@kvaser.com>
>>
>> ----------------------------------------------------------------------
>> -----
>>
>>  
>>
>>  
>>
>>  
>>
>> -----Original Message-----
>>
>> From: "Kvaser Support" <support@kvaser.com 
>> <mailto:support@kvaser.com>>
>>
>> Reply-To: "Kvaser Support" <support@kvaser.com 
>> <mailto:support@kvaser.com>>
>>
>> Date: Mon, 31 Mar 2014 22:29:00 +02:00
>>
>> To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu 
>> <mailto:chris.smith@ll.mit.edu>>
>>
>> Subject: Re: (Case 14217) Linux driver support
>>
>>  
>>
>>> To our knowledge, support for the Leaf family was added to socketcan 
>>> by
>> Oliver Harkopp in 2012.
>>
>>>
>>
>>> I tried to perform a google search to determine which version of Linux 
>>> this
>> has been included in without good results.
>>
>>>
>>
>>> I hope the socketcan community can point you to the version that 
>>> includes
>> this patch.
>>
>>>
>>
>>> Best regards,
>>
>>>
>>
>>> Troy
>>
>>> --
>>
>>> Kvaser Support
>>
>>> support@kvaser.com <mailto:support@kvaser.com>
>>
>>> ----------------------------------------------------------------------
>>> -----
>>
