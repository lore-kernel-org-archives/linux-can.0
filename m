From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [linux-sunxi] [PATCH v5 0/2] can: Allwinner A10/A20 CAN
 Controller support - summary
Date: Sun, 13 Sep 2015 15:42:18 +0200
Message-ID: <20150913134218.GT9885@lukather>
References: <1442144632-4541-1-git-send-email-info@gerhard-bertelsmann.de>
 <20150913122227.GQ9885@lukather>
 <55F572B4.10107@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qUsYCxAE223BCwdt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42936 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751774AbbIMNmb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 13 Sep 2015 09:42:31 -0400
Content-Disposition: inline
In-Reply-To: <55F572B4.10107@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org, linux-sunxi@googlegroups.com


--qUsYCxAE223BCwdt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2015 at 02:57:24PM +0200, Marc Kleine-Budde wrote:
> On 09/13/2015 02:22 PM, Maxime Ripard wrote:
> >> History:
> >>     V5: fix license
> >>         modify prefix to mode select defines
> >>         enable and disable clock in sunxican_get_berr_counter
> >> 	delete set_normal_mode at the end of sunxi_can_start
> >> 	removed sunxican_id_table
> >> 	use devm_clk_get instead of clk_get
> >> 	use devm_ioremap_resource to simplify probe and remove
> >> 	make set-normal-mode and set-reset-mode more readable
> >>        =20
> >>     v4: defines prefixed with SUNXI_
> >>         sunxi_can_write_cmdreg tweaked
> >> 	loops in set_xxx_mode reworked
> >> 	add return value to set_xxx_mode
> >> 	sunxican_start_xmit reworked
> >> 	struct platform_driver stripped
> >> 	moved set_bittiming into open
> >> 	moved clock start into open
> >> 	add clock stop to close
> >>         suspend reworked
> >>         resume reworked
> >>         fixed double counting bug
> >>
> >>     v3: changed error state change handling (thx Andri for the hint)
> >>         use bittiming function correct (no need to call it)
> >>         strip down priv (suggested by Marc)
> >>         scripts/checkpatch.pl-> no matches anymore
> >>         sparse -> no errors or warnings anymore
> >>     v2: cleaning
> >>     v1: initial
> >=20
> > Where were those versions posted ?
>=20
> On the linux-can mailinglist.

Hmm, ok. My comment about using get_maintainer to have the right
recipient list is even more valid then.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--qUsYCxAE223BCwdt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV9X06AAoJEBx+YmzsjxAgDCYQAKb3u6+M7HB3i+zn+622MeWt
bv9rw5JGgwVmyqsikwjYDI2amrObz4oNbLa0hSYfufWe5uI59DXlfaOg7mlds3dT
ajqSdy7EkTeLY3lp1H4e3xljBptBjuvy7kdgpZsjrKm4kqgGuWG9hc2bXCOc0/xZ
uBP73AsSx5GCxVc28HV52W8FekBBVOW1qrunl+oiwX/wlVKu7fhwB/HR36jS0p0I
TwEJ9sRjI85h9qVBHcA5GMgPXK8F27v2RXz+LaKbgnbiZpLUUnsY7nc2KV+XGsZq
s95xIZ9ZNXHM1C3Zr/A0W/2AL2/HftsDw9LmC+dxwCPXWHkkiIZ+oMmfKfOVYHKp
zspajvcmD91E5MvOkhjPnzxb/VTuRFf9J9SbRmjn7p5a5R0ALfvIhx+NOe2bfQCa
qBQuwRlCK3mXiJQ3J5R0GxH7nqYnI/uTAWc4833X98S2tosCG3BsTP771wNzsWpV
5LSY8KrwvgOisy/2UiC/H2lBBrx53N5avD06Eur/qnQL+myvJ/zxspfenZukNk9D
Ile2qAIYZqkQCpBNbU8r/KTnzOh33X2BG7pQ7GGvI3pkWQbEloCtbmjlWrvSWEjR
BKk/kbG7C5+KVdQma3ioe3NMwrBtCfvQUokFGJFWetvsEwfke5NDPoSvALyMKgw1
CId3I49KT35wTFMAM4TO
=qC2L
-----END PGP SIGNATURE-----

--qUsYCxAE223BCwdt--
