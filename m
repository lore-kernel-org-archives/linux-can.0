From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: rx-fifo: add implmentation and switch flexcan driver to use it
Date: Mon, 9 May 2016 12:54:48 +0200
Message-ID: <57306C78.2070007@pengutronix.de>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3RuwLI91iMbg0TRL00MRtFLiVjT4GQeFM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50502 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751248AbcEIKyy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 May 2016 06:54:54 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <mkl@pengutronix.de>)
	id 1azipw-0004af-Ss
	for linux-can@vger.kernel.org; Mon, 09 May 2016 12:54:52 +0200
Received: from [IPv6:2001:6f8:105b:1122:9cfe:47ab:a2a6:db41] (unknown [IPv6:2001:6f8:105b:1122:9cfe:47ab:a2a6:db41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Primary Intermediate Client CA" (verified OK))
	(Authenticated sender: mkl@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 722DE124E25
	for <linux-can@vger.kernel.org>; Mon,  9 May 2016 10:54:51 +0000 (UTC)
In-Reply-To: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3RuwLI91iMbg0TRL00MRtFLiVjT4GQeFM
Content-Type: multipart/mixed; boundary="SQ8H5ns7vi7JpT80MPqGwge7aHmjuqhNP"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Message-ID: <57306C78.2070007@pengutronix.de>
Subject: Re: rx-fifo: add implmentation and switch flexcan driver to use it
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
In-Reply-To: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>

--SQ8H5ns7vi7JpT80MPqGwge7aHmjuqhNP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2016 12:52 PM, Marc Kleine-Budde wrote:
> Hello,
>=20
> this patch add support for a software bases rx-fifo implementation (pat=
ches
> 1+2). The remaining patches modify the flexcan driver to make use of it=
=2E imx6
> and vf610 SoCs can make use of the 64 mailbox software FIFO, while olde=
r SoCs
> still use flexcan's 6 mailbox deep hardware FIFO.
>=20
> Testing on any flexcan core is highly appreciated.

BTW: This series is available on git:

https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/log/?=
h=3Dflexcan-next

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SQ8H5ns7vi7JpT80MPqGwge7aHmjuqhNP--

--3RuwLI91iMbg0TRL00MRtFLiVjT4GQeFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXMGx4AAoJED07qiWsqSVq7V0IAI2wScFgjPvhz1pnseZM6l0l
zbIoUWP3HIwuCTBbgQmOMXzq5xsH9hca/8tKmDcC5uAQ7Rk0fmJ0i8eX8Pmt5InA
MeccufNUI8xOWyD6arNZ7lrnDGwtdrze0Mocf0laFNl+Ycmkj346TkMTRUbZGtFH
B8AF7vVqeiikpR8PN9Abx2Nc8yMrujBB7lqqqF7IWYOjWtHNPZdzIhzt0a6WwEYJ
GQwmnh6LX7a6kfVhPOcuvdgqeN10EhPzKfNMvCrDbv4YwC7U5AaU2odD5kmsdKih
WjZ65t4Fsz+m9AwEbc8UYBmyUsdEsOUfAHTNKMI/bkvYjp0wGoKd2RQ1fYSST68=
=5qUi
-----END PGP SIGNATURE-----

--3RuwLI91iMbg0TRL00MRtFLiVjT4GQeFM--
