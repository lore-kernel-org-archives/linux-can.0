From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: adding can4linux to drivers/char
Date: Mon, 30 Sep 2013 09:40:37 +0200
Message-ID: <CADGMhsWUYN8gYqaRFH802jHmDgC2kamdLzDCgOvhhB-MYG-0hQ@mail.gmail.com>
References: <1881932.U1kQQJkqCz@heinz.site>
	<523DF9C1.30300@grandegger.com>
	<2109885.0l6dWmo4a5@heinz.site>
	<52488278.4030603@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:43569 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3I3Hkk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Sep 2013 03:40:40 -0400
Received: from [209.85.128.46] (helo=mail-qe0-f46.google.com)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.68)
	(envelope-from <dev@sebastianhaas.info>)
	id 1VQY5u-0004jj-Ms
	for linux-can@vger.kernel.org; Mon, 30 Sep 2013 09:40:38 +0200
Received: by mail-qe0-f46.google.com with SMTP id x7so3518966qeu.33
        for <linux-can@vger.kernel.org>; Mon, 30 Sep 2013 00:40:37 -0700 (PDT)
In-Reply-To: <52488278.4030603@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

2013/9/29 Wolfgang Grandegger <wg@grandegger.com>:
> On 09/29/2013 06:28 PM, Heinz-J=FCrgen Oertel wrote:
>>
>> Hello
>>
>> Am Samstag, 21. September 2013, 21:55:45 schrieb Wolfgang Grandegger=
:
>>> I think you need *strong* arguments to get it accepted.
>>
>> I have some good arguments for this kind of driver
>> - it is much more simple in design than others,
>>   simplicity is one of the Linux design goals
>> - It has a simple user API
>> - It does not need any other infrastructure than the kernel API
>> - It is mature
>
> Well, the question is in what respect it's (much) better than the
> existing Linux-CAN. I can imagine some performance benefits on very l=
ow
> end systems, if at all.
Again think about memory (RAM/ROM) as well. We are talking here about s=
mall
ARM7TDMI stuff and other creepy and limited systems.

>> I agree, it would be nice to share the low level CAN controller rela=
ted
>> experiences of the developers. That is may be something we can share=
 if we
>> could agree of a set of CAN controller header files with shared regi=
ster
>> #defines. And a set of very basic functions like initialize and acti=
vate CAN,
>> set acceptance filters, transmit and receive, read out error registe=
r or
>> whatever.
>
> Sounds ugly!
Sharing definitions and common functions sounds ugly to you? What does
the candev
and sja1000dev in Socket CAN does?

>> But to stay simple, I don't like the idea to have another additional=
 layer
>> around SocketCAN as layer below the can4linux API.
>>
>> Linux offers real diversity on the desktop, why not with drivers? Li=
nux also
>> has different sound devices and architectures.  Why not offering two=
 different
>> CAN driver concepts to the application programmer,
>> let she decide what to use.
>
>
> It's also about maintenance. It's real work to keep a driver in the
> kernel up-to-date, to review and accept new drivers, etc., not only f=
or
> the initial submitter.
Right, and I think a chardev drivers has far less dependencies to maint=
ain then
the Socket CAN driver. No netdev changes to maintain, iputils stuff or =
changes
in the candev ;-)

A reason more trying to share code with a chardev solution!

> There are missing bits and pieces in Linux-CAN, e.g. hardware filter
> support, improved bus-off handling or even bitrate detection. That's
> also not a strong argument for can4linux. Just contribute them to Lin=
ux-CAN.
Well, some things can't be done cause of the underlying networking subs=
ystem
(namely the queuing) which is perfectly fine for real networking stuff
(>=3D IP) but
not that well for CAN IMHO.

-Sebastian
