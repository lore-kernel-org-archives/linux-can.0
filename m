From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: Fix napi poll return value for repoll
Date: Mon, 27 Nov 2017 15:18:07 +0100
Message-ID: <7c85aa90-86ce-80ad-cde4-cf3cf7406d29@pengutronix.de>
References: <20171120134515.2658-1-oliver.staebler@bytesatwork.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="u2Nd57Vma1lLgO9xguktwLcCdB46Kl9wA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53851 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752223AbdK0OSN (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Mon, 27 Nov 2017 09:18:13 -0500
In-Reply-To: <20171120134515.2658-1-oliver.staebler@bytesatwork.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Oliver_St=c3=a4bler?= <oliver.staebler@bytesatwork.ch>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u2Nd57Vma1lLgO9xguktwLcCdB46Kl9wA
Content-Type: multipart/mixed; boundary="TBSRHcTA4fOrxOg5fCPlkxdKkXhEw2uDf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Oliver_St=c3=a4bler?= <oliver.staebler@bytesatwork.ch>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org
Message-ID: <7c85aa90-86ce-80ad-cde4-cf3cf7406d29@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: Fix napi poll return value for repoll
References: <20171120134515.2658-1-oliver.staebler@bytesatwork.ch>
In-Reply-To: <20171120134515.2658-1-oliver.staebler@bytesatwork.ch>

--TBSRHcTA4fOrxOg5fCPlkxdKkXhEw2uDf
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/20/2017 02:45 PM, Oliver St=C3=A4bler wrote:
> After commit d75b1ade567f ("net: less interrupt masking in NAPI") napi
> repoll is done only when work_done =3D=3D budget.
> So we need to return budget if there are still packets to receive.
>=20
> Signed-off-by: Oliver St=C3=A4bler <oliver.staebler@bytesatwork.ch>

Applied to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--TBSRHcTA4fOrxOg5fCPlkxdKkXhEw2uDf--

--u2Nd57Vma1lLgO9xguktwLcCdB46Kl9wA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlocHp8ACgkQHv7KIOw4
HPaFxAf/UxO+Sk8BHnRRm+TS8LbUhbzQfE/ieiCt5WsxVz+bBhHXfQS2XoPCQ10/
DtcdtF2X4pX2tXV8GrSMQ8n8PvP8zPTIkdzxwywfCivOoWjBaIJdEIsHQzisI0BU
dEK0f/t4T5ARWZ19wPmmkOhDGcvc1B7eVpyKlkWVjUM3R4jzApNs+rNkFsrr/8UB
ve1ZNZ0HZZQBvZCWKfZa3XpKIPUF7CwKM/g1kXD03d0bDqYzbCThOPO9TOiceP/j
8RLCvm9WpsnZ2WwsD6BDg2iqCQnDn7RuJ7k9tg5YT3PZj4Ne8l7BPQoGLXYa7eTE
MnuxoEd+ThBDnbKGHK85A/HX0WhmXA==
=f5ao
-----END PGP SIGNATURE-----

--u2Nd57Vma1lLgO9xguktwLcCdB46Kl9wA--
