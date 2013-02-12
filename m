From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] candump: Add timeout option if no message has been received
Date: Tue, 12 Feb 2013 15:07:07 +0100
Message-ID: <511A4C8B.3030605@pengutronix.de>
References: <1360665082-14256-1-git-send-email-alexander.stein@systec-electronic.com> <511A1EA1.7050607@pengutronix.de> <2883446.YiNPK9y0c4@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QFPOTGHLFEBJDNOJLPEF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40545 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953Ab3BLOHN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Feb 2013 09:07:13 -0500
In-Reply-To: <2883446.YiNPK9y0c4@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QFPOTGHLFEBJDNOJLPEF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/12/2013 03:05 PM, Alexander Stein wrote:
> On Tuesday 12 February 2013 11:51:13, Marc Kleine-Budde wrote:
>> On 02/12/2013 11:31 AM, Alexander Stein wrote:
>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com=
>
>>
>> I get a new warning with your patch:
>>
>> candump.c:231: warning: 'timeout_config' is used uninitialized in this=

>> function
>>
>> I think the compiler is not smart enough :)
>=20
> Yeah, I think that too :) Which version did you use?
> Both gcc 4.6.3 and clang 3.1 didn't complain.

gcc (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QFPOTGHLFEBJDNOJLPEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEaTI4ACgkQjTAFq1RaXHMB+ACbB/wGgAHe+DvO148xM+3XwRmS
vIQAn2ytEzjn+lmoWFt/98q+rCiBjntN
=nGIz
-----END PGP SIGNATURE-----

------enig2QFPOTGHLFEBJDNOJLPEF--
