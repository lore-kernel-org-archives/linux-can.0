From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] socket can compilation failed
Date: Wed, 01 May 2013 16:25:58 +0200
Message-ID: <518125F6.6080402@hartkopp.net>
References: <CANdmM3N21Z2iNjMSyoKpt9_i3-n-SjODangdN4Th47EdW4QcvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:10769 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab3EAO0B (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 May 2013 10:26:01 -0400
In-Reply-To: <CANdmM3N21Z2iNjMSyoKpt9_i3-n-SjODangdN4Th47EdW4QcvA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kedari appana <kedare06@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Kedar,

first your used mailing list is obsolete.

Please use linux-can@vger.kernel.org for future questions (see CC).

Regarding your problem, it does not look like to be a SocketCAN specifi=
c problem.

Please ask the Xilinx people, which provided your Linux kernel 3.6.0-xi=
linx.

Compiling the CAN subsystem and the vcan driver is architecture in-depe=
nded and
is working on every platform.

When Xilinx provided a CAN hardware driver for their Zynq CAN controlle=
r, which
causes a crash then they are the only guys to fix it.

Regards,
Oliver


Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.6.0-xilinx (appanad@xhdspdgnu) (gcc version 4.5.2 (Sour=
cery Code                                                              =
                          Bench Lite 2011.07-57) ) #4 PREEMPT Wed May 1=
 15:18:25 IST 2013
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=3D18c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cach=
e
Machine: Xilinx Zynq Platform, model: Xilinx Zynq
bootconsole [earlycon0] enabled
cma: CMA: reserved 16 MiB at 2e800000
Memory policy: ECC disabled, Data cache writeback
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 26=
0096
Kernel command line: console=3DttyPS0,115200n8 root=3D/dev/ram rw initr=
d=3D0x00800000,                                                        =
                                16M earlyprintk mtdparts=3Dphysmap-flas=
h.0:512K(nor-fsbl),512K(nor-u-boot),5M(nor-                            =
                                                            linux),9M(n=
or-user),1M(nor-scratch),-(nor-rootfs)
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1024MB =3D 1024MB total
Memory: 1013032k/1013032k available, 35544k reserved, 270336K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc04f105c   (5029 kB)
      .init : 0xc04f2000 - 0xc0513564   ( 134 kB)
      .data : 0xc0514000 - 0xc05581d0   ( 273 kB)
       .bss : 0xc05581f4 - 0xc057d67c   ( 150 kB)
NR_IRQS:512
Zynq clock init
xlnx,ps7-ttc-1.00.a #0 at 0xf0000000, irq=3D43
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294=
967286ms
Console: colour dummy device 80x30
Calibrating delay loop... 666.41 BogoMIPS (lpj=3D3332096)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
hw perfevents: enabled with ARMv7 Cortex-A9 PMU driver, 7 counters avai=
lable
Setting up static identity map for 0x39cca0 - 0x39ccd4
L310 cache controller enabled
l2x0: 8 ways, CACHE_ID 0x410000c8, AUX_CTRL 0x72360000, Cache size: 524=
288 B
devtmpfs: initialized
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
xgpiops e000a000.ps7-gpio: gpio at 0xe000a000 mapped to 0xf0008000
registering platform device 'pl330' id 0
registering platform device 'arm-pmu' id 0
registering platform device 'zynq-dvfs' id 0
------------[ cut here ]------------
WARNING: at arch/arm/kernel/hw_breakpoint.c:240 enable_monitor_mode+0x3=
0/0xb0()
halting debug mode enabled. Unable to access hardware resources.
Modules linked in:
[<c0013250>] (unwind_backtrace+0x0/0x11c) from [<c0020664>] (warn_slowp=
ath_commo                                                              =
                          n+0x4c/0x64)
[<c0020664>] (warn_slowpath_common+0x4c/0x64) from [<c00206fc>] (warn_s=
lowpath_f                                                              =
                          mt+0x2c/0x3c)
[<c00206fc>] (warn_slowpath_fmt+0x2c/0x3c) from [<c001406c>] (enable_mo=
nitor_mod                                                              =
                          e+0x30/0xb0)
[<c001406c>] (enable_monitor_mode+0x30/0xb0) from [<c0014150>] (reset_c=
trl_regs+                                                              =
                          0x64/0x104)
[<c0014150>] (reset_ctrl_regs+0x64/0x104) from [<c04f52f8>] (arch_hw_br=
eakpoint_                                                              =
                          init+0x54/0x1bc)
[<c04f52f8>] (arch_hw_breakpoint_init+0x54/0x1bc) from [<c00086fc>] (do=
_one_init                                                              =
                          call+0x94/0x164)
[<c00086fc>] (do_one_initcall+0x94/0x164) from [<c04f27f8>] (kernel_ini=
t+0xe4/0x                                                              =
                          1ac)
[<c04f27f8>] (kernel_init+0xe4/0x1ac) from [<c000eb24>] (kernel_thread_=
exit+0x0/                                                              =
                          0x8)
---[ end trace 1b75b31a2719ed1c ]---
hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchpoint regist=
ers.
hw-breakpoint: halting debug mode enabled. Assuming maximum watchpoint =
size of 4                                                              =
                           bytes.
MIO pin 47 not assigned(00001220)
xslcr xslcr.0: at 0xF8000000 mapped to 0xF8000000
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource xttcpss_timer1
NET: Registered protocol family 2
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP: reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pl330 dev 0 probe success
bounce pool size: 64 pages
jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Red Hat, Inc.
msgmni has been set to 1482
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
e0001000.serial: ttyPS1 at MMIO 0xe0001000 (irq =3D 82) is a xuartps
xdevcfg f8007000.ps7-dev-cfg: ioremap f8007000 to f005c000 with size 10=
00
brd: module loaded
loop: module loaded
xqspips e000d000.ps7-qspi: master is unqueued, this is deprecated
xqspips e000d000.ps7-qspi: at 0xE000D000 mapped to 0xF005E000, irq=3D51
vcan: Virtual CAN interface driver
Unable to handle kernel paging request at virtual address 696c6978
pgd =3D c0004000
[696c6978] *pgd=3D00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0    Tainted: G        W     (3.6.0-xilinx #4)
PC is at platform_match+0x50/0x8c
LR is at of_device_is_compatible+0x3c/0x6c
pc : [<c01f7360>]    lr : [<c02e41cc>]    psr: 20000013
sp : ee037f28  ip : 00000000  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : ee06ec00  r6 : ee06ec08  r5 : c05417c4  r4 : 696c6978
r3 : 00000000  r2 : c0d81788  r1 : 00000000  r0 : 00000000
=46lags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 18c5387d  Table: 00004059  DAC: 00000015
Process swapper (pid: 1, stack limit =3D 0xee0362e8)
Stack: (0xee037f28 to 0xee038000)
7f20:                   c01f7310 ee06ec08 c01f6310 c05417c4 00000000 c0=
1f6330
7f40: c05417c4 c01f6310 00000000 c01f4868 ee00f54c ee0563f0 c05417c4 ee=
3698c0
7f60: c053a970 c01f5710 c04853a6 c04853a8 c05417c4 c050e458 c050e438 c0=
5043c4
7f80: 00000000 c01f6808 00000006 c050e458 c050e438 c05043c4 00000000 00=
000000
7fa0: 00000000 c00086fc c05043c4 ee037f78 c0513508 00000007 00000006 c0=
50e458
7fc0: c050e438 00000082 c0513434 c04f27f8 00000006 00000006 c04f2160 00=
000000
7fe0: 00000000 c04f2714 c000eb24 00000013 00000000 c000eb24 d4b6f66d 2b=
5173e6
[<c01f7360>] (platform_match+0x50/0x8c) from [<c01f6330>] (__driver_att=
ach+0x20/                                                              =
                          0x84)
[<c01f6330>] (__driver_attach+0x20/0x84) from [<c01f4868>] (bus_for_eac=
h_dev+0x4                                                              =
                          8/0x74)
[<c01f4868>] (bus_for_each_dev+0x48/0x74) from [<c01f5710>] (bus_add_dr=
iver+0xbc                                                              =
                          /0x238)
[<c01f5710>] (bus_add_driver+0xbc/0x238) from [<c01f6808>] (driver_regi=
ster+0x9c                                                              =
                          /0x12c)
[<c01f6808>] (driver_register+0x9c/0x12c) from [<c00086fc>] (do_one_ini=
tcall+0x9                                                              =
                          4/0x164)
[<c00086fc>] (do_one_initcall+0x94/0x164) from [<c04f27f8>] (kernel_ini=
t+0xe4/0x                                                              =
                          1ac)
[<c04f27f8>] (kernel_init+0xe4/0x1ac) from [<c000eb24>] (kernel_thread_=
exit+0x0/                                                              =
                          0x8)
Code: e3500000 05874150 0a000004 e2844018 (e5d43000)
---[ end trace 1b75b31a2719ed1d ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x000000=
0bUncompressing Linux... done, booting the kernel.


On 01.05.2013 12:26, kedari appana wrote:

> Hi ,
>=20
>   I try to compile my sokcet can i am getting the kernel panic am i n=
eed to
> apply  any patch to it.Please tell me the solution to it.
> I forwarded the error in the attachment
>=20
> Waiting for your response.
>=20
> Regards,
> Kedar
>=20
>=20
> _______________________________________________
> Socketcan-users mailing list
> Socketcan-users@lists.berlios.de
> https://lists.berlios.de/mailman/listinfo/socketcan-users


