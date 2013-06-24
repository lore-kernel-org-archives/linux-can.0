From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Receiving messages issue
Date: Mon, 24 Jun 2013 15:36:07 +0200
Message-ID: <51C84B47.3090309@pengutronix.de>
References: <CAOHwv57B+vq6aTc-Yep9jZvxbnQ0Bpe2149KMSe1On93OACDjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2FMUNRUXSAJHQVTHBCCPB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58098 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab3FXNgO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Jun 2013 09:36:14 -0400
In-Reply-To: <CAOHwv57B+vq6aTc-Yep9jZvxbnQ0Bpe2149KMSe1On93OACDjg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luka Rahne <luka.rahne@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FMUNRUXSAJHQVTHBCCPB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/24/2013 02:26 PM, Luka Rahne wrote:
> I am using MCP2515 with  i.MX27

MCP2515 is the second worst CAN hardware I know. Only MCP2510 is worse.

You can try Andre B. Oliveira's async mcp2515 driver. It's here:

http://git.pengutronix.de/?p=3Dmkl/linux.git;a=3Dshortlog;h=3Drefs/heads/=
can/mcp2515-async

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2FMUNRUXSAJHQVTHBCCPB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHIS0oACgkQjTAFq1RaXHNknQCePX9U2YLdK5ZRVJ6nCcghLgm6
xqMAn38LFJ4jMBQRRRdDJE2XPxM/zuZ0
=2Rej
-----END PGP SIGNATURE-----

------enig2FMUNRUXSAJHQVTHBCCPB--
