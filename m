From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: canutils problem on mainline kernel
Date: Wed, 13 Apr 2016 16:03:24 +0200
Message-ID: <570E51AC.4060705@pengutronix.de>
References: <20160413134659.GB1455@archie.localdomain>
 <570E4F22.2080208@pengutronix.de>
Reply-To: ptxdist-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1524701139=="
Return-path: <ptxdist-bounces+gcepd-ptxdist=m.gmane.org-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
In-Reply-To: <570E4F22.2080208-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/ptxdist>,
 <mailto:ptxdist-request-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/ptxdist/>
List-Post: <mailto:ptxdist-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Help: <mailto:ptxdist-request-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/ptxdist>,
 <mailto:ptxdist-request-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org?subject=subscribe>
Sender: "ptxdist" <ptxdist-bounces-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Errors-To: ptxdist-bounces+gcepd-ptxdist=m.gmane.org-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Clemens Gruber <clemens.gruber-lZxf/j91sTNWk0Htik3J/w@public.gmane.org>, ptxdist-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1524701139==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="H80fc6UPdXe28MMMbqgI3uJxVDuOom30l"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H80fc6UPdXe28MMMbqgI3uJxVDuOom30l
Content-Type: multipart/mixed; boundary="hlJLDFvFMWMmS3qblXpK5bFgIU8rOWCdE"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Clemens Gruber <clemens.gruber-lZxf/j91sTNWk0Htik3J/w@public.gmane.org>, ptxdist-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
 linux-can <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <570E51AC.4060705-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: canutils problem on mainline kernel
References: <20160413134659.GB1455-XFg2mmwPnERSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>
 <570E4F22.2080208-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
In-Reply-To: <570E4F22.2080208-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--hlJLDFvFMWMmS3qblXpK5bFgIU8rOWCdE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2016 03:52 PM, Marc Kleine-Budde wrote:
>> I can reproduce it with the flexcan driver on an i.MX6Q board. I get o=
ut
>> of range errors when trying to set the bitrate.
>=20
> There was a problem with the CAN clock on some imx in the kernel recent=
ly.

You probably need:
https://lkml.org/lkml/2016/3/30/299

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hlJLDFvFMWMmS3qblXpK5bFgIU8rOWCdE--

--H80fc6UPdXe28MMMbqgI3uJxVDuOom30l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXDlGsAAoJED07qiWsqSVq7B8H/iE8pZR1u5pzl8xtNoa+FPfD
QQESqjxaYyE59AaKpdz/6V4elPCTTCa2ThQijnodktVB0xdOiuQEdYxAeOHYhFCv
lFJ/VPbQukKv7wG9TDJ9VFcwKtJb2O/0Cvl4UhGjdVx5e/LYuCc0+kqzvmMKNkrT
JzpyqOTtXQBs1VhY2F7fcQEEY4Jg3Phd8ZXUvxD70MOJDiHW6WdSdyrWGOKWB7Bv
1qo+YQ4H1wyGNLbzbACj1Oo+D3YIFOfMjcsIGsFaLGkiY3L+WfIdsc/YAsN+IrB2
BzV+xT5rYrQSAIKEVqjzA7JCHdaRnJm6TRFSdUb/cUPuE1gjDRweX+ONcceCQRQ=
=wSbk
-----END PGP SIGNATURE-----

--H80fc6UPdXe28MMMbqgI3uJxVDuOom30l--


--===============1524701139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHR4ZGlzdCBt
YWlsaW5nIGxpc3QKcHR4ZGlzdEBwZW5ndXRyb25peC5kZQ==

--===============1524701139==--
