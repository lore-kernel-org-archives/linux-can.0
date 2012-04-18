From: Michael Economides <mecono@gmail.com>
Subject: Re: read() question from newbie
Date: Wed, 18 Apr 2012 16:10:20 -0700
Message-ID: <CABHoAvmnqpHsjeNYZRh-T5dvNYaENXxGFtwN7=_15rmGJTMWcQ@mail.gmail.com>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com>
	<CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com>
	<4F51DEF0.9060501@hartkopp.net>
	<CABHoAvmiu2JY70zJ8K20n8b=ahCDe8owRRWaSLMJoTd36ub7iw@mail.gmail.com>
	<4F553BDA.8060106@hartkopp.net>
	<4F553CA5.8080704@hartkopp.net>
	<CABHoAv=WuK0WZWNyi7jgBTNUbHub8AuGtPzbjL4dYaQ1ZGpu_g@mail.gmail.com>
	<4F56701E.3020104@hartkopp.net>
	<CABHoAv=FhULnAY+a2CbNjdyEEOoBKdEAezL7NQLo+PdfeyRTow@mail.gmail.com>
	<4F8D08D2.3090701@hartkopp.net>
	<CABHoAvmwCbAUfNBocHiUOHypN1uHMi9BrSREG-Yt=K=i3Wfn_w@mail.gmail.com>
	<4F8F24F0.5000501@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45034 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2DRXKV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Apr 2012 19:10:21 -0400
Received: by yhmm54 with SMTP id m54so4083942yhm.19
        for <linux-can@vger.kernel.org>; Wed, 18 Apr 2012 16:10:20 -0700 (PDT)
In-Reply-To: <4F8F24F0.5000501@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Wolfgang,

I checked and the Freescale BSP I'm using is based on Linux version
2.6.24.7-rt21

Thanks,

Mike


On Wed, Apr 18, 2012 at 1:32 PM, Wolfgang Grandegger <wg@grandegger.com=
> wrote:
> Hi Michael,
>
> On 04/18/2012 10:13 PM, Michael Economides wrote:
>> Hi Oliver,
>>
>> Looking on my scope, it does seem like the baudrate is a little off.
>>
>> Here are the commands I use to set up my CAN interface on my Linux b=
oard:
>>
>> insmod -m candev;
>
> Oops, you are using a very very old version of insmod. Are you using
> Linux 2.4.x? I do remember using "-m" with old Linux 2.4 distribution=
s.
>
>> insmod -m mscan-mpc52xx;
>> insmod -m can;
>> insmod -m can-raw
>> ifconfig can0 up;
>>
>> ./cantest can0 baud 1000000;
>>
>> This "cantest" program uses:
>>
>> =A0ifr.ifr_ifru.ifru_ivalue =3D baudrate;
>> ret =3D ioctl(s, SIOCSCANBAUDRATE, &ifr);
>>
>> to set the baudrate. =A0But it seems from reading other discussions,
>> that this is not the correct way to set baud rate.
>
> That's right, in case you are using a recent kernel version.
>
>> I am using the MPC5121 from Freescale, in case that is relevant.
>
> What Linux kernel version do you use? Where did you get the drivers
> above from?
>
> Wolfgang.
>
>> On Mon, Apr 16, 2012 at 11:08 PM, Oliver Hartkopp
>> <socketcan@hartkopp.net> wrote:
>>> On 17.04.2012 06:16, Michael Economides wrote:
>>>
>>>
>>>>>
>>>>> I assume there is a CAN bus problem:
>>>>>
>>>>> - wiring (CAN_L/CAN_H)
>>>>> - correct CAN termination (2x 120 Ohms)
>>>>> - different bitrate
>>>>>
>>>>
>>>> I think you are right, but I have checked that, it looks ok. =A0I =
will
>>>> check again.
>>>>
>>>> I am using a PCAN USB adapter, and the PCAN software says there is=
 an
>>>> "acknowledge error" when it sends a frame to my Linux board.
>>>
>>>
>>> This is an indication for a missing counterpart CAN node:
>>>
>>> - Wrong connection wiring
>>> - Wrong termination
>>> - Wrong bitrate
>>>
>>>>
>>>> When the Linux board tries to send a frame to PCAN, the PCAN softw=
are
>>>> says "form error acknowledge delimiter".
>>>>
>>>> It seems this is the same error in both cases, just worded differe=
ntly.
>>>
>>>
>>> Yes. But this means the same regarding the obvious problems.
>>>
>>>>
>>>> In your opinion, is this most likely a hardware issue? =A0Or is th=
ere
>>>> still some way I could be doing something wrong at the software le=
vel?
>>>
>>>
>>> Did you swap CAN_H / CAN_L ??
>>>
>>> It's definitely one of the three points above. No SW problem ...
>>>
>>> Try to add a third CAN node - if you have one.
>>>
>>> Regards,
>>> Oliver
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>
