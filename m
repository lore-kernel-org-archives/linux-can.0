From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Testing CAN on Allwinner A20 / Banana Pi
Date: Sat, 12 Sep 2015 11:13:16 +0200
Message-ID: <55F3ECAC.7040508@pengutronix.de>
References: <55F3E7A0.9020309@posteo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KA11HIBqVA8hnh8tlQ9tSbTQvjIgCdiLd"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33028 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbILJNZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 12 Sep 2015 05:13:25 -0400
In-Reply-To: <55F3E7A0.9020309@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KA11HIBqVA8hnh8tlQ9tSbTQvjIgCdiLd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2015 10:51 AM, Patrick Menschel wrote:

> I'm new to socketcan and like to test the recent driver for the
> Allwinner A20 on a BPi.
>=20
> I've got a BPi running CAN4Linux and like to setup a second BPi running=

> socketcan.

Is your CAN4Linux setup working? It's good to have a working CAN station
to talk to.

> I have some basic questions prior to get started with the project:
>=20
> 1.
> Which kernel version is necessary for the current socketcan?
> I use the standard linux-sunxi kernel from the repos as this worked wel=
l
> with CAN4Linux.
> https://github.com/linux-sunxi/linux-sunxi.git

I'm using mainline linux on my Bpi. Works quite well. I don't use the
graphics, though.

> 2.
> I haven't been able to locate the recent driver on the repos.
> https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/
> https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can.git/
>=20
> Did I miss something, because none of the related commits I see in the
> mailing list are present in the repo?

The driver by Gerhard Bertelsmann is still under review, you have to
apply the patches:

http://article.gmane.org/gmane.linux.can/8511/raw
http://article.gmane.org/gmane.linux.can/8512/raw

to your kernel manually. You have to switch on the CAN driver in you dts
as documented in patch 8511. Note: When using the patch from the gmane
archive you have to replace the " <at> " by a "@" sign.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--KA11HIBqVA8hnh8tlQ9tSbTQvjIgCdiLd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV8+ysAAoJEP5prqPJtc/H+dsH/2eWRQ5tWnw5cdnoXXWTCCWp
VkEZs6kd8N/h/Vt9GjZd013EmOCcU4Ce8Uuncks/AkgmGxGbnLFI/1+2WSK8+rKp
rJWIWQ11a+vxRZWqLUsVXK4NWhsf1le5cGPqkZJKCV3fBlRQGRcHPwuddYZF/30a
DCTN0fu/g2qT46lee0dEe861wrl10QQQFhy5QN3R2HnbQaYhovJxPF5XPz0b1mpa
zidYdZxavnxolCL4BziE53mAl7Nwxd/7kWbhBveWgql0I083+txl3fRJIH4Vyp5/
BxUollBbDmovhIqeJYsOOY2YXBo9E/EzteL993PDr73By83hv9SUAVzwLDWbxdk=
=wNjk
-----END PGP SIGNATURE-----

--KA11HIBqVA8hnh8tlQ9tSbTQvjIgCdiLd--
