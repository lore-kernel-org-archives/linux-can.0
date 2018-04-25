From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: dev: increase bus-off message severity
Date: Wed, 25 Apr 2018 16:42:18 +0200
Message-ID: <89a09851-827e-96b6-a0b0-e31b24755193@pengutronix.de>
References: <20180418141003.10229-1-jakob.unterwurzacher@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ihHchI2HsXm4U12mWS36BGSsnsfxT93C8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418141003.10229-1-jakob.unterwurzacher@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ihHchI2HsXm4U12mWS36BGSsnsfxT93C8
Content-Type: multipart/mixed; boundary="gjDoSdyAP2o5ioiezgnjdC9grYYuzOcFw";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <89a09851-827e-96b6-a0b0-e31b24755193@pengutronix.de>
Subject: Re: [PATCH] can: dev: increase bus-off message severity
References: <20180418141003.10229-1-jakob.unterwurzacher@theobroma-systems.com>
In-Reply-To: <20180418141003.10229-1-jakob.unterwurzacher@theobroma-systems.com>

--gjDoSdyAP2o5ioiezgnjdC9grYYuzOcFw
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/18/2018 04:10 PM, Jakob Unterwurzacher wrote:
> bus-off is usually caused by hardware malfunction or
> configuration error (baud rate mismatch) and causes a
> complete loss of communication.
>=20
> Increase the "bus-off" message's severity from netdev_dbg
> to netdev_info to make it visible to the user.
>=20
> A can interface going into bus-off is similar in severity to
> ethernet's "Link is Down" message, which is also printed
> at info level.
>=20
> It is debatable whether the the "restarted" message should
> also be changed to netdev_info to make the interface state
> changes comprehensible from the kernel log.
> I have chosen to keep the "restarted" message at dbg for now
> as the "bus-off" message should be enough for the user to
> notice and investigate the problem.
>=20
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-sys=
tems.com>
> Cc: linux-can@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Applied to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gjDoSdyAP2o5ioiezgnjdC9grYYuzOcFw--

--ihHchI2HsXm4U12mWS36BGSsnsfxT93C8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrgk8oACgkQk9IU1zQo
ZfGGEwgAsE97/1rKOLPekZvPoP+0iGlIyLrh8vk7bmdHYgZrEtnFNVPr9cbCnqcA
0Mpjk2coP9K9lu9ojdbq5Y1MV+KsjIJccoZAEnFlA5+TdyM3XOKtqLUfmmX8Iggz
rlnmFIsgdWVsNKBsXG2gbLTzRtoR2jv4uFP78+ViUnmmW/3zYkt0JDnZRztinsMh
IimYuKcfnvXfDaHhXns/nNV+bkh8xgEUf3CEgfCv0OIBgmOAsWdAiJCpx5oAil2L
jVNgpiOxaD80QUE3zD6TcC0KV+YWkd7jDSN7pDF41aiUjc3EKabgo0KtDNCuxYUA
rD4/6GydrUAW5dKpk+0/gyEYcp9sXQ==
=Sqvt
-----END PGP SIGNATURE-----

--ihHchI2HsXm4U12mWS36BGSsnsfxT93C8--
