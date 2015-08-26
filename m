From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: SocketCAN on Intel Edison with MCP 2515
Date: Wed, 26 Aug 2015 12:31:27 +0200
Message-ID: <zarafa.55dd957f.34be.077c29991e8b8903@euve35974.vserver.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_+lpTOcowvu4PVuxsLaTsFYzr+O9Zp-HngndtNGkwTFGjxGmC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from euve35974.vserver.de ([62.75.213.146]:43390 "EHLO
	euve35974.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394AbbHZKhH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Aug 2015 06:37:07 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>, =?utf-8?Q?Rosemarie_Sheehy?= <rsheehy@dairymaster.ie>, =?utf-8?Q?tom=5Fusenet=40optusnet=2Ecom=2Eau?= <tom_usenet@optusnet.com.au>

This is a multi-part message in MIME format. Your mail reader does not
understand MIME message format.
--=_+lpTOcowvu4PVuxsLaTsFYzr+O9Zp-HngndtNGkwTFGjxGmC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

attached you can find a working DeviceTree examples which is working fine for me with 2x MCP2515 CAN devices via socketcan.
The ODROID-W is an BCM2835 SoC based (Raspi like) system running kernel 3.18.x.
Hint: My MCP2515 SPI is running wth 12MHz instead of 16MHz.

On another embedded system (Raspi B) I've some days ago used a fresh Rapbmc installation with kernel 3.18.x!
I've adapted the original DeviceTree from...
https://github.com/raspberrypi/linux/blob/rpi-3.18.y/arch/arm/boot/dts/overlays/mcp2515-can0-overlay.dts
...to my needs (16MHz to 12MHz MCP2515 SPI-clock)

Maybe you can use these background informations to adapt to the Edison platform.

Regards
Michael

-----Urspr=C3=BCngliche Nachricht-----
Von:=09Tom Evans <tom_usenet@optusnet.com.au>
Gesendet:=09Mi 26.08.2015 06:56
Betreff:=09Re: SocketCAN on Intel Edison with MCP 2515
An:=09Rosemarie Sheehy <rsheehy@dairymaster.ie>; linux-can@vger.kernel.org;=20
> On 26/08/15 00:49, Rosemarie Sheehy wrote:
> > Michael Gallagher <mjg <at> isomorphdevelopment.com> writes:
>=20
> Actually:
>=20
> On 28/05/15 01:18, Michael Gallagher wrote:
>  > ...
>=20
> He may not be monitoring this list after 3 months.
>=20
> > I am trying to trying to set the can bus on the Edison.
> > I have the expansion board and the can-bus shield
> > (https://www.sparkfun.com/products/10039)
>=20
> That's an Arduino Shield board on an adaptor on an Intel Edison running (I'm=20
> guessing) Yocto Linux. Good luck with that, you may be the first in the world=20
> to try that combination.
>=20
> Did you read all the other posts in this thread=3F You may get some clues from=20
> them
>=20
> Apparently the RPi Linux will automatically detect the CAN chips, but you'll=20
> have to consult the Yocto/Edison documentation to see if it has been set up by=20
> someone to do that.
>=20
> Michael didn't say which hardware he was using.
>=20
> As I said in another post "Linux used t be plug-and-play, but they fixed that=20
> bug". Devices on an I2C bus can sometimes be automatically identified, but the=20
> MCP2515 is on an SPI bus, and it can't autodetect chips. You have to add=20
> descriptions in the Device Tree File for your board (or add information to the=20
> Bootstrap Configuration so it can edit the Device Tree - more complications=20
> and more languages to learn to get a simple job done).
>=20
> Check your Linux Source Tree "Documentation/devicetree/bindings/net/can"=20
> directory. Mine has documentation for cc770, flexcan, mscan, sj1000 but no=20
> mcp251x.
>=20
> A more modern version of Linux has this:
>=20
> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/net/can/m
> icrochip,mcp251x.txt
>=20
> That doesn't tell you where in the tree to add that section. I assume it has=20
> to be under/inside or reference an SPI controller somehow.
>=20
> So to try and find a worked example, google for <compatible =3D=20
> "microchip,mcp2515">
>=20
> http://www.microchip.com/forums/m828830.aspx
>=20
> Also check "Documentation/devicetree/bindings/spi-bus.txt".
>=20
> Remember the device doesn't show up as "/dev/can0", but shows up as a network=20
> device when you run "/sbin/ifconfig". It might also show up under /sys=20
> somewhere too. You then have to control it (to enable and set the baud rate)=20
> with "canconfig". If you don't have that software installed you may have to=20
> find/configure/build/install it as well.
>=20
> Tom
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--=_+lpTOcowvu4PVuxsLaTsFYzr+O9Zp-HngndtNGkwTFGjxGmC
Content-Type: application/x-zip-compressed;
 name=ODROID-W_mcp2515-can-overlay.zip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=ODROID-W_mcp2515-can-overlay.zip

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
--=_+lpTOcowvu4PVuxsLaTsFYzr+O9Zp-HngndtNGkwTFGjxGmC--

