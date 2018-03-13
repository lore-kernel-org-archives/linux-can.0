From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/1] Open questions
Date: Tue, 13 Mar 2018 18:48:40 +0100
Message-ID: <ba3f53b1-e8bb-4c61-b486-19b9865d6e22@pengutronix.de>
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <e0c8c001-f66b-2e8e-d9ec-89a0db9c5853@theobroma-systems.com>
 <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="49paDp0mhg3MWsTipV1DAfxyZPFq7FpeI"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--49paDp0mhg3MWsTipV1DAfxyZPFq7FpeI
Content-Type: multipart/mixed; boundary="bQcAFp41XHCNHrKJW2aC1AyjzBG8tsgzM";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>,
 Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <ba3f53b1-e8bb-4c61-b486-19b9865d6e22@pengutronix.de>
Subject: Re: [PATCH v2 0/1] Open questions
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <e0c8c001-f66b-2e8e-d9ec-89a0db9c5853@theobroma-systems.com>
 <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>
In-Reply-To: <06378497-1ACE-4333-810F-4E3E4706CCD5@theobroma-systems.com>

--bQcAFp41XHCNHrKJW2aC1AyjzBG8tsgzM
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 03/13/2018 06:42 PM, Dr. Philipp Tomsich wrote:
>=20
>> On 13 Mar 2018, at 18:40, Jakob Unterwurzacher
>> <jakob.unterwurzacher@theobroma-systems.com
>> <mailto:jakob.unterwurzacher@theobroma-systems.com>> wrote:
>>
>> >> + =C2=A0=C2=A0=C2=A0/* get the urb context */
>> >> + =C2=A0=C2=A0=C2=A0if (WARN_ON(!context))
>> >> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> >
>> > Can this happen?
>>
>> Not unless there is a bug in the code. But we want to get a message
>> before dereferencing a pointer.
>=20
> Why not use BUG_ON(!context)?

As this will halt the whole system.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bQcAFp41XHCNHrKJW2aC1AyjzBG8tsgzM--

--49paDp0mhg3MWsTipV1DAfxyZPFq7FpeI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqoDvgACgkQk9IU1zQo
ZfGnxAf/bHqg0zD/R0v3M1dsYUGCcDfamzj4iot5GBPbKNvxaLZCC6SRVKZG87zM
TP6htWEymi+Dq+ouJfXSQXk231A56JSeyNuF1Q6Ao5e+gzRHfOCKKJnC91vAqMCc
YSmBYDI9Fwi33I7C8AyNl/l4jH+0sCQUcSrr4CzcSs7YrOB9RKAKa129oId/y33s
bM9NEjGMIULCshYk2yDHkVInIrHq3VM1+c63GC3RgnL0j/c9oIm+9IVC+eCmKqRU
sb3IW+clqFeX6cvxsXxn4iOGYc47ns5I+REqEa9FyDf14zsuadhOMHleM4TBoHX4
XXataKvoS+cktczHg4NBe9HRxssxLg==
=25Mo
-----END PGP SIGNATURE-----

--49paDp0mhg3MWsTipV1DAfxyZPFq7FpeI--
