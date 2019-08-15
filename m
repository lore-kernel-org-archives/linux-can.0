From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: tcan4x5x: spi bits_per_word issue on Raspberry PI
Date: Thu, 15 Aug 2019 10:34:41 +0200
Message-ID: <f78bb414-4165-3f56-151a-47ab4a8a645d@pengutronix.de>
References: <3f71bdff8f4f4fe19ad9a09be89bc73d@escrypt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xqf547y8PtvXfCI67HZmMAuU7QfIKFbNg"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <3f71bdff8f4f4fe19ad9a09be89bc73d@escrypt.com>
Sender: netdev-owner@vger.kernel.org
To: "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)" <fixed-term.Konstantin.Buecheler@escrypt.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xqf547y8PtvXfCI67HZmMAuU7QfIKFbNg
Content-Type: multipart/mixed; boundary="sgyIAmfCBtqDoYrQjsV52KdMqUfL81F6Z";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)"
 <fixed-term.Konstantin.Buecheler@escrypt.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>
Message-ID: <f78bb414-4165-3f56-151a-47ab4a8a645d@pengutronix.de>
Subject: Re: can: tcan4x5x: spi bits_per_word issue on Raspberry PI
References: <3f71bdff8f4f4fe19ad9a09be89bc73d@escrypt.com>
In-Reply-To: <3f71bdff8f4f4fe19ad9a09be89bc73d@escrypt.com>

--sgyIAmfCBtqDoYrQjsV52KdMqUfL81F6Z
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/14/19 5:01 PM, FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu) wro=
te:
>> Hi all,
>>
>> I am trying to use a tcan4550 together with a Raspberry PI 3 B. I am u=
sing the
>> tcan4x5x driver from net-next.
>> I always get the following error during startup.
>> 	tcan4x5x spi0.0: Probe failed, err=3D-22
>> 	tcan4x5x: probe of spi0.0 failed with error -22
>>
>> I realized that this happens because the Raspberry PI does only suppor=
t 8/9 bit
>> words. https://elinux.org/index.php?title=3DRPi_SPI#Supported_bits_per=
_word
>> In the driver it is set to 32.
>> 	spi->bits_per_word =3D 32;
>>
>> Setting this to 8 does not help of course since the tcan chip expects =
a multiple of
>> 32 per spi transaction.
>> I don't know if this is a Raspberry Pi specific problem or if there ar=
e more devices
>> with this hardware limitation.
>>
>> Does anyone have a workaround for that?
>=20
> It seems to be enough to just change the bits_per_word value to 8
>=20
>>
>> If this a common issue it might be a good idea to patch the driver. I =
will check if I
>> can find proper a way to do so.
>>
>> Regards,
>> Konstantin
>=20
> Now I have another really confusing problem. Anything I write to SPI is=
 written little endian. The tcan chip expects big endian.=20
> Anything I read from SPI is treated as little endian but is big endian.=
 Does anyone know why this happens?=20
> Is there a flag or something I can set for the SPI device/wire to fix t=
his?

Have you changed the bits_per_word to 8? Then you read just a stream of
bytes. If you tread them as an u32 they are in host order.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sgyIAmfCBtqDoYrQjsV52KdMqUfL81F6Z--

--xqf547y8PtvXfCI67HZmMAuU7QfIKFbNg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1VGSIACgkQWsYho5Hk
nSDnZwf8CfJ2EnMKXDS3Ez42dUPL+x1PyZc+Li2HtQZHRkemByikMuqgGEJFLtJC
uEIcZ+wi0sRumR1LSAaAaE3pj58ksHPRo3xA+f5oW7Tv/qP5JsxN6rlXNsNMzbTt
+oDOkEOl7OLMO47D/EcCcPHUUUGcQ//yKb1RrtwGRmmIXb+YZj0snOTaWNjNz7Ug
1xGeMcIeyzJ5ozoCBcLABZ91AWZ3GIsoPkTN2a3xWb0xTOKoknOe7a/2v77uF/gB
0wyWnJxL1R64aIwftAm2tzFDn4YYR9N80kyC7bHYhvfrU+oFx8qWqP+6pbgInTnH
NIZLGTf86iKBMW9nM+jGs7HY8sEm7w==
=38U6
-----END PGP SIGNATURE-----

--xqf547y8PtvXfCI67HZmMAuU7QfIKFbNg--
