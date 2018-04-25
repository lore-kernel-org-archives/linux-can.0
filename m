From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: flexcan: fix regression from v4.16-rc1
Date: Wed, 25 Apr 2018 17:07:28 +0200
Message-ID: <0ab617ff-c650-b1f9-7fb4-8940fec42c07@pengutronix.de>
References: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7874560083812162223=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
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
Cc: Gavin Schenk <g.schenk@eckelmann.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7874560083812162223==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BL9mCFSFckz1eCraAzEVmaVBUMngEAR5v"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BL9mCFSFckz1eCraAzEVmaVBUMngEAR5v
Content-Type: multipart/mixed; boundary="Op0KnAWGmAtex8NOVTTBCwDKn7OBWUn9w";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Gavin Schenk <g.schenk@eckelmann.de>
Message-ID: <0ab617ff-c650-b1f9-7fb4-8940fec42c07@pengutronix.de>
Subject: Re: [PATCH 0/2] can: flexcan: fix regression from v4.16-rc1
References: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>

--Op0KnAWGmAtex8NOVTTBCwDKn7OBWUn9w
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 04:50 PM, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> when porting the kernel from a i.MX25 based machine to 4.17-rc1 (but
> still using the old dtb) can failed to probe. After some research we
> noticed that a commit that was merged in the v4.16 merge window
> introduced a change that broke using an older device tree.
>=20
> This series first commit fixes the issue.
> The second patch introduces a fallback compatible which matches the
> usual dt-style on i.MX. (Before v4.16-rc1 there was a wrong fallback
> compatible that was removed.)

Applied both to linux-can + added stable on Cc.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Op0KnAWGmAtex8NOVTTBCwDKn7OBWUn9w--

--BL9mCFSFckz1eCraAzEVmaVBUMngEAR5v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrgmbAACgkQk9IU1zQo
ZfF00gf+KsB5txQNrO80onC09GGurSojs3NOL9vQmc7baOsHwdCCDmu04kK3PHoo
7y+OEeWpm5LnZ0YwaLq0EqtBrY45d3S3/TBLOETNctnE3YdLodyiCktD6J4qrbXT
GFgtU+hC8VDTDL7Ha0k+wYeD7OCK43+jVaQMHPHoSfqD5akuV5XzVxe+EgmZyzwM
sZIkBKROPqN7wQ1hhsh2WaRfAQ5RNtKrUq7YweVlOkZEvk9/PUwvFGutalsBVmfd
hzHAkdZ8/ckJQSTfSIcFWDlbbVmd0zXAm80zIdlheuQmyCBXngbZB5tKYfL+kPqZ
Wse+a5+9cS5L33wxX8DipWDEckcUug==
=2sEQ
-----END PGP SIGNATURE-----

--BL9mCFSFckz1eCraAzEVmaVBUMngEAR5v--


--===============7874560083812162223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7874560083812162223==--
