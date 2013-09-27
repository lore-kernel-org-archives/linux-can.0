From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Fri, 27 Sep 2013 12:14:21 +0200
Message-ID: <52455A7D.6030403@pengutronix.de>
References: <21060.15934.600859.167074@ipc1.ka-ro> <524455FD.7070808@pengutronix.de> <20130926155422.GQ12758@n2100.arm.linux.org.uk> <52445FBE.4060503@ti.com> <21061.20097.221946.197751@ipc1.ka-ro> <5245535F.6020804@pengutronix.de> <21061.22576.404020.384558@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6AaJawueEPUMPTCGNCPDcwTC3J643G5E9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47631 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab3I0KOf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Sep 2013 06:14:35 -0400
In-Reply-To: <21061.22576.404020.384558@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6AaJawueEPUMPTCGNCPDcwTC3J643G5E9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2013 12:04 PM, Lothar Wa=C3=9Fmann wrote:

>> They layout of the flexcan varies in the different imx chips. I'm
>> comparing the datasheets at the moment. As Russell pointed out the are=
a
>> staring at offset 0x80 is by the reception FIFO engine.
>>
> The layout is correct when the Rx FIFO is disabled!
>=20
> removing 'FLEXCAN_MCR_FEN' from the MCR setting makes the driver work
> as expected (just without receive fifo).
>=20
> For the use case with the FIFO enabled, the layout has to be changed
> obviously.

Can you just remove the loop completely? I think it's not needed. It
was in the original driver, when I picked it up.

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e1ac75d..57ee3df 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -778,17 +778,6 @@ static int flexcan_chip_start(struct net_device *dev=
)
        netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl);=

        flexcan_write(reg_ctrl, &regs->ctrl);

-       for (i =3D 0; i < ARRAY_SIZE(regs->cantxfg); i++) {
-               flexcan_write(0, &regs->cantxfg[i].can_ctrl);
-               flexcan_write(0, &regs->cantxfg[i].can_id);
-               flexcan_write(0, &regs->cantxfg[i].data[0]);
-               flexcan_write(0, &regs->cantxfg[i].data[1]);
-
-               /* put MB into rx queue */
-               flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
-                       &regs->cantxfg[i].can_ctrl);
-       }
-
        /* acceptance mask/acceptance code (accept everything) */
        flexcan_write(0x0, &regs->rxgmask);
        flexcan_write(0x0, &regs->rx14mask);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6AaJawueEPUMPTCGNCPDcwTC3J643G5E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJFWn0ACgkQjTAFq1RaXHMcvACeM4vPdmJCIfIZpNiFsGGMHE7a
pggAnAvM9+tTA7Nl8tWbQO8HM6HJUXcU
=vayJ
-----END PGP SIGNATURE-----

--6AaJawueEPUMPTCGNCPDcwTC3J643G5E9--
