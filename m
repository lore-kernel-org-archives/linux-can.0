From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Wed, 10 Apr 2013 16:11:13 +0200
Message-ID: <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-103-wednesday.noc.nerim.net ([178.132.17.103]:11385 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760149Ab3DJOLP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Apr 2013 10:11:15 -0400
Content-class: urn:content-classes:message
In-Reply-To: <51656B9B.80907@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc Kleine-Budde,

It is again you who answers my questions :) Thank you again for your he=
lp.

Le 10/04/2013 15:39, Marc Kleine-Budde a =E9crit :
> On 04/10/2013 03:07 PM, Mylene Josserand wrote:
>> When I compile the driver in static, the kernel stopped booting. Wit=
h
>> some printk, the driver is blocked at the function "spi_write" of th=
e
>> function "mcp251x_hw_reset". The dmesg with my outputs :
>>
>> "
>> spi_imx imx27-cspi.0: master is unqueued, this is deprecated
>> spi_imx imx27-cspi.0: probed
>> CAN device driver interface
>> mcp251x_can_init
>> mcp251x_clean
>> mcp251x_can_probe
>> mcp251x_hw_probe
>> mcp251x_hw_reset
>> mcp251x_hw_reset : spi_write : start
>> "
>
> Does it hang here?
>
> http://lxr.linux.no/linux+v3.8.6/drivers/net/can/mcp251x.c#L624

Yes it hangs here. It did not print "reset failed: ret =3D X" or anythi=
ng=20
else.

>
> Is this the first spi transfer that occurs in the driver?

I think yes. It is the first time MCP251x uses spi transfer function.

>
>> I thought that it was a spi problem because of the warning "master i=
s
>> unqueued, this is deprecated" but in fact the spi works.
>> One surprising thing (for me) is that the MCP251x compiled in module=
 is
>> probed ! (I did not test it yet)
>
> If it's the first spi transfer in the driver that hangs and if the
> mcp251x works if loaded as a module, there is probably some
> initialisation missing. Look for stuff that gets initialized after th=
e
> mcp251x would have been loaded if compiled into the kernel. Make a
> "diff" between the bootload with mcp251x compiled into the kernel and
> without. Other usual suspects are: clocks, pinmux (spi _and_ the mcp2=
51x
> dedicated IRQ line), gpio setup.

Thanks for the advice and the ideas to look at ! I have already compare=
d=20
the bootload and I have seen no differences (maybe I will check that=20
another time). I will search about clocks, pinmux and gpio setup and I=20
will update you if I found how to fix that.

>
> Marc
>

Best regards,


--=20
Myl=E8ne JOSSERAND
Navocap
