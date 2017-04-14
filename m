From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Several patches mainline status
Date: Fri, 14 Apr 2017 17:22:16 +0200
Message-ID: <7bd99678-d8f5-390e-833a-7bb2738caec7@pengutronix.de>
References: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
 <11876946-e619-3141-af51-b1c98ac3ace5@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iE78qG6lVEsmnp0R0iha2xFFqOFLHdjon"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46905 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751720AbdDNPW1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 11:22:27 -0400
In-Reply-To: <11876946-e619-3141-af51-b1c98ac3ace5@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, "Huettel Mario (AE/PJ-SCI1)" <Mario.Huettel@de.bosch.com>, "mario.huettel@gmx.net" <mario.huettel@gmx.net>, Mario Kicherer <dev@kicherer.org>, Andreas Werner <andreas.werner@men.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iE78qG6lVEsmnp0R0iha2xFFqOFLHdjon
Content-Type: multipart/mixed; boundary="U261WS8f4HG3cfHQfcv4MnscDSAEli633";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Stephane Grosjean <s.grosjean@peak-system.com>,
 =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
 <remigiusz.kollataj@mobica.com>,
 "Huettel Mario (AE/PJ-SCI1)" <Mario.Huettel@de.bosch.com>,
 "mario.huettel@gmx.net" <mario.huettel@gmx.net>,
 Mario Kicherer <dev@kicherer.org>, Andreas Werner <andreas.werner@men.de>
Message-ID: <7bd99678-d8f5-390e-833a-7bb2738caec7@pengutronix.de>
Subject: Re: Several patches mainline status
References: <c764c3d1-6248-0273-5c20-b401051c818a@hartkopp.net>
 <11876946-e619-3141-af51-b1c98ac3ace5@hartkopp.net>
In-Reply-To: <11876946-e619-3141-af51-b1c98ac3ace5@hartkopp.net>

--U261WS8f4HG3cfHQfcv4MnscDSAEli633
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 03:53 PM, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> here's my list of pending patches to be considered for upstream:
>=20
> [PATCH v4 0/4] can: peak: Add support for PCAN-PCIe FD cards
> STATUS: we both reviewed this patch -> should be ok
> http://marc.info/?l=3Dlinux-can&m=3D148483988920494&w=3D2

added to can

> [PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
> STATUS: We introduced infrastructure (fixed bitrate/termination)
> http://marc.info/?l=3Dlinux-can&m=3D148534935211400&w=3D2

reviewed

> [PATCH v4 1/7] can: m_can: (upgrade to newer IP cores)
> STATUS: we both reviewed this patch & tested by Quentin Schulz
> For that reason I would suggest to upstream Mario's v4 patch set:
>=20
> http://marc.info/?l=3Dlinux-can&m=3D149165343604033&w=3D2
> http://marc.info/?l=3Dlinux-can&m=3D149165343304029&w=3D2
> http://marc.info/?l=3Dlinux-can&m=3D149165343304030&w=3D2
> http://marc.info/?l=3Dlinux-can&m=3D149165343604031&w=3D2
> http://marc.info/?l=3Dlinux-can&m=3D149165343604032&w=3D2
> http://marc.info/?l=3Dlinux-can&m=3D149165343804036&w=3D2
> http://marc.info/?l=3Dlinux-can&m=3D149165343704035&w=3D2

added to can-next

> [PATCH RESEND] net: can: Introduce MEN 16Z192-00 CAN controller driver
> STATUS: No review so far?
> http://marc.info/?l=3Dlinux-can&m=3D146952497113100&w=3D2
> http://marc.info/?l=3Dlinux-can&m=3D146857017211840&w=3D2

reviewed - added info@men.de on Cc :)

> [PATCH can-next] can: fix initial calculation of total rx/tx rate in CA=
N=20
> statistics
> STATUS: integrated into following netns complete patch
> http://marc.info/?l=3Dlinux-can&m=3D146779206204365&w=3D2

ok - so superseded.

> [PATCH RFC v2] can: complete initial namespace support
> STATUS: completes & fixes initial netns patch
> http://marc.info/?l=3Dlinux-can&m=3D149182812827576&w=3D2

I've split this patch, into the fix memleak and the rest.
added to can-next

> And now (brandnew):
> [PATCH] can: introduce CANFD_FDF flag for mixed content in struct=20
> canfd_frame
> STATUS: Was sitting for some time on my box. NVIDIA is doing similar=20
> stuff in their BSP for their Drive PX2
> http://marc.info/?l=3Dlinux-can&m=3D149191823322125&w=3D2

Please explain the usecase more, I don't get it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--U261WS8f4HG3cfHQfcv4MnscDSAEli633--

--iE78qG6lVEsmnp0R0iha2xFFqOFLHdjon
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljw6SgACgkQHv7KIOw4
HPaV+wf9Ft8VVxLdSJcJtPZCUzj3JY5MEpIhH0DyXIX4u17nQmtLPaAgCNHrAvK9
gFzRyzbCQ1nvv2Yok+eEJFau7gCDHmkYrgnwGZGrFwr0YddJBSkPMxgOtxe1UvtQ
eBj0ciIN87cq52vYuQn0itQ2V2Cb1eElKj182/p8Rgpfhf6Fc8MAGjn5+ZhhQA8U
0lzNRJAZACdPJlkXEslg7xOL9quhZXG3czHo5ByLubl2oeoJb75ThJXEzLdCK8pP
q/QNlXpeMLaSJpTtJN/yIuTqUIq89c59iOx4yhgW88QUjsixrWeu2/EflkcE3nz7
y5YI6q6GZDZNuIbZjjMQkGXlR1f4Dw==
=nbp8
-----END PGP SIGNATURE-----

--iE78qG6lVEsmnp0R0iha2xFFqOFLHdjon--
