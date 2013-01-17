From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb_8dev: firmware and windows library
Date: Thu, 17 Jan 2013 17:32:06 +0100
Message-ID: <50F82786.5050509@hartkopp.net>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:18038 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757181Ab3AQQcJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Jan 2013 11:32:09 -0500
In-Reply-To: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Bernd_Krumb=F6ck?= <krumboeck@universalnet.at>, gediminas@8devices.com
Cc: linux-can@vger.kernel.org

Whow! Great!

On 17.01.2013 10:03, "Bernd Krumb=F6ck" wrote:

>=20
> 8 devices (http://www.8devices.com/) allowed me to publish the firmwa=
re to
> the public:
>=20
> firmware:
> https://github.com/krumboeck/usb2can_firmware
>=20
> canal library:
> https://github.com/krumboeck/usb2can_canal
>=20
>=20
> Many thanks to 8 devices!


Indeed. Great step for this CAN hardware.

Today i compared the performance of the 8devices CAN USB with

	cangen -g0 -i -I 010 -L 8 -D 0000000000000000 canX

in my Laptop:

EMS PCMCIA sja1000    tx busload up to 74% (5699 frames/s)
8devices CAN USB      tx busload up to 88% (6780 frames/s)
PEAK USB (mainline)   tx busload up to 68% (5288 frames/s)

ALL: rx busload up to 104% (8007 frames/s) =3D=3D 88% w/o bitstuff esti=
mation

So the 8devices CAN USB has an excellent performance right now.

Tnx & regards,
Oliver
