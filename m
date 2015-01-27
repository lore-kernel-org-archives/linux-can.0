From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v10 1/9] can: peak_usb: use ARRAY_SIZE instead off NULL
 termination for peak_usb_adapters_list
Date: Tue, 27 Jan 2015 22:02:46 +0100
Message-ID: <54C7FCF6.7050006@pengutronix.de>
References: <1422392516406850652@MailServerPEAK>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wBmwWvAhxUXwxXenqemulOaXTqCORGbft"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34778 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932981AbbA0VCz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 16:02:55 -0500
In-Reply-To: <1422392516406850652@MailServerPEAK>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wBmwWvAhxUXwxXenqemulOaXTqCORGbft
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2015 10:02 PM, St=C3=A9phane Grosjean wrote:
> Hi Mark,
>=20
> You've got my Ack for this patch.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wBmwWvAhxUXwxXenqemulOaXTqCORGbft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUx/z9AAoJECte4hHFiupUPh4P/jCsIeQkV5ZdF2x4tC9jvJHf
fgO+6/Dko8duBxwP2QOEtzGt9ru/A5cNgzjYPa+b+vxZ0ZTLyQVRrSsQ8G+njdlZ
v/4f6Rw42PHi4aualw9mbjMuoUlB2VrDOlYDJujraOxq2kqq7siHVzjzl8MSz32L
6f4KZRbBn8f0HZ0UVkzScoY/J7iattVSDu0sd6nshV8nMQUA8WXw4wIoiO5Zfsrd
Nxv9YilDOLo5PAn790GEKA3Z6a1eCruWGs/YTJEbZnHJSDDZQ2d60HBjwsWu1083
GqfKAB0hvSFjHu2flsfJjyKYgZ7EYCfyzdjGHqCae4g+fkJUoQsNkBhyDyz+XC7O
IAijOa5eV7U8dAb3rtsZq8S+eY6l7vXH/cS9rXb1PM6Vs3JZou8GIiVJUaNzcZUR
wQNvAzZSRrzdTPb/JrVdXLAXYu5HvIifVjQNmwjeuuuk9HkskPmh8wS9uznF6SWE
LIMVJ3PWo9kWkW5YTZYkAAuXDx2FF4Plujb8Hg/vtHX2bBLte4f2g21+wjxFciox
aFlnmAAWwfKBNa6AYXoS2CCLUXH9XDvEd/WxnvDLRcaVKl09IoHKFwncHlzwMNM2
xfjy5C5mzH7OVQZ+fFxKYj410IH0kEKw3n9vAP1YHQr59C5wHLkcdmkprhVL0+m4
RPKp7PI0t3VzpMDW8o2h
=/rE9
-----END PGP SIGNATURE-----

--wBmwWvAhxUXwxXenqemulOaXTqCORGbft--
