From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: c_can: fix "BUG! echo_skb is occupied!" during
 transmit
Date: Tue, 24 Apr 2012 15:11:06 +0200
Message-ID: <4F96A66A.8020200@pengutronix.de>
References: <1334915862-29810-1-git-send-email-anilkumar@ti.com> <4F965C6D.6030303@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13E997D11@DBDE01.ent.ti.com> <4F968E47.7020109@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13E997D85@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1F2EBEC750D9929D59B83A8B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36270 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab2DXNLQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 09:11:16 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E997D85@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F2EBEC750D9929D59B83A8B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/24/2012 01:53 PM, AnilKumar, Chimata wrote:
>>>>> Also, fix the condition used to find if the packet is transmitted
>>>>> or not. Current code skips the first tx message object and ends up
>>>>> checking one extra invalid object.
>>>>
>>>> The two above listed issues can occur with the c_can hardware, too?
>>>> Please split into two separate patches. These should go to the stabl=
e
>>>> kernel, too. Can someone with a c_can hardware test these patches.
>>>
>>> I will split into two patches. I had clubbed both the changes in a si=
ngle
>>> patch because both the changes are required to get rid of the error m=
entioned
>>> in the subject line.
>>
>> okay - then it's better to keep them together.
>=20
> After we got the status, c_can driver testing with this patch, can I se=
nd one
> more patch (v2) with stable tag added or will you take care? I am ok wi=
th any
> of these.

Poke me, if I forget to push these patches upstream :)

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1F2EBEC750D9929D59B83A8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+Wpm0ACgkQjTAFq1RaXHOGcwCfWqTR1X+zp+1sakU3hWCvsajo
dZEAn2EJTIc6tLsKNpmIBoG7FTy7Mqh0
=xKP1
-----END PGP SIGNATURE-----

--------------enig1F2EBEC750D9929D59B83A8B--
