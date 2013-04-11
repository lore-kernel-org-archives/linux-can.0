From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Thu, 11 Apr 2013 09:39:58 +0200
Message-ID: <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailhost-i1-m1.netultra.net ([78.40.49.164]:65079 "EHLO
	smtp-delay2.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752062Ab3DKHk0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Apr 2013 03:40:26 -0400
Received: from maiev.nerim.net (smtp-154-thursday.nerim.net [194.79.134.154])
	by smtp-delay2.nerim.net (Postfix) with ESMTP id 5F2A819CF332
	for <linux-can@vger.kernel.org>; Thu, 11 Apr 2013 08:43:38 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <5165857D.1050303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

Le 10/04/2013 17:30, Marc Kleine-Budde a =E9crit :
> On 04/10/2013 04:11 PM, Mylene Josserand wrote:
>
>>> If it's the first spi transfer in the driver that hangs and if the
>>> mcp251x works if loaded as a module, there is probably some
>>> initialisation missing. Look for stuff that gets initialized after =
the
>>> mcp251x would have been loaded if compiled into the kernel. Make a
>>> "diff" between the bootload with mcp251x compiled into the kernel a=
nd
>>> without. Other usual suspects are: clocks, pinmux (spi _and_ the mc=
p251x
>>> dedicated IRQ line), gpio setup.
>>
>> Thanks for the advice and the ideas to look at ! I have already comp=
ared
>> the bootload and I have seen no differences (maybe I will check that
>> another time). I will search about clocks, pinmux and gpio setup and=
 I
>> will update you if I found how to fix that.
>
> Save the bootlog of a system start with the driver compiled as a modu=
le
> into file bootlog-module.txt. Make a second bootlog with the driver
> compiled into the kernel, save as bootlog-builtin.txt. Then:
>
>      diff -u bootlog-module.txt bootlog-builtin.txt
>
> Look for the stuff that would have been initialized _after_ the syste=
m
> hangs. The diff should show you this.
>
> Marc
>

Thank you for the help.
I have done it and instead of having the mcp configuration, in the=20
bootlog-module, there is the libphy fec_net_mii_bus driver probed and=20
other boot configurations.

"
  spi_imx imx27-cspi.0: master is unqueued, this is deprecated
  spi_imx imx27-cspi.0: probed
  CAN device driver interface
-mcp251x_can_init
-mcp251x_clean
-mcp251x_can_probe
-mcp251x_hw_probe
-mcp251x_hw_reset
-mcp251x_hw_reset : spi_write : start
+libphy: fec_enet_mii_bus: probed
+PPP generic driver version 2.4.2
+PPP BSD Compression module registered
+PPP Deflate Compression module registered
+PPP MPPE Compression module registered
+ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
+ehci-mxc: Freescale On-Chip EHCI Host driver
+mxc-ehci mxc-ehci.2: initializing i.MX USB Controller
[...]
"

If the MCP 251x is compiled as module, will it use the init configurati=
on ?

I think I have a problem with the irq because I have tried to use it as=
=20
module and when I do "ifconfig can0 up", I get :
"
root@navocap:~# ifconfig can0 up
genirq: Threaded irq requested with handler=3DNULL and !ONESHOT for irq=
 201
mcp251x spi0.0: failed to acquire irq 201
ifconfig: SIOCSIFFLAGS: Invalid argument
"

I will continue to search how to fix it.

Best regards,

--=20
Myl=E8ne JOSSERAND
Navocap
