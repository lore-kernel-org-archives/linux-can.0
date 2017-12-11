From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] vxcan: improve handling of missing peer name attribute
Date: Mon, 11 Dec 2017 14:45:52 +0100
Message-ID: <ae0989b0-3ee7-9938-255b-59c1a9a0d8a8@pengutronix.de>
References: <20171202174852.9618-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9EictA64eIFaGCgnV0eFve6TpGgWWM3Ub"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35021 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753067AbdLKNp5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Dec 2017 08:45:57 -0500
In-Reply-To: <20171202174852.9618-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Serhey Popovych <serhe.popovych@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9EictA64eIFaGCgnV0eFve6TpGgWWM3Ub
Content-Type: multipart/mixed; boundary="pC1Ue181dm7aqojp8e6tiwAKOGDBNN6gb";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Serhey Popovych <serhe.popovych@gmail.com>
Message-ID: <ae0989b0-3ee7-9938-255b-59c1a9a0d8a8@pengutronix.de>
Subject: Re: [PATCH] vxcan: improve handling of missing peer name attribute
References: <20171202174852.9618-1-socketcan@hartkopp.net>
In-Reply-To: <20171202174852.9618-1-socketcan@hartkopp.net>

--pC1Ue181dm7aqojp8e6tiwAKOGDBNN6gb
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/02/2017 06:48 PM, Oliver Hartkopp wrote:
> Picking up the patch from Serhey Popovych (commit 191cdb3822e5df6b3c8,
> "veth: Be more robust on network device creation when no attributes").
>=20
> When the peer name attribute is not provided the former implementation =
tries
> to register the given device name twice ... which leads to -EEXIST.
> If only one device name is given apply an automatic generated and valid=
 name
> for the peer.
>=20
> CC: Serhey Popovych <serhe.popovych@gmail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pC1Ue181dm7aqojp8e6tiwAKOGDBNN6gb--

--9EictA64eIFaGCgnV0eFve6TpGgWWM3Ub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloujBEACgkQHv7KIOw4
HPYfSgf/SqmYAjq50lLx/GzqZ1QQhtGxINphsBznUYhevY7QI/c9+f5Vk2ysaVlz
IChdAieQBN6BhQVwlVK5VcBSypkYMiueSK6G6zhus1wLZvOtrYHkquU8dP1kZ1aN
Rcd6khr87FGe0X4hkRz87FqXBxEvYr92H3g2GglPBt4sb4t4uv48efNGRoj2xAeY
gDGRbqS1wCRZizcWLrWUf+H7wGwLY3QdyjVoDjMYcUbBlSUoVLvPTGooMIT5ViHd
EHpvhe/FVxUNC92/I+xFi3SD8qKEfpLo9f2jbqpLK89F7w1P2mDVPb0Y9vYynpgP
zm+vi08RCIznYkLhvh0BvDWsU2iT9A==
=gr3d
-----END PGP SIGNATURE-----

--9EictA64eIFaGCgnV0eFve6TpGgWWM3Ub--
