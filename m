From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: check number of channels returned by
 HW
Date: Tue, 11 Feb 2014 11:09:57 +0100
Message-ID: <52F9F6F5.6090209@pengutronix.de>
References: <1392112884-27101-1-git-send-email-olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IxH4KX6bXK3CUKHdKQs0SlEgjtoGncbW6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32931 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaBKKKD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Feb 2014 05:10:03 -0500
In-Reply-To: <1392112884-27101-1-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IxH4KX6bXK3CUKHdKQs0SlEgjtoGncbW6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/11/2014 11:01 AM, Olivier Sobrie wrote:
> It is needed to check the number of channels returned by the HW
> because it cannot be greater than MAX_NET_DEVICES otherwise
> it will crash.
>
> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>

Does this bug occur on any kvaser USB hardware?
However, I think, I'll add stable on Cc

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IxH4KX6bXK3CUKHdKQs0SlEgjtoGncbW6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL59vUACgkQjTAFq1RaXHNGKQCfVV3czMtaYXizUG1ydxdBvXkg
zxAAnjngVNtCOaMT4OX877NTUAzqpMP8
=2wVA
-----END PGP SIGNATURE-----

--IxH4KX6bXK3CUKHdKQs0SlEgjtoGncbW6--
