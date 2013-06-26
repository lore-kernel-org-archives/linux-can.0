From: Michael Thalmeier <michael.thalmeier@hale.at>
Subject: flexcan gcc optimization bug
Date: Wed, 26 Jun 2013 11:43:43 +0200
Message-ID: <51CAB7CF.2050405@hale.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailbackup.inode.at ([213.229.60.24]:45399 "EHLO
	mailbackup.inode.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab3FZJuK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Jun 2013 05:50:10 -0400
Received: from [62.99.145.2] (port=14051 helo=mx.inode.at)
	by mailbackup.inode.at with esmtp (Exim 4.76)
	(envelope-from <michael.thalmeier@hale.at>)
	id 1UrmHX-0001Ra-N9
	for linux-can@vger.kernel.org; Wed, 26 Jun 2013 11:44:55 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Hui Wang <jason77.wang@gmail.com>

Hi !

I have a weird problem with the flexcan driver on our i.MX28 board.
As soon as i configure the interface with "canconfig can0 bitrate 125000 start"
(or the equivalent ip command) I get the following segmentation fault in the driver:

[   17.830000] Unhandled fault: external abort on non-linefetch (0x008) at 0xf5032048
[   17.830000] Internal error: : 8 [#1] ARM
[   17.830000] Modules linked in:
[   17.830000] CPU: 0    Not tainted  (3.6.0-00059-g867073b #226)
[   17.830000] PC is at flexcan_chip_start+0x16c/0x204
[   17.830000] LR is at flexcan_chip_start+0xd0/0x204
[   17.830000] pc : [<c01de168>]    lr : [<c01de0cc>]    psr: 60000013
[   17.830000] sp : cf76dae8  ip : 00000478  fp : 00000000
[   17.830000] r10: c030f394  r9 : c0318430  r8 : 04000000
[   17.830000] r7 : 00000000  r6 : f5032470  r5 : cf580000  r4 : f5032000
[   17.830000] r3 : 00000004  r2 : 00000000  r1 : 00000047  r0 : f50323f0
[   17.830000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   17.830000] Control: 0005317f  Table: 4f78c000  DAC: 00000015
[   17.830000] Process canconfig (pid: 216, stack limit = 0xcf76c270)
[   17.830000] Stack: (0xcf76dae8 to 0xcf76e000)
...
[   17.830000] [<c01de168>] (flexcan_chip_start+0x16c/0x204) from [<c01de2ac>] (flexcan_open+0xac/0x140)
[   17.830000] [<c01de2ac>] (flexcan_open+0xac/0x140) from [<c0270978>] (__dev_open+0xac/0x110)
[   17.830000] [<c0270978>] (__dev_open+0xac/0x110) from [<c0270bac>] (__dev_change_flags+0x78/0x13c)
[   17.830000] [<c0270bac>] (__dev_change_flags+0x78/0x13c) from [<c0270cdc>] (dev_change_flags+0x10/0x48)
[   17.830000] [<c0270cdc>] (dev_change_flags+0x10/0x48) from [<c027ca08>] (do_setlink+0x338/0x858)
[   17.830000] [<c027ca08>] (do_setlink+0x338/0x858) from [<c027ddbc>] (rtnl_newlink+0x2bc/0x46c)
[   17.830000] [<c027ddbc>] (rtnl_newlink+0x2bc/0x46c) from [<c027d760>] (rtnetlink_rcv_msg+0x150/0x294)
[   17.830000] [<c027d760>] (rtnetlink_rcv_msg+0x150/0x294) from [<c028a3f8>] (netlink_rcv_skb+0xbc/0xd8)
[   17.830000] [<c028a3f8>] (netlink_rcv_skb+0xbc/0xd8) from [<c027c5f4>] (rtnetlink_rcv+0x18/0x24)
[   17.830000] [<c027c5f4>] (rtnetlink_rcv+0x18/0x24) from [<c0289e20>] (netlink_unicast+0x1a4/0x208)
[   17.830000] [<c0289e20>] (netlink_unicast+0x1a4/0x208) from [<c028a1dc>] (netlink_sendmsg+0x2b4/0x318)
[   17.830000] [<c028a1dc>] (netlink_sendmsg+0x2b4/0x318) from [<c025ca74>] (sock_sendmsg+0x80/0xa0)
[   17.830000] [<c025ca74>] (sock_sendmsg+0x80/0xa0) from [<c025d074>] (__sys_sendmsg+0x2a8/0x2c0)
[   17.830000] [<c025d074>] (__sys_sendmsg+0x2a8/0x2c0) from [<c025e9b4>] (sys_sendmsg+0x3c/0x68)
[   17.830000] [<c025e9b4>] (sys_sendmsg+0x3c/0x68) from [<c000e7e0>] (ret_fast_syscall+0x0/0x2c)
[   17.830000] Code: e5847018 e595346c e5933000 e3130002 (05947048) 
[   17.830000] ---[ end trace 12de4c1559c67321 ]---

I have debugged this down to the following line in the flexcan driver in flexcan_chip_start:

if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
        flexcan_write(0x0, &regs->rxfgmask);

As we have an i.MX28 board this line should not be executed, but it is as can be seen in the
objdump output:

gcc 4.7.2:

if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
 50c:   e598346c        ldr     r3, [r8, #1132] ; 0x46c
 510:   e5933000        ldr     r3, [r3]
 514:   e3130002        tst     r3, #2
        return readl(addr);
}

static inline void flexcan_write(u32 val, void __iomem *addr)
{
        writel(val, addr);
 518:   15846048        strne   r6, [r4, #72]   ; 0x48


gcc 4.6.4:

if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
 518:   e595346c        ldr     r3, [r5, #1132] ; 0x46c
 51c:   e5933000        ldr     r3, [r3]
 520:   e3130002        tst     r3, #2
        return readl(addr);
}

static inline void flexcan_write(u32 val, void __iomem *addr)
{
        writel(val, addr);
 524:   05947048        ldreq   r7, [r4, #72]   ; 0x48
 528:   e5847048        str     r7, [r4, #72]   ; 0x48


As you can see gcc 4.6.4 obviously produces wrong code that always writes this register.

What can I do best to prevent the compiler from thinking it is
safe to access that memory region.

Regards,
Michael

--
Scanned by MailScanner.

