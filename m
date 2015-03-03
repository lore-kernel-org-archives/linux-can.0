From: Andrew Lentvorski <bsder@allcaps.org>
Subject: Re: Bug on configure ... where to report?
Date: Tue, 03 Mar 2015 02:30:49 -0800
Message-ID: <54F58D59.5070809@allcaps.org>
References: <54EE63C5.3040307@allcaps.org> <54EEDD2F.5080501@pengutronix.de> <54F4EAE3.5090406@allcaps.org> <54F562CE.6030009@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XPrRFviN8cLFkgA5tPpT0OEDsbsRRHvUS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 64-73-229-46.static-ip.telepacific.net ([64.73.229.46]:36879
	"EHLO s0-postfix.allcaps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625AbbCCKam (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Mar 2015 05:30:42 -0500
In-Reply-To: <54F562CE.6030009@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XPrRFviN8cLFkgA5tPpT0OEDsbsRRHvUS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

That worked even without the patch.  I had to explicitly install
automake with "apt-get install automake".  The standard "apt-get update;
apt-get upgrade" dance was insufficient.

Presumably, this is all about to be moot as it seems that debian jessie
actually has a can-utils package.

Thanks for all the effort.

-a


--XPrRFviN8cLFkgA5tPpT0OEDsbsRRHvUS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU9Y1ZAAoJEJ9wo+TcbAAXK7UIAJwZo725Upc2X5X49/mEVDJK
CMj4OwX592ckSV0XsYV4Y5irzBxHgysnyrqXfAJfBg3HkMAkfEEldxmXTtEC1rL9
fMkCaaSuHya2qMNfWw3AEX1NirJQgo7BdwsfDa/iGPIxYHx5HpCt0SMq3IXFBV4N
QHrGm+F1CXAkI6RA/QblLoA6u23n3sLrhsw3L30GJAQm8P3V7LotUIqobmu0/On5
uEDKDy/8G297BmeGj6gLsQRwYOjiXJNHT/MuH2sL0LZRY8YXO1P2ENwNct6VP932
4cetUbS95Lq4Ccz3YcjgLCNgP5ANKPyyPZylXVj+NDbDwnYZAfY5hbtEwi26M28=
=5HMS
-----END PGP SIGNATURE-----

--XPrRFviN8cLFkgA5tPpT0OEDsbsRRHvUS--
