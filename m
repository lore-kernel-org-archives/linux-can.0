From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/6] canfd: add new data structures and constants
Date: Mon, 18 Jun 2012 21:12:54 +0200
Message-ID: <4FDF7DB6.6090208@pengutronix.de>
References: <4FDF67C3.6020201@hartkopp.net> <4FDF6A96.4050305@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig475FC35E16257D16E8CB5408"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58861 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab2FRTM4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:12:56 -0400
In-Reply-To: <4FDF6A96.4050305@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig475FC35E16257D16E8CB5408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/2012 07:51 PM, Oliver Hartkopp wrote:
> On 18.06.2012 19:39, Oliver Hartkopp wrote:
>=20
>=20
>> --- a/include/linux/can.h
>> +++ b/include/linux/can.h
>> @@ -46,18 +46,65 @@ typedef __u32 canid_t;
>>   */
>>  typedef __u32 can_err_mask_t;
>>  +#define CAN_MAX_DLC 8
>> +#define CAN_MAX_DLEN 8
>> +
>=20
>=20
> Hm looks broken - but the patch and the repo content is ok.

I suggest to use git send-email. It can talk smtp with authentication
and all bells and whistles you need. Yes, the repo is all-right.

>=20
> Oh, well.
>=20
> Anyone an idea how to set up imap with strato.de for git send-imap with=
 a
> debian system ??

sudo aptitude install dovecot-imapd

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig475FC35E16257D16E8CB5408
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/ffbYACgkQjTAFq1RaXHP2awCfaDPeGjA59LJQ85yZR7qe8n2m
OisAniAeoohUdLNC52xZHmBXAUPpmcqX
=uj3C
-----END PGP SIGNATURE-----

--------------enig475FC35E16257D16E8CB5408--
