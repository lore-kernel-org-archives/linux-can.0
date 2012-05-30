From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 14:37:30 +0200
Message-ID: <4FC6148A.4080208@pengutronix.de>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <jq52jo$i2e$2@dough.gmane.org> <4FC61007.80802@pengutronix.de> <jq5452$1mv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig24E19BDFBCE5BE9B406E1017"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44857 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab2E3Mhe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 May 2012 08:37:34 -0400
In-Reply-To: <jq5452$1mv$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24E19BDFBCE5BE9B406E1017
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On 05/30/2012 02:34 PM, Martin Kozusky wrote:
>>> And I can only use 2.6.39 kernel because there is no patch for my boa=
rd
>>> for kernel 3.x yet :(
>>
>> Ask your supplier to a) backport the fixes to your kernel or b) to
>> deliver a 3.4 based BSP.
>=20
> or c) backport the fixes myself :) I think that will be fastest way, if=

> it's just about fixes of flexcan driver. Or are there many changes in
> many kernel files?

No, IIRC 2 patches on the driver, one small infrastructure patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig24E19BDFBCE5BE9B406E1017
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/GFIoACgkQjTAFq1RaXHMsWACggB+DjOwBCqRqv3901cscXR5+
h4YAni4c/vPRKpGkPdUIyc8h6hbCJm3f
=DTgY
-----END PGP SIGNATURE-----

--------------enig24E19BDFBCE5BE9B406E1017--
