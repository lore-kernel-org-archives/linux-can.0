From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can:for-davem 3/3] drivers/net/can/ti_hecc.c:909:7: warning:
 assignment makes pointer from integer without a cast
Date: Sun, 22 Dec 2013 00:04:53 +0100
Message-ID: <52B61E95.1050706@pengutronix.de>
References: <52b60e29.e6MbNbPY4sH1N+Ql%fengguang.wu@intel.com> <52B60F21.5070502@pengutronix.de> <20131221225722.GA12243@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sdIegURLGsuRtE3BhGpKXs8DxNfhmqGSX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34253 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab3LUXFG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Dec 2013 18:05:06 -0500
In-Reply-To: <20131221225722.GA12243@localhost>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sdIegURLGsuRtE3BhGpKXs8DxNfhmqGSX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/21/2013 11:57 PM, Ezequiel Garcia wrote:
[...]

>> Should we go back to "depends on ARM"?

> Well, it seems user-mode linux has no ioremap? So, maybe we'll have to
> live with "depends on ARM" unless anyone has a better idea.

Then it's Patch v2.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sdIegURLGsuRtE3BhGpKXs8DxNfhmqGSX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlK2HpkACgkQjTAFq1RaXHONswCePEacq2Dd716BTlqEZXrRf6Oe
edkAniZhGgWZgwWypnAG1YaUhCjBDVur
=GQQx
-----END PGP SIGNATURE-----

--sdIegURLGsuRtE3BhGpKXs8DxNfhmqGSX--
