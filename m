From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: fix USB altsetting bugs
Date: Tue, 10 Dec 2019 12:40:30 +0100
Message-ID: <1244df5c-27e4-2558-3a88-5be6a7c2bfea@pengutronix.de>
References: <20191210113231.3797-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PYGNQfSib4ZC3jmgsc9Zx3onSi9UVP22F"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191210113231.3797-1-johan@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PYGNQfSib4ZC3jmgsc9Zx3onSi9UVP22F
Content-Type: multipart/mixed; boundary="4pKZgfYpzjUZxIs7BT0wqFDzgp0vWLE1V";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1244df5c-27e4-2558-3a88-5be6a7c2bfea@pengutronix.de>
Subject: Re: [PATCH 0/2] can: fix USB altsetting bugs
References: <20191210113231.3797-1-johan@kernel.org>
In-Reply-To: <20191210113231.3797-1-johan@kernel.org>

--4pKZgfYpzjUZxIs7BT0wqFDzgp0vWLE1V
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/10/19 12:32 PM, Johan Hovold wrote:
> We had quite a few driver using the first alternate setting instead of
> the current one when doing descriptor sanity checks. This is mostly an
> issue on kernels with panic_on_warn set due to a WARN() in
> usb_submit_urn(). Since we've started backporting such fixes (e.g. as
> reported by syzbot), I've marked these for stable as well.
>=20
> The second patch here is a related cleanup to prevent future issues.

Applied both to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--4pKZgfYpzjUZxIs7BT0wqFDzgp0vWLE1V--

--PYGNQfSib4ZC3jmgsc9Zx3onSi9UVP22F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3vhC4ACgkQWsYho5Hk
nSD2aQgAs5lFAaX+514YmdXepheaxkuir4ylLzDPIatvpPcC20tLVL7dGefACkyl
46nNfNaGzduZI/UwIbkflwthsNqVUJvMpm9Lzho2CKpIqunUt/QDBKo+9ZxhtwI7
UJY8uhR3CMQBNn5c4cxAFTlqM4S+wvJTn/5QrCRRxwJysfBGRifkUPV7iqTGR3yK
/04uPq4EVVRixbQ2Te5XNdnKhv5qyDmPUll8ZPiNgrF7SuemJ0iAZmBA47elxD/j
0iPo2BREX5akTkghbLsOHav42jREllGklBsMo3+d5M410MkliWfQH4Aou2Gx0LbM
JnTfQqgPH3IlNXWHHqGowMmpR1bXuA==
=Ow7r
-----END PGP SIGNATURE-----

--PYGNQfSib4ZC3jmgsc9Zx3onSi9UVP22F--
