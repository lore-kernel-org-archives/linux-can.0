From: "Harrington, Sean M." <harrington.234@buckeyemail.osu.edu>
Subject: C-Can or Other SocketCAN Issue
Date: Mon, 3 Mar 2014 16:26:53 +0000
Message-ID: <d634b30117cf40dfb954c723bef01b65@BN1PR01MB071.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0241.outbound.protection.outlook.com ([207.46.163.241]:17345
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754715AbaCCQ05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Mar 2014 11:26:57 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello all,

I'm having some fairly odd  issues with can-utils and SocketCAN and cou=
ld use some help if anyone  has a bit of time to spare. Specifically, I=
'm trying to use SocketCAN on  a Beaglebone Black to read in and write =
CAN messages to a CAN bus using similar methods to how=A0the can-utils'=
  "candump" works. My issues do not seem to occur when using the cangen=
  tool to load a bus but instead when I use a different method of  gene=
rating messages and loading the bus (mainly a Kvaser Eagle). Although m=
essages are intercepted with no issues for a short  amount of time, a s=
ystem crash will then occur=A0soon after when using the  Beaglebone Bla=
ck. This crash happens with=A0running both=A0the can-utils  "candump" t=
ool and when running my personal CAN=A0reading=A0software. The issue ca=
n usually be replicated easily by generating enough messages  to fill t=
he entire bus. However, I do not think the issue is caused by  bus load=
 alone since sometimes everything will run well at full bus load  and a=
t other times it will crash with only half the bus being filled. Using =
a serial connection, I am able to get  the following system message bef=
ore the entire Beaglebone freezes up:

[ =A0864.029581] BUG: soft lockup - CPU#0 stuck for 22s! [main:1119]=20
[ =A0864.036222] BUG: scheduling while atomic: main/1119/0x40010100=20
[ =A0864.045930] Kernel panic - not syncing: softlockup: hung tasks=20
[ =A0864.052066] [<c0013598>] (unwind_backtrace+0x0/0xe0) from [<c061b2=
30>] (panic+0x84/0x1e0)=20
[ =A0864.060643] [<c061b230>] (panic+0x84/0x1e0) from [<c0093200>] (wat=
chdog_timer_fn+0x120/0x164)=20
[ =A0864.069587] [<c0093200>] (watchdog_timer_fn+0x120/0x164) from [<c0=
05cf2c>] (__run_hrtimer+0xec/0x1e4)=20
[ =A0864.079253] [<c005cf2c>] (__run_hrtimer+0xec/0x1e4) from [<c005d96=
0>] (hrtimer_interrupt+0x108/0x25c)=20
[ =A0864.088924] [<c005d960>] (hrtimer_interrupt+0x108/0x25c) from [<c0=
0247c0>] (omap2_gp_timer_interrupt+0x20/0x30)=20
[ =A0864.099501] [<c00247c0>] (omap2_gp_timer_interrupt+0x20/0x30)  fro=
m [<c0093c20>] (handle_irq_event_percpu+0x60/0x214)=20
[ =A0864.110530] [<c0093c20>] (handle_irq_event_percpu+0x60/0x214) from=
 [<c0093e10>] (handle_irq_event+0x3c/0x5c)=20
[ =A0864.120832] [<c0093e10>] (handle_irq_event+0x3c/0x5c) from [<c0096=
810>] (handle_level_irq+0xd4/0xec)=20
[ =A0864.130405] [<c0096810>] (handle_level_irq+0xd4/0xec) from [<c0093=
658>] (generic_handle_irq+0x20/0x30)=20
[ =A0864.140158] [<c0093658>] (generic_handle_irq+0x20/0x30) from [<c00=
0e15c>] (handle_IRQ+0x64/0x8c)=20
[ =A0864.149366] [<c000e15c>] (handle_IRQ+0x64/0x8c) from [<c0008760>] =
(omap3_intc_handle_irq+0x60/0x74)=20
[ =A0864.158847] [<c0008760>] (omap3_intc_handle_irq+0x60/0x74) from [<=
c0623280>] (__irq_svc+0x40/0x50)=20
[ =A0864.168230] Exception stack(0xde29fd40 to 0xde29fd88)=20
[ =A0864.173524] fd40: 00008000 00000044 fa1d0000 fa1d00b0 de31d540 000=
00010 00000022 c099c3e4=20
[ =A0864.182094] fd60: de31d000 c09cb80c c09cd640 c094c0c0 00745a2f de2=
9fd88 bf007014 bf00e018=20
[ =A0864.190658] fd80: 40000113 ffffffff=20
[ =A0864.194320] [<c0623280>] (__irq_svc+0x40/0x50) from  [<bf00e018>] =
(c_can_plat_read_reg_aligned_to_16bit+0x18/0x24  [c_can_platform])=20
[ =A0864.206628] [<bf00e018>]  (c_can_plat_read_reg_aligned_to_16bit+0x=
18/0x24 [c_can_platform]) from  [<bf007014>] (c_can_read_reg32+0x14/0x3=
0 [c_can])=20
[ =A0864.220299] [<bf007014>] (c_can_read_reg32+0x14/0x30 [c_can]) from=
 [<bf008158>] (c_can_poll+0x66c/0x818 [c_can])=20
[ =A0864.230970] [<bf008158>] (c_can_poll+0x66c/0x818 [c_can]) from [<c=
053b780>] (net_rx_action+0x6c/0x1bc)=20
[ =A0864.240727] [<c053b780>] (net_rx_action+0x6c/0x1bc) from [<c0042d3=
0>] (__do_softirq+0xfc/0x22c)=20
[ =A0864.249845] [<c0042d30>] (__do_softirq+0xfc/0x22c) from [<c0043120=
>] (irq_exit+0x44/0x84)=20
[ =A0864.258417] [<c0043120>] (irq_exit+0x44/0x84) from [<c000e160>] (h=
andle_IRQ+0x68/0x8c)=20
[ =A0864.266715] [<c000e160>] (handle_IRQ+0x68/0x8c) from [<c0008760>] =
(omap3_intc_handle_irq+0x60/0x74)=20
[ =A0864.276195] [<c0008760>] (omap3_intc_handle_irq+0x60/0x74) from [<=
c0623280>] (__irq_svc+0x40/0x50)=20
[ =A0864.285578] Exception stack(0xde29fe70 to 0xde29feb8)=20
[ =A0864.290869] fe60: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 df259010 df259010 04e404e3 00000001=20
[ =A0864.299438] fe80: 60000013 00000000 00000007 00000000 de698407 df2=
59010 de5b8800 a0000013=20
[ =A0864.308006] fea0: 00000c1b de29feb8 c0622f70 c0622f74 60000013 fff=
fffff=20
[ =A0864.314940] [<c0623280>] (__irq_svc+0x40/0x50) from [<c0622f74>] (=
_raw_spin_unlock_irqrestore+0x10/0x14)=20
[ =A0864.324877] [<c0622f74>] (_raw_spin_unlock_irqrestore+0x10/0x14) f=
rom [<c035a3b4>] (uart_write+0xc8/0xd4)=20
[ =A0864.334906] [<c035a3b4>] (uart_write+0xc8/0xd4) from [<c0344e2c>] =
(n_tty_write+0x238/0x394)=20
[ =A0864.343660] [<c0344e2c>] (n_tty_write+0x238/0x394) from [<c034236c=
>] (tty_write+0x184/0x214)=20
[ =A0864.352505] [<c034236c>] (tty_write+0x184/0x214) from [<c00f5c00>]=
 (vfs_write+0xa8/0x178)=20
[ =A0864.361077] [<c00f5c00>] (vfs_write+0xa8/0x178) from [<c00f5ee0>] =
(sys_write+0x38/0x64)=20
[ =A0864.369466] [<c00f5ee0>] (sys_write+0x38/0x64) from [<c000d880>] (=
ret_fast_syscall+0x0/0x30)=20
[ =A0864.378309] drm_kms_helper: panic occurred, switching back to text=
 console=20

I'm thinking this might be a  kernel or driver issue but this=A0problem=
 reaches far beyond my knowledge.  Any feedback would be greatly apprec=
iated. I wouldn't mind trying to  sort through and fix this problem mys=
elf if I can get a bit of guidance on what needs to be done. I can't be=
 the  only one using a Beaglebone Black to do CAN work so I must have  =
something set up wrong.

The Beaglebone Black should be running Ubuntu 13.04. I'm willing to  re=
build the kernel and install the latest distribution if I can some  fee=
dback on the proper method to get SocketCAN functional and if it  would=
 most likely resolve the issue.=20

Thanks for your time,
Sean Harrington
               =20

 