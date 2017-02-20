From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5/5 v2] can: xilinx_can: fix TX FIFO accounting getting
 out of sync
Date: Mon, 20 Feb 2017 10:42:14 +0100
Message-ID: <49191a70-f9d3-6082-0e9a-975ca15fa2d9@pengutronix.de>
References: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
 <20170213153937.1945-1-anssi.hannula@bitwise.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vV5dtkLwmxbaeGch4eV3upbMBPcPbr1GH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58341 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751409AbdBTJmW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2017 04:42:22 -0500
In-Reply-To: <20170213153937.1945-1-anssi.hannula@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>, stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vV5dtkLwmxbaeGch4eV3upbMBPcPbr1GH
Content-Type: multipart/mixed; boundary="G6h1389n7FuHxknkoNrBLqi2PUlQfodcs";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>,
 stable@vger.kernel.org
Message-ID: <49191a70-f9d3-6082-0e9a-975ca15fa2d9@pengutronix.de>
Subject: Re: [PATCH 5/5 v2] can: xilinx_can: fix TX FIFO accounting getting
 out of sync
References: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
 <20170213153937.1945-1-anssi.hannula@bitwise.fi>
In-Reply-To: <20170213153937.1945-1-anssi.hannula@bitwise.fi>

--G6h1389n7FuHxknkoNrBLqi2PUlQfodcs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/13/2017 04:39 PM, Anssi Hannula wrote:
> The xilinx_can driver assumes that the TXOK interrupt only clears after=

> it has been acknowledged as many times as there have been successfully
> sent frames.
>=20
> However, the documentation does not mention such behavior, instead
> saying just that the interrupt is cleared when the clear bit is set.
>=20
> Similarly, testing seems to also suggest that it is immediately cleared=

> regardless of the amount of frames having been sent. Performing some
> heavy TX load and then going back to idle has the tx_head drifting
> further away from tx_tail over time, steadily reducing the amount of
> frames the driver keeps in the TX FIFO (but not to zero, as the TXOK
> interrupt always frees up space for 1 frame from the driver's
> perspective, so frames continue to be sent) and delaying the local echo=

> frames.
>=20
> The TX FIFO tracking is also otherwise buggy as it does not account for=

> TX FIFO being cleared after software resets, causing
>   BUG!, TX FIFO full when queue awake!
> messages to be output.
>=20
> Since there does not seem to be any way to accurately track the state o=
f
> the TX FIFO, drop the code trying to do that and perform
> netif_stop_queue() based on whether the HW reports the FIFO being full.=

> Driver-side local echo support is also removed as it is not possible to=

> do accurately (relying instead on the CAN core fallback support).
>=20
> Tested with the integrated CAN on Zynq-7000 SoC.
>=20
> v2: Add FIFO space check before TX queue wake with locking to
> synchronize with queue stop. This avoids waking the queue when xmit()
> had just filled it.

Removing the echo on TX-complete should be avoided if possible. Is there
a way to get a indication that an individual package has been send?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--G6h1389n7FuHxknkoNrBLqi2PUlQfodcs--

--vV5dtkLwmxbaeGch4eV3upbMBPcPbr1GH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAliqufYACgkQHv7KIOw4
HPZupQf+OEKCwLrpJ6+V0t7pWTeRqGyAghyUUMzJ90nDc/L0edsAG9x4AvGkOq7V
jQihUlBW6LpCu3K+ZaUqLsSttBbPLyPul8aUXzUJecZlylMhf2MmQv7n0ogUfHKY
JJD2+9+SYWHN/CpRVAAuWa3/rLIcTAXMi+4AbMK8f8edeQiHIFmK0HhPX+7x5i09
ld65VI47sXXG4/L115aDt9LdL5l4FIZUQ/9ukFH2PGO1bNw/EH8/X9V7D6IBdspr
qPHStzqYXrg8D1yZc+aaWPtDumjz2jhSksOLQr9nlWMRKbsm/TvUuN4j6W8jnMUb
i2QaPskMGpOhz2+omtvgQ6wkCwqFwQ==
=ePD+
-----END PGP SIGNATURE-----

--vV5dtkLwmxbaeGch4eV3upbMBPcPbr1GH--
