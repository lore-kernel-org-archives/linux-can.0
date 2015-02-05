From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] bfin_can: rewrite the blackfin CAN driver into arch independent
 style
Date: Thu, 05 Feb 2015 09:51:42 +0100
Message-ID: <54D32F1E.1090407@pengutronix.de>
References: <1419391828-21105-1-git-send-email-Aaron.wu@analog.com> <54AD4461.1040203@pengutronix.de> <649EF91064D35D40B9C93A225BF41674613109AC@NWD2MBX7.ad.analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="i6dmCR3kgaDpBSkAgw5Wv275EbucoONgw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48859 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746AbbBEIvw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Feb 2015 03:51:52 -0500
In-Reply-To: <649EF91064D35D40B9C93A225BF41674613109AC@NWD2MBX7.ad.analog.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Wu, Aaron" <Aaron.Wu@analog.com>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "Zhang, Sonic" <Sonic.Zhang@analog.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i6dmCR3kgaDpBSkAgw5Wv275EbucoONgw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2015 09:42 AM, Wu, Aaron wrote:
> Thanks for the comments from you and other guys in the list, I've
> updated the patch accordingly to V4, do you happen to have a look at
> it? Next I will merge the used contents of bfin_can.h into the

Yes, see reply :)

> bfin_can.c directly as you suggested earlier.

Fine - this would be a good improvement. You add that patch to the
series when posting a v5.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--i6dmCR3kgaDpBSkAgw5Wv275EbucoONgw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU0y8hAAoJECte4hHFiupUwHkP/i6hoCaNZBJ7O17m0bswqbXq
xqBE9AZT84p88AjPafG2+dYGxZlCEbfgSxeG4ruAMkInmh0s1dEzombwTS9X+uMl
wCz7t8xZvpMgAQZOtMub30RGdVyBleQaiNsFTm+QJEXAVUiDqlM9H8sn8ynQgoUH
ssdOiWMQmtCnxC297k4Yf9qyzAH3+Q20R/f5AybTYZjkEw/ztIHOg0kU9zgjjvz5
PEI7yHIwjU+LTFS+EHPhDv1vSsdGnrzmgbQKTPe0B9KbIEYdNMpDIm5cj6KD9ENF
ht+E1WP2g001bE+lHh+U16iE7AzCgjja/RwvHsKBRU7xbQ+WKGiYoUKAeLZTjnNp
/SbsyNNuCEAbPgtCKlnV9TRztXYDMde0893j7oZaYZLDS6b84OP0TzZpqaAv19Ih
EJpCB02MHe/NY950q5KPMq/MUwoz0C1x4FlFS7fau65+EvogZmzeE42NS/qpSngd
cvFki1Xpc5hcoCVeAsnTG7USqS/nbAVzWM2CG8oBJGNZcC7urSfXZfr/m/uApx/D
CRIheZljxGoKvZouelaCvM+NGadtFMiZ0+JNBlCdNbJPGx5C/3aWZLxHWus99Ytx
ckg9PWMixDUAJR5fh4jjiGsLdJOjctM9hEAMSQ5xa5A4yGW9Hhzo2uwcor2OgMDO
KjzuF8GWQjEzD+IwzBkD
=KrzA
-----END PGP SIGNATURE-----

--i6dmCR3kgaDpBSkAgw5Wv275EbucoONgw--
