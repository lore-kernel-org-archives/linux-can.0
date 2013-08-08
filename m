From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] pcan_usb: fix wrong memcpy() bytes length
Date: Thu, 08 Aug 2013 15:53:46 +0200
Message-ID: <5203A2EA.7080402@pengutronix.de>
References: <1375951951-18507-1-git-send-email-s.grosjean@peak-system.com> <52036B60.7090701@pengutronix.de> <5203A113.9080207@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LsB3gqhNB3vvUp986xffrJPb6ad232s9r"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52439 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965593Ab3HHNyE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Aug 2013 09:54:04 -0400
In-Reply-To: <5203A113.9080207@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LsB3gqhNB3vvUp986xffrJPb6ad232s9r
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2013 03:45 PM, Stephane Grosjean wrote:
> I'm afraid I don't understand your remark/question below. Can you pleas=
e
> be more precise?

Under Linux we have the concept of stable kernel [1] releases. As this
is a bugfix, I suggested that this patch should be scheduled for the
stable kernel procedure. This is done by adding a "Cc:
<stable@vger.kernel.org>" to the patch description.

I'll add the Cc and push the patch to David, okay :)

Marc

[1]
http://lxr.free-electrons.com/source/Documentation/stable_kernel_rules.tx=
t

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LsB3gqhNB3vvUp986xffrJPb6ad232s9r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIDousACgkQjTAFq1RaXHOfsQCfX9S5xl3VFgHuwlnbP2TOYD//
/FMAniO6gbRhK5oJbXIaoA0CouDEuiPg
=otXO
-----END PGP SIGNATURE-----

--LsB3gqhNB3vvUp986xffrJPb6ad232s9r--
