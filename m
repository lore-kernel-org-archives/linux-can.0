From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Getting manufacturer/product name for CAN interface
Date: Wed, 19 Jul 2017 19:52:54 +0200
Message-ID: <c1c3465d-7860-fec3-118e-0a30826fc791@pengutronix.de>
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
 <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
 <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
 <18d6c6fc-fcc2-34d9-a98a-1d2ae4d1e0b1@pengutronix.de>
 <q10u44.otcmiv.1hge1d1-qmf@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="me6tEXiPeCQV0O4wP46gXliwncJmg3VAK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46093 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755271AbdGSRxB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jul 2017 13:53:01 -0400
In-Reply-To: <q10u44.otcmiv.1hge1d1-qmf@gmx.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: aha_1980@gmx.de
Cc: linux-can@vger.kernel.org, Marcel.Birthelmer@microchip.com, wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--me6tEXiPeCQV0O4wP46gXliwncJmg3VAK
Content-Type: multipart/mixed; boundary="lROdtdccDv94DM1w6i1kGnfSic3hbXpxE";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: aha_1980@gmx.de
Cc: linux-can@vger.kernel.org, Marcel.Birthelmer@microchip.com,
 wg@grandegger.com
Message-ID: <c1c3465d-7860-fec3-118e-0a30826fc791@pengutronix.de>
Subject: Re: Getting manufacturer/product name for CAN interface
References: <c3904508-14b9-1ffb-8507-9196fa193f56@gmx.de>
 <955344be-5991-5de9-a705-5f2e480c765d@grandegger.com>
 <5c9a4542-aa3d-c54f-7f83-d7cd3f594a65@gmx.de>
 <18d6c6fc-fcc2-34d9-a98a-1d2ae4d1e0b1@pengutronix.de>
 <q10u44.otcmiv.1hge1d1-qmf@gmx.com>
In-Reply-To: <q10u44.otcmiv.1hge1d1-qmf@gmx.com>

--lROdtdccDv94DM1w6i1kGnfSic3hbXpxE
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 07:42 PM, aha_1980@gmx.de wrote:
>> Does the udev property dev_id help? See
>> http://permalink.gmane.org/gmane.linux.can/5227 for more information.
>=20
> That looks indeed interesting. My Google-foo tells me the patch was
> included in a pull request, so it should be merged to mainline
> Kernel.

Ack.

> Let's see what I can achive.

Please post you solution here, others are probably interested in it, too.=
 :D

regards.
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lROdtdccDv94DM1w6i1kGnfSic3hbXpxE--

--me6tEXiPeCQV0O4wP46gXliwncJmg3VAK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAllvnHYACgkQHv7KIOw4
HPYAwAf/WkIzs8RIxgb5d6V9CNaiwLbwXuTR7ld0rQ71q0D5WCri8GpWQVtFhgXl
mWjk6sYoaWZ4onX1tFlLqhxD921fUIEC3KICRJrQEicwVI6/Eb3LAOSv+Mexzkgg
Pn/GKpxctoavSBMIZOkJ3uV9zOb26Hw2KDE+dEYFDfC0PuIq8qSw454NxuAxMF8b
OqIdpPbl7VgW5i0rkGpGQcKjfRhWhxAZeEZAdaQR7lFvoEIDUOnINAT5lxvDNysI
XQETCN+GeaGoCeiPeBHXz+bvp88sdWP0kfpgN5INsf3+r9JcrTujYUlil+ypBHqc
DfrwyHTbZRE6bqRNL2d2+nLAYgCI5g==
=wVzn
-----END PGP SIGNATURE-----

--me6tEXiPeCQV0O4wP46gXliwncJmg3VAK--
