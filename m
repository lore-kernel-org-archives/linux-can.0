From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 01 Oct 2014 09:15:46 +0200
Message-ID: <542BAA22.7010508@pengutronix.de>
References: <1411995175-13540-1-git-send-email-david@protonic.nl> <2928841.hvxjaQ0ECy@ws-stein> <20141001082932.7f3d69d4@archvile> <1952804.jDdF5Ah5L9@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8FArJuNW7pkkttXDcm4DQow14s8jd8cQA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44169 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaJAHSq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 03:18:46 -0400
In-Reply-To: <1952804.jDdF5Ah5L9@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8FArJuNW7pkkttXDcm4DQow14s8jd8cQA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/01/2014 09:11 AM, Alexander Stein wrote:
> BTW: You posted a patch for at91_can in June (Din't get opportunity
> to try it yet), where you use a kfifo to accomplish the same, why not
> here?

The cyclic buffer approach is okay, from my point of view.

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8FArJuNW7pkkttXDcm4DQow14s8jd8cQA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQrqiUACgkQjTAFq1RaXHNWKgCfQxy15n3zzrvunJCtD+x2jv2o
cukAnjt0p8xLgenBtqKljuP8GqgJ7Smx
=o3jA
-----END PGP SIGNATURE-----

--8FArJuNW7pkkttXDcm4DQow14s8jd8cQA--
