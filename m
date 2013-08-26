From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RESEND next 1/2] net: can: mscan: add a comment on reg
 to idx mapping
Date: Mon, 26 Aug 2013 09:20:23 +0200
Message-ID: <521B01B7.7050001@pengutronix.de>
References: <1377256144-4173-1-git-send-email-agust@denx.de> <52174782.6080002@pengutronix.de> <521A33D9.7050605@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uGRUij588QduoTPxMLW15i3qBGXhBUqc4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60012 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab3HZH1t (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Aug 2013 03:27:49 -0400
In-Reply-To: <521A33D9.7050605@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uGRUij588QduoTPxMLW15i3qBGXhBUqc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/25/2013 06:42 PM, Oliver Hartkopp wrote:
> On 23.08.2013 13:29, Marc Kleine-Budde wrote:
>> On 08/23/2013 01:09 PM, Anatolij Gustschin wrote:
>>> From: Gerhard Sittig <gsi@denx.de>
>>>
>>> add a comment about the magic of deriving an MSCAN component index
>>> from the peripheral's physical address / register offset
>>>
>>> Cc: linux-can@vger.kernel.org
>>> Cc: netdev@vger.kernel.org
>>> Signed-off-by: Gerhard Sittig <gsi@denx.de>
>>> Signed-off-by: Anatolij Gustschin <agust@denx.de>
>>
>> Tnx, both applied to linux-can-next/testing. Will be included in the n=
et
>> pull request to Daivd.
>=20
> For net-next or for net?

Typo: should read "next" pull request to David. As the patches are in
the linux-can-next/testing branch, they will go into David's
net-next/master.

> When this stuff would be for net-next i could add a new feature for can=
-gw too ...
> So that there's not always only one lonely item to pull for Dave ;-)

Just send your patches. :D

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uGRUij588QduoTPxMLW15i3qBGXhBUqc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIbAboACgkQjTAFq1RaXHPyDQCdH9zseXlTJRE/eoVQGMLhd0bj
CYAAn3Tj/p5Qt2BVX4RYB+Qr+vvQVeJh
=ymQS
-----END PGP SIGNATURE-----

--uGRUij588QduoTPxMLW15i3qBGXhBUqc4--
