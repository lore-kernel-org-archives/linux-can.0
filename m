From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: peak: Add support of new USB device
Date: Thu, 13 Apr 2017 16:58:06 +0200
Message-ID: <00d6ad5a-3460-5218-70f7-d7730927384c@pengutronix.de>
References: <1490618171-3128-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="U9aCEDflbKotEtkP0ogf9aCGG6EfQ1EhF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48031 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751139AbdDMVdJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 13 Apr 2017 17:33:09 -0400
In-Reply-To: <1490618171-3128-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U9aCEDflbKotEtkP0ogf9aCGG6EfQ1EhF
Content-Type: multipart/mixed; boundary="M25ewu7h9974il3bfvPx3WvMInlwwqMMN";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <00d6ad5a-3460-5218-70f7-d7730927384c@pengutronix.de>
Subject: Re: [PATCH 0/2] can: peak: Add support of new USB device
References: <1490618171-3128-1-git-send-email-s.grosjean@peak-system.com>
In-Reply-To: <1490618171-3128-1-git-send-email-s.grosjean@peak-system.com>

--M25ewu7h9974il3bfvPx3WvMInlwwqMMN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 02:36 PM, Stephane Grosjean wrote:
> These patches add the support of the PCAN-Chip USB stamp module, as wel=
l as
> fix the help section of the CAN_PEAK_USB Kconfig section.
>=20
> Stephane Grosjean (2):
>   can: usb: Add support of PCAN-Chip USB stamp module
>   can: usb: Kconfig: Add PCAN-USB X6 device in help text
>=20
>  drivers/net/can/usb/Kconfig                  |  2 +
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |  2 +
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 72 ++++++++++++++++++++=
++++++++
>  4 files changed, 78 insertions(+)

Added to can.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--M25ewu7h9974il3bfvPx3WvMInlwwqMMN--

--U9aCEDflbKotEtkP0ogf9aCGG6EfQ1EhF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljvkf4ACgkQHv7KIOw4
HPakLggA1bLRNZg4WgcqT/xV6o3Hy85HGtmcGitSkpv2Qk4WZPMR7J6SL5o0Ov0P
73ogR9u/6OtY7KSCFAhWk16AwA4PBWba5Swdk2MzQaawTiNHmRET8Kw2+A+GjQQ1
iE1DC1QbzBbYrM3xt6xXpzWE4nUy1+HsALz/VgvHDELiSWJ+LHZOZmOhg48hCvrl
z6JdA4chIdu0cvsX1Mk0DggrmPX9dwkAyOwColcrHcSxfiGNRcxWDWqRLqbAZDIp
aFcmGyq7iYMIki5+26cWTZF6YELQkyJrELGSMX51nsCwe0ZaZvUmmOArCy3ccs20
581fy5m9zYf9/uG+DmnU17o9sVs+RA==
=WvtF
-----END PGP SIGNATURE-----

--U9aCEDflbKotEtkP0ogf9aCGG6EfQ1EhF--
