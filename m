From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: read() question from newbie
Date: Thu, 19 Apr 2012 10:39:51 +0200
Message-ID: <4F8FCF57.70900@grandegger.com>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com>	<CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com>	<4F51DEF0.9060501@hartkopp.net>	<CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com>	<4F553BDA.8060106@hartkopp.net>	<4F553CA5.8080704@hartkopp.net>	<CABHoAv=WuK0WZWNyi7jgBTNUbHub8AuGtPzbjL4dYaQ1ZGpu_g@mail.gmail.com>	<4F56701E.3020104@hartkopp.net>	<CABHoAv=FhULnAY+a2CbNjdyEEOoBKdEAezL7NQLo+PdfeyRTow@mail.gmail.com>	<4F8D08D2.3090701@hartkopp.net>	<CABHoAvmwCbAUfNBocHiUOHypN1uHMi9BrSREG-Yt=K=i3Wfn_w@mail.gmail.com>	<4F8F24F0.5000501@grandegger.com> <CABHoAvmnqpHsjeNYZRh-T5dvNYaENXxGFtwN7=_15rmGJTMWcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33539 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab2DSIjz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Apr 2012 04:39:55 -0400
In-Reply-To: <CABHoAvmnqpHsjeNYZRh-T5dvNYaENXxGFtwN7=_15rmGJTMWcQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Economides <mecono@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On 04/19/2012 01:10 AM, Michael Economides wrote:
> Hi Wolfgang,
> 
> I checked and the Freescale BSP I'm using is based on Linux version
> 2.6.24.7-rt21

Do you need rt? Anyway, IIRC, the MPC5121EADS board is supported by the
mainline kernel:

http://lxr.linux.no/#linux+v3.3.2/arch/powerpc/boot/dts/mpc5121ads.dts

There is no need to use the old kernel from Freescale's LTIB
distribution, which uses a special and old Socket-CAN implementation.

Wolfgang.


> On Wed, Apr 18, 2012 at 1:32 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Hi Michael,
>>
>> On 04/18/2012 10:13 PM, Michael Economides wrote:
>>> Hi Oliver,
>>>
>>> Looking on my scope, it does seem like the baudrate is a little off.
>>>
>>> Here are the commands I use to set up my CAN interface on my Linux board:
>>>
>>> insmod -m candev;
>>
>> Oops, you are using a very very old version of insmod. Are you using
>> Linux 2.4.x? I do remember using "-m" with old Linux 2.4 distributions.
>>
>>> insmod -m mscan-mpc52xx;
>>> insmod -m can;
>>> insmod -m can-raw
>>> ifconfig can0 up;
>>>
>>> ./cantest can0 baud 1000000;
>>>
>>> This "cantest" program uses:
>>>
>>>  ifr.ifr_ifru.ifru_ivalue = baudrate;
>>> ret = ioctl(s, SIOCSCANBAUDRATE, &ifr);
>>>
>>> to set the baudrate.  But it seems from reading other discussions,
>>> that this is not the correct way to set baud rate.
>>
>> That's right, in case you are using a recent kernel version.
>>
>>> I am using the MPC5121 from Freescale, in case that is relevant.
>>
>> What Linux kernel version do you use? Where did you get the drivers
>> above from?
>>
>> Wolfgang.
>>
>>> On Mon, Apr 16, 2012 at 11:08 PM, Oliver Hartkopp
>>> <socketcan@hartkopp.net> wrote:
>>>> On 17.04.2012 06:16, Michael Economides wrote:
>>>>
>>>>
>>>>>>
>>>>>> I assume there is a CAN bus problem:
>>>>>>
>>>>>> - wiring (CAN_L/CAN_H)
>>>>>> - correct CAN termination (2x 120 Ohms)
>>>>>> - different bitrate
>>>>>>
>>>>>
>>>>> I think you are right, but I have checked that, it looks ok.  I will
>>>>> check again.
>>>>>
>>>>> I am using a PCAN USB adapter, and the PCAN software says there is an
>>>>> "acknowledge error" when it sends a frame to my Linux board.
>>>>
>>>>
>>>> This is an indication for a missing counterpart CAN node:
>>>>
>>>> - Wrong connection wiring
>>>> - Wrong termination
>>>> - Wrong bitrate
>>>>
>>>>>
>>>>> When the Linux board tries to send a frame to PCAN, the PCAN software
>>>>> says "form error acknowledge delimiter".
>>>>>
>>>>> It seems this is the same error in both cases, just worded differently.
>>>>
>>>>
>>>> Yes. But this means the same regarding the obvious problems.
>>>>
>>>>>
>>>>> In your opinion, is this most likely a hardware issue?  Or is there
>>>>> still some way I could be doing something wrong at the software level?
>>>>
>>>>
>>>> Did you swap CAN_H / CAN_L ??
>>>>
>>>> It's definitely one of the three points above. No SW problem ...
>>>>
>>>> Try to add a third CAN node - if you have one.
>>>>
>>>> Regards,
>>>> Oliver
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
> 
> 

