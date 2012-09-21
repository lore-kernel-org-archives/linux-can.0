From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: Add d_can suspend resume support
Date: Fri, 21 Sep 2012 12:25:59 +0200
Message-ID: <505C40B7.6010902@pengutronix.de>
References: <1348221541-28878-1-git-send-email-anilkumar@ti.com> <505C3D4A.5030205@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA389E1@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2153223424DE46C4A1F6BB30"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40470 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab2IUK0K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Sep 2012 06:26:10 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA389E1@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2153223424DE46C4A1F6BB30
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/21/2012 12:16 PM, AnilKumar, Chimata wrote:
> Hi Marc,
>=20
> On Fri, Sep 21, 2012 at 15:41:22, Marc Kleine-Budde wrote:
>> On 09/21/2012 11:59 AM, AnilKumar Ch wrote:
>>> Adds suspend resume support to DCAN driver which enables
>>> DCAN power down mode bit (PDR). Then DCAN will ack the local
>>> power-down mode by setting PDA bit in STATUS register.
>>
>> Applied to can-next. I've updated the master branch in the can-next
>=20
> Thanks for pushing,
>=20
>> repo. AnilKumar, I think I should squash patch "of: Modify c_can bindi=
ng
>> documentation" into "can: c_can: Add device tree support to Bosch
>> C_CAN/D_CAN controller". What do you think?
>>
>=20
> Yes, good to have in a patch where C_CAN DT support is added.
> No issues.

Squashed and pushed.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2153223424DE46C4A1F6BB30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBcQL0ACgkQjTAFq1RaXHOsaACcDMm+GmrjKwcOMxei8v0YMmOw
SVsAn05w3/eRjX7dDcL+LF6gAPrDmiJg
=R8VD
-----END PGP SIGNATURE-----

--------------enig2153223424DE46C4A1F6BB30--
