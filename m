From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Thu, 11 Apr 2013 16:39:36 +0200
Message-ID: <CA78C307B8F06747967D122FC656B153774467@SERVEUR0.nvp.local>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local> <51666B21.10109@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445D@SERVEUR0.nvp.local> <516676B5.6090903@pengutronix.de> <CA78C307B8F06747967D122FC656B153774460@SERVEUR0.nvp.local> <51668741.6030909@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-154-thursday.nerim.net ([194.79.134.154]:62939 "EHLO
	maiev.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934437Ab3DKOjk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Apr 2013 10:39:40 -0400
Content-class: urn:content-classes:message
In-Reply-To: <51668741.6030909@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Le 11/04/2013 11:49, Marc Kleine-Budde a =E9crit :
> On 04/11/2013 11:22 AM, Mylene Josserand wrote:
>> Le 11/04/2013 10:39, Marc Kleine-Budde a =E9crit :
>>> On 04/11/2013 10:04 AM, Mylene Josserand wrote:
>>>>>> root@navocap:~# ifconfig can0 up
>>>>>> genirq: Threaded irq requested with handler=3DNULL and !ONESHOT =
for irq 201
>>>>>> mcp251x spi0.0: failed to acquire irq 201
>>>>>
>>>>> It's a bug in the driver....which was introduced in v3.5[1]. I'm =
looking
>>>>> for a fix.
>>>>>
>>>>> Marc
>>>>>
>>>>> [1] 1c6c695 genirq: Reject bogus threaded irq requests
>>>>>
>>>>
>>>> Okay.
>>>>
>>>> In this
>>>> http://markmail.org/thread/uc2adurel247yitp#query:+page:1+mid:uc2a=
durel247yitp+state:results
>>>> and this
>>>> http://www.raspberrypi.org/phpBB3/viewtopic.php?f=3D44&t=3D7027&st=
art=3D150
>>>> posts, they set the irq_flags to IRQF_ONESHOT.
>>>>
>>>> I have tested it and I did not have the error anymore. Maybe it is=
 not a
>>>> good way to fix that ? (I don't know what is a "one shot" IRQ) but=
 in
>>>> case it could help.
>>>> However, it did not fix my static-mcp251x boot hang.
>>>
>>> Can you test my patch and give me a Tested-by?
>>>
>>> Marc
>>>
>>
>> I tested your patch and it works ! (As module), I can UP the can
>> interface and set an IP adress. I did not test much (cansend / candu=
mp,
>> ...).
>
> Err... don't set IP addresses on CAN interfaces, that's wrong.

Yes, I even do not know why I set the IP address !

>
>> Sorry, it is the first time I take part of a kernel patch (thank you=
 for
>> that !) so I don't know what the "procedure" to give you a "Tested-b=
y" ? :)
>
> Please do a "real test" and and send and receive some 10k frames. Rep=
ly
> to the patch and say something like:
>
> "I've tested your patch and successfully send and received 10000
> CAN-Frames. You can add my Tested-by: Mylene Josserand
> <Mylene.Josserand@navocap.com>"
>
> Marc
>

Bad news for me.

I think that your patch works but I have the same error as my first pos=
t=20
: the CAN / spi is blocked after some frames sent/received.

Currently, I use a CAN232 and a small program which send CAN frames=20
through the 232 to the CAN. Then, In the same time, I read the CAN=20
frames sent with "candump can0".

I received the good message sent (00 01 02 03 04) :

"
root@navocap:~# candump can0
interface =3D can0, family =3D 29, type =3D 3, proto =3D 1
<0x001> [5] 00 01 02 03 04
<0x001> [5] 00 01 02 03 04
<0x001> [5] 00 01 02 03 04
<0x001> [5] 00 01 02 03 04
<0x001> [5] 00 01 02 03 04
<0x001> [5] 00 01 02 03 04
<0x001> [5] 00 01 02 03 04
<0x001> [5] 00 01 02 03 04
<0x001> [5] 00 01 02 03 04
<0x001> [5] 00 01 02 03 04
[...]
"

I have read 15 383 frames but after 15 834, it hangs. And after that, I=
=20
can not act on the CAN anymore. A "ifconfig can0 down" hangs the kernel=
=20
(even with ^C) and I have to restart the board to use the CAN again !

I really think that it is not linked to your patch (do you want me to=20
send the "Tested by" anyway ?) but to my first problem. The kernel=20
update did not seem to fix that.
Could you help me to try to fix it ? Because I really do not know how t=
o=20
debug / fix it.
=46or CAN bus, which is the most CAN chip used ? Do you think that the=20
MCP2515 is a good choice ?

Thank you in advance,

--=20
Myl=E8ne JOSSERAND
Navocap
