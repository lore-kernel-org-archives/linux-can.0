From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: add ability to allocate CANFD frame in skb data
Date: Wed, 15 Jan 2014 13:58:46 +0100
Message-ID: <52D68606.1050103@pengutronix.de>
References: <1389775813-14838-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ThXAb1GndWKxb11QwiwLVvvF77ptdPIwN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59611 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaAOM7G (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Jan 2014 07:59:06 -0500
In-Reply-To: <1389775813-14838-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ThXAb1GndWKxb11QwiwLVvvF77ptdPIwN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2014 09:50 AM, Stephane Grosjean wrote:
> This patch adds the ability of allocating a CANFD frame data structure =
in the
> skb data area.

Do you have real CANFD hardware?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ThXAb1GndWKxb11QwiwLVvvF77ptdPIwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLWhgYACgkQjTAFq1RaXHM8sQCfVxfpTe/+4vQLSoWrFB/opCmf
uq0AniB16jYpkxu7nQmIALAIAbIOiBFJ
=FFDZ
-----END PGP SIGNATURE-----

--ThXAb1GndWKxb11QwiwLVvvF77ptdPIwN--
