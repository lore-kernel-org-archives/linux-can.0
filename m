From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Fwd: Re: (Case 10934) Re: [PATCH v4] can: kvaser_usb: Add support
 for Kvaser CAN/USB devices
Date: Mon, 24 Sep 2012 13:56:29 +0200
Message-ID: <50604A6D.3040809@pengutronix.de>
References: <md5:932bhqRVAAL8C/77La5+vQ==>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig25B06765D320AF9BD54B1330"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48457 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab2IXL4g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Sep 2012 07:56:36 -0400
In-Reply-To: <md5:932bhqRVAAL8C/77La5+vQ==>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Kvaser Support <support@kvaser.com>, db@kvaser.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25B06765D320AF9BD54B1330
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

FYI: Olivier has got a S-o-b from Daniel Berglund from Kvaser for his
USB driver.

regards, Marc

-------- Original Message --------
Subject: Re: (Case 10934) Re: [PATCH v4] can: kvaser_usb: Add support
for Kvaser CAN/USB devices
Date: Mon, 24 Sep 2012 13:23:46 +0200
From: Kvaser Support <support@kvaser.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Olivier Sobrie <olivier@sobrie.be>

Hi again,

I just got the following comments from our head of software development:

--
They can add:
Signed-off-by: Daniel Berglund <db@kvaser.com>

By the way, the following lines are not necessary as the devices will
not be found in the wild:
  - Kvaser Memorator II, Prototype
  - Kvaser Leaf prototype (P010v2 and v3)

and this line:
  - Kvaser Leaf Light (P010v3)
should be just
  - Kvaser Leaf Light
--

Best regards
Jerry Thors=E9n
Kvaser Support
support@kvaser.com
-------------------------------------------------------------------------=
--



-----Original Message-----
From: "Kvaser Support" <support@kvaser.com>
Reply-To: "Kvaser Support" <support@kvaser.com>
Date: Mon, 24 Sep 2012 10:05:36 +02:00
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Olivier Sobrie" <olivier@sobrie.be>
Subject: Re: (Case 10934) Re: [PATCH v4] can: kvaser_usb: Add support
for Kvaser CAN/USB devices

>Hi,
>
>Great, thanks!
>
>Best regards
>Jerry Thors=E9n
>Kvaser Support
>support@kvaser.com
>------------------------------------------------------------------------=
---

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




--------------enig25B06765D320AF9BD54B1330
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBgSnAACgkQjTAFq1RaXHOPwQCcDhj2EicW6ekV02nq57nF0HpY
NrsAn3rZA8LeUTD8jVOtbUJrXT9w3s4w
=oCz+
-----END PGP SIGNATURE-----

--------------enig25B06765D320AF9BD54B1330--
