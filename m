From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mp251x: fix mcp2515 stops receiving problem
Date: Mon, 12 May 2014 19:07:08 +0200
Message-ID: <5370FFBC.6040008@pengutronix.de>
References: <1399914360-7146-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JXrhc00NnFAispBt5Qd0fE24WAmOvxDNu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59411 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759121AbaELRHR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 13:07:17 -0400
In-Reply-To: <1399914360-7146-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, "Rost, Martin" <Martin.Rost@tonfunk.de>, Alexander Shiyan <shc_work@mail.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JXrhc00NnFAispBt5Qd0fE24WAmOvxDNu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/12/2014 07:06 PM, Marc Kleine-Budde wrote:
> From: "Rost, Martin" <Martin.Rost@tonfunk.de>
>=20
> The mcp2515 sometimes seems to trigger an interrupt with the correspond=
ing
> register not being set yet. This makes the driver exit the interrupt be=
cause
> there is obviously nothing to do, but the interrupt line is kept low.
> Therefore the driver does not see any more interrupts until the chip is=
 reset
> (via interface down/up).
>=20
> This patch changes the IST to first check the IRQ registers, and wait u=
p to 10
> ms if an event really occurrs. If the IRQ register is still empty after=
 10ms,
> a kernel message gets issued. The IST loop is rearranged to evaluate th=
e IRQ
> register at the last moment before exiting, to not miss a late irq even=
t.
>=20
> Not-Signed-off-by: Martin Rost <Martin.Rost@tonfunk.de>

Martin, can I add your S-o-b [1]?

> Cc: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L307=


Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JXrhc00NnFAispBt5Qd0fE24WAmOvxDNu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNw/7wACgkQjTAFq1RaXHNZXwCbBn24Q2friYhjSBS5zwpVuJ05
vKcAoIUY/jc+gXZnYeSwTu08VJzs5I5f
=3N5a
-----END PGP SIGNATURE-----

--JXrhc00NnFAispBt5Qd0fE24WAmOvxDNu--
