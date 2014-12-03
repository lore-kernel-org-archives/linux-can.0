From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Wed, 03 Dec 2014 11:45:30 +0100
Message-ID: <547EE9CA.8070608@pengutronix.de>
References: <5477A5A3.9070107@pengutronix.de> <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com> <547DD81B.9000403@pengutronix.de> <547EDA21.6030802@peak-system.com> <547EE315.40703@hartkopp.net> <547EE827.2080004@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5UJasNEjN0SJIe62sekdTXdb98X70uH91"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41280 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbaLCKpj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 05:45:39 -0500
In-Reply-To: <547EE827.2080004@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5UJasNEjN0SJIe62sekdTXdb98X70uH91
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2014 11:38 AM, Stephane Grosjean wrote:
> Well I know that. My remark was about two points:
>=20
> - the *kernel 3.4* version of pcan_usb_pro.h defines some data struct
> and constants that are *only* used by pcan_usb_pro.c (see "struct
> pcan_usb_pro_fwinfo", for example). Since it has been acked in the
> mainline in these early times, I simply asked if and when this rule did=

> evolve? Underlying question: what to do now? Should I (also) post
> patches to setup things right between pcan_usb_pro.c and pcan_usb_pro.h=
,
> in order to define (for ex) "struct pcan_usb_pro_fwinfo" in
> pcan_usb_pro.c instead? Or do we let things "as is"?

No need to clean up the .h files already in the kernel. But please stick
to the rule when adding new files.

> - pcan_ucan.h defines some data structs and constants that will be
> common across different kinds of CAN-FD hardwares. How should I include=

> this "pcan_ucan.h" file from a future (for example) PCI CAN-FD driver
> (which, obvioulsy) won't be stored  under "usb/peak_usb" directory).

If it's CAN-FD relevant than it will go under include/linux/can/ somewher=
e.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5UJasNEjN0SJIe62sekdTXdb98X70uH91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfunKAAoJECte4hHFiupUKr0QAJeFTfkNx8cNYCPBDPxWhUi/
6Swn7lN5YgegWSY0AltJv/weKUliWuc450V2WHPUOmcSMH/W7tRVFr8pWaacLaFo
+KmzCKt6a8krgTbGsZNv281QUaZog/iAav9Dxf4dbofNt9iaIAwe8A1z0BJOli2O
rQuBUhWmBzA0d2aA6S2UU4T0m6eBg7X+7BLCXbWhsfG8va4yrC2iTbhBP/JAWbtC
yJakWxvxhVpYtcfs/XcQZERiSjk1IvPpjIrBtOSyW5yqI3gBpvtgIg+/i399isWR
qICHU4z8MyrdzD/L2dZlyBLxds1Q97F846mw3xKHcTi1d6IHHTorRkCTjqhNyaxF
ADXIpWXqkQ9TU6Sr97UNnugyWbvxdIfliCjJAITIqfkX97jHsDI3wM1Kf3MzMFO3
V+NRoY9Pw6RG4df4ykuSDFY74nRT46hMvIm+gTPBwSzXap9WYWFPlqX1Z82qXk1F
giXzISWE5sZzI36R32ZManc4pHqt0itQyURBdqKlHBhzTUYLIWrIUkHAF71rpfOB
oaGDwL4ZxHvZGsPotM7la14DrqIgZsbB5AnCNJ+eGwrL8Pv12ZDci7VbKIT6zr2F
ho4R55jkS7NQC036Uv39m4NEtyfAb4nWaw7zzZLuHfyUkdzV2BiHuXb1saPGn6rP
0uwAoI5tHgmDkmdJtuZL
=lWbg
-----END PGP SIGNATURE-----

--5UJasNEjN0SJIe62sekdTXdb98X70uH91--
