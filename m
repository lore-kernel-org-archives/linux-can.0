From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Thu, 11 Apr 2013 10:04:20 +0200
Message-ID: <CA78C307B8F06747967D122FC656B15377445D@SERVEUR0.nvp.local>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local> <51666B21.10109@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-154-thursday.nerim.net ([194.79.134.154]:42684 "EHLO
	maiev.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762634Ab3DKIaW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Apr 2013 04:30:22 -0400
Content-class: urn:content-classes:message
In-Reply-To: <51666B21.10109@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org



Le 11/04/2013 09:49, Marc Kleine-Budde a =E9crit :
> On 04/11/2013 09:39 AM, Mylene Josserand wrote:
>> Hi Marc,
>>
>> Le 10/04/2013 17:30, Marc Kleine-Budde a =E9crit :
>>> On 04/10/2013 04:11 PM, Mylene Josserand wrote:
>>>
>>>>> If it's the first spi transfer in the driver that hangs and if th=
e
>>>>> mcp251x works if loaded as a module, there is probably some
>>>>> initialisation missing. Look for stuff that gets initialized afte=
r the
>>>>> mcp251x would have been loaded if compiled into the kernel. Make =
a
>>>>> "diff" between the bootload with mcp251x compiled into the kernel=
 and
>>>>> without. Other usual suspects are: clocks, pinmux (spi _and_ the =
mcp251x
>>>>> dedicated IRQ line), gpio setup.
>>>>
>>>> Thanks for the advice and the ideas to look at ! I have already co=
mpared
>>>> the bootload and I have seen no differences (maybe I will check th=
at
>>>> another time). I will search about clocks, pinmux and gpio setup a=
nd I
>>>> will update you if I found how to fix that.
>>>
>>> Save the bootlog of a system start with the driver compiled as a mo=
dule
>>> into file bootlog-module.txt. Make a second bootlog with the driver
>>> compiled into the kernel, save as bootlog-builtin.txt. Then:
>>>
>>>       diff -u bootlog-module.txt bootlog-builtin.txt
>>>
>>> Look for the stuff that would have been initialized _after_ the sys=
tem
>>> hangs. The diff should show you this.
>>>
>>> Marc
>>>
>>
>> Thank you for the help.
>> I have done it and instead of having the mcp configuration, in the
>> bootlog-module, there is the libphy fec_net_mii_bus driver probed an=
d
>> other boot configurations.
>>
>> "
>>    spi_imx imx27-cspi.0: master is unqueued, this is deprecated
>>    spi_imx imx27-cspi.0: probed
>>    CAN device driver interface
>> -mcp251x_can_init
>> -mcp251x_clean
>> -mcp251x_can_probe
>> -mcp251x_hw_probe
>> -mcp251x_hw_reset
>> -mcp251x_hw_reset : spi_write : start
>> +libphy: fec_enet_mii_bus: probed
>> +PPP generic driver version 2.4.2
>> +PPP BSD Compression module registered
>> +PPP Deflate Compression module registered
>> +PPP MPPE Compression module registered
>> +ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> +ehci-mxc: Freescale On-Chip EHCI Host driver
>> +mxc-ehci mxc-ehci.2: initializing i.MX USB Controller
>> [...]
>> "
>>
>> If the MCP 251x is compiled as module, will it use the init configur=
ation ?
>>
>> I think I have a problem with the irq because I have tried to use it=
 as
>> module and when I do "ifconfig can0 up", I get :
>> "
>> root@navocap:~# ifconfig can0 up
>> genirq: Threaded irq requested with handler=3DNULL and !ONESHOT for =
irq 201
>> mcp251x spi0.0: failed to acquire irq 201
>
> It's a bug in the driver....which was introduced in v3.5[1]. I'm look=
ing
> for a fix.
>
> Marc
>
> [1] 1c6c695 genirq: Reject bogus threaded irq requests
>

Okay.

In this
http://markmail.org/thread/uc2adurel247yitp#query:+page:1+mid:uc2adurel=
247yitp+state:results=20
and this=20
http://www.raspberrypi.org/phpBB3/viewtopic.php?f=3D44&t=3D7027&start=3D=
150=20
posts, they set the irq_flags to IRQF_ONESHOT.

I have tested it and I did not have the error anymore. Maybe it is not =
a=20
good way to fix that ? (I don't know what is a "one shot" IRQ) but in=20
case it could help.
However, it did not fix my static-mcp251x boot hang.

Best regards,


--=20
Myl=E8ne JOSSERAND
Navocap
