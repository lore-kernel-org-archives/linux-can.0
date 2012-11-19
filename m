From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Mon, 19 Nov 2012 16:20:47 +0000 (UTC)
Message-ID: <loom.20121119T171647-35@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33929 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662Ab2KSQVG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 19 Nov 2012 11:21:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TaU5w-0008Ud-A1
	for linux-can@vger.kernel.org; Mon, 19 Nov 2012 17:21:12 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 19 Nov 2012 17:21:12 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 19 Nov 2012 17:21:12 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> On 11/19/2012 04:10 PM, Michael Pellegrini wrote:
> > Wolfgang Grandegger <wg <at> grandegger.com> writes:
> > 
> >>
> >> On 11/15/2012 10:34 PM, Michael Pellegrini wrote:
> >>> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> >>>
> >>>> I need to check first if this driver can be supported with little effort.
> >>>
> >>> Thank you for your consideration.
> >>
> >> For simple out-of-tree build I have now extracted the most recent
> >> version of c_can and c_can_pci driver files, backported it to v3.2 and
> >> added the PCH related code.
> >>
> >> You should be able to build these drivers on your system as shown below:
> >>
> >>   $ tar xf c-can-pci-v1.tar.bz2
> >>   $ cd c-can-pci-v1
> >>   $ CONFIG_CAN_C_CAN_PCI=m \
> >>     make -C /usr/src/linux-headers-`uname -r` SUBDIRS=`pwd` modules
> >>
> >> This requires that you have the kernel header, gcc and fiends installed
> >> on your system.
> >>
> >> Then you can load the modules as shown below, after unloading the
> >> original C_CAN modules:
> >>
> >>   $ sudo modprobe can_dev
> >>   $ rmmod c_can
> >>   $ rmmod c_can_pci
> >>   $ sudo insmod c_can.ko
> >>   $ sudo insmod c_can_pci.ko
> >>
> >> Hope it works as expected. 
> > 
> > I got the modules built, however loading them results in a non-functional 
CAN 
> > interface.  can0 no longer shows up in "ifconfig" or "ip".  Upon loading the 
> > modules, dmesg prints the following:
> > 
> > [ 2786.244341] c_can_pci 0000:02:0c.3: PCI INT C -> GSI 18 (level, low) -> 
IRQ 
> > 18
> > [ 2786.244381] c_can_pci 0000:02:0c.3: setting latency timer to 64
> > [ 2786.244497] c_can_pci 0000:02:0c.3: irq 41 for MSI/MSI-X
> > [ 2786.244523] c_can_pci 0000:02:0c.3: device has no PCI memory resources, 
> > failing adapter
> > [ 2786.244586] c_can_pci 0000:02:0c.3: PCI INT C disabled
> > [ 2786.244611] c_can_pci: probe of 0000:02:0c.3 failed with error -12
> 
> "-ENOMEM", ah, the PCH uses PCI Bar 1 (instead of 0). I missed that.
> Could you please replace:
> 
> 	addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
> 
> with
> 
> 	addr = pci_iomap(pdev, 1, pci_resource_len(pdev, 0));
> 
> in c_can_pci and retry.
> 
> Wolfgang.

I made the change, the module crashes on load now.  Dmesg output is:

[  249.244698] c_can_pci 0000:02:0c.3: PCI INT C -> GSI 18 (level, low) -> IRQ 
18
[  249.244737] c_can_pci 0000:02:0c.3: setting latency timer to 64
[  249.244869] c_can_pci 0000:02:0c.3: irq 41 for MSI/MSI-X
[  249.339061] BUG: unable to handle kernel paging request at f85af538
[  249.339078] IP: [<c12bc410>] iowrite32+0x30/0x40
[  249.339098] *pdpt = 0000000001938001 *pde = 0000000035822067 *pte = 
80000000228cc161
[  249.339113] Oops: 0003 [#1] SMP
[  249.339122] Modules linked in: c_can_pci(O) c_can(O) can_raw can i2c_isch 
snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq_midi 
snd_rawmidi snd_seq_midi_event snd_seq snd_timer ftdi_sio snd_seq_device 
usbserial snd soundcore snd_page_alloc lpc_sch can_dev pch_phub rfcomm gpio_pch 
bnep bluetooth parport_pc ppdev video mac_hid shpchp lp parport sdhci_pci sdhci 
pch_gbe [last unloaded: pch_can]
[  249.339206]
[  249.339214] Pid: 2365, comm: ifconfig Tainted: G           O 3.2.0-23-
generic-pae #36-Ubuntu To be filled by O.E.M. To be filled by O.E.M./To be 
filled by O.E.M.
[  249.339231] EIP: 0060:[<c12bc410>] EFLAGS: 00010296 CPU: 1
[  249.339240] EIP is at iowrite32+0x30/0x40
[  249.339247] EAX: 00000001 EBX: f85af538 ECX: f85af538 EDX: f85af538
[  249.339255] ESI: 00000000 EDI: 00000000 EBP: e290be5c ESP: e290be5c
[  249.339263]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[  249.339271] Process ifconfig (pid: 2365, ti=e290a000 task=e721cbc0 
task.ti=e290a000)
[  249.339278] Stack:
[  249.339282]  e290be68 f85ae0b1 f2640000 e290be88 f85bdbd6 00000080 f2640000 
f2640000
[  249.339304]  f2640000 f85bf220 00000000 e290bea4 c14ad8f3 c15a7e06 e290bea4 
c14ad85e
[  249.339325]  f2640000 000000c1 e290becc c14adb62 000000c1 fffffff3 e290bec4 
00040080
[  249.339346] Call Trace:
[  249.339361]  [<f85ae0b1>] c_can_pci_reset_pch+0x21/0x30 [c_can_pci]
[  249.339374]  [<f85bdbd6>] c_can_open+0xa6/0x100 [c_can]
[  249.339387]  [<c14ad8f3>] __dev_open+0x83/0xd0
[  249.339400]  [<c15a7e06>] ? _raw_spin_unlock_bh+0x16/0x20
[  249.339410]  [<c14ad85e>] ? dev_set_rx_mode+0x2e/0x40
[  249.339421]  [<c14adb62>] __dev_change_flags+0x82/0x150
[  249.339431]  [<c14adcd1>] dev_change_flags+0x21/0x60
[  249.339443]  [<c1504f6c>] devinet_ioctl+0x4dc/0x640
[  249.339453]  [<c14ae26e>] ? dev_ioctl+0x1de/0x2f0
[  249.339463]  [<c150551d>] inet_ioctl+0x8d/0xb0
[  249.339475]  [<c149887d>] sock_ioctl+0x6d/0x290
[  249.339485]  [<c1498810>] ? move_addr_to_user+0x90/0x90
[  249.339497]  [<c1154869>] do_vfs_ioctl+0x79/0x2d0
[  249.339507]  [<c15a8ea0>] ? do_debug+0x180/0x180
[  249.339518]  [<c10197cb>] ? fpu_finit+0x2b/0x70
[  249.339528]  [<c1154b2f>] sys_ioctl+0x6f/0x80
[  249.339539]  [<c1012474>] ? math_state_restore+0x44/0x60
[  249.339551]  [<c15af11f>] sysenter_do_call+0x12/0x28
[  249.339557] Code: 03 00 89 e5 89 d1 77 23 81 fa 00 00 01 00 76 0b 81 e2 ff ff 
00 00 ef 5d c3 66 90 ba d8 94 77 c1 89 c8 e8 44 ff ff ff 5d c3 66 90 <89> 02 5d 
c3 8d b6 00 00 00 00 8d bf 00 00 00 00 55 81 fa ff ff
[  249.339675] EIP: [<c12bc410>] iowrite32+0x30/0x40 SS:ESP 0068:e290be5c
[  249.339688] CR2: 00000000f85af538
[  249.339697] ---[ end trace ee92cde2e8156087 ]---



