From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: [PATCH v2 00/11] RFC: cleanup flexcan driver, introduce and make use of IRQ offloading
Date: Mon, 18 Jan 2016 12:14:45 +0100
Message-ID: <87egdf5eca.fsf@gmail.com>
References: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33238 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbcARLOt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jan 2016 06:14:49 -0500
Received: by mail-wm0-f68.google.com with SMTP id u188so15875036wmu.0
        for <linux-can@vger.kernel.org>; Mon, 18 Jan 2016 03:14:48 -0800 (PST)
In-Reply-To: <1449750837-11376-1-git-send-email-mkl@pengutronix.de> (Marc
	Kleine-Budde's message of "Thu, 10 Dec 2015 13:33:46 +0100")
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, bhupesh.sharma@freescale.com

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> Testing and feedback welcome.

And here it is, albeit a bit late:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at /home/schurig/d/mkarm/linux-4.4/drivers/net/can/rx-fifo.c:203 can_rx_fifo_irq_offload+0x214/0x264()
can_rx_fifo_irq_offload: No messages found, RX-FIFO out of sync?
Modules linked in: bnep btusb btrtl btbcm btintel bluetooth smsc95xx usbnet mii imx_sdma flexcan dlog(O)
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O    4.4.0 #1
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Backtrace:
[<c0012694>] (dump_backtrace) from [<c001288c>] (show_stack+0x18/0x1c)
 r6:c04def61 r5:00000009 r4:00000000 r3:00200000
[<c0012874>] (show_stack) from [<c01b87a4>] (dump_stack+0x88/0xd4)
[<c01b871c>] (dump_stack) from [<c001ecd8>] (warn_slowpath_common+0x90/0xbc)
 r4:c0559dd8 r3:c0558000
[<c001ec48>] (warn_slowpath_common) from [<c001ed3c>] (warn_slowpath_fmt+0x38/0x40)
 r8:00000000 r7:00040008 r6:00000010 r5:00000000 r4:ee952570
[<c001ed08>] (warn_slowpath_fmt) from [<c02913a8>] (can_rx_fifo_irq_offload+0x214/0x264)
 r3:c041894e r2:c04def9b
[<c0291194>] (can_rx_fifo_irq_offload) from [<bf008da4>] (flexcan_irq+0xcc/0x188 [flexcan])
 r8:00000000 r7:00040008 r6:00000010 r5:f0b30000 r4:ee952000 r3:fffffffc
[<bf008cd8>] (flexcan_irq [flexcan]) from [<c0058b50>] (handle_irq_event_percpu+0x38/0x12c)
fec 2188000.ethernet eth0: MDIO read timeout
 r8:0000001a r7:00000000 r6:ef1316c0 r5:00000000 r4:ee25f800 r3:bf008cd8
[<c0058b18>] (handle_irq_event_percpu) from [<c0058c84>] (handle_irq_event+0x40/0x64)
 r10:00000000 r9:ef7dc6c0 r8:ef008000 r7:0000001a r6:ef131720 r5:ef131720
 r4:ef1316c0
[<c0058c44>] (handle_irq_event) from [<c005bff4>] (handle_fasteoi_irq+0xb0/0x12c)
 r6:ef131720 r5:c055def0 r4:ef1316c0 r3:00000000
[<c005bf44>] (handle_fasteoi_irq) from [<c0058288>] (generic_handle_irq+0x20/0x30)
 r6:c0553080 r5:00000000 r4:00000000 r3:c005bf44
[<c0058268>] (generic_handle_irq) from [<c0058590>] (__handle_domain_irq+0x94/0xbc)
[<c00584fc>] (__handle_domain_irq) from [<c00093fc>] (gic_handle_irq+0x4c/0x78)
 r8:c05478c0 r7:f4001100 r6:c0559f18 r5:c055a744 r4:f4000100 r3:c0559f18
[<c00093b0>] (gic_handle_irq) from [<c0013354>] (__irq_svc+0x54/0x90)
Exception stack(0xc0559f18 to 0xc0559f60)
9f00:                                                       00000000 002d4f24
9f20: ef7aa2d4 c001a420 c0558000 c055a4d8 c0559f88 c055a4d8 c05478c0 ef7dc6c0
9f40: 00000000 c0559f74 c0559f78 c0559f68 c000faa8 c000faac 60070013 ffffffff
 r7:c0559f4c r6:ffffffff r5:60070013 r4:c000faac
[<c000fa78>] (arch_cpu_idle) from [<c0050c68>] (default_idle_call+0x30/0x34)
[<c0050c38>] (default_idle_call) from [<c0050d80>] (cpu_startup_entry+0x114/0x17c)
[<c0050c6c>] (cpu_startup_entry) from [<c03e3d3c>] (rest_init+0x7c/0x94)
 r7:c055a400 r3:c0558000
[<c03e3cc0>] (rest_init) from [<c0524c4c>] (start_kernel+0x304/0x35c)
 r4:00000000 r3:c0558000
[<c0524948>] (start_kernel) from [<10008078>] (0x10008078)
---[ end trace 9a14375964ae8903 ]---
------------[ cut here ]------------

Kernel is 4.4 with ...

flexcan/flexcan-calculate-default-value-for-imask1-during-runtime.patch
flexcan/flexcan-make-TX-mailbox-selectable-during-runtime.patch
flexcan/rx-fifo-Add-support-for-simple-irq-offloading.patch
flexcan/flexcan-make-use-of-rx-fifos-irq_offload_simple.patch
flexcan/flexcan-add-missing-register-definitions.patch
flexcan/flexcan-activate-individual-RX-masking-and-initialize-reg_rximr.patch
flexcan/flexcan-add-quirk-FLEXCAN_QUIRK_ENABLE_EACEN_RRS.patch
flexcan/flexcan-reg_imask2_default.patch
flexcan/rx-fifo-introduce-software-rx-fifo-implementation.patch
flexcan/flexcan-add-support-for-rx-fifo-based-software-FIFO-implementation.patch
flexcan/flexcan-switch-imx6-and-vf610-to-software-based-fifo.patch
