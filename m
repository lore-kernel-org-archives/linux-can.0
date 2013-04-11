From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Thu, 11 Apr 2013 11:22:23 +0200
Message-ID: <CA78C307B8F06747967D122FC656B153774460@SERVEUR0.nvp.local>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local> <51666B21.10109@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445D@SERVEUR0.nvp.local> <516676B5.6090903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-104-thursday.noc.nerim.net ([178.132.17.104]:31131 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1160998Ab3DKJdg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Apr 2013 05:33:36 -0400
Content-class: urn:content-classes:message
In-Reply-To: <516676B5.6090903@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Le 11/04/2013 10:39, Marc Kleine-Budde a =E9crit :
> On 04/11/2013 10:04 AM, Mylene Josserand wrote:
>>>> root@navocap:~# ifconfig can0 up
>>>> genirq: Threaded irq requested with handler=3DNULL and !ONESHOT fo=
r irq 201
>>>> mcp251x spi0.0: failed to acquire irq 201
>>>
>>> It's a bug in the driver....which was introduced in v3.5[1]. I'm lo=
oking
>>> for a fix.
>>>
>>> Marc
>>>
>>> [1] 1c6c695 genirq: Reject bogus threaded irq requests
>>>
>>
>> Okay.
>>
>> In this
>> http://markmail.org/thread/uc2adurel247yitp#query:+page:1+mid:uc2adu=
rel247yitp+state:results
>> and this
>> http://www.raspberrypi.org/phpBB3/viewtopic.php?f=3D44&t=3D7027&star=
t=3D150
>> posts, they set the irq_flags to IRQF_ONESHOT.
>>
>> I have tested it and I did not have the error anymore. Maybe it is n=
ot a
>> good way to fix that ? (I don't know what is a "one shot" IRQ) but i=
n
>> case it could help.
>> However, it did not fix my static-mcp251x boot hang.
>
> Can you test my patch and give me a Tested-by?
>
> Marc
>

I tested your patch and it works ! (As module), I can UP the can=20
interface and set an IP adress. I did not test much (cansend / candump,=
=20
=2E..).

Sorry, it is the first time I take part of a kernel patch (thank you fo=
r=20
that !) so I don't know what the "procedure" to give you a "Tested-by" =
? :)


Best regards,


--=20
Myl=E8ne JOSSERAND
Navocap
