From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Fri, 27 Sep 2013 10:59:23 +0200
Message-ID: <21061.18667.822159.317689@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
	<524455FD.7070808@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:58335 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab3I0I76 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Sep 2013 04:59:58 -0400
In-Reply-To: <524455FD.7070808@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Marc Kleine-Budde writes:
> On 09/26/2013 04:01 PM, Lothar Wa=C3=9Fmann wrote:
> > Hi,
> >=20
> > when enabling the can interface with 'ifconfig can0 up' (after
> > configuring the bitrate with canconfig) on an i.MX6Q board (TX6) I'=
m
> > getting the following kernel dump:
> >=20
> > |flexcan 2094000.flexcan can0: writing ctrl=3D0x0a212003
> > |flexcan 2094000.flexcan can0: flexcan_set_bittiming: mcr=3D0x59800=
00f ctrl=3D0x0a212003
> > |flexcan 2094000.flexcan can0: flexcan_chip_start: writing mcr=3D0x=
79a2020f
> > |flexcan 2094000.flexcan can0: flexcan_chip_start: writing ctrl=3D0=
x0a21ac53
> > |Unhandled fault: imprecise external abort (0x1c06) at 0x00057adc
>=20
> Looks like a NULL pointer deref to me. But it doesn't make any sense,
> because the offset is way beyond the length of the struct flexcan_reg=
s.
>=20
Since it is an 'imprecise' external abort the access is obviously not
directly related to a CPU write, but rather caused by DMA access (by
the flexcan controller). But I cannot imagine why the flexcan
controller would want to access memory when clearing the control word
of the second mailbox.

> > The same kernel/driver works perfectly well on an i.MX53 based boar=
d.
>=20
> Just to be sure, can you boot with one CPU only.
>=20
same result.

> > The data abort happens upon writing to can_ctrl in the second run o=
f
> > this loop in flexcan_chip_start():
> > |	for (i =3D 0; i < ARRAY_SIZE(regs->cantxfg); i++) {
> > |		flexcan_write(0, &regs->cantxfg[i].can_ctrl);
> > ----------------^ crashes here with i =3D 1
>=20
> Can you instrument flexcan_write().
>
I applied the following patch:
--- .pc/flexcan-debug2/drivers/net/can/flexcan.c	2013-09-27 10:48:23.94=
0490850 +0200
+++ drivers/net/can/flexcan.c	2013-09-27 10:56:17.108489543 +0200
@@ -248,8 +248,28 @@ static inline void flexcan_write(u32 val
 	out_be32(addr, val);
 }
 #else
-static inline u32 flexcan_read(void __iomem *addr)
+#ifdef DEBUG
+#define LINE_OFFS 21
+#define flexcan_read(a)	flexcan_dbg_read(a, __func__, __LINE__)
+static inline u32 flexcan_dbg_read(void __iomem *addr,
+				const char *fn, int ln)
 {
+	u32 val =3D readl(addr);
+	printk("%s@%d: read %08x from %p\n", fn, ln - LINE_OFFS, val, addr);
+	return val;
+}
+
+#define flexcan_write(v, a)	flexcan_dbg_write(v, a, __func__, __LINE__=
)
+static inline void flexcan_dbg_write(u32 val, void __iomem *addr,
+				const char *fn, int ln)
+{
+	printk("%s@%d: writing %08x to %p\n", fn, ln - LINE_OFFS, val, addr);
+	writel(val, addr);
+}
+#else
+static inline u32 flexcan_dbg_read(void __iomem *addr)
+{
+	u32 val =3D readl(addr);
 	return readl(addr);
 }
=20
@@ -257,6 +277,7 @@ static inline void flexcan_write(u32 val
 {
 	writel(val, addr);
 }
+#endif /* DEBUG */
 #endif
=20
 static inline int flexcan_has_and_handle_berr(const struct flexcan_pri=
v *priv,

This now leads to a hang or a: "BUG: recent printk recursion!"
(obviously because the data abort is induced while the printk() is
being executed).

The line numbers printed are adjusted to match the original kernel
source:
|CAN device driver interface
|flexcan_chip_disable@286: read 5980000f from c0ae8000
|flexcan_chip_disable@288: writing d980000f to c0ae8000
|register_flexcandev@952: read 00000000 from c0ae8004
|register_flexcandev@954: writing 00002000 to c0ae8004
|flexcan_chip_enable@274: read d890000f from c0ae8000
|flexcan_chip_enable@276: writing 5890000f to c0ae8000
|register_flexcandev@959: read 5980000f from c0ae8000
|register_flexcandev@962: writing 7980000f to c0ae8000
|register_flexcandev@969: read 7980000f from c0ae8000
|flexcan_get_berr_counter@296: read 00000000 from c0ae801c
|flexcan_chip_disable@286: read 7980000f from c0ae8000
|flexcan_chip_disable@288: writing f980000f to c0ae8000
|flexcan 2090000.flexcan: device registered (reg_base=3Dc0ae8000, irq=3D=
142)
|flexcan_chip_disable@286: read 5980000f from c0af0000
|flexcan_chip_disable@288: writing d980000f to c0af0000
|register_flexcandev@952: read 00000000 from c0af0004
|register_flexcandev@954: writing 00002000 to c0af0004
|flexcan_chip_enable@274: read d890000f from c0af0000
|flexcan_chip_enable@276: writing 5890000f to c0af0000
|register_flexcandev@959: read 5980000f from c0af0000
|register_flexcandev@962: writing 7980000f to c0af0000
|register_flexcandev@969: read 7980000f from c0af0000
|flexcan_get_berr_counter@296: read 00000000 from c0af001c
|flexcan_chip_disable@286: read 7980000f from c0af0000
|flexcan_chip_disable@288: writing f980000f to c0af0000
|flexcan 2094000.flexcan: device registered (reg_base=3Dc0af0000, irq=3D=
143)
|flexcan_get_berr_counter@296: read 00000000 from c0ae801c
|flexcan_get_berr_counter@296: read 00000000 from c0af001c
|flexcan_get_berr_counter@296: read 00000000 from c0ae801c
|flexcan_get_berr_counter@296: read 00000000 from c0af001c
|flexcan_chip_enable@274: read f890000f from c0ae8000
|flexcan_chip_enable@276: writing 7890000f to c0ae8000
|flexcan_chip_start@713: writing 02000000 to c0ae8000
|flexcan_chip_start@716: read 5980000f from c0ae8000
|flexcan_set_bittiming@664: read 00002000 from c0ae8004
|flexcan 2090000.flexcan can0: writing ctrl=3D0x0a212003
|flexcan_set_bittiming@688: writing 0a212003 to c0ae8004
|flexcan_set_bittiming@692: read 5980000f from c0ae8000
|flexcan_set_bittiming@692: read 0a212003 from c0ae8004
|flexcan 2090000.flexcan can0: flexcan_set_bittiming: mcr=3D0x5980000f =
ctrl=3D0x0a212003
|flexcan_chip_start@738: read 5980000f from c0ae8000
|flexcan 2090000.flexcan can0: flexcan_chip_start: writing mcr=3D0x79a2=
020f
|flexcan_chip_start@743: writing 79a2020f to c0ae8000
|flexcan_chip_start@757: read 0a212003 from c0ae8004
|flexcan 2090000.flexcan can0: flexcan_chip_start: writing ctrl=3D0x0a2=
1ac53
|flexcan_chip_start@773: writing 0a21ac53 to c0ae8004
|flexcan_chip_start@776: writing 00000000 to c0ae8080
|flexcan_chip_start@777: writing 00000000 to c0ae8084
|flexcan_chip_start@778: writing 00000000 to c0ae8088
|flexcan_chip_start@779: writing 00000000 to c0ae808c
|flexcan_chip_start@783: writing 04000000 to c0ae8080
|flexcan_chip_start@776: writing 00000000 to c0ae8090

here the CPU either hangs or continues with:

|BUG: recent printk recursion!
|Internal error: : 1c06 [#1] SMP ARM
|Modules linked in: flexcan can_dev snd_soc_imx_sgtl5000 snd_soc_fsl_ss=
i imx_pcm_dma snd_soc_imx_audmux snd_soc_s
|gtl5000 snd_soc_core regmap_spi snd_pcm_dmaengine snd_pcm snd_timer sn=
d_page_alloc evdev snd_compress snd regmap
|_i2c edt_ft5x06
|CPU: 0 PID: 1271 Comm: ifconfig Not tainted 3.12.0-rc1-next-20130919-k=
aro+ #95
|task: beb83500 ti: be178000 task.ti: be178000
|PC is at vprintk_emit+0x11c/0x4c4
|LR is at vprintk_emit+0x108/0x4c4
|pc : [<8004f908>]    lr : [<8004f8f4>]    psr: 60000093
|sp : be179db8  ip : 00000000  fp : 00000000
|r10: c0ae8004  r9 : 00000000  r8 : 00000000
|r7 : 00000000  r6 : ffffffff  r5 : 8061b930  r4 : 00000000
|r3 : 805f47a4  r2 : 000010ab  r1 : 00000000  r0 : 00000000
|Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
|Control: 10c5387d  Table: 4e1a404a  DAC: 00000015
|Process ifconfig (pid: 1271, stack limit =3D 0xbe178240)
|Stack: (0xbe179db8 to 0xbe17a000)
|9da0:                                                       00000000 0=
0000000
|9dc0: 00000000 00000000 8061c230 00000034 7f0c1158 be179dcc 60000013 0=
0000000
|9de0: 8051f255 c0ae8000 bebef800 00000000 c0ae8090 00000001 c0ae808c c=
0ae8004
|9e00: c0ae8088 803f4360 7f0c103e be179e24 00000309 be179e24 c0ae8000 7=
f0bf82c
|9e20: 7f0c103e 7f0c0b23 00000309 00000000 c0ae8094 0a212003 be8c1400 b=
ebef800
|9e40: 00000000 be81e480 bebef82c 7eb89c08 00008914 00000000 00000001 7=
f0c08fc
|9e60: bebef800 bebef800 bebef800 000000c1 7f0c0e68 8036f358 8036f2dc b=
ebef800
|9e80: 000000c1 00000001 00040080 8036f590 beb83500 bebef800 00040080 b=
eb37600
|9ea0: bebef800 8036f690 00000000 beb3760c beb37600 803b9658 00000000 0=
1b89c08
|9ec0: 306e6163 00000000 00000000 00000000 000000c1 76fa44d0 7eb89ed5 0=
00566ce
|9ee0: 00000080 00008914 be047b40 7eb89c08 00008914 00000003 be178000 7=
eb89c08
|9f00: bd844920 8035ae40 7eb89c08 be047b40 00000003 800bb464 7eb89c08 8=
00bbfa8
|9f20: be166a80 00000003 804379c0 800add4c 00000020 00000003 805eeff8 b=
e179f60
|9f40: 00000003 800ade08 805e7bb8 805eeff8 bd844900 00000000 00000002 8=
035a5fc
|9f60: be8ce3d0 7eb89c08 be047b40 00000000 00008914 00000003 be178000 0=
0000000
|9f80: 00000000 800bc030 00000003 00000000 0005868f 00000004 00054f14 0=
0000036
|9fa0: 8000e7e4 8000e660 0005868f 00000004 00000003 00008914 7eb89c08 0=
005868f
|9fc0: 0005868f 00000004 00054f14 00000036 00000000 00000000 7eb89ee3 0=
0000000
|9fe0: 00000000 7eb89bf0 0000cad4 76e6f87c 20000010 00000003 4eff1811 4=
eff1c11
|[<8004f908>] (vprintk_emit+0x11c/0x4c4) from [<803f4360>] (printk+0x2c=
/0x3c)
|[<803f4360>] (printk+0x2c/0x3c) from [<7f0bf82c>] (flexcan_chip_start+=
0x358/0x620 [flexcan])
|[<7f0bf82c>] (flexcan_chip_start+0x358/0x620 [flexcan]) from [<7f0c08f=
c>] (flexcan_open+0x74/0x118 [flexcan])
|[<7f0c08fc>] (flexcan_open+0x74/0x118 [flexcan]) from [<8036f358>] (__=
dev_open+0x7c/0xfc)
|[<8036f358>] (__dev_open+0x7c/0xfc) from [<8036f590>] (__dev_change_fl=
ags+0x8c/0x118)
|[<8036f590>] (__dev_change_flags+0x8c/0x118) from [<8036f690>] (dev_ch=
ange_flags+0x10/0x44)
|[<8036f690>] (dev_change_flags+0x10/0x44) from [<803b9658>] (devinet_i=
octl+0x2a4/0x62c)
|[<803b9658>] (devinet_ioctl+0x2a4/0x62c) from [<8035ae40>] (sock_ioctl=
+0x220/0x274)
|[<8035ae40>] (sock_ioctl+0x220/0x274) from [<800bb464>] (vfs_ioctl+0x2=
8/0x3c)
|[<800bb464>] (vfs_ioctl+0x28/0x3c) from [<800bbfa8>] (do_vfs_ioctl+0x5=
3c/0x590)
|[<800bbfa8>] (do_vfs_ioctl+0x53c/0x590) from [<800bc030>] (SyS_ioctl+0=
x34/0x58)
|[<800bc030>] (SyS_ioctl+0x34/0x58) from [<8000e660>] (ret_fast_syscall=
+0x0/0x30)
|Code: e59f338c e3a00000 e3540000 e583705c (0a00000c)=20
|---[ end trace 16ce38ae8b7c1165 ]---
|Kernel panic - not syncing: Fatal exception


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
