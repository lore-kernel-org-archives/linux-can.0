From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Kernel-Warning when stopping the CAN interface
Date: Thu, 12 Mar 2020 08:05:44 +0100
Message-ID: <38dccda1-ca41-bc5d-01fb-70050d16730d@grandegger.com>
References: <c72f924a-8736-1f54-c5ab-4f5cfe6af9ed@grandegger.com>
 <4c5cd8bd-3d4d-4826-9333-0d0f23b30f5a@schneidersoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:40518 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387959AbgCLHFr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Mar 2020 03:05:47 -0400
In-Reply-To: <4c5cd8bd-3d4d-4826-9333-0d0f23b30f5a@schneidersoft.net>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maximilian Schneider <max@schneidersoft.net>
Cc: linux-can@vger.kernel.org

Hello Maximilian,

I think, the problem is not gs_usb specific. The following patch seems
to help:

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -321,7 +321,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	netdev = dev->netdev;
 	stats = &netdev->stats;
 
-	if (!netif_device_present(netdev))
+	if (!netif_device_present(netdev) || !netif_running(netdev))
 		return;
 
 	if (hf->echo_id == -1) { /* normal rx */

Wolfgang

Am 12.03.20 um 07:06 schrieb Maximilian Schneider:
> I guess the naive solution would be to test dev->state in the RX
> callback. I doubt that's the best solution thought. Is it known if this
> warning affects only the gs_usb driver?





> On 11 Mar 2020, at 16:53, Wolfgang Grandegger <wg@grandegger.com
> <mailto:wg@grandegger.com>> wrote:
> 
>     Hello,
> 
>     I can easily trigger the kernel warning below with a "gs_usb" device when
>     I send messages with "cangen -g1 can0" and then stop the interface with
>     "ifconfig can0 down". The warning comes from here:
> 
>       https://elixir.bootlin.com/linux/latest/source/net/core/skbuff.c#L651
> 
>     What happens is that the "ifconfig down" command first sets
> 
>       clear_bit(__LINK_STATE_START, &dev->state);
> 
>     before it calls the device specific stop/close routine. In the meantime,
>     TX done events may still occur, calling can_get_echo_skb(), which calls
>     netif_rx() then netif_rx_internal() and finally enqueue_to_backlog().
>     Because the interface is not running any longer, the skb is dropped in
>     there:
> 
>       https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L4394
> 
>     causing the warning below, because the kfree_skb(skb) is called from
>     the interrupt context.
> 
>     How can I avoid that warning? Actually, I do not see a simple method.
>     Maybe I have missed something.
> 
>     Wolfgang
> 
>     [ 1694.131475] ------------[ cut here ]------------
>     [ 1694.139911] WARNING: CPU: 0 PID: 0 at skb_release_head_state+0x9e/0xb0
>     [ 1694.147206] Modules linked in: intel_telemetry_pltdrv intel_pmc_ipc intel_punit_ipc intel_telemetry_core x86_pkg_temp_thermal igb tpm_tis tpm_tis_core btusb btrtl dca tpm lpc_ich btbcm spi_pxa2xx_platform mei_me btintel mei thermal rfcomm bluetooth ecdh_generic ntngdm_i2c ntngdm_core ntngdm_bl ntngdm_tsi ntngdm_irq ntngdm_hwmon i915 video
>     [ 1694.180782] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U  W       4.14.51apollolake #1
>     [ 1694.189828] Hardware name: Default string Default string/AGCO_NT-NG, BIOS X3.00c#AGCO BETA 09/19/2019
>     [ 1694.200136] task: ffffffff840104c0 task.stack: ffffffff84000000
>     [ 1694.206753] RIP: 0010:skb_release_head_state+0x9e/0xb0
>     [ 1694.212494] RSP: 0018:ffff8b2b3fc03cb0 EFLAGS: 00010006
>     [ 1694.218333] RAX: ffffffff835a4fb0 RBX: ffff8b2b3a20b100 RCX: 0000000000000018
>     [ 1694.226310] RDX: 0000000000010000 RSI: 0000000000000000 RDI: 0000000000000000
>     [ 1694.234284] RBP: 0000000000020ac0 R08: 0000000000000014 R09: 0000000000000014
>     [ 1694.242259] R10: 0000000000000000 R11: ffff8b2b3a7a2180 R12: ffff8b2b3fc03d40
>     [ 1694.250235] R13: ffff8b2b3a20b100 R14: ffff8b2b3fc20bcc R15: 0000000000000086
>     [ 1694.258211] FS:  0000000000000000(0000) GS:ffff8b2b3fc00000(0000) knlGS:0000000000000000
>     [ 1694.267256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [ 1694.273678] CR2: 00007f83a2db5130 CR3: 0000000179c6a000 CR4: 00000000003406f0
>     [ 1694.281653] Call Trace:
>     [ 1694.284383]  <IRQ>
>     [ 1694.286629]  skb_release_all+0x9/0x20
>     [ 1694.290720]  kfree_skb+0x19/0x40
>     [ 1694.294327]  enqueue_to_backlog+0x7e/0x230
>     [ 1694.298906]  ? recalibrate_cpu_khz+0x10/0x10
>     [ 1694.303677]  ? ktime_get_with_offset+0x4f/0xb0
>     [ 1694.308644]  netif_rx_internal+0x56/0x150
>     [ 1694.313126]  can_get_echo_skb+0x37/0x60
>     [ 1694.317415]  gs_usb_receive_bulk_callback+0x111/0x320
>     [ 1694.323063]  __usb_hcd_giveback_urb+0x7b/0xf0
>     [ 1694.327924]  xhci_giveback_urb_in_irq.isra.55+0x6d/0x90
>     [ 1694.333765]  xhci_td_cleanup+0xcb/0x150
>     [ 1694.338051]  xhci_irq+0x66a/0x20b0
>     [ 1694.341854]  ? rcu_accelerate_cbs+0x3a/0x190
>     [ 1694.346628]  __handle_irq_event_percpu+0x32/0xd0
>     [ 1694.351791]  handle_irq_event_percpu+0x2b/0x70
>     [ 1694.356757]  handle_irq_event+0x2f/0x50
>     [ 1694.361044]  handle_edge_irq+0x72/0x190
>     [ 1694.365331]  handle_irq+0x17/0x20
>     [ 1694.369038]  do_IRQ+0x3c/0xc0
>     [ 1694.372355]  common_interrupt+0x7a/0x7a
>     [ 1694.376639]  </IRQ>
>     [ 1694.378981] RIP: 0010:cpuidle_enter_state+0x122/0x200
>     [ 1694.384622] RSP: 0018:ffffffff84003ea8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffffbd
>     [ 1694.393087] RAX: ffff8b2b3fc1fa00 RBX: 0000000000000002 RCX: 0000018a721a5ae8
>     [ 1694.401063] RDX: 0000018a721a5ae8 RSI: 0000000050523fbe RDI: 0000000000000000
>     [ 1694.409040] RBP: ffff8b2b3aa13600 R08: 0000000000000193 R09: 000000000000012a
>     [ 1694.417015] R10: ffffffff84003e90 R11: 00000000000000ef R12: 0000018a721a5ae8
>     [ 1694.424990] R13: 0000018a72199308 R14: 0000000000000002 R15: 0000000072efca78
>     [ 1694.432970]  ? cpuidle_enter_state+0x11e/0x200
>     [ 1694.437937]  do_idle+0x161/0x1a0
>     [ 1694.441544]  cpu_startup_entry+0x6a/0x70
>     [ 1694.445927]  start_kernel+0x414/0x434
>     [ 1694.450023]  secondary_startup_64+0xa5/0xb0
>     [ 1694.454697] Code: 88 96 4f 17 00 74 02 5b c3 5b e9 4e 15 bc ff e8 d9 33 04 00 eb dd e8 c2 5a 0d 00 eb 9f 48 83 e7 fe e8 07 d7 01 00 e9 75 ff ff ff <0f> 0b eb ad 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 53 48 89 
>     [ 1694.475869] ---[ end trace 063196a1141471b3 ]---
> 
