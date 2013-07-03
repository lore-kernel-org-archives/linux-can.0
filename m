From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: esd_usb2: check index of array before accessing
Date: Wed, 03 Jul 2013 15:04:30 +0200
Message-ID: <51D4215E.7070701@pengutronix.de>
References: <1372840409-13481-1-git-send-email-mkl@pengutronix.de> <1372852299.15632.13.camel@blackbox> <51D41E53.2030900@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2UPKJANAMXCLPOGIQPAGM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42698 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932698Ab3GCNEl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Jul 2013 09:04:41 -0400
In-Reply-To: <51D41E53.2030900@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Fuchs <matthias.fuchs@esd.eu>
Cc: "Max S." <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2UPKJANAMXCLPOGIQPAGM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2013 02:51 PM, Matthias Fuchs wrote:
> On 03.07.2013 13:51, Max S. wrote:
>> On Wed, 2013-07-03 at 12:00 +0200, Matthias Fuchs wrote:
>>> Hi,
>>>
>>> did anybody encounter an issue with invalid net codes comming from th=
e
>>> device?
>> Technically one could write a usb device that sends a bad
>> netcode/crafted message.
>=20
> Yes of course. I only asked if somebody observed an issue with the real=

> device.

There are no known issues with the real device.


Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2UPKJANAMXCLPOGIQPAGM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHUIV4ACgkQjTAFq1RaXHOLxgCcClG16BldIoWowJ4Bn6cP0lh6
3WQAn2hmpSq8GdEkyxIBl9gl5Bl3L07Y
=rECZ
-----END PGP SIGNATURE-----

------enig2UPKJANAMXCLPOGIQPAGM--
