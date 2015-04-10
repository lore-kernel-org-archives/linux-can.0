From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [REGRESSION] commit 0461a41 "spi: Pump transfers inside
 calling context for spi_sync()" breaks Apalis/Colibri T30 with MCP2515
 SPI CAN controller
Date: Fri, 10 Apr 2015 17:15:11 +0200
Message-ID: <5527E8FF.7050104@pengutronix.de>
References: <1428670853.7008.87.camel@localhost.localdomain> <20150410132330.GH6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wfG8euhQrESrjeIrSeTWvVv3P9BILVKXO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44583 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbbDJPQN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Apr 2015 11:16:13 -0400
In-Reply-To: <20150410132330.GH6023@sirena.org.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark Brown <broonie@kernel.org>, Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-can@vger.kernel.org, linux-spi@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Stefan Agner <stefan@agner.ch>, Himangi Saraogi <himangi774@gmail.com>, Julia Lawall <julia.lawall@lip6.fr>, Stefano Babic <sbabic@denx.de>, Christian Pellegrin <chripell@fsfe.org>, "DavidS.Miller" <davem@davemloft.net>, Marc Zyngier <maz@misterjones.org>, Sascha Hauer <s.hauer@pengutronix.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wfG8euhQrESrjeIrSeTWvVv3P9BILVKXO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2015 03:23 PM, Mark Brown wrote:
> On Fri, Apr 10, 2015 at 03:00:53PM +0200, Marcel Ziswiler wrote:
>> Hi there
>=20
> Please try to use somewhat more targetted CC lists...
>=20
>> I also have not yet looked further into what exactly is happening and
>> whether or not the SPI stack, the Tegra SPI controller driver or the
>> MCP2515 SPI CAN driver is to blame but rather decided to ask Mr. Brown=

>> and the community first for any insights they might have to share.
>> Anybody?
>=20
> I'd ask for trace logs but obviously we can't turn them on until boot
> has finished...  Adding some trace in the relevant bits of code to try
> to see where it's deadlocking is the obvious first step.

FWIW: the mcp2515 driver is accessing the SPI bus during probe(). Seems
you have to instrument the SPI stack and/or host driver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wfG8euhQrESrjeIrSeTWvVv3P9BILVKXO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVJ+kCAAoJECte4hHFiupUv7IP/j2LqRbj+5HeXLthNT5xQxhn
IeSCIbXU2ohGHPRrEkXbuO0BbQYOsC9PoX3D0TB77iQzeKtBPJ+wDuPGhj/jIc1P
ZLbry+sDe0RaYhNdfKGcLYMNMqbBf08+NcFQxf9tmTAFkDA+7n9H+CBvg4QWj1p5
nvUjyHf/kz4zFHUx6qJnKzEL7ysqxYtOuYMUOCWj5G3EiIsVkmr3l32nj0vdREh1
WgF6xqu9xu6h/6FSKsNlOFKZM3MS4fOX+AgPsMdvj7aqZyxMABV74XOQg0KInwlQ
/bdEdiMozLJK9Snnhar2dYwxqopZgONKAsOMJ4WqawjRzdKuLnv6SYxTsIpI/Vmz
tUZ5UW9W5Jouuy1LrXSxqcdjb8Spl6jDKbNvkUx2hOB+B3dYqIi8/Wab0CJpVadK
w6WC+qNuh3aef/nHw9mw3AY3gqx1YyNEtG2FL7hcn04YcR+1yrCfdYw63U7mBJ5X
Iyxsj0jZZPiWymk0S12QnTjeVI5ooEAx4tG1wPr8805ROeeU1VfujRON0IwkyrsU
9uImSuRRkH7D6jJO124iuOR5Q2Sb8/LcXYWi9YLSgbNQESmlPuwtKsrbYAWVp3aw
hZLkWb3B/ymrAQ1BMV38yG8WVNjQkiKDAg7BHcAx/TTpK0ECEA/sUSZl3t3B0tqK
ny6epGxrOWZrLHKnt3TO
=xDk+
-----END PGP SIGNATURE-----

--wfG8euhQrESrjeIrSeTWvVv3P9BILVKXO--
