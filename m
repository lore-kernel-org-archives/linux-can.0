From: "Tietz, Fabian" <Fabian.Tietz@bachmann-technology.com>
Subject: Socketcan kernel panic when using dhclient.
Date: Mon, 3 Jun 2013 15:27:10 +0000
Message-ID: <41B73DFEBC62264A887C90F789C9F99C4452DC@bws-exmb01.bama.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout04.rmx.de ([94.199.90.94]:53258 "EHLO mailout04.rmx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756694Ab3FCPiQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Jun 2013 11:38:16 -0400
Received: from kdin01.retarus.de (kdin01.retarus.de [172.19.17.48] (may be forged))
	by mailout04.rmx.de (8.14.4/8.14.5/retarus.custom) with ESMTP id r53FRCBc007353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-can@vger.kernel.org>; Mon, 3 Jun 2013 17:27:12 +0200
Received: from bws-exht01.bama.eu.com ([194.25.114.226])
	by kdin01.retarus.de (8.14.5/8.14.2/retarus.custom) with ESMTP id r53FRB3H006128
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-can@vger.kernel.org>; Mon, 3 Jun 2013 17:27:12 +0200
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

We are using socketcan on AT91SAM 9x25 Hardware, Stock Kernel 2.6.39, n=
o experimental Atmel patches applied.

When using dhclient, we experience the following kernel oops. Any hints=
 on this issue?

Regards,=20
=46abian
-------snip--------

ioctl(6, SIOCGIFADDR, {ifr_name=3D"lo", ifr_addr=3D{AF_INET, inet_addr(=
"127.0.0.1")}}) =3D 0
ioctl(6, SIOCGIFFLAGS, {ifr_name=3D"lo", ifr_flags=3DIFF_UP|IFF_LOOPBAC=
K|IFF_RUNNING}) =3D 0
ioctl(6, SIOCGIFADDR, {ifr_name=3D"can0", ???}) =3D -1 EADDRNOTAVAIL (C=
annot assiskb_under_panic: text:c02ac490 len:-960460656 put:-960460672 =
head:c6c08860 data:=A0 (null) tail:0xc6c08890 end:0xc6c088a0 dev:can0
kernel BUG at net/core/skbuff.c:146!
Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 817 [#1]
last sysfs file: /sys/devices/platform/leds-gpio/leds/can_red/brightnes=
s
Modules linked in:
CPU: 0=A0=A0=A0 Tainted: G=A0=A0=A0=A0=A0=A0=A0 W=A0=A0=A0 (2.6.39-GHOS=
T-Rev.:167 #34)
PC is at __bug+0x1c/0x28
LR is at __bug+0x18/0x28
pc : [<c0032784>]=A0=A0=A0 lr : [<c0032780>]=A0=A0=A0 psr: 60000013
sp : c7991e18 =A0ip : 00000003=A0 fp : c7991f84
r10: c7adabd0=A0 r9 : 00000003=A0 r8 : c03aa464
r7 : 00000000=A0 r6 : c6c08890=A0 r5 : c6c088a0=A0 r4 : c0367451
r3 : 00000000=A0 r2 : c7991e0c=A0 r1 : c03412f9=A0 r0 : 0000002b
=46lags: nZCv=A0 IRQs on=A0 FIQs on=A0 Mode SVC_32=A0 ISA ARM=A0 Segmen=
t kernel
Control: 0005317f=A0 Table: 27bf4000=A0 DAC: 00000017
Process kworker/0:1 (pid: 397, stack limit =3D 0xc7990270)
Stack: (0xc7991e18 to 0xc7992000)
1e00:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 c6c08890 c01f3960
1e20: c6c08860 00000000 c6c08890 c6c088a0 c7963800 c01f28a0 c784d200 c7=
963800
1e40: c7adaa00 c02ac490 c7963800 c7963800 c03ae778 00000000 00000c00 c0=
1fc510
1e60: c7963800 00000000 0000012c c784d2c0 c7991ea4 c03ae798 0000012c c7=
963800
1e80: 00000000 0000012c 00000006 44200000 c7963be8 c01b0cb4 20000013 ff=
ffffff
1ea0: fefff000 c6c08880 00000000 c7963be8 00000001 0000012c 00000006 00=
00000a
1ec0: 00000003 ffffa4e0 c7991f84 c01fc918 c03b3b1c 00000001 0000000c c7=
990000
1ee0: 00000100 0000000a c03d4f04 c00442cc 00000000 00000008 0000001e 00=
000000
1f00: 0000001e 00000000 00000000 00000000 c79d64a8 c002a080 60000013 ff=
ffffff
1f20: fefff000 c002f7b4 c03bcd54 00000003 c03bcd60 00000000 60000013 c7=
812800
1f40: c0163a50 00000000 00000000 00000000 c79d64a8 c7991f84 60000093 c7=
991f70
1f60: c003a3e4 c003a3e8 60000013 ffffffff 00000000 c0163a50 c7923da0 c7=
923da0
1f80: 00000000 c00510fc 80000093 c7923da0 c03b4e3c c7923db0 00000001 c0=
3b4e3c
1fa0: 00000000 00000009 00000000 c0051cf8 00000000 c7827f38 c7923da0 c0=
051b30
1fc0: 00000013 00000000 00000000 c005500c 00000000 00000000 c7923da0 00=
000000
1fe0: c7991fe0 c7991fe0 c7827f38 c0054f90 c0030a18 c0030a18 c1200092 11=
100a25
[<c0032784>] (__bug+0x1c/0x28) from [<c01f3960>] (skb_push+0x78/0x8c)
[<c01f3960>] (skb_push+0x78/0x8c) from [<c02ac490>] (packet_rcv_spkt+0x=
d4/0x118)
[<c02ac490>] (packet_rcv_spkt+0xd4/0x118) from [<c01fc510>] (__netif_re=
ceive_skb+0x32c/0x3d0)
[<c01fc510>] (__netif_receive_skb+0x32c/0x3d0) from [<c01b0cb4>] (at91_=
poll+0x3e0/0x468)
[<c01b0cb4>] (at91_poll+0x3e0/0x468) from [<c01fc918>] (net_rx_action+0=
x4c/0x174)
[<c01fc918>] (net_rx_action+0x4c/0x174) from [<c00442cc>] (__do_softirq=
+0x84/0x120)
[<c00442cc>] (__do_softirq+0x84/0x120) from [<c002a080>] (asm_do_IRQ+0x=
80/0xa0)
[<c002a080>] (asm_do_IRQ+0x80/0xa0) from [<c002f7b4>] (__irq_svc+0x34/0=
x60)
Exception stack(0xc7991f28 to 0xc7991f70)
1f20:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c03bcd54 00=
000003 c03bcd60 00000000 60000013 c7812800
1f40: c0163a50 00000000 00000000 00000000 c79d64a8 c7991f84 60000093 c7=
991f70
1f60: c003a3e4 c003a3e8 60000013 ffffffff
[<c002f7b4>] (__irq_svc+0x34/0x60) from [<c003a3e8>] (__wake_up+0x28/0x=
30)
[<c003a3e8>] (__wake_up+0x28/0x30) from [<c00510fc>] (process_one_work+=
0x1e8/0x328)
[<c00510fc>] (process_one_work+0x1e8/0x328) from [<c0051cf8>] (worker_t=
hread+0x1c8/0x2f8)
[<c0051cf8>] (worker_thread+0x1c8/0x2f8) from [<c005500c>] (kthread+0x7=
c/0x84)
[<c005500c>] (kthread+0x7c/0x84) from [<c0030a18>] (kernel_thread_exit+=
0x0/0x8)
Code: e59f0010 e1a0100c eb0a2a7d e3a03000 (e5833000)
---[ end trace 1b75b31a2719ed1f ]---
Kernel panic - not syncing: Fatal exception in interrupt
[<c003484c>] (unwind_backtrace+0x0/0xe0) from [<c02bd054>] (panic+0x50/=
0x174)
[<c02bd054>] (panic+0x50/0x174) from [<c0032b6c>] (die+0x184/0x1c4)
[<c0032b6c>] (die+0x184/0x1c4) from [<c00356c0>] (__do_kernel_fault+0x6=
4/0x84)
[<c00356c0>] (__do_kernel_fault+0x64/0x84) from [<c0035894>] (do_page_f=
ault+0x1b4/0x1c8)
[<c0035894>] (do_page_fault+0x1b4/0x1c8) from [<c002a240>] (do_DataAbor=
t+0x34/0x98)
[<c002a240>] (do_DataAbort+0x34/0x98) from [<c002f76c>] (__dabt_svc+0x4=
c/0x60)
Exception stack(0xc7991dd0 to 0xc7991e18)
1dc0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0000002b c03412f9 c7991e0c 0=
0000000
1de0: c0367451 c6c088a0 c6c08890 00000000 c03aa464 00000003 c7adabd0 c7=
991f84
1e00: 00000003 c7991e18 c0032780 c0032784 60000013 ffffffff
[<c002f76c>] (__dabt_svc+0x4c/0x60) from [<c0032784>] (__bug+0x1c/0x28)
[<c0032784>] (__bug+0x1c/0x28) from [<c01f3960>] (skb_push+0x78/0x8c)
[<c01f3960>] (skb_push+0x78/0x8c) from [<c02ac490>] (packet_rcv_spkt+0x=
d4/0x118)
[<c02ac490>] (packet_rcv_spkt+0xd4/0x118) from [<c01fc510>] (__netif_re=
ceive_skb+0x32c/0x3d0)
[<c01fc510>] (__netif_receive_skb+0x32c/0x3d0) from [<c01b0cb4>] (at91_=
poll+0x3e0/0x468)
[<c01b0cb4>] (at91_poll+0x3e0/0x468) from [<c01fc918>] (net_rx_action+0=
x4c/0x174)
[<c01fc918>] (net_rx_action+0x4c/0x174) from [<c00442cc>] (__do_softirq=
+0x84/0x120)
[<c00442cc>] (__do_softirq+0x84/0x120) from [<c002a080>] (asm_do_IRQ+0x=
80/0xa0)
[<c002a080>] (asm_do_IRQ+0x80/0xa0) from [<c002f7b4>] (__irq_svc+0x34/0=
x60)
Exception stack(0xc7991f28 to 0xc7991f70)
1f20:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c03bcd54 00=
000003 c03bcd60 00000000 60000013 c7812800
1f40: c0163a50 00000000 00000000 00000000 c79d64a8 c7991f84 60000093 c7=
991f70
1f60: c003a3e4 c003a3e8 60000013 ffffffff
[<c002f7b4>] (__irq_svc+0x34/0x60) from [<c003a3e8>] (__wake_up+0x28/0x=
30)
[<c003a3e8>] (__wake_up+0x28/0x30) from [<c00510fc>] (process_one_work+=
0x1e8/0x328)
[<c00510fc>] (process_one_work+0x1e8/0x328) from [<c0051cf8>] (worker_t=
hread+0x1c8/0x2f8)
[<c0051cf8>] (worker_thread+0x1c8/0x2f8) from [<c005500c>] (kthread+0x7=
c/0x84)
[<c005500c>] (kthread+0x7c/0x84) from [<c0030a18>] (kernel_thread_exit+=
0x0/0x8)

------------------------------------


