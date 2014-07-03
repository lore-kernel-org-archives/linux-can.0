From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: skbuff panic
Date: Thu, 3 Jul 2014 16:18:24 -0700
Message-ID: <CANGgnMbxKo4wkaJ+Fo2K551TfqrdKGSKu9bhyXMMvCatACGtEw@mail.gmail.com>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33409 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaGCXSq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Jul 2014 19:18:46 -0400
Received: by mail-ig0-f181.google.com with SMTP id h15so1791652igd.8
        for <linux-can@vger.kernel.org>; Thu, 03 Jul 2014 16:18:45 -0700 (PDT)
In-Reply-To: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

On Thu, Jul 3, 2014 at 4:03 PM, Austin Schuh <austin@peloton-tech.com> wrote:
> I'm seeing the following panic.  I've seen it on multiple kernel
> versions (3.10.24 patched, and 3.14.3).
>
> uname -a
> Linux vpc5 3.14.3-rt4abs+ #16 SMP PREEMPT RT Tue Jul 1 16:28:26 PDT
> 2014 x86_64 GNU/Linux
>
> Jul  3 12:18:28 vpc7 kernel: [   16.691928] skbuff: skb_under_panic:
> text:ffffffff814fb64d len:-65447 put:-65463 head:ffff880407415080
> data:ffff88030742507f tail:0x58 end:0x80 dev:can0
> Jul  3 12:18:28 vpc7 kernel: [   16.692207] ------------[ cut here ]------------
> Jul  3 12:18:28 vpc7 kernel: [   16.692209] kernel BUG at net/core/skbuff.c:100!
> Jul  3 12:18:28 vpc7 kernel: [   16.692215] invalid opcode: 0000 [#1]
> PREEMPT SMP
> Jul  3 12:18:28 vpc7 kernel: [   16.692268] Modules linked in: ext3
> mbcache jbd vcan loop snd_hda_codec_hdmi snd_hda_codec_realtek
> snd_hda_codec_generic iTCO_wdt iTCO_vendor_support
> x86_pkg_temp_thermal coretemp crc32c_intel ghash_clmulni_intel
> aesni_intel aes_x86_64 ablk_helper cryptd lrw gf128mul glue_helper
> evdev psmouse pcspkr serio_raw parport_pc parport tpm_tis tpm
> snd_hda_intel snd_hda_codec peak_pci sja1000 i915 snd_hwdep can_dev
> snd_pcm video snd_timer mei_me e1000e lpc_ich ac i2c_i801 mfd_core snd
> mei ptp intel_gtt pps_core ata_generic drm_kms_helper button processor
> ahci libahci fan thermal
> Jul  3 12:18:28 vpc7 kernel: [   16.692274] CPU: 1 PID: 2080 Comm:
> irq/18-can0 Not tainted 3.14.3-rt4abs+ #16
> Jul  3 12:18:28 vpc7 kernel: [   16.692276] Hardware name: CompuLab
> Intense-PC/Intense-PC, BIOS CR_2.2.0.400 X64 12/12/2013
> Jul  3 12:18:28 vpc7 kernel: [   16.692279] task: ffff88040c5ad680 ti:
> ffff880407cba000 task.ti: ffff880407cba000
> Jul  3 12:18:28 vpc7 kernel: [   16.692293] RIP:
> 0010:[<ffffffff81512339>]  [<ffffffff81512339>] skb_panic+0x63/0x65
> Jul  3 12:18:28 vpc7 kernel: [   16.692295] RSP: 0000:ffff880407cbbba8
>  EFLAGS: 00010292
> Jul  3 12:18:28 vpc7 kernel: [   16.692298] RAX: 000000000000008c RBX:
> ffff88040be50200 RCX: 0000000016f816f7
> Jul  3 12:18:28 vpc7 kernel: [   16.692300] RDX: 0000000000000001 RSI:
> 0000000000000000 RDI: 00000000ffffffff
> Jul  3 12:18:28 vpc7 kernel: [   16.692301] RBP: ffff880407cbbbc8 R08:
> 0000000000000000 R09: 0000000000000000
> Jul  3 12:18:28 vpc7 kernel: [   16.692304] R10: 00000000ffffffff R11:
> 00000000ffffffff R12: ffff88040be3f000
> Jul  3 12:18:28 vpc7 kernel: [   16.692306] R13: ffff88040bf29000 R14:
> ffff88040be3f000 R15: 0000000000000000
> Jul  3 12:18:28 vpc7 kernel: [   16.692309] FS:
> 0000000000000000(0000) GS:ffff88042e080000(0000)
> knlGS:0000000000000000
> Jul  3 12:18:28 vpc7 kernel: [   16.692311] CS:  0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033
> Jul  3 12:18:28 vpc7 kernel: [   16.692313] CR2: 00007fe8a7fd34cc CR3:
> 00000004070ec000 CR4: 00000000001407e0
> Jul  3 12:18:28 vpc7 kernel: [   16.692314] Stack:
> Jul  3 12:18:28 vpc7 kernel: [   16.692320]  ffff88030742507f
> 0000000000000058 0000000000000080 ffff88040be3f000
> Jul  3 12:18:28 vpc7 kernel: [   16.692324]  ffff880407cbbbd8
> ffffffff8143e142 ffff880407cbbc08 ffffffff814fb64d
> Jul  3 12:18:28 vpc7 kernel: [   16.692328]  ffff88040bf29880
> ffffffff81ac40e8 ffffffff81ac4110 ffff88040be3f000
> Jul  3 12:18:28 vpc7 kernel: [   16.692330] Call Trace:
> Jul  3 12:18:28 vpc7 kernel: [   16.692340]  [<ffffffff8143e142>]
> skb_push+0x38/0x39
> Jul  3 12:18:28 vpc7 kernel: [   16.692348]  [<ffffffff814fb64d>]
> packet_rcv_spkt+0x98/0xdf
> Jul  3 12:18:28 vpc7 kernel: [   16.692357]  [<ffffffff8144b8f8>]
> __netif_receive_skb_core+0x459/0x4dc
> Jul  3 12:18:28 vpc7 kernel: [   16.692363]  [<ffffffff8106b2db>] ?
> get_parent_ip+0xe/0x3e
> Jul  3 12:18:28 vpc7 kernel: [   16.692369]  [<ffffffff8144b9ce>]
> __netif_receive_skb+0x53/0x65
> Jul  3 12:18:28 vpc7 kernel: [   16.692376]  [<ffffffff8144ba40>]
> process_backlog+0x60/0x13d
> Jul  3 12:18:28 vpc7 kernel: [   16.692384]  [<ffffffff8144be10>]
> net_rx_action+0x91/0x1bd
> Jul  3 12:18:28 vpc7 kernel: [   16.692395]  [<ffffffff81046793>]
> do_current_softirqs+0x1a5/0x35b
> Jul  3 12:18:28 vpc7 kernel: [   16.692404]  [<ffffffff81089c0e>] ?
> irq_thread_fn+0x3a/0x3a
> Jul  3 12:18:28 vpc7 kernel: [   16.692409]  [<ffffffff810469c7>]
> __local_bh_enable+0x41/0x68
> Jul  3 12:18:28 vpc7 kernel: [   16.692413]  [<ffffffff810469fc>]
> local_bh_enable+0xe/0x10
> Jul  3 12:18:28 vpc7 kernel: [   16.692417]  [<ffffffff81089c57>]
> irq_forced_thread_fn+0x49/0x55
> Jul  3 12:18:28 vpc7 kernel: [   16.692422]  [<ffffffff8108a3cb>]
> irq_thread+0x8e/0x174
> Jul  3 12:18:28 vpc7 kernel: [   16.692426]  [<ffffffff81089b32>] ?
> irq_finalize_oneshot+0x9c/0x9c
> Jul  3 12:18:28 vpc7 kernel: [   16.692431]  [<ffffffff8108a33d>] ?
> irq_affinity_notify+0x14/0x14
> Jul  3 12:18:28 vpc7 kernel: [   16.692437]  [<ffffffff8105f7cf>]
> kthread+0xdc/0xe4
> Jul  3 12:18:28 vpc7 kernel: [   16.692443]  [<ffffffff8105f6f3>] ?
> flush_kthread_worker+0xe1/0xe1
> Jul  3 12:18:28 vpc7 kernel: [   16.692449]  [<ffffffff815158ac>]
> ret_from_fork+0x7c/0xb0
> Jul  3 12:18:28 vpc7 kernel: [   16.692454]  [<ffffffff8105f6f3>] ?
> flush_kthread_worker+0xe1/0xe1
> Jul  3 12:18:28 vpc7 kernel: [   16.692498] Code: 00 00 48 89 44 24 10
> 8b 87 c8 00 00 00 48 89 44 24 08 48 8b 87 d8 00 00 00 48 c7 c7 fb 46
> 7b 81 48 89 04 24 31 c0 e8 37 b2 ff ff <0f> 0b 55 48 89 e5 0f 0b 55 48
> c7 c2 a0 66 d8 81 48 89 e5 53 48
> Jul  3 12:18:28 vpc7 kernel: [   16.692503] RIP  [<ffffffff81512339>]
> skb_panic+0x63/0x65
> Jul  3 12:18:28 vpc7 kernel: [   16.692505]  RSP <ffff880407cbbba8>
> Jul  3 12:18:28 vpc7 kernel: [   16.849291] ---[ end trace 0000000000000002 ]---
>
>
> Here are the skbuffs from a number of crashes.  The call traces seem
> to be similar to the one above, but I haven't exhaustively checked.
>
> Jul  3 12:18:28 vpc7 kernel: [   16.691928] skbuff: skb_under_panic:
> text:ffffffff814fb64d len:-65447 put:-65463 head:ffff880407415080
> data:ffff88030742507f tail:0x58 end:0x80 dev:can0
>
> The following are from kernel version 'Linux version 3.10.24-rt22abs
> (austin@aschuh-peloton) (gcc version 4.7.2 (Debian 4.7.2-5abs) ) #15
> SMP PREEMPT RT Tue May 13 14:42:22 PDT'
>
> Jul  3 09:25:11 vpc6 kernel: [    7.994591] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff8802151eaa00
> data:ffff8802151ea9ff tail:0x58 end:0x80 dev:can0
> Jul  3 09:32:46 vpc6 kernel: [    7.887542] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff8802176a9a40
> data:ffff8802176a9a3f tail:0x58 end:0x80 dev:can1
> Jun 28 08:56:19 vpc7 kernel: [    8.157864] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff8803f4d49a40
> data:ffff8803f4d49a3f tail:0x58 end:0x80 dev:can0
> Jun 28 08:56:19 vpc7 kernel: [    8.157868] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff8803f41881c0
> data:ffff8803f41881bf tail:0x58 end:0x80 dev:can1
> Jun 30 15:01:59 vpc6 kernel: [   11.481219] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff8802150f8540
> data:ffff8802150f853f tail:0x58 end:0x80 dev:can1
> Jun 30 14:42:13 vpc6 kernel: [    9.660556] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff88021733f1c0
> data:ffff88021733f1bf tail:0x58 end:0x80 dev:can1
> Jun 30 12:55:40 vpc6 kernel: [    8.782069] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff880214f63d40
> data:ffff880214f63d3f tail:0x58 end:0x80 dev:can1
> Jun 30 12:17:30 vpc6 kernel: [   10.016782] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff880217cb9180
> data:ffff880217cb917f tail:0x58 end:0x80 dev:can1
> Jun 30 12:48:04 vpc6 kernel: [    8.720439] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff880214bb88c0
> data:ffff880214bb88bf tail:0x58 end:0x80 dev:can1
> Jun 27 18:46:38 vpc7 kernel: [    7.953504] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff8803f22d0700
> data:ffff8803f22d06ff tail:0x58 end:0x80 dev:can0
> Jun 27 18:54:15 vpc7 kernel: [    8.861305] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff8803f2cdbf00
> data:ffff8803f2cdbeff tail:0x58 end:0x80 dev:can1
> Jun 27 04:57:37 vpc6 kernel: [    8.336231] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff88021a81d780
> data:ffff88021a81d77f tail:0x58 end:0x80 dev:can1
> Jun 27 04:57:37 vpc6 kernel: [    8.336251] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff880218756740
> data:ffff88021875673f tail:0x58 end:0x80 dev:can0
> Jun 23 00:22:42 vpc7 kernel: [    7.924303] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff8803f21e7e00
> data:ffff8803f21e7dff tail:0x58 end:0x80 dev:can0
> Jun 17 04:04:30 vpc6 kernel: [    7.776512] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff880215b19500
> data:ffff880215b194ff tail:0x58 end:0x80 dev:can1
> Jun 17 03:56:57 vpc6 kernel: [   11.906063] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff88021830a140
> data:ffff88021830a13f tail:0x58 end:0x80 dev:can0
> Jun 17 04:12:06 vpc6 kernel: [    7.656869] skbuff: skb_under_panic:
> text:ffffffff81492274 len:89 put:73 head:ffff8802148b4ec0
> data:ffff8802148b4ebf tail:0x58 end:0x80 dev:can0
>
> Any ideas what is causing it?  The issue seems to be that the data
> pointer is less than the head pointer, from reading the code.  It only
> happens right at startup.
>
> Thanks,
>   Austin

And, of course, I forget to tell which hardware I'm using...

$ lspci -v -s 05:00.0
05:00.0 Network controller: PEAK-System Technik GmbH Device 0008 (rev 02)
        Subsystem: PEAK-System Technik GmbH Device 0005
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at e0610000 (32-bit, non-prefetchable) [size=64K]
        Memory at e0600000 (32-bit, non-prefetchable) [size=64K]
        Kernel driver in use: peak_pci

Austin
