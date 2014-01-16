From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] slcanpty: declare command buffer static
Date: Thu, 16 Jan 2014 17:18:44 +0100
Message-ID: <52D80664.7040809@pengutronix.de>
References: <1389619756-28940-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IEf9LQivbOUBuR3D2RGw3Ia93di1r2QQx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58467 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbaAPQSt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 11:18:49 -0500
In-Reply-To: <1389619756-28940-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IEf9LQivbOUBuR3D2RGw3Ia93di1r2QQx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2014 02:29 PM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> ASCII command buffer char buf[200] must be declared as static,
> because it holds incomplete commands between pty2can() calls.
> Without static it is not guaranteed, that buf retains the same
> data between calls.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Applied to master.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IEf9LQivbOUBuR3D2RGw3Ia93di1r2QQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLYBmQACgkQjTAFq1RaXHMhLgCeJV7gvixNLpdkB+igcyr8cfSh
dgQAnj1fKdkElKFYGg9dxMVMOoK2uHIK
=fs4T
-----END PGP SIGNATURE-----

--IEf9LQivbOUBuR3D2RGw3Ia93di1r2QQx--
