From: ajneu <ajneu1@gmail.com>
Subject: Kernel Oops with: ip link set can0 type can
Date: Tue, 21 Jun 2016 07:57:49 +0000 (UTC)
Message-ID: <loom.20160621T095606-63@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36064 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbcFUIaK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Jun 2016 04:30:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFGZH-0003XK-8t
	for linux-can@vger.kernel.org; Tue, 21 Jun 2016 09:57:55 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 09:57:55 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 09:57:55 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

issuing the command
   sudo ip link set can0 type can
I get Kernel Oops (NULL pointer dereference)
Command line prints: "Killed".

Thereafter command
   sudo ifconfig
hangs. Cannot even stop it with Ctrl-C.


Details:
========

Debian Stretch
uname -r  -> 4.6.0-1-amd64


dmesg shows

[  212.768984] BUG: unable to handle kernel NULL pointer dereference at
0000000000000028
[  212.769004] IP: [<ffffffffc041a0c5>] can_validate+0x5/0x40 [can_dev]
[  212.769020] PGD 40ec5a067 PUD 41cbaa067 PMD 0 
[  212.769031] Oops: 0000 [#1] SMP 
[  212.769040] Modules linked in: fuse(E) bnep(E) snd_hda_codec_hdmi(E)
snd_hda_codec_realtek(E) snd_hda_codec_generic(E) peak_usb(E) can_dev(E)
binfmt_misc(E) evdev(E) intel_rapl(E) x86_pkg_temp_thermal(E)
intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) dcdbas(E) irqbypass(E)
crct10dif_pclmul(E) crc32_pclmul(E) i915(E) snd_hda_intel(E)
ghash_clmulni_intel(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep(E)
snd_pcm(E) snd_timer(E) drm_kms_helper(E) hci_uart(E) pcspkr(E) snd(E)
btbcm(E) drm(E) btqca(E) mei_me(E) serio_raw(E) soundcore(E) i2c_i801(E)
btintel(E) sg(E) mei(E) i2c_algo_bit(E) shpchp(E) battery(E) bluetooth(E)
8250_fintek(E) rfkill(E) video(E) intel_lpss_acpi(E) intel_lpss(E)
mfd_core(E) wmi(E) acpi_pad(E) acpi_als(E) kfifo_buf(E) button(E)
industrialio(E) tpm_tis(E) tpm(E) processor(E)
[  212.769210]  parport_pc(E) ppdev(E) lp(E) parport(E) autofs4(E) ext4(E)
ecb(E) crc16(E) jbd2(E) crc32c_generic(E) mbcache(E) hid_generic(E)
usbhid(E) sr_mod(E) cdrom(E) sd_mod(E) crc32c_intel(E) aesni_intel(E)
aes_x86_64(E) glue_helper(E) lrw(E) gf128mul(E) ablk_helper(E) cryptd(E)
psmouse(E) ahci(E) libahci(E) libata(E) xhci_pci(E) xhci_hcd(E) r8169(E)
mii(E) scsi_mod(E) usbcore(E) usb_common(E) fan(E) thermal(E) i2c_hid(E)
hid(E) fjes(E)
[  212.769308] CPU: 0 PID: 1713 Comm: ip Tainted: G            E  
4.6.0-1-amd64 #1 Debian 4.6.1-1
[  212.769325] Hardware name: Dell Inc. OptiPlex 3040/05XGC8, BIOS 1.3.5
01/26/2016
[  212.769339] task: ffff880441070000 ti: ffff88041cbac000 task.ti:
ffff88041cbac000
[  212.769361] RIP: 0010:[<ffffffffc041a0c5>]  [<ffffffffc041a0c5>]
can_validate+0x5/0x40 [can_dev]
[  212.769380] RSP: 0018:ffff88041cbaf918  EFLAGS: 00010286
[  212.769390] RAX: ffffffffc041a0c0 RBX: 0000000000000000 RCX: 0000000000000000
[  212.769404] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88041cbafa00
[  212.769417] RBP: ffff88041cbafbc8 R08: ffffffff81687110 R09: ffff88041cbafb60
[  212.769431] R10: 000000007ffff000 R11: 0000000000000000 R12: ffff8800369fc000
[  212.769445] R13: ffff88044362da00 R14: ffff88041cbaf9c8 R15: ffffffffc041d000
[  212.769459] FS:  00007f5482f49700(0000) GS:ffff880456c00000(0000)
knlGS:0000000000000000
[  212.769474] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  212.769485] CR2: 0000000000000028 CR3: 0000000441f99000 CR4: 00000000003406f0
[  212.769499] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  212.769513] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  212.769526] Stack:
[  212.769531]  ffffffff814d9a84 ffff88044362da24 ffff88041cbaf9d0
ffffffff81687110
[  212.769547]  0000000000000005 ffffffff8133ca63 0000000000000000
ffffffff8133cb0d
[  212.769564]  0000000000000000 ffffffff814d6ec4 0000000000000000
ffff88041cbafbc8
[  212.769581] Call Trace:
[  212.769588]  [<ffffffff814d9a84>] ? rtnl_newlink+0x214/0x8a0
[  212.769601]  [<ffffffff8133ca63>] ? nla_parse+0x93/0xf0
[  212.769611]  [<ffffffff8133cb0d>] ? nla_strlcpy+0x4d/0x60
[  212.769622]  [<ffffffff814d6ec4>] ? rtnl_link_ops_get+0x34/0x50
[  212.769634]  [<ffffffff814d99e6>] ? rtnl_newlink+0x176/0x8a0
[  212.769646]  [<ffffffff814d8491>] ? rtnetlink_rcv_msg+0xe1/0x230
[  212.769658]  [<ffffffff814d83b0>] ? rtnetlink_rcv+0x30/0x30
[  212.769670]  [<ffffffff814fb5d1>] ? netlink_rcv_skb+0xa1/0xc0
[  212.769681]  [<ffffffff814d83a4>] ? rtnetlink_rcv+0x24/0x30
[  212.769693]  [<ffffffff814fafa2>] ? netlink_unicast+0x172/0x220
[  212.769705]  [<ffffffff814fb34e>] ? netlink_sendmsg+0x2fe/0x3b0
[  212.769717]  [<ffffffff814ab410>] ? sock_sendmsg+0x30/0x40
[  212.769729]  [<ffffffff814abe2e>] ? ___sys_sendmsg+0x28e/0x2a0
[  212.769741]  [<ffffffff811ca7df>] ? alloc_pages_vma+0xbf/0x250
[  212.769754]  [<ffffffff811a6602>] ? handle_mm_fault+0x1462/0x1d00
[  212.769767]  [<ffffffff811ab7ae>] ? vma_link+0xae/0xb0
[  212.769777]  [<ffffffff814ac701>] ? __sys_sendmsg+0x51/0x90
[  212.769789]  [<ffffffff815c65b6>] ? system_call_fast_compare_end+0xc/0x96
[  212.769802] Code: b8 ea ff ff ff c3 f6 87 b8 08 00 00 20 75 f1 83 a7 b0
08 00 00 df 89 b7 38 02 00 00 31 c0 c3 b8 f0 ff ff ff c3 90 0f 1f 44 00 00
<48> 8b 46 28 48 85 c0 74 1e 8b 50 08 23 50 04 89 d0 a8 20 74 12 
[  212.769880] RIP  [<ffffffffc041a0c5>] can_validate+0x5/0x40 [can_dev]
[  212.769894]  RSP <ffff88041cbaf918>
[  212.769901] CR2: 0000000000000028
[  212.774926] ---[ end trace c39a282f357c1064 ]---



Note:
If I reboot and change the command
   sudo ip link set can0 type can
to
   sudo ip link set can0 type can bitrate 1000000 works
then it works correctly.

Is this mailinglist the right place to report this bug, or should it go to
bugzilla.kernel.org ??
(See for example: https://bugzilla.kernel.org/show_bug.cgi?id=13954 )


Thanks,
ajneu


