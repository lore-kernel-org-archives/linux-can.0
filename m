From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
Date: Tue, 13 Mar 2018 18:56:25 +0100
Message-ID: <00db8dc8-682c-cbcb-d264-d563a854a8c1@pengutronix.de>
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <e6864131-adab-382b-617b-35e9329f00d0@pengutronix.de>
 <872c1fca-df7c-84c1-e14b-0f7d60d0bafe@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pPUTzALaltl3BbymtuEFzSVd0pTGzPoUE"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <872c1fca-df7c-84c1-e14b-0f7d60d0bafe@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pPUTzALaltl3BbymtuEFzSVd0pTGzPoUE
Content-Type: multipart/mixed; boundary="NYbVJuDv885Aasn3fB7hsVjrHObwKj64x";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <00db8dc8-682c-cbcb-d264-d563a854a8c1@pengutronix.de>
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <e6864131-adab-382b-617b-35e9329f00d0@pengutronix.de>
 <872c1fca-df7c-84c1-e14b-0f7d60d0bafe@theobroma-systems.com>
In-Reply-To: <872c1fca-df7c-84c1-e14b-0f7d60d0bafe@theobroma-systems.com>

--NYbVJuDv885Aasn3fB7hsVjrHObwKj64x
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 03/13/2018 06:53 PM, Jakob Unterwurzacher wrote:
> On 13.03.18 18:44, Marc Kleine-Budde wrote:
>> On 03/13/2018 06:35 PM, Jakob Unterwurzacher wrote:
>>
>> [...]
>>
>> Please mark all multibyte values going over the USB as either le or be=
=2E
>=20
> This is documented in can_ucan_protocol.rst,
>=20
>      All multi-byte integers are encoded as Little Endian.
>=20
> but it's probably worth mentioning here as well.

Yes, but in the code, use "__le16" and "__le32" instead of "u16" and "u32=
"

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NYbVJuDv885Aasn3fB7hsVjrHObwKj64x--

--pPUTzALaltl3BbymtuEFzSVd0pTGzPoUE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqoEMkACgkQk9IU1zQo
ZfHLGwf/SMrbGogp4+J45Hi6UxyeQry/Q/2gYwP49YjAfBV4zWtHmsWkTJSWrh0X
qwRSBYO1mmNun1MTnmunjQ8ik2coZk6KZMXUV7pq63JLNRrWXS5YdIP9LJQOAEUN
hVDg70AtOAfZrOk+kACl8sKcl+xeaCS1IdG3v9vWqOGmFQymCK0qxob9tGt3wKQN
p26yChMhG17Rb2XXTB2ZIrdTkPidccPM5OW9OyyWWoOWQ5vYf6UJV3UrRzgQvzxW
mSn1e2xk/3NsEo+w+QIWR8DOQZgkU0XavdHEdjUI0IfaOkWSfLaCRZdQE87oVbDu
r7w/V0lIKth8055QgyhLfijotRzWJA==
=kJkx
-----END PGP SIGNATURE-----

--pPUTzALaltl3BbymtuEFzSVd0pTGzPoUE--
