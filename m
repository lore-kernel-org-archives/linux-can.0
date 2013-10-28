From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: fix usb endpoints detection
Date: Mon, 28 Oct 2013 10:25:42 +0100
Message-ID: <526E2D96.5050106@pengutronix.de>
References: <1382908073-6865-1-git-send-email-olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PHUQK9GAfqB24AWt6pDLPB37qIUQq8MFo"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38436 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab3J1JZu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 05:25:50 -0400
In-Reply-To: <1382908073-6865-1-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PHUQK9GAfqB24AWt6pDLPB37qIUQq8MFo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2013 10:07 PM, Olivier Sobrie wrote:
> Some devices, like the Kvaser Memorator Professional, have several
> bulk in endpoints. Only the first one found should be used by the
> driver. The same holds for the bulk out endpoint.

Is this a critical fix? Does the hardware work without this patch?
Should I add stable on Cc?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PHUQK9GAfqB24AWt6pDLPB37qIUQq8MFo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJuLZYACgkQjTAFq1RaXHM8uQCeMtUs1MlX2Zk9TZYiKPAQjiL1
DFoAnAuPxte8EbUb/ay3OS5OR0ghTJ1l
=6yF1
-----END PGP SIGNATURE-----

--PHUQK9GAfqB24AWt6pDLPB37qIUQq8MFo--
