From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Wed, 10 Apr 2013 15:07:56 +0200
Message-ID: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailhost-e3-m0.nerim.net ([78.40.49.146]:13145 "EHLO
	smtp-delay2.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750738Ab3DJNPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Apr 2013 09:15:07 -0400
Received: from mallaury.nerim.net (smtp-103-wednesday.noc.nerim.net [178.132.17.103])
	by smtp-delay2.nerim.net (Postfix) with ESMTP id 0605E19CEF44
	for <linux-can@vger.kernel.org>; Wed, 10 Apr 2013 14:11:37 +0200 (CEST)
Received: from SERVEUR0.nvp.local (navocap.net2.nerim.net [213.41.131.28])
	by mallaury.nerim.net (Postfix) with ESMTP id D0F24153431
	for <linux-can@vger.kernel.org>; Wed, 10 Apr 2013 15:07:47 +0200 (CEST)
Content-class: urn:content-classes:message
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi everyone,


I have posted in December 2012 a post about "[mcp251x - spi] Blocked to=
=20
"wait_for_completion"".

To resolve the problem of CAN/spi and others, I am currently updating=20
our kernel to the version 3.8.2 ! The SoC is a IMX27 and the CAN=20
controller is MCP2515.

Currently, I have another problem with the MCP251x driver.

When I compile the driver in static, the kernel stopped booting. With=20
some printk, the driver is blocked at the function "spi_write" of the=20
function "mcp251x_hw_reset". The dmesg with my outputs :

"
spi_imx imx27-cspi.0: master is unqueued, this is deprecated
spi_imx imx27-cspi.0: probed
CAN device driver interface
mcp251x_can_init
mcp251x_clean
mcp251x_can_probe
mcp251x_hw_probe
mcp251x_hw_reset
mcp251x_hw_reset : spi_write : start
"

I thought that it was a spi problem because of the warning "master is=20
unqueued, this is deprecated" but in fact the spi works.
One surprising thing (for me) is that the MCP251x compiled in module is=
=20
probed ! (I did not test it yet)

"
root@navocap:~# modprobe mcp251x
mcp251x_can_init
sdrv->probe =3D bf09047c
sdrv->remove =3D bf08f348
mcp251x_clean
mcp251x_can_probe
mcp251x_hw_probe
mcp251x_hw_reset
mcp251x_hw_reset : spi_write : start
mcp251x_hw_reset : spi_write : end
mcp251x_read_reg
mcp251x_spi_trans
mcp251x_hw_reset : end
mcp251x_hw_probe : hw_reset done
mcp251x_read_reg
mcp251x_spi_trans
mcp251x_read_reg
mcp251x_spi_trans
mcp251x_hw_sleep
mcp251x_write_reg
mcp251x_spi_trans
mcp251x spi0.0: probed
"

I do not understand why is it probed in module and not in static.
Do you have a suggestion ?
I thought that maybe the spi has not finished to be configured but how=20
know that ?
Do you think that it is a spi problem and not a MCP251x problem ?

Best regards,

--=20
Myl=E8ne JOSSERAND
Navocap
