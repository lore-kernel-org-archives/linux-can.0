From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: add support for CAL/CANopen firmware
Date: Wed, 6 May 2015 08:01:48 +0200
Message-ID: <5549AE4C.5000606@pengutronix.de>
References: <5543C69C.5060508@gmail.com> <5543E065.6060000@pengutronix.de>
 <20150502164049.GB31242@gmail.com> <5544FE8C.9020100@pengutronix.de>
 <55490722.3090802@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="76vGPDGv6Ma8JbqvTTCi8HFDxuWnsiLtO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53746 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbbEFGCI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 May 2015 02:02:08 -0400
in-reply-to: <55490722.3090802@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--76vGPDGv6Ma8JbqvTTCi8HFDxuWnsiLtO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2015 08:08 PM, Andreas Gr=C3=B6ger wrote:
> sorry, my S-o-b was invalid.
> ---
> Hi Marc, Hi Ira,
>=20
> thank you very much for the positive and constructive responses,
> seems to be the right way.
>=20
> String comparison for firmware identification: there is another way
> to retrieve the id and version (IDVERS-request), but it is more
> complicated. You have to await the response and the result is a
> longer string about 200 bytes. Janz recommends this firmware stamp
> for module identification.
>=20
> Bittiming in ican3_set_bus_state: this affects the driver with
> ICANOS-firmware. So I asked Janz for the ICANOS-firmware to be able
> to test. I tested both firmware-variants with different baudrates:
> went as expected. Hope I met your needs.
>=20
> Kind regards, Andreas
>=20
> Signed-off-by: Andreas Gr=C3=B6ger <andreas24groeger@gmail.com>

Applied to can-next. I've split the patch, first the existing sysfs
entries are documented, the second one updates the driver.

cheers,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--76vGPDGv6Ma8JbqvTTCi8HFDxuWnsiLtO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVSa5MAAoJECte4hHFiupUcEQP/jiCwYTAe6UdUnAmPQx6W2Wh
p0YXb3sHXuCdEgqjwJHOapgqN3G+qq8FBZ/vJLDduhAeLqsY7BCftqeOdLP9xYPz
9NGJFIAGyJlRKKOwQPxUfSPKe28B4Fb5mY1NGoBbDtKuroIWpdmuGkKZy2dmC4s4
U89lfwla54OT3B1+r7zcziN/7QBfHrdM5KaWusI1lbg6mYSObGTH4XgBfGZlfhZ4
TUhhUcQeYsk0Dk0k2I7fTixh+mZ5vdpIkgrrQeqphzP90lpBHJDLcWCpKMiO7ItW
3nbNBYAOlhmE++rlVX6JgBnj+rdzAnfT//55IJCKKKtNFIn1U+mO3M6DXU+HKotG
9ZE3sY8LLmAfFiOO6ueo9hHe58j32EhjnEE8Q3w34BFf5ZM7IDEezZZ2tUzNVDHR
Ds2PSYpcRQ2y5zbe87V/DwdqBfbOyQC3MaeeDPFwQYKTK7p1rA8Lp5QK3BTUxk/a
jmRfrRxIqYU2UpPiPJtgNaOdFNDsyamokLeJ4q4PVrI5STgnGScBSUDqtn0lJ6yA
EDv3S6JAQK46HRhzDQHnr6/MjTPVI75gnxMozmT08VjWVVcYJVxEvRbVByo4qRUR
O/rJScUSqAVoCUSvpAlhqH6s4fqTdp7BHME687jegMEuX7hF8Yc8hETMCmcaLsHI
s+gFT8XOTGQiK8gRLwg3
=s16G
-----END PGP SIGNATURE-----

--76vGPDGv6Ma8JbqvTTCi8HFDxuWnsiLtO--
