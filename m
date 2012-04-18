From: Michael Economides <mecono@gmail.com>
Subject: Re: read() question from newbie
Date: Wed, 18 Apr 2012 13:13:50 -0700
Message-ID: <CABHoAvmwCbAUfNBocHiUOHypN1uHMi9BrSREG-Yt=K=i3Wfn_w@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51759 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab2DRUNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Apr 2012 16:13:51 -0400
Received: by qadc11 with SMTP id c11so673418qad.19
        for <linux-can@vger.kernel.org>; Wed, 18 Apr 2012 13:13:51 -0700 (PDT)
In-Reply-To: <4F8D08D2.3090701@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

Looking on my scope, it does seem like the baudrate is a little off.

Here are the commands I use to set up my CAN interface on my Linux boar=
d:

insmod -m candev;
insmod -m mscan-mpc52xx;
insmod -m can;
insmod -m can-raw
ifconfig can0 up;

=2E/cantest can0 baud 1000000;

This "cantest" program uses:

 ifr.ifr_ifru.ifru_ivalue =3D baudrate;
ret =3D ioctl(s, SIOCSCANBAUDRATE, &ifr);

to set the baudrate.  But it seems from reading other discussions,
that this is not the correct way to set baud rate.

I am using the MPC5121 from Freescale, in case that is relevant.

Thanks,

Mike


On Mon, Apr 16, 2012 at 11:08 PM, Oliver Hartkopp
<socketcan@hartkopp.net> wrote:
> On 17.04.2012 06:16, Michael Economides wrote:
>
>
>>>
>>> I assume there is a CAN bus problem:
>>>
>>> - wiring (CAN_L/CAN_H)
>>> - correct CAN termination (2x 120 Ohms)
>>> - different bitrate
>>>
>>
>> I think you are right, but I have checked that, it looks ok. =A0I wi=
ll
>> check again.
>>
>> I am using a PCAN USB adapter, and the PCAN software says there is a=
n
>> "acknowledge error" when it sends a frame to my Linux board.
>
>
> This is an indication for a missing counterpart CAN node:
>
> - Wrong connection wiring
> - Wrong termination
> - Wrong bitrate
>
>>
>> When the Linux board tries to send a frame to PCAN, the PCAN softwar=
e
>> says "form error acknowledge delimiter".
>>
>> It seems this is the same error in both cases, just worded different=
ly.
>
>
> Yes. But this means the same regarding the obvious problems.
>
>>
>> In your opinion, is this most likely a hardware issue? =A0Or is ther=
e
>> still some way I could be doing something wrong at the software leve=
l?
>
>
> Did you swap CAN_H / CAN_L ??
>
> It's definitely one of the three points above. No SW problem ...
>
> Try to add a third CAN node - if you have one.
>
> Regards,
> Oliver
