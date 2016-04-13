From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: canutils problem on mainline kernel
Date: Wed, 13 Apr 2016 15:52:34 +0200
Message-ID: <570E4F22.2080208@pengutronix.de>
References: <20160413134659.GB1455@archie.localdomain>
Reply-To: ptxdist-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1735753789=="
Return-path: <ptxdist-bounces+gcepd-ptxdist=m.gmane.org-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
In-Reply-To: <20160413134659.GB1455-XFg2mmwPnERSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>
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
--===============1735753789==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GjowiQuS9lrxA4TxDTWWVl3TPqm6TI4pe"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GjowiQuS9lrxA4TxDTWWVl3TPqm6TI4pe
Content-Type: multipart/mixed; boundary="PURsINOjuRJ0iqRV6BsjntcVvMMF5q2tu"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Clemens Gruber <clemens.gruber-lZxf/j91sTNWk0Htik3J/w@public.gmane.org>, ptxdist-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
 linux-can <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <570E4F22.2080208-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: canutils problem on mainline kernel
References: <20160413134659.GB1455-XFg2mmwPnERSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>
In-Reply-To: <20160413134659.GB1455-XFg2mmwPnERSq9BJjBFyUp/QNRX+jHPU@public.gmane.org>

--PURsINOjuRJ0iqRV6BsjntcVvMMF5q2tu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2016 03:46 PM, Clemens Gruber wrote:

> it looks like the canutils from ptxdist do not work anymore with the
> current mainline kernel 4.6. (Working fine on 4.5)
>=20
> Did you also notice this?

No. What's the outout of:

    canconfig can0

> I can reproduce it with the flexcan driver on an i.MX6Q board. I get ou=
t
> of range errors when trying to set the bitrate.

There was a problem with the CAN clock on some imx in the kernel recently=
=2E

> I saw that some of you created a new project "can-utils":
> https://github.com/linux-can/can-utils
>=20
> Is there a replacement for the canconfig utility from canutils?

You can use the "ip" tool from iproute2 (not the one from busybox).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PURsINOjuRJ0iqRV6BsjntcVvMMF5q2tu--

--GjowiQuS9lrxA4TxDTWWVl3TPqm6TI4pe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXDk8iAAoJED07qiWsqSVq8wUIAKh/l7YQANxwGOv1xOzu+JVf
7i+bWGpttJ3Noz0+3hEPZ9kqCf0PF/jk9NkCOM7MyCbnnTYbfQ2AyvG3rTMYwIXD
wcBP2i2vvRuiSG22bA1tg52jry1hQAcmw1hBuanQxJqrEgAp69pjKyyIpRRAgjGe
JJzCfBxKsNR/V8fumj4DGQ6j8QkwbdUiBz0ei+vMhQg0KssGD8nlDsvH9Eimbu1o
pC59h6HbyTKvYJ4THAwLEX+eSL+oiMWD7dCEU4wRA262QLUr112IZWIYXepioZD4
G15mK/osxASPK8F8qeDpB0Nz0b4jRHq6eAbmkrQulSagbfmdwmOBN5mTuhaYKLE=
=luV7
-----END PGP SIGNATURE-----

--GjowiQuS9lrxA4TxDTWWVl3TPqm6TI4pe--


--===============1735753789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHR4ZGlzdCBt
YWlsaW5nIGxpc3QKcHR4ZGlzdEBwZW5ndXRyb25peC5kZQ==

--===============1735753789==--
