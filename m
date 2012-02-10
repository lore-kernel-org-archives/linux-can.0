From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] socketcan in barebox bootloader
Date: Fri, 10 Feb 2012 09:55:30 +0100
Message-ID: <4F34DB82.2050603@pengutronix.de>
References: <OF32B6D01B.4E8430B8-ONC125799E.0055E20B-C125799E.00563FFD@o0802.rafi.inhouse> <1328824647.5414.10.camel@slaptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDDACDC8D11CAD60A4735D08A"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55604 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757927Ab2BJIzc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Feb 2012 03:55:32 -0500
In-Reply-To: <1328824647.5414.10.camel@slaptop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <king@greatfreeworld.org>
Cc: socketcan-users@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDACDC8D11CAD60A4735D08A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Now with linux-can on Cc :)

On 02/09/2012 10:57 PM, Max S. wrote:
> CAN is meant for control messages, not for media, or data transfer.

In the automotive world it's quite common to do firmware updates over CAN=
=2E

> That aside, I do use CAN to flash AVR microchips. It can take a few
> minutes though.

What throughput do you usually get when updating over CAN?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




--------------enigDDACDC8D11CAD60A4735D08A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8024IACgkQjTAFq1RaXHP7nQCePBcjA5PYhNK0R542pw8CBxo9
LgIAnRA3RVEd/rIpy5f1ELdx9TtfVeu+
=GrNu
-----END PGP SIGNATURE-----

--------------enigDDACDC8D11CAD60A4735D08A--
