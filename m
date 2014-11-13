From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: mcp251x (was: Re: candump error flags)
Date: Thu, 13 Nov 2014 11:20:51 +0100
Message-ID: <54648603.8040808@pengutronix.de>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>	<545CD775.1030200@pengutronix.de>	<545CDD93.1080600@hartkopp.net>	<CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>	<545E301F.7090708@hartkopp.net>	<CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>	<545E48D0.3020409@pengutronix.de>	<CAHuoermH8js-WJYGRVbWkLK91yUBQOL8CxoyqfJgbqLpjvsX5w@mail.gmail.com>	<545F81B6.1090900@pengutronix.de> <CAHuoermg1YGrmeqZ8Xh7eu-S=HbHh0Wf-ptVkHXf-dqNqRz9zA@mail.gmail.com> <473f02a2fc154c79b7902f7f7bb438df@SGPMBX1004.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fCrJ0KQjJoeMp15SbBEn1kpPB07lh2xtV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60649 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbaKMKUz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Nov 2014 05:20:55 -0500
In-Reply-To: <473f02a2fc154c79b7902f7f7bb438df@SGPMBX1004.APAC.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Pankajkumar Misra (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>, Paul Lever <svjeorgia@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fCrJ0KQjJoeMp15SbBEn1kpPB07lh2xtV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Pankajkumar,

please start a new thread, when starting a new topic.

On 11/10/2014 06:29 AM, Pankajkumar Misra (RBEI/EEA2) wrote:
> Are there any patches available for MCP251x module.
> I am using it on Olimex board with spi interface.

Any patched compared to which Kernel version?

> I am getting bus-off very often & also not able to set any other baud
> rate than 250KBPS.

Which driver are you using? The mcp251x chips are not the best CAN chips
to be used on a Linux based system.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fCrJ0KQjJoeMp15SbBEn1kpPB07lh2xtV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZIYDAAoJECte4hHFiupU5OoP/RWKlgGjZ3DPPMrPYPboUdLZ
nWl13tbpbhK6ykPZY+GNS0Bm0Tedq1vo+ORYAyQHc4ElRFbwqBKsHbJIOPOhkSeC
XoBsK7Rq+L4rwNNMIdGM9f8nvdxa8S7A9QZOFlqGgz/DwGyw9U8Sfoi74Ig0xtCF
c2k0mjo8ofV70ROPuMsNhN7nHtuTGvYEeicONb9KggSGYbxNC1+DdjScHXYNjSU4
NbOz2bVqNbfomJs81rZh1zF0Vj9LNT47U/S9tLXbgEFeD1ydmxeKh9F1GcmaRLVw
imcYE3OiMK4uyLAYp5CwvczmciRYZwp5OibMEI/u7kCTFesOqCrvsQ453EFf63hk
JkpuWHsI5zAWZx9yI5NhoGnjSyLSK7r7USfJhN36/0ESNzwCa8JXDdFbr5IwdFBz
a6H5fLkyoaJBhiYotFDVDradA+z9t6CmeIeB9h67T08PNmDnu7+u6HQIeyWGsSMn
PwgWdt11tcx2oAwhz9VMEqpEDVx4GfDA56Swbks4I5UHP/L1Ngu+el7qT4/NM5GU
IHNS/y0XUfcQyDEjusyV2Ft/aFfU/vNIPaEL/w2vK23j6hq3453YeSVSvHtbCu/4
yADtBVpoCXoClaSCq2j2UbHaNw0LsJ1YAv+v4e7TXxHXb7YvnxOUHoLHp5BhSshF
CWGHsdsvofWsTXSxzdA1
=0dEd
-----END PGP SIGNATURE-----

--fCrJ0KQjJoeMp15SbBEn1kpPB07lh2xtV--
