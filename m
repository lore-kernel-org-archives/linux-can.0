From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Canutils can not up can0
Date: Tue, 22 Jul 2014 14:20:01 +0200
Message-ID: <53CE56F1.2070907@pengutronix.de>
References: <53CE4BDC.1000508@gmail.com> <53CE4E59.90602@pengutronix.de> <53CE54BA.2070609@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="brtopTUjtpn7P4oOXVC5bhoAnL1eCs21q"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43590 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaGVMUG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jul 2014 08:20:06 -0400
In-Reply-To: <53CE54BA.2070609@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: grommerin <grommerin@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--brtopTUjtpn7P4oOXVC5bhoAnL1eCs21q
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Mikita,

please keep the mailing list on Cc.

On 07/22/2014 02:10 PM, grommerin wrote:
> Now I try using this version:
> https://gitorious.org/linux-can/can-utils/source/518faef3acc79bb4f31ae2=
b55b266eb540850f39:

There is no canconfig in the gitoruous can-utils.

> Working version: git://git.pengutronix.de/git/tools/canutils.git
> No error messages. The problem is that I can not configure can0 and set=

> bitrate.
> I can not attach a message "dmesg". "ifconfig" sees can0 but it is not
> configured.

Which canconfig are you using?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--brtopTUjtpn7P4oOXVC5bhoAnL1eCs21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPOVvEACgkQjTAFq1RaXHPXkgCbBfGbmlLfca4MZ+Q0C4IdaFE8
NKQAnRI+Mgux82n8/Rb7byaHY2kcvMWJ
=jqgO
-----END PGP SIGNATURE-----

--brtopTUjtpn7P4oOXVC5bhoAnL1eCs21q--
