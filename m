From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: facing some problem with flexcan driver
Date: Wed, 15 May 2013 11:30:42 +0200
Message-ID: <519355C2.2050502@pengutronix.de>
References: <CALUo3F9Zmx-rOCOmBone6b-nu3G_0bfOjL1Npp=ku=2fBHpTJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WUHNKIUHGQGVVFXLXIRM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38587 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab3EOJau (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 05:30:50 -0400
In-Reply-To: <CALUo3F9Zmx-rOCOmBone6b-nu3G_0bfOjL1Npp=ku=2fBHpTJw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ashutosh Singh <ashuleapyear@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WUHNKIUHGQGVVFXLXIRM
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Ashu,

please use the linux-can mailing list (Cc'ed).

On 05/10/2013 04:31 PM, Ashutosh Singh wrote:
> I trying to use this driver for freescale vybrid processor VF600.
>=20
> I just modify the below structure
>=20
> static struct platform_device_id flexcan_devtype[] =3D {
>         {
>                 .name =3D "imx25-flexcan",
>                 .driver_data =3D FLEXCAN_VER_3_0_0,
>         }, {
>                 .name =3D "imx28-flexcan",
>                 .driver_data =3D FLEXCAN_VER_3_0_4,
>         }, {
>                 .name =3D "imx35-flexcan",
>                 .driver_data =3D FLEXCAN_VER_3_0_0,
>         }, {
>                 .name =3D "imx53-flexcan",
>                 .driver_data =3D FLEXCAN_VER_3_0_0,
>         }, {
>                 .name =3D "imx6q-flexcan",
>                 .driver_data =3D FLEXCAN_VER_10_0_12,
>         }, {
>                 .name =3D "mvf-flexcan",
>                 .driver_data =3D FLEXCAN_VER_10_0_12,
>         },
>=20
> };

Tip: use "git diff" to illustrate your changes.

[...]

> # canconfig can0 bitrate 50000 ctrlmode triple-sampling on
>=20
> Unhandled fault: external abort on non-linefetch (0x1008) at 0x9087801c=

> Internal error: : 1008 [#1]
> Modules linked in:
> CPU: 0    Not tainted  (3.0.15-ts-armv7l-gf141ea3-dirty #18)
> PC is at flexcan_get_berr_counter+0xc/0x38
> LR is at can_fill_info+0xf0/0x150
> pc : [<8025c6f4>]    lr : [<80258454>]    psr: a0000013
> sp : 8f961b80  ip : 00000018  fp : 00000000
> r10: 8f9995b4  r9 : 805f48f0  r8 : 8f99958c
> r7 : 805ca7b0  r6 : 8f961ba0  r5 : 8f86e180  r4 : 8f961ba4
> r3 : 90878000  r2 : 00000000  r1 : 8f961ba4  r0 : 8fe22800
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c53c7d  Table: 8f97c059  DAC: 00000015
> Process canconfig (pid: 806, stack limit =3D 0x8f9602e8)
> Stack: (0x8f961b80 to 0x8f962000)

[...]

> [<8025c6f4>] (flexcan_get_berr_counter+0xc/0x38) from [<80258454>]
> (can_fill_info+0xf0/0x150)
> [<80258454>] (can_fill_info+0xf0/0x150) from [<802e8710>]
> (rtnl_fill_ifinfo+0x5b0/0x76c)

This means the driver is in the flexcan_get_berr_counter() [1] function
when the oops happens. The driver accesses the hardware to read the ecr
register (offset 0x1c) [2].

Please check if the flexcan in the vybrid still has the ecr register at
offset 0x1c. The next thing might be, that in this flexcan design the
clock gating has improved and access to the ecr register is only valid
if the clock(s) is/are switched on. Please check if this patch (totally
untested) helps:

-------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
-----
commit 28c17d5a382912ee66ed5476616b3d64d425a3e0
Author: Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Wed May 15 11:28:38 2013 +0200

    net: can: flexcan: switch on clocks before accessing ecr register

    Reported-by: Ashutosh Singh <ashuleapyear@gmail.com>
    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4a40a18..71983c8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -302,7 +302,13 @@ static int flexcan_get_berr_counter(const struct
net_device *dev,
 {
        const struct flexcan_priv *priv =3D netdev_priv(dev);
        struct flexcan_regs __iomem *regs =3D priv->base;
-       u32 reg =3D flexcan_read(&regs->ecr);
+       u32 reg;
+
+       clk_prepare_enable(priv->clk_ipg);
+       clk_prepare_enable(priv->clk_per);
+       reg =3D flexcan_read(&regs->ecr);
+       clk_disable_unprepare(priv->clk_per);
+       clk_disable_unprepare(priv->clk_ipg);

        bec->txerr =3D (reg >> 0) & 0xff;
        bec->rxerr =3D (reg >> 8) & 0xff;

-------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
-----

[1] http://lxr.free-electrons.com/source/drivers/net/can/flexcan.c#L300
[2] http://lxr.free-electrons.com/source/drivers/net/can/flexcan.c#L305

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2WUHNKIUHGQGVVFXLXIRM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGTVcYACgkQjTAFq1RaXHNUbgCePlb1DO2LmNhxxlRxoefvbkeS
zB0AnjGv3PdBDz/JzB7q5UMyteBvtK4y
=fn+1
-----END PGP SIGNATURE-----

------enig2WUHNKIUHGQGVVFXLXIRM--
