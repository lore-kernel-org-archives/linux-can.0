From: Andrew Lentvorski <bsder@allcaps.org>
Subject: Re: newbi Question: NMEA2000 and BeagleBone
Date: Thu, 26 Mar 2015 16:29:18 -0700
Message-ID: <5514964E.8050401@allcaps.org>
References: <55140B67.9060207@arcor.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5nLr4E7inrbljwP3w88aWvSsglB1thQn3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 64-73-229-46.static-ip.telepacific.net ([64.73.229.46]:26695
	"EHLO s0-postfix.allcaps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932145AbbCZX3Y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Mar 2015 19:29:24 -0400
In-Reply-To: <55140B67.9060207@arcor.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: vklein <vk4514@arcor.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5nLr4E7inrbljwP3w88aWvSsglB1thQn3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Well, I have the TowerTech TT-3201 on a BeagleBone black.  It sorta
works.  I can generally get 2 of the 3 interfaces to work.  However, I
can't really recommend it as working out how to do this in straight
Debian instead of Angstrom has been a slog.


If I had to do it again, I'd probably try these guys.
http://www.logicsupply.com/components/beaglebone/capes/cbb-serial/

They update their user manual for it regularly, and they talk about
doing this with the latest Debian image (which you need for the latest
SocketCAN stuff).

-a


On 3/26/15, 6:36 AM, vklein wrote:
> Hi all,
>=20
> I searched the list about using NMEA2000 ( a subclass of J1939) and a
> BeageBone-black.
>=20
> Are there some newer infos how to install J1939 support on the BBB?
>=20
> Are there preferred transceiver boards? I Think I need only one interfa=
ce.
>=20
> At the moment I use a Actisense NTG-1 USB and a Raspberry pi with the
> canboat software.
>=20
> http://wiki.openseamap.org/wiki/OpenSeaMap-dev:HW-logger/raspberry
>=20
> Regards
>=20
> Victor
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--5nLr4E7inrbljwP3w88aWvSsglB1thQn3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJVFJZSAAoJEJ9wo+TcbAAXh/YIAJXLb1nep4JKzSs0sqPnmegp
gp9It8Rr/udWLegdBfDpSG0pakiYCt+x3D9Xih1Vx8ItpBjJRYiq3TD96E86S+0z
ZHJeI9gYHi/4Ycl2EfZbdZ/ICO3yJbS4M919bL99ny5Jwu3L2J5UfTEoRfbhsotI
xhwELCedX1sPS+NBcwPlJ+D0U8Et2cANki1W1Z7vyiewSqx9A2eR9dwSRMZlFSQY
Fz1wY1+cfyboNRbcbRTocVxeedCy3L9Rd4GZ+x7wLzOAM8GV4PRRNBe2oHimLKBZ
cUKRWd5NJBNAR51pV2xFA13UOfnYEQ9SsC35gIH1NzDOxMwfHWuxg48mM9hbfHU=
=IEy4
-----END PGP SIGNATURE-----

--5nLr4E7inrbljwP3w88aWvSsglB1thQn3--
