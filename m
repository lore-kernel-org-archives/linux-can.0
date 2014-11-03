From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 12/15] can: flexcan: Add support for RX-FIFO.
Date: Mon, 03 Nov 2014 12:26:21 +0100
Message-ID: <5457665D.9030008@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl> <1412956020-21489-13-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fwW5vgeMJSPaMB3SwhCVsHWL8u5GcwLUE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37853 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbaKCL0Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 06:26:25 -0500
In-Reply-To: <1412956020-21489-13-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fwW5vgeMJSPaMB3SwhCVsHWL8u5GcwLUE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2014 05:46 PM, David Jander wrote:
> This adds support for RX-FIFO simulating a FIFO from a linear array of =
message-
> boxes. This breaks RTR reception on flexcan older than V10.

Breaking things in one patch and fixing them later is not a good idea.
Please squash this patch into 4/15, so that we don't have an
intermediate non-rx-fifo flexcan driver.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fwW5vgeMJSPaMB3SwhCVsHWL8u5GcwLUE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV2ZdAAoJECte4hHFiupUxAAQAIAxe/llvih+K/z539xxzUK8
qr5zgLD44Eqd4Pe1xEhopvYQtywKed8Zohw3z5SBWRn5xCunlPZxSDhk2c44QkFD
rS9kAR+9tmpShLdRf7fCpFQO4QfWbvTJr6N0oy1WFxhlRjatez6nzf8y5BJav7pf
XqXPdkb0kycRV8xUB6dvsMujvtqrTKu8rlq7qQoMhq+ZrZI0FgdbBcc97RggNei3
fNFxLQfxb2HjS7XVwtdsNEPRyecYRdLu8jwFGALGAy2iRP1ktGKc9XyhzD2+ChgB
lwdnHtLHh/ZbSyHKfR1st8r183kwctWB/MQZTdvKeymmoH2UfFJ+UkWcTtr/M7uT
IbtbP3Cu0nvuRitlaexcLoazc9jimSnsOIHw8kByoGNzc0uFhJTCtkl2zpuU3GgQ
p6t2A42dD5CL+AuRrJtKsEjRuNMA+mMP0xbbxiiB7CGw3ZFEI7rPwxJ2CHQ4xOal
RxzQ6dfEokollFeYYaKtQ1BzsqcmSyK/uxHZGqu3BSWsawFmX0lB8TOCseQxE8B4
UsRxpN9aIDEtP+aVxVd3+i+BFYT4+snH7z0eryQAF5ToXUaMelzLu/qAhh4PsWRy
7nsqEb1dndh0i0pHOZvRxp528CyQdYWjVF8b1oBA4i0M2OBGN5A/LbWKCtHopQBf
SRYaQnDW138j26e78lXS
=+ZU6
-----END PGP SIGNATURE-----

--fwW5vgeMJSPaMB3SwhCVsHWL8u5GcwLUE--
