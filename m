From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/7] can: rcar_canfd: fix possible IRQ storm on high load
Date: Thu, 25 Jul 2019 15:41:35 +0200
Message-ID: <ce15aec8-db14-65e7-720d-b0ef066145bb@pengutronix.de>
References: <20190724130322.31702-3-mkl@pengutronix.de>
 <20190724210328.D91DF21873@mail.kernel.org>
 <6b23b091-92d1-b05d-b451-d8c78a990ef3@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GrY1lSSDTvHidBFAR22Ka79GGPjL3xAh1"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <6b23b091-92d1-b05d-b451-d8c78a990ef3@cogentembedded.com>
Sender: netdev-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GrY1lSSDTvHidBFAR22Ka79GGPjL3xAh1
Content-Type: multipart/mixed; boundary="DktKmtTd8FO4IzzNauI9LR8c4JaB334BN";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org,
 linux-stable <stable@vger.kernel.org>
Message-ID: <ce15aec8-db14-65e7-720d-b0ef066145bb@pengutronix.de>
Subject: Re: [PATCH 2/7] can: rcar_canfd: fix possible IRQ storm on high load
References: <20190724130322.31702-3-mkl@pengutronix.de>
 <20190724210328.D91DF21873@mail.kernel.org>
 <6b23b091-92d1-b05d-b451-d8c78a990ef3@cogentembedded.com>
In-Reply-To: <6b23b091-92d1-b05d-b451-d8c78a990ef3@cogentembedded.com>

--DktKmtTd8FO4IzzNauI9LR8c4JaB334BN
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/25/19 3:29 PM, Nikita Yushchenko wrote:
>> NOTE: The patch will not be queued to stable trees until it is upstrea=
m.
>>
>> How should we proceed with this patch?
>=20
> I don't know.
> Maintainer did not respond, nor to original send nor to resend.

You can backport this patch to v4.9.186 and send it to Sasha

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DktKmtTd8FO4IzzNauI9LR8c4JaB334BN--

--GrY1lSSDTvHidBFAR22Ka79GGPjL3xAh1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl05sZIACgkQWsYho5Hk
nSDENAgAmdiXpqQKEQJQWdwUKY33k0MFGe9SI6ATpWeJQTMxm+4CtltFDaH7GBxX
6Y0DnoUCf6XZi6UKLiceWZ507+B/uq4rtQNFaSmkC9AlOY/+VYCweBNIxwpBRhjD
dOioD8vE0BBkCspY3wTbzzhGzOdnSb6UkORSBFnq2NUsJpKStRnj6LJNlbREYOyI
z19PFHwI7202zOVQDz51ZlB0ttTS1V70pT+O4H+VNBY7vr+Scp2uj7gLDRs6uH7/
NFQYcIpQbvPaFB5FELG7iCXaat6Pg3RNpnQ+8m+odDHHArwYAa2PYZVgDTuZV4m+
HdzRMf3fZ6oPkjMIcNekFDINYyPvIg==
=9SAy
-----END PGP SIGNATURE-----

--GrY1lSSDTvHidBFAR22Ka79GGPjL3xAh1--
