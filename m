From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_usb: fix sequence order in case of error during
 init
Date: Tue, 02 Dec 2014 13:35:31 +0100
Message-ID: <547DB213.9040207@pengutronix.de>
References: <1417178950-26398-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cwwdeKc9PkqQingJtfgJhmcA8IOrce7m0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48164 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbaLBMfl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 07:35:41 -0500
In-Reply-To: <1417178950-26398-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cwwdeKc9PkqQingJtfgJhmcA8IOrce7m0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/28/2014 01:49 PM, Stephane Grosjean wrote:
> This patch sets the correct reverse sequence order to the instructions
> set to run, when any failure occurs during the initialization steps.
> It also adds the missing unregistration call of the can device if the
> failure appears after having been registered.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Applied to can/master.

Thanks,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--cwwdeKc9PkqQingJtfgJhmcA8IOrce7m0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfbITAAoJECte4hHFiupUBK0P+gPUphI6HP3aLAjLxK64s7Ys
EOJ3RuQLgHHxeGObWzZl9Zf1E9lccSpw56VXjMZnyRoNLoTzJCbUNTgwksqOXGDR
9Eq9kRPZ1QPlXuTQ3hlLKQiXHhT3XMJLMTFNB9QVKnEAJf/Vj7nB9A//+aQpRwGr
Rq+pdHcsUYbNxiRHS+Qm2K8/stNOzV0S/sYEZmVQY0q8t3WA39IAlmg0f8qIq6EU
Qg6c+AJh5HjvUeMZU/MMWmqPN3duvmZabRA+Y/TdSF8/Mx9k+1jT8PT8vQP1KsI8
66CTQyV3ySdYse69IOxOcsQ0tJWuWvion/gOmOYiXozIsfLkTTbM2ncoO45r/q23
U2oXMvNpGE5Rj8xVE164qcasCNBHwtHATxPFSY05JS6hhSoW9E2qeyTy2heYdLV1
zy+/botBhgKv2ojpQeBbSNUz0qwFNfMfmZ9HS0o0TUhfoIVAvfuDVhzhrf+2j5il
obTPCsIsUYxJsaSKb5CT9TzsLjkcIqLvTwcCIpCK6M8+Jfz9xtwGYJjVWqonwY8m
7BQCbA8pTkj/9tpmP4czCVzwC87bONbFTtBBFqqD51SIiHh+WykdiEM6qA55t8IO
bQA22xdHvGd91kHmMcPKkMWBlyzXq+GamYIdPZ+Pk7zim5+rujSCk8MjPWAez8uH
uCqL+SapwLhJshlf8a8M
=vsH0
-----END PGP SIGNATURE-----

--cwwdeKc9PkqQingJtfgJhmcA8IOrce7m0--
