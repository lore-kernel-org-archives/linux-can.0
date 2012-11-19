From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Mon, 19 Nov 2012 17:39:52 +0000 (UTC)
Message-ID: <loom.20121119T183819-427@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47222 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab2KSRmA (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 19 Nov 2012 12:42:00 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TaVM9-0006Wn-VG
	for linux-can@vger.kernel.org; Mon, 19 Nov 2012 18:42:01 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 19 Nov 2012 18:42:01 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 19 Nov 2012 18:42:01 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> On 11/19/2012 05:20 PM, Michael Pellegrini wrote:
> > Wolfgang Grandegger <wg <at> grandegger.com> writes:
> > 
> >>
> >> On 11/19/2012 04:10 PM, Michael Pellegrini wrote:
> >>> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> >>>
> >>>>
> >>>> On 11/15/2012 10:34 PM, Michael Pellegrini wrote:
> >>>>> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> >>>>>
> >>>>>> I need to check first if this driver can be supported with little 
effort.
> >>>>>
> >>>>> Thank you for your consideration.
> >>>>
> >>>> For simple out-of-tree build I have now extracted the most recent
> >>>> version of c_can and c_can_pci driver files, backported it to v3.2 and
> >>>> added the PCH related code.
> >>>>
> >>>> You should be able to build these drivers on your system as shown below:
> >>>>
> >>>>   $ tar xf c-can-pci-v1.tar.bz2
> >>>>   $ cd c-can-pci-v1
> >>>>   $ CONFIG_CAN_C_CAN_PCI=m \
> >>>>     make -C /usr/src/linux-headers-`uname -r` SUBDIRS=`pwd` modules
> >>>>
> >>>> This requires that you have the kernel header, gcc and fiends installed
> >>>> on your system.
> >>>>
> >>>> Then you can load the modules as shown below, after unloading the
> >>>> original C_CAN modules:
> >>>>
> >>>>   $ sudo modprobe can_dev
> >>>>   $ rmmod c_can
> >>>>   $ rmmod c_can_pci
> >>>>   $ sudo insmod c_can.ko
> >>>>   $ sudo insmod c_can_pci.ko
> >>>>
> >>>> Hope it works as expected. 
> >>>
> >>> I got the modules built, however loading them results in a non-functional 
> > CAN 
> >>> interface.  can0 no longer shows up in "ifconfig" or "ip".  Upon loading 
the 
> >>> modules, dmesg prints the following:
> >>>
> >>> [ 2786.244341] c_can_pci 0000:02:0c.3: PCI INT C -> GSI 18 (level, low) -> 
> > IRQ 
> >>> 18
> >>> [ 2786.244381] c_can_pci 0000:02:0c.3: setting latency timer to 64
> >>> [ 2786.244497] c_can_pci 0000:02:0c.3: irq 41 for MSI/MSI-X
> >>> [ 2786.244523] c_can_pci 0000:02:0c.3: device has no PCI memory resources, 
> >>> failing adapter
> >>> [ 2786.244586] c_can_pci 0000:02:0c.3: PCI INT C disabled
> >>> [ 2786.244611] c_can_pci: probe of 0000:02:0c.3 failed with error -12
> >>
> >> "-ENOMEM", ah, the PCH uses PCI Bar 1 (instead of 0). I missed that.
> >> Could you please replace:
> >>
> >> 	addr = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
> >>
> >> with
> >>
> >> 	addr = pci_iomap(pdev, 1, pci_resource_len(pdev, 0));
> >>
> >> in c_can_pci and retry.
> >>
> >> Wolfgang.
> > 
> > I made the change, the module crashes on load now.  Dmesg output is:
> 
> Grrr, sorry, it should be :
> 
> 	addr = pci_iomap(pdev, 1, pci_resource_len(pdev, 1));
> 
> Wolfgang.

Made the change, same problem.  Dmesg output is:

[ 5015.918981] c_can_pci 0000:02:0c.3: PCI INT C -> GSI 18 (level, low) -> IRQ 
18
[ 5015.919047] c_can_pci 0000:02:0c.3: setting latency timer to 64
[ 5015.919328] c_can_pci 0000:02:0c.3: irq 41 for MSI/MSI-X
[ 5016.014291] BUG: unable to handle kernel paging request at f85a0538
[ 5016.014322] IP: [<c12bc410>] iowrite32+0x30/0x40
[ 5016.014360] *pdpt = 0000000001938001 *pde = 0000000035822067 *pte = 
8000000022ec8161
[ 5016.014391] Oops: 0003 [#1] SMP
[ 5016.014410] Modules linked in: c_can_pci(O) c_can(O) can_raw can i2c_isch 
snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_seq_midi 
snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device snd ftdi_sio 
usbserial soundcore lpc_sch snd_page_alloc can_dev rfcomm bnep parport_pc 
bluetooth ppdev gpio_pch video mac_hid pch_phub shpchp lp parport sdhci_pci 
sdhci pch_gbe [last unloaded: pch_can]
[ 5016.014588]
[ 5016.014606] Pid: 3335, comm: ifconfig Tainted: G           O 3.2.0-23-
generic-pae #36-Ubuntu To be filled by O.E.M. To be filled by O.E.M./To be 
filled by O.E.M.
[ 5016.014642] EIP: 0060:[<c12bc410>] EFLAGS: 00010296 CPU: 0
[ 5016.014661] EIP is at iowrite32+0x30/0x40
[ 5016.014677] EAX: 00000001 EBX: f85a0538 ECX: f85a0538 EDX: f85a0538
[ 5016.014693] ESI: 00000000 EDI: 00000000 EBP: e2e09e5c ESP: e2e09e5c
[ 5016.014710]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[ 5016.014728] Process ifconfig (pid: 3335, ti=e2e08000 task=ec73cbc0 
task.ti=e2e08000)
[ 5016.014741] Stack:
[ 5016.014751]  e2e09e68 f859f0b1 f2729800 e2e09e88 f84cbbd6 00000080 f2729800 
f2729800
[ 5016.014798]  f2729800 f84cd220 00000000 e2e09ea4 c14ad8f3 c15a7e06 e2e09ea4 
c14ad85e
[ 5016.014843]  f2729800 000000c1 e2e09ecc c14adb62 000000c1 fffffff3 e2e09ec4 
00040080
[ 5016.014888] Call Trace:
[ 5016.014916]  [<f859f0b1>] c_can_pci_reset_pch+0x21/0x30 [c_can_pci]
[ 5016.014943]  [<f84cbbd6>] c_can_open+0xa6/0x100 [c_can]
[ 5016.014970]  [<c14ad8f3>] __dev_open+0x83/0xd0
[ 5016.014994]  [<c15a7e06>] ? _raw_spin_unlock_bh+0x16/0x20
[ 5016.015017]  [<c14ad85e>] ? dev_set_rx_mode+0x2e/0x40
[ 5016.015039]  [<c14adb62>] __dev_change_flags+0x82/0x150
[ 5016.015062]  [<c14adcd1>] dev_change_flags+0x21/0x60
[ 5016.015086]  [<c1504f6c>] devinet_ioctl+0x4dc/0x640
[ 5016.015107]  [<c14ae26e>] ? dev_ioctl+0x1de/0x2f0
[ 5016.015129]  [<c150551d>] inet_ioctl+0x8d/0xb0
[ 5016.015153]  [<c149887d>] sock_ioctl+0x6d/0x290
[ 5016.015175]  [<c1498810>] ? move_addr_to_user+0x90/0x90
[ 5016.015199]  [<c1154869>] do_vfs_ioctl+0x79/0x2d0
[ 5016.015221]  [<c15a8ea0>] ? do_debug+0x180/0x180
[ 5016.015244]  [<c10197cb>] ? fpu_finit+0x2b/0x70
[ 5016.015264]  [<c1154b2f>] sys_ioctl+0x6f/0x80
[ 5016.015288]  [<c1012474>] ? math_state_restore+0x44/0x60
[ 5016.015312]  [<c15af11f>] sysenter_do_call+0x12/0x28
[ 5016.015325] Code: 03 00 89 e5 89 d1 77 23 81 fa 00 00 01 00 76 0b 81 e2 ff ff 
00 00 ef 5d c3 66 90 ba d8 94 77 c1 89 c8 e8 44 ff ff ff 5d c3 66 90 <89> 02 5d 
c3 8d b6 00 00 00 00 8d bf 00 00 00 00 55 81 fa ff ff
[ 5016.015581] EIP: [<c12bc410>] iowrite32+0x30/0x40 SS:ESP 0068:e2e09e5c
[ 5016.015610] CR2: 00000000f85a0538
[ 5016.015627] ---[ end trace f89a7ceb8cce24a5 ]---



