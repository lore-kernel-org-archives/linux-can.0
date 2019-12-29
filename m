From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin
 device-state GPIO is unavailable
Date: Sun, 29 Dec 2019 17:05:47 +0100
Message-ID: <afa5c681-bbd1-a6f6-2b58-4f24c924144e@pengutronix.de>
References: <20191212161536.23264-1-dmurphy@ti.com>
 <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ErfGB2JhlV9tFPSlfmfTApANASHC9q8AV"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ErfGB2JhlV9tFPSlfmfTApANASHC9q8AV
Content-Type: multipart/mixed; boundary="ufP7ELgO2JCaYT0AOrvlkGTfNb0k9Qwz8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Message-ID: <afa5c681-bbd1-a6f6-2b58-4f24c924144e@pengutronix.de>
Subject: Re: [PATCH linux-can/testing] can: tcan4x5x: Disable the INH pin
 device-state GPIO is unavailable
References: <20191212161536.23264-1-dmurphy@ti.com>
 <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>
In-Reply-To: <b0560413-525c-39ba-30ce-816c098e51ab@pengutronix.de>

--ufP7ELgO2JCaYT0AOrvlkGTfNb0k9Qwz8
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/29/19 4:32 PM, Marc Kleine-Budde wrote:
> On 12/12/19 5:15 PM, Dan Murphy wrote:
>>  static int tcan4x5x_parse_config(struct m_can_classdev *cdev)
>>  {
>>  	struct tcan4x5x_priv *tcan4x5x =3D cdev->device_data;
>> @@ -383,8 +393,10 @@ static int tcan4x5x_parse_config(struct m_can_cla=
ssdev *cdev)
>>  	tcan4x5x->device_state_gpio =3D devm_gpiod_get_optional(cdev->dev,
>>  							      "device-state",
>>  							      GPIOD_IN);
>> -	if (IS_ERR(tcan4x5x->device_state_gpio))
>> +	if (IS_ERR(tcan4x5x->device_state_gpio)) {
>>  		tcan4x5x->device_state_gpio =3D NULL;
>> +		tcan4x5x_disable_state(cdev);
>> +	}
> For some reason, this hunk doesn't apply, due to the additional:
>=20
>>> 	tcan4x5x->power =3D devm_regulator_get_optional(cdev->dev,
>>> 						      "vsup");

=2E..which was my fault. :) Please have a look at

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/log/?h=3D=
testing

=2E..if I've collected every m_can related patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--ufP7ELgO2JCaYT0AOrvlkGTfNb0k9Qwz8--

--ErfGB2JhlV9tFPSlfmfTApANASHC9q8AV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4IztsACgkQWsYho5Hk
nSCOhgf/eM4Q5w75fCd1N0GJIHlTB7jFNfp36CQKpHfG2TsG8U+1Qvi3dd3wccpY
zA8IY2Fej45LnSCSGy4/PsVYRBgf9WM0OmVhSDeUU4T1pHyqz0mI+BS5CUBltG7N
llqWTnDHrHQPEgEy8a1/I/5DWFDoKBzV2ywL1Hcof9jQ+ZcKYmUptPOBkXtZbfkq
uciVc+y6q32gaHBi55a7dCOC1/b1YWxb24oe2NDbjfqWbmCATU9M+s6cGZXC3YOJ
CkpaoMOJyI4DTklME2udP/viWE7qOfEMWzaeHzyRJnlLmcR/rEll9cxIZ6ILvf0L
Hj8WgBj5uNhX+KC/UkJx2vbMOcmHTw==
=sUMO
-----END PGP SIGNATURE-----

--ErfGB2JhlV9tFPSlfmfTApANASHC9q8AV--
