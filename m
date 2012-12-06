From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: RE: [mcp251x - spi] Blocked to "wait_for_completion"
Date: Thu, 6 Dec 2012 14:43:26 +0100
Message-ID: <CA78C307B8F06747967D122FC656B1537FEDF4@SERVEUR0.nvp.local>
References: <50C0862F.4080309@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bamako.nerim.net ([178.132.17.28]:64850 "EHLO bamako.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755024Ab2LFNn3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 08:43:29 -0500
Content-class: urn:content-classes:message
In-Reply-To: <50C0862F.4080309@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

Thank you for your quick answer ! :)


>what SPI controller are you using?
>Which SoC are you on?

We are using a IMX27 and the spi controller is inside I think.

>Do you have a MCP2510 or a MCP2515?

We have a MCP2515.


>A lot of fixes have been applied to the driver since v2.6.34, you shou=
ld
>backport them, too.

Yes, I see it. I have tried to update the MCP driver with a patch that =
you have wrote to "fix and optimize" this driver. Unfortunately, it did=
 not seem to solve the problem. But I will try to backport the new driv=
er version.


>The CAN driver calls into the SPI layer to send a message synchronousl=
y.
>The SPI layer kicks the SPI driver to send the message, bus, this is
>done asynchronously. In the completion handler of the SPI driver the S=
PI
>layer is told that the SPI transfer is complete.

>In the above described mechanism the SPI layer is waiting with
>wait_for_completion(), the SPI driver will call (either directly, or v=
ia
>a callback, which has been set by the SPI layer) a complete() which wi=
ll
>wake up the SPI layer.

>If the SPI layer is still in wait_for_completion(), the SPI transfer
>never finished...there's might be a bug in the SPI driver.

Okay. It was what I am thinking of. It was like waiting something...


>Never seen it.

Arf ! I thought that maybe, it was a bug known that you/someone had fix=
ed with new versions.

>Debug your SPI driver. Especially the completion of a transfer. Hook u=
p
>a scope to the SPI lines.

Okay. So the spi.c with the wait_for_completion is the spi layer ? My p=
roblem would not be in this file but in the spi driver (which I do not =
know where it is but I will search it ! ) ?

>Updating the Kernel is always a good idea. Use latest v3.7-rc or newer
>if updating.

Okay ! This was something that I propose to my company. I will maybe tr=
y directly to update the kernel (so the driver too) !
I will let you know if I find why it is happening.


Thank you again for your answer and your work on the CAN ! :)


Myl=E8ne JOSSERAND

