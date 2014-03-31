From: Mylene Josserand <Mylene.Josserand@navocap.com>
Subject: RE: mcp251x: mcp2515 stops receiving
Date: Mon, 31 Mar 2014 08:29:51 +0000
Message-ID: <ef6bcef63bd74fb890ed2a4145f481cf@courrier2014.nvp.local>
References: <2E9F00CBB66AB544A1ACDC59627518BA0DB3F120@mailserver>,<20140329181521.GB31437@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailhost-c5-m0.nerim.net ([78.40.49.141]:11415 "EHLO
	smtp-delay2.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752967AbaCaIkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 31 Mar 2014 04:40:08 -0400
Received: from maiev.nerim.net (smtp-151-monday.nerim.net [194.79.134.151])
	by smtp-delay2.nerim.net (Postfix) with ESMTP id 8304F19CF8EB
	for <linux-can@vger.kernel.org>; Mon, 31 Mar 2014 10:30:33 +0200 (CEST)
In-Reply-To: <20140329181521.GB31437@griso.site>
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>, "Rost, Martin" <Martin.Rost@tonfunk.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi everyone,


I have previously posted on this list because of a freeze problem while=
 using the MCP2515 + imx27 : http://marc.info/?l=3Dlinux-can&m=3D136559=
970919837&w=3D2 and http://marc.info/?l=3Dlinux-can&m=3D136559970919837=
&w=3D2


We find a "solution" of this freeze issue with old kernel 2.6.32.
I did not test it in newer kernel and I did not know the impact on othe=
r devices but for the MCP2515 (that is the only device on our SPI bus..=
 with many devices, maybe, it is not a good solution), it works. I ran =
CAN simulation during 2 weeks and it did not freeze anymore.

The solution to this issue is linked to SPI imx driver. I have checked =
and sometimes, the value of tx-fifo buffer of the spi-imx was equals to=
 429496729.
With some external help, we see it was due to the register MX27_INTREG_=
TEEN reading instead of
the MX27_INTREG_TSHFEEN register.=20


With these changes (reading of the register TSHFEEN), for me, it works =
well.
I hope it can help.


Best regards,


Mylene JOSSERAND


________________________________________
De : linux-can-owner@vger.kernel.org <linux-can-owner@vger.kernel.org> =
de la part de John Whitmore <arigead@gmail.com>
Envoy=E9 : samedi 29 mars 2014 19:15
=C0 : Rost, Martin
Cc : linux-can@vger.kernel.org
Objet : Re: mcp251x: mcp2515 stops receiving

Sorry Martin just catching up with this list.

On Fri, Mar 21, 2014 at 12:40:30PM +0000, Rost, Martin wrote:
> Hello List,
>
> We are using the MCP2515 on a tegra3 (Toradex Colibri T30, to be prec=
ise) and every now and then the driver just stops.
> The interrupt line stays low, and the driver does not collect the dat=
a.
> From my investigations I conclude, that the MCP lowers the IRQ line b=
efore the value in the INTF register is  updated,
> so when the driver reads the INTF register, a 0 is returned, and the =
driver assumes nothing has to be done.
>

What you have described is something that I've been getting with the
MCP2515. I do have the MCP2515 connected on the RPi, but I've not been =
using
that setup for a few weeks. I'm currently working with a MCP2515 connec=
ted to
a Microchip PIC24 and cannot get the MCP2515 to work in Interrupt mode =
as it
triggers an Interrupt but the Flags are zero indicating that there is n=
o
interrupt so my driver does nothing and the interrupt line is locked lo=
w. I
can only get the 2515 to work in polled mode.

All that is of no help to you but I'll have a look at my RPi setup and =
really
test it on a network and see if I can recreate that problem there.


> (
> Chances are I'm misinterpreting my observations.
> It might as well be that the call to the IST is suspended, because th=
e previous instance is still running and processes the new irq cause as=
 well,
> so the next call will not see the signal at all.
> But in that case the driver should not stop with the irq line held lo=
w, or should it?
> )
>
> We are using the 3.1.10 kernel from the toradex repository, which sho=
uld be in sync with the nvidia tegra4linux one.
> I have browsed through the patches between 3.1.10 and head and have a=
pplied all those that seem to address issues and don't interfere with t=
he 3.1.10 kernel structures, but to no avail.
> In fact, these patches have been applied:
> cab32f39dcc5b35db96497dc0a026b5dea76e4e7
> db388d6460ffa53b3b38429da6f70a913f89b048
> ae5d589e5f9f3217656ada632869968178886ac6
> b1ef05a5a20afe50d4188a5b59579bd140758cf0
> I have changed the IST loop to poll the INTF register beforehand for =
up to 10ms, and now the driver seems a lot more stable in our environme=
nt.
> Has someone seen this issue before, or can confirm I am not completel=
y off the path?
>
> On a side note, I have a second reason that makes the driver stop, wh=
ich has to do with smp somehow.
> Disabling core1..3 keeps that from happening, but the problem address=
ed above would persist.
> Switching the irq to a different core by setting /proc/irq/91/smp_aff=
inity does not trigger this problem.
> Any insights or starting point on this would also be greatly apprecia=
ted.
>
> Best regards
> Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
