From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: fix endianess detection
Date: Thu, 26 Apr 2018 09:19:17 +0200
Message-ID: <6ab7ce71-ee02-c959-49b4-c1cc569e46ba@pengutronix.de>
References: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
 <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0935701900070369527=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0935701900070369527==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ulFVdLmzO8U9bBq5QLmZpwIezFYpU6g6x"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ulFVdLmzO8U9bBq5QLmZpwIezFYpU6g6x
Content-Type: multipart/mixed; boundary="gy96pzHOeQYYt1zvLcoZkOYHiN7COarYa";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: Gavin Schenk <g.schenk@eckelmann.de>,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
 linux-can@vger.kernel.org
Message-ID: <6ab7ce71-ee02-c959-49b4-c1cc569e46ba@pengutronix.de>
Subject: Re: [PATCH 1/2] can: flexcan: fix endianess detection
References: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
 <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>

--gy96pzHOeQYYt1zvLcoZkOYHiN7COarYa
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 04:50 PM, Uwe Kleine-K=C3=B6nig wrote:
> In commit 88462d2a7830 ("can: flexcan: Remodel FlexCAN register r/w API=
s
> for big endian FlexCAN controllers.") the following logic was
> implemented:
>=20
> 	if the dt property "big-endian" is given or
> 	   the device is compatible to "fsl,p1010-flexcan":
> 		use big-endian mode;
> 	else
> 		use little-endian mode;
>=20
> This relies on commit d50f4630c2e1 ("arm: dts: Remove p1010-flexcan
> compatible from imx series dts") which was applied a few commits later.=

> Without this commit (or an old device tree used for booting a new
> kernel) the flexcan devices on i.MX25, i.MX28, i.MX35 and i.MX53 match
> the 'the device is compatible to "fsl,p1010-flexcan"' test and so are
> switched erroneously to big endian mode.
>=20
> Instead of the check above put a flag into devtype data and rely on
> of_match_device yielding the most compatible match
>=20
> Fixes: 88462d2a7830 ("can: flexcan: Remodel FlexCAN register r/w APIs f=
or big endian FlexCAN controllers.")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/net/can/flexcan.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 634c51e6b8ae..a6cbbe689eab 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -262,6 +262,7 @@ struct flexcan_regs {
> =20
>  struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */
> +	bool default_be;
>  };

What about adding this to quirks?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gy96pzHOeQYYt1zvLcoZkOYHiN7COarYa--

--ulFVdLmzO8U9bBq5QLmZpwIezFYpU6g6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrhfXUACgkQk9IU1zQo
ZfGTmAf+N1YRL35OnVG7vGbvUG5ATB2S5RUHSh6OtvJ/LWnJ5YQP97JYuiPIl0t1
g/RymXgNvLI23wIPBl8kAQi+/5wDh7NAF60OShtvfyaExicsMF1xz7ZpPMUtpF4v
mUSsj0KsqcEB2fPT9+tG/o0zDgdbES55Qqi9sEnOf/iNlm7r5Mx23xu04sf97pAL
3JlR0Bk0qS5Xi1gstL5chM/J2VMHQlaFZCoqYJyy3h3OVa6qtLg50a+ZlLveop8R
n0++qP8IxeyR3OR45BBWWeauq8/hubgq0lW+RvjYr8LhBk0HGgPuVTuim4bS9Qvf
qnhWnTByxTHWGD/qiRwobFdnVAFlyw==
=4HTM
-----END PGP SIGNATURE-----

--ulFVdLmzO8U9bBq5QLmZpwIezFYpU6g6x--


--===============0935701900070369527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0935701900070369527==--
