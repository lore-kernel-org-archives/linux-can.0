From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 15/15] can: flexcan: Re-enable RTR reception support for
 older flexcan IPs
Date: Mon, 03 Nov 2014 13:02:21 +0100
Message-ID: <54576ECD.4010303@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl> <1412956020-21489-16-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="N3CVCWE6n7JDCb71CRbl7vDJIXJTfAXse"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33545 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaKCMC0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 07:02:26 -0500
In-Reply-To: <1412956020-21489-16-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N3CVCWE6n7JDCb71CRbl7vDJIXJTfAXse
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2014 05:47 PM, David Jander wrote:
> Flexcan IPs prior to V10 need to work in FIFO mode in order to be able
> to receive RTR frames, so restore FIFO-mode for older IPs while still
> using rx-fifo IRQ offloading.

Please squash, so that we don't have a non functional driver in the mean
time.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--N3CVCWE6n7JDCb71CRbl7vDJIXJTfAXse
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV27NAAoJECte4hHFiupUuGoQAJIycMxi6Kg9kErrqGBdCCM2
P2zVnZouUCnaTJlQgHGkrCbmnNClFU6acII2sdssIVOxQ554aLzYABLtjA11W9fL
KKz7F2gChnmAX86tMbY7pLDAEIgE+/4eXJPGYz7cSAV8lzw97k0NjXEQJ4IT0xQS
tYmrY0U2s+n6iz72KzdgLQWVdsN8F3Rfo5Zh6mRXWjWFYIP9AElBafstz1J0EQbm
4xgQ4BxxDXXOEP6AIVnh9whfMlrwfebva1dkJKCnd9vns+/mAS8656du6L8koaiJ
NWFmTmdbtl3sv3V6Xzb+SBm2ZmmxKQZMPdXKTvgr+EQtHCY1malTZTBqgvY078m2
I7X/xWyY4rQFUi47MXEztiq13+awv+t0mfWhPn9XhBdaUznI8qrfq9P8znprhlTa
TTdx5biWQGsvOKMDZTia/L+jSaWuf3iAdG7c268ewxLvRLW9h278ytyb0VNaxfFf
QJqjoQEX9IlI8uGiN71S0JWrgx1avK9nL+NV5AenwMDBiDq37jlfrPBD5wB+kJaN
AH0Va8Go0p1Cyahgtw7DrYdnOOsIJAbj43jlFA/8JrW1vHgdoSvKS7St8yKym9ua
ncui+qHeRh5brWTUFIF+z7a5MlPFJy5HtQB16Mr1NulDLFN/pq0wcwZpT7dVN9UA
oADAL6foIjOSF1PnY5Qv
=KqXw
-----END PGP SIGNATURE-----

--N3CVCWE6n7JDCb71CRbl7vDJIXJTfAXse--
