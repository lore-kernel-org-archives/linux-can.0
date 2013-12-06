From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: arbitration lost error reporting
Date: Fri, 06 Dec 2013 13:16:47 +0100
Message-ID: <52A1C02F.6050106@pengutronix.de>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <52A1A323.1030605@pengutronix.de> <loom.20131206T114831-779@post.gmane.org> <52A1B8DA.1030700@pengutronix.de> <52A1BCEE.5070101@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="00sVu77b8RGVk2BeIOjFupKtijoUKflV8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44536 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab3LFMQz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2013 07:16:55 -0500
In-Reply-To: <52A1BCEE.5070101@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Richard Andrysek <richard.andrysek@rg-mechatronics.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--00sVu77b8RGVk2BeIOjFupKtijoUKflV8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2013 01:02 PM, Oliver Hartkopp wrote:
>> Do you have a preferred name for the define?
>> - CAN_CTRLMODE_AERR_REPORTING
>> - CAN_CTRLMODE_ARBITRATIONERR_REPORTING to
>=20
> Loosing the arbitration is not an error. It just can happen from time t=
o time.

Details :)

> If you thing about a define, what about:
>=20
> [ ] CAN_CTRLMODE_ARB_LOST_REPORTING
> [x] CAN_CTRLMODE_ARBITRATION_LOST_REPORTING

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--00sVu77b8RGVk2BeIOjFupKtijoUKflV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKhwC8ACgkQjTAFq1RaXHPoewCfaAHWOOFawZp9VZBQCtcvTG57
UXEAnAzNhOPuWyoaDo5xUpre7anc1T2y
=xcGc
-----END PGP SIGNATURE-----

--00sVu77b8RGVk2BeIOjFupKtijoUKflV8--
