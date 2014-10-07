From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC PATCH 1/2] can: rx-fifo: Increase MB size limit from 32
 to 64
Date: Tue, 07 Oct 2014 15:17:20 +0200
Message-ID: <5433E7E0.4050007@pengutronix.de>
References: <20141006131751.75823c82@archvile> <1412674205-23882-1-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NSpn7ApdxXk9iueUN4FukL10oN9wbkeJr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35721 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbaJGNR3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Oct 2014 09:17:29 -0400
In-Reply-To: <1412674205-23882-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NSpn7ApdxXk9iueUN4FukL10oN9wbkeJr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/07/2014 11:30 AM, David Jander wrote:
> Signed-off-by: David Jander <david@protonic.nl>

Applied to the rx-fifo branch. I can rebase the branch if you need e.g.
v3.17....

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NSpn7ApdxXk9iueUN4FukL10oN9wbkeJr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQz5+AACgkQjTAFq1RaXHM9ZQCfTWE3JcmbdVMCXxPuW0EgNc6v
VMIAnj0u5ChBitNCrwekXZN3jcgbqrWv
=Slcp
-----END PGP SIGNATURE-----

--NSpn7ApdxXk9iueUN4FukL10oN9wbkeJr--
