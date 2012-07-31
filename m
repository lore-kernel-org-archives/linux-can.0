From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next v3 1/2] can: add tx/rx LED trigger support
Date: Tue, 31 Jul 2012 14:00:36 +0200
Message-ID: <5017C8E4.4020003@pengutronix.de>
References: <1343676041-29572-1-git-send-email-fabio.baltieri@gmail.com> <5016FA01.5000109@pengutronix.de> <20120731065733.GA30267@gmail.com> <501784C8.9050803@pengutronix.de> <20120731115733.GB30417@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig05D7B327D6C64F42C5EED01A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51222 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab2GaMAk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jul 2012 08:00:40 -0400
In-Reply-To: <20120731115733.GB30417@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05D7B327D6C64F42C5EED01A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/31/2012 01:57 PM, Fabio Baltieri wrote:
[...]

>>>> Can you provide a devm implementation for can_led?
>>>
>>> Sounds reasonable, you mean like a devm_kasprintf implementation to
>>> remove kfree and unwinding code?
>>
>> IMHO it would be sufficient if you implement the devm cleanup function=
s
>> here.
>=20
> Uh - can you be more specific?  I mean, are you suggesting to just
> convert the code to something like:
>=20
> unsigned int len;
> char *p;
>=20
> len =3D snprintf(NULL, 0, "%s-tx", netdev->name);
> p =3D devm_kzalloc(&netdev->dev, len + 1, GFP_KERNEL);
> if (!p)
> return -ENOMEM;
> sprintf(p, len + 1, "%s-tx", netdev->name);

This would work, if you just have to free both names, but...

> or to implement something with devres_alloc() and a specific
> release function?

=2E..you have to call led_trigger_unregister_simple(), so we need a custo=
m
release function.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig05D7B327D6C64F42C5EED01A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAXyOQACgkQjTAFq1RaXHOrqgCfR1xP0itAC6UcfCW9B2FuNvQ+
0OQAn3lhSjV4AoKtOv8jB+q0AsHV+uSF
=WBxJ
-----END PGP SIGNATURE-----

--------------enig05D7B327D6C64F42C5EED01A--
