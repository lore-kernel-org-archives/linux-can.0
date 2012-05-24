From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 0/5] can: c_can: Add support for Bosch D_CAN controller
Date: Thu, 24 May 2012 10:28:50 +0200
Message-ID: <4FBDF142.6020805@pengutronix.de>
References: <1337775313-28219-1-git-send-email-anilkumar@ti.com> <4FBDEF66.1050307@pengutronix.de> <4FBDF081.5070903@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3FEEC6346DCB4548D7737803"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41093 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab2EXI3I (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 May 2012 04:29:08 -0400
In-Reply-To: <4FBDF081.5070903@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3FEEC6346DCB4548D7737803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/24/2012 10:25 AM, Wolfgang Grandegger wrote:
>>>   can: c_can: Move overlay structure to array with offset as index
>>>   can: c_can: Add support for Bosch D_CAN controller
>>
>> I'm going to add these patches to linux-can-next after we've sorted ou=
t
>> the outstanding minor things about the id_table.
>=20
> And the missing Kconfig name and help update.

Right, thanks, missed that.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3FEEC6346DCB4548D7737803
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+98UoACgkQjTAFq1RaXHPNhgCeN7QnDHyzjIHtAOpby5roGjLO
5OwAmwVaT4yQXmmVFXfh0vmBps2dQa/r
=elMe
-----END PGP SIGNATURE-----

--------------enig3FEEC6346DCB4548D7737803--
