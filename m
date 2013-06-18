From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: usb_8dev: unregister netdev before free()ing
Date: Tue, 18 Jun 2013 22:21:57 +0200
Message-ID: <51C0C165.50901@pengutronix.de>
References: <1371560243-24316-1-git-send-email-mkl@pengutronix.de> <51C0A5A2.6010909@universalnet.at> <51C0A820.3010102@pengutronix.de> <51C0C11E.1090705@universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XSFLDLTIORPXQVASOVCS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51861 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933069Ab3FRUWD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Jun 2013 16:22:03 -0400
In-Reply-To: <51C0C11E.1090705@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XSFLDLTIORPXQVASOVCS
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/18/2013 10:20 PM, Bernd Krumboeck wrote:
>>>> The driver tries to free the netdev, which has already been
>>>> registered, without
>>>> unregistering it.
>>>>
>>>> This patch fixes the problem by unregistering the netdev in the erro=
r
>>>> path.
>>>>
>>>
>>> Thank you for the patch!
>>>
>>> I've applied it to my source tree:
>>> https://github.com/krumboeck/usb2can
>>
>> Can I have you Acked-by or Reviewed-by?
>>
>> Marc
>>
>=20
> Yes, of course.
>=20
> Please add "Reviewed-by: Bernd Krumboeck <krumboeck@universalnet.at>".

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XSFLDLTIORPXQVASOVCS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHAwWgACgkQjTAFq1RaXHM30QCglx1Fv2TgFZhiTz0q17JzJNKH
su0An0sNQYblJOSUhIPdsq+DfSoHysvL
=kxMR
-----END PGP SIGNATURE-----

------enig2XSFLDLTIORPXQVASOVCS--
