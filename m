From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: mailmap
Date: Thu, 6 Oct 2016 15:08:08 +0200
Message-ID: <8c0ae82e-dd87-7b33-a8ea-c76db44e8491@pengutronix.de>
References: <20161006122427.GF26915@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="awLEBRtFs118qpkDSgPFwDiNgacW30QwG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46331 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750979AbcJFNIQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 09:08:16 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <mkl@pengutronix.de>)
        id 1bs8PF-0006WN-Ve
        for linux-can@vger.kernel.org; Thu, 06 Oct 2016 15:08:14 +0200
Received: from [172.17.34.175] (unknown [172.17.34.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Primary Intermediate Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B4C8417A271
        for <linux-can@vger.kernel.org>; Thu,  6 Oct 2016 13:08:11 +0000 (UTC)
In-Reply-To: <20161006122427.GF26915@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--awLEBRtFs118qpkDSgPFwDiNgacW30QwG
Content-Type: multipart/mixed; boundary="W7QSUpdGKxhRO2TjwCwM1Ct0FtWJchGPw";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Message-ID: <8c0ae82e-dd87-7b33-a8ea-c76db44e8491@pengutronix.de>
Subject: Re: mailmap
References: <20161006122427.GF26915@airbook.vandijck-laurijssen.be>
In-Reply-To: <20161006122427.GF26915@airbook.vandijck-laurijssen.be>

--W7QSUpdGKxhRO2TjwCwM1Ct0FtWJchGPw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2016 02:24 PM, Kurt Van Dijck wrote:
> Besides the legal aspect of squashing the whole j1939 tree, which I did=

> half on EIA, half in private time, it sure seems a good idea to fix
> the email address in .mailmap:

I was hoping that .mailmap would replace the email address but it seems
that it's really only used by shortlog. On the other hand we have the
MAINTAINERS file, which doesn't say anything about authorship or copyrigh=
ts.

> Can you, besides the j1939 stuff, incorporate this one.

Done.

> I also prepare a MAINTAINERS commit, that should go along with the J193=
9
> stuff....

Done.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--W7QSUpdGKxhRO2TjwCwM1Ct0FtWJchGPw--

--awLEBRtFs118qpkDSgPFwDiNgacW30QwG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX9ky4AAoJED07qiWsqSVqrgYIAKbVKUyo3bCq3gGMNhAGPvTq
+tiQUHgoIvdp471mQZjYw7MI3FA4yNfYtRAV/2YWfw2l9DckAxXqTu7ALD0x4zOb
riuiGET6i21W3oFMfw1D8oqgMaHkeSDhwzEbXLDy/hT6jpaU6/EkQnYCQrbRL/eE
q8i5njrQ0sj8KZ9niktln3q8JMkcuy5dbJET0OHPoUk1RVnKbxp5VLBznrA91hjT
3bz9HQCdY9avtRm7xbQyzjoN0A5WjTyJ8XM/VWqrMtH6ls5sY+V1feONaS0O4gjS
bTKwK5cZeJbvDltKdR7yfMz1JKUndq4O+KD6eFEzinADUKzLIWxpqVoP06fQoCE=
=keJ/
-----END PGP SIGNATURE-----

--awLEBRtFs118qpkDSgPFwDiNgacW30QwG--
