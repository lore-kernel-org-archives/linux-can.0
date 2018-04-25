From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
Date: Wed, 25 Apr 2018 17:34:09 +0200
Message-ID: <f0a8e012-8164-612f-5e92-8db1c64c8bec@pengutronix.de>
References: <20180411160642.18383-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180411160642.18383-2-jakob.unterwurzacher@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="j5GmnwGVbsEKdYwoVgOszKGWc0ayCSvlh"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180411160642.18383-2-jakob.unterwurzacher@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5GmnwGVbsEKdYwoVgOszKGWc0ayCSvlh
Content-Type: multipart/mixed; boundary="6TDtMteWxTdAiAsMg5pCGe0QDls6LxshD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <f0a8e012-8164-612f-5e92-8db1c64c8bec@pengutronix.de>
Subject: Re: [PATCH v5 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
References: <20180411160642.18383-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180411160642.18383-2-jakob.unterwurzacher@theobroma-systems.com>
In-Reply-To: <20180411160642.18383-2-jakob.unterwurzacher@theobroma-systems.com>

--6TDtMteWxTdAiAsMg5pCGe0QDls6LxshD
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/11/2018 06:06 PM, Jakob Unterwurzacher wrote:
> The UCAN driver supports the microcontroller-based USB/CAN
> adapters from Theobroma Systems. There are two form-factors
> that run essentially the same firmware:
>=20
> * Seal: standalone USB stick ( https://www.theobroma-systems.com/seal )=

>=20
> * Mule: integrated on the PCB of various System-on-Modules from
>   Theobroma Systems like the A31-=C2=B5Q7 and the RK3399-Q7
>   ( https://www.theobroma-systems.com/rk3399-q7 )
>=20
> The USB wire protocol has been designed to be as generic and
> hardware-indendent as possible in the hope of being useful for
> implementation on other microcontrollers.
>=20
> Signed-off-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-sys=
tems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6TDtMteWxTdAiAsMg5pCGe0QDls6LxshD--

--j5GmnwGVbsEKdYwoVgOszKGWc0ayCSvlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrgn/EACgkQk9IU1zQo
ZfGGrggAz/8gUQVrmb5C0J9RLm9kYcLjjSZWci3ww5Ra6ANxvK7iCDIIV5T8TYW3
lrUqZBVbOjghaIDN6mcaLojulTCsAa0EPpe/l/P/bfAbpX8LXa44zMLm2ipz8hdM
Ndt1DweJfnGehELlWLH3CiqxbqmUiIvybuJsQL271jHwmhWhoMX05Mu26bW+bVLM
LPWsVn5FrLbBths/oGHJ+n2sRxTC1goMYvk6FnUC12O9hu5i8v1O6XRgDHv/SeD3
s7YiGtHLQmPq+jrw27Fc7oNA7FACzAHEb9+5T90cGdoQA85P/1peBySGXc1V4zPu
M1bev7cb//XpMdXufZ41fId7n9r96Q==
=WhMW
-----END PGP SIGNATURE-----

--j5GmnwGVbsEKdYwoVgOszKGWc0ayCSvlh--
