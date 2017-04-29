From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Enabling rcar_can changelink support
Date: Sat, 29 Apr 2017 23:26:25 +0200
Message-ID: <01f8d1b7-0ef2-a13e-b626-5026b4409a7c@pengutronix.de>
References: <1493495283-55306-1-git-send-email-Bogdan-Stefan_mirea@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iSI2rDWorKu5iaKii1v2rblb94gpXMqb8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1493495283-55306-1-git-send-email-Bogdan-Stefan_mirea@mentor.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Bogdan Mirea <Bogdan-Stefan_mirea@mentor.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, socketcan@hartkopp.net
Cc: Eugen Hristev <Eugen_hristev@mentor.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iSI2rDWorKu5iaKii1v2rblb94gpXMqb8
Content-Type: multipart/mixed; boundary="L1roSqa2FEHd7GU3XBos1jwCroClRlgId";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bogdan Mirea <Bogdan-Stefan_mirea@mentor.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, socketcan@hartkopp.net
Cc: Eugen Hristev <Eugen_hristev@mentor.com>
Message-ID: <01f8d1b7-0ef2-a13e-b626-5026b4409a7c@pengutronix.de>
Subject: Re: [PATCH] Enabling rcar_can changelink support
References: <1493495283-55306-1-git-send-email-Bogdan-Stefan_mirea@mentor.com>
In-Reply-To: <1493495283-55306-1-git-send-email-Bogdan-Stefan_mirea@mentor.com>

--L1roSqa2FEHd7GU3XBos1jwCroClRlgId
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/29/2017 09:48 PM, Bogdan Mirea wrote:
> Added rcar_can_set_bittiming as can.do_set_bittiming callback that will=

> be called from can_changelink generic callback when link state is
> changed.
>=20
> This enables set bittiming support:
> 	ip link set can0 type can bitrate 500000 triple-sampling on

Why is this needed? rcar_can_set_bittiming() is called during
rcar_can_open().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--L1roSqa2FEHd7GU3XBos1jwCroClRlgId--

--iSI2rDWorKu5iaKii1v2rblb94gpXMqb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlkFBQEACgkQHv7KIOw4
HPYNKQgAw1sijEl2n9s1wZcmPNRU7YPETYCdlJUQKamRyGnNp1dS1pBOwoTAVZrq
/6QZOICwsjZTf8IeLOKETnWrWmCIVRw6lO/x59uvfTP6dGUtsZOTbz9SVji4ed9h
kzE4NPZFcH6lSPIDErH3Tzq2y5KWdbCIuTw7KjDN7h3AsSfEO4FC6V0lu0jfUEBV
OF4uzebevyWm05mB60gRrTKPAaNqCeWJCT2u6X5XmRNkV4+dNznwkHnLwv2W6H7S
Eqd1c0sHPIYgYx+RA4P1oQAFRixsq0gEibbhvMhlf5szPfPP2T7MbI2onZNyrI1J
wd5X5+vIHTWu7vXny/RbwtFoDXSr3A==
=PtEu
-----END PGP SIGNATURE-----

--iSI2rDWorKu5iaKii1v2rblb94gpXMqb8--
