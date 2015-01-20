From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_usb: export ctrlmode_supported to adapter specific
Date: Tue, 20 Jan 2015 15:18:55 +0100
Message-ID: <54BE63CF.804@pengutronix.de>
References: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com> <1421684127-12764-2-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="S7g0La9OKg9xCNa4xW0sp9ilsAUcTgS25"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53320 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbATOS6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:18:58 -0500
In-Reply-To: <1421684127-12764-2-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S7g0La9OKg9xCNa4xW0sp9ilsAUcTgS25
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2015 05:15 PM, Stephane Grosjean wrote:
> Export the ctrlmode_supported value from the core file to each adapter
> specific file. This has been mandatory for supporting the new CANFD
> extension.

Looks good, although the subject could be improved, it looks unfinished.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--S7g0La9OKg9xCNa4xW0sp9ilsAUcTgS25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUvmPPAAoJECte4hHFiupUH0UP/3xs7niEso5b7DEj1O3Z3OZZ
SrQvYKWTUAXXgZaDMSR3kZKRYiAjCTwE24cnnaLSdWt0lipqTqZTyvi+RJ15jObJ
bWUZknvGhp+0kwX27dl2G5Ukyt3Mxuc69H6aSrzYAFXQxCaRnQhIGRuTtvvkCJYz
Ta780hcWyARE7APU+yjC/mNK+YnrbdisGQAD9MZGbj+hsrs2FePb+3a8/36aVKZs
gvzJTq1SxyW32oepHI62Gj/zpMO5ecMFDPy6SZzhZWfM+34/gqMYja+Bswr3f9R+
40gPJRs4Cber2JGmuNU+rtZumwStaNxaZf0YGMCY3G4Ekr2+zHEl9txxqwd1dzKI
wj7e1WGlyWE7LI6ynIcfNkZaoLVu075H5/H7dTRFfCdsc6Hhn+FU6D7lpMjqIAU9
3PeAszMtlyT9nb0RcBnvTf4rcPaXVVbDx6FcmADCYplb/CxbCTxPJfPVEk38EmfI
FxQkC8WiAhZgNCm6SP0T8I7HJXqQwlhSx55sQD/9Ncii/zZY+K5ASNVPLUKdwmbo
IN+xkPWpuJ29X4WfjtazdGCT9tJqXOX7j3hZJF42T3TWdP82rvrRolhDySc03BvV
JIMxPrgC689ty6Pmr/g47lq9izSTx+eLcxgWy3GgAoGuHsisIciWd0wUj4qXxP3X
8rBkK/CXszAXNwgCTZn9
=EDdo
-----END PGP SIGNATURE-----

--S7g0La9OKg9xCNa4xW0sp9ilsAUcTgS25--
