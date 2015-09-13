From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [linux-sunxi] [PATCH v5 2/2] can: Allwinner A10/A20 CAN
 Controller support - controller code
Date: Sun, 13 Sep 2015 15:49:05 +0200
Message-ID: <55F57ED1.7050906@pengutronix.de>
References: <1442144632-4541-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442144632-4541-3-git-send-email-info@gerhard-bertelsmann.de>
 <20150913124501.GS9885@lukather>
 <f8eea0f544eb6367142bbc1c2ab35964@mail.rdts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ndqF6nI4KEt0PhW0pQl91opC8CWOGRF1x"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35403 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbbIMNtN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 13 Sep 2015 09:49:13 -0400
In-Reply-To: <f8eea0f544eb6367142bbc1c2ab35964@mail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-can@vger.kernel.org, linux-sunxi@googlegroups.com, linux-can-owner@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ndqF6nI4KEt0PhW0pQl91opC8CWOGRF1x
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2015 03:42 PM, Gerhard Bertelsmann wrote:
>> > Even if it does start, it is really confusing. Please move the
>> > clk_prepare_enable in the open function.
>> >=20
> That was my first approach. IMHO it's useful to enable/disable
> according to the state of the CAN interface to save power.

The open() function is perfectly right, enabling the clock in the probe
function keeps the clock powered even if the CAN controller is not used.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ndqF6nI4KEt0PhW0pQl91opC8CWOGRF1x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV9X7RAAoJEP5prqPJtc/H4aQH+gJzjphRiQYlLDy03TiO0gaj
GuEYxu+DXaamxPlud9hMPJGwZ076t/D+oSpeKx+u6bYwRJGZZusbf2vpS884XPai
4T9/jnTBdji2FVikdOLMwu1CwugNYZAOUH1aTh61f6fFCIpN6rDMfpnYWkODi1cc
8sRljw9JYzzF7XtJzCGmS/upWV1hWXu6Rb5iX/kzk1H/U2Gh7kg7vBNhUbGBv+rD
YnZZIKpqWiXBpA1yw4BRbrQlToJVIbgooaXrStwNtnf4XMAZ7MzVqYpaG4CT7q8D
eugyovu25aC0jGEAaiQuomn4BQRVcrvYtu4k+fMccIEloy08g/gS8zwRp9bfN9Y=
=IPpV
-----END PGP SIGNATURE-----

--ndqF6nI4KEt0PhW0pQl91opC8CWOGRF1x--
