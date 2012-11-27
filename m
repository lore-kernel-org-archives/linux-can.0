From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: at91_can.c: Data transmission stops
Date: Tue, 27 Nov 2012 17:31:29 +0100
Message-ID: <50B4EAE1.6070400@grandegger.com>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com> <50B398E6.2070101@rosetechnology.dk> <50B4CA2D.5080309@rosetechnology.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:58576 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab2K0Qbi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Nov 2012 11:31:38 -0500
In-Reply-To: <50B4CA2D.5080309@rosetechnology.dk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Henrik Bork Steffensen <hbs@rosetechnology.dk>
Cc: linux-can@vger.kernel.org

On 11/27/2012 03:11 PM, Henrik Bork Steffensen wrote:
> On 11/26/2012 05:29 PM, Henrik Bork Steffensen wrote:
>> On 11/26/2012 04:25 PM, Wolfgang Grandegger wrote:
>>> On 11/26/2012 03:28 PM, Henrik Bork Steffensen wrote:
>>>> In our case the lockup occurs approximately 1 time in 50 days.
>>> :(
>> Luckily we have 50 systems for in-house testing.
>>
>>
>>>
>>>> I am considering protecting tx objects as Wolfgang suggests in the
>>>> pch_can thread.
>>> This problem is with SMP in the first place. Can you show your .config.
>> I attached my .config.
>>> The c_can driver uses similar code than the at91_can and they have
>>> therefore the same issues if the kernel is preemptable, IIUC. Should not
>>> be a big deal to adapt the following patch:
>>>
>>>    http://marc.info/?l=linux-can&m=135391821814519&w=2
>> I was not aware of the relationship to c_can.
>>
>> I agree, it should be very easy to implement that patch.
>>
> 
> I implemented this patch on our at91_can.c, and it was rather simple to
> find the spots.
> But the compiled kernel gives me this during boot:
> 
> [   86.750000] ------------[ cut here ]------------
> [   86.750000] WARNING: at kernel/softirq.c:143 local_bh_enable+0x4c/0xc8()
> [   86.750000] Modules linked in: reset_state ad_converter_mcp3002
> ohci_hcd ads7846 atmel_lcdfb cfbcopyarea cfbimgblt cfbfillrect pwm ext3
> ipv6 jbd mmc_block at91_mci can_raw can at91_can can_dev led
> at91sam9_wdt rtc_at91sam9
> [   86.750000] [<c0030bb4>] (unwind_backtrace+0x0/0xd0) from
> [<c02c084c>] (dump_stack+0x18/0x1c)
> [   86.750000] [<c02c084c>] (dump_stack+0x18/0x1c) from [<c0048f3c>]
> (warn_slowpath_common+0x50/0x68)
> [   86.750000] [<c0048f3c>] (warn_slowpath_common+0x50/0x68) from
> [<c0048f6c>] (warn_slowpath_null+0x18/0x1c)
> [   86.750000] [<c0048f6c>] (warn_slowpath_null+0x18/0x1c) from
> [<c004f620>] (local_bh_enable+0x4c/0xc8)
> [   86.750000] [<c004f620>] (local_bh_enable+0x4c/0xc8) from
> [<c02512e8>] (sk_filter+0x84/0x8c)
> [   86.750000] [<c02512e8>] (sk_filter+0x84/0x8c) from [<c0236f7c>]
> (sock_queue_rcv_skb+0x34/0x110)
> [   86.750000] [<c0236f7c>] (sock_queue_rcv_skb+0x34/0x110) from
> [<bf02e25c>] (raw_rcv+0x64/0x78 [can_raw])
> [   86.750000] [<bf02e25c>] (raw_rcv+0x64/0x78 [can_raw]) from
> [<bf0220e4>] (can_rcv_filter+0xa8/0x218 [can])
> [   86.750000] [<bf0220e4>] (can_rcv_filter+0xa8/0x218 [can]) from
> [<bf022334>] (can_rcv+0xc8/0x148 [can])
> [   86.750000] [<bf022334>] (can_rcv+0xc8/0x148 [can]) from [<c0241b34>]
> (netif_receive_skb+0x2a0/0x2fc)
> [   86.750000] [<c0241b34>] (netif_receive_skb+0x2a0/0x2fc) from
> [<bf01ac18>] (at91_poll+0x15c/0x380 [at91_can])
> [   86.750000] [<bf01ac18>] (at91_poll+0x15c/0x380 [at91_can]) from
> [<c0242fac>] (net_rx_action+0x7c/0x204)
> [   86.750000] [<c0242fac>] (net_rx_action+0x7c/0x204) from [<c004f3a4>]
> (__do_softirq+0xf8/0x200)
> [   86.750000] [<c004f3a4>] (__do_softirq+0xf8/0x200) from [<c004f8b0>]
> (irq_exit+0x50/0xac)
> [   86.750000] [<c004f8b0>] (irq_exit+0x50/0xac) from [<c002a07c>]
> (asm_do_IRQ+0x7c/0x94)
> [   86.750000] [<c002a07c>] (asm_do_IRQ+0x7c/0x94) from [<c002a9e8>]
> (__irq_svc+0x48/0x8c)
> [   86.750000] Exception stack(0xc03d3f40 to 0xc03d3f88)
> [   86.750000] 3f40: 00000000 0005317f 0005217f 60000013 c03d2000
> c03d63c8 c03fcf44 c03d63c0
> [   86.750000] 3f60: 200241fc 41069265 200241c8 c03d3f94 600000d3
> c03d3f88 c002be64 c002be70
> [   86.750000] 3f80: 60000013 ffffffff
> [   86.750000] [<c002a9e8>] (__irq_svc+0x48/0x8c) from [<c002be70>]
> (default_idle+0x34/0x38)
> [   86.750000] [<c002be70>] (default_idle+0x34/0x38) from [<c002bff0>]
> (cpu_idle+0x68/0xc0)
> [   86.750000] [<c002bff0>] (cpu_idle+0x68/0xc0) from [<c02bed80>]
> (rest_init+0x70/0x84)
> [   86.750000] [<c02bed80>] (rest_init+0x70/0x84) from [<c0008ab8>]
> (start_kernel+0x268/0x2c0)
> [   86.750000] [<c0008ab8>] (start_kernel+0x268/0x2c0) from [<20008034>]
> (0x20008034)
> [   86.750000] ---[ end trace 1dd02412fce3b434 ]---

Hm, could you show your diffs.

> I this case "at91_poll" is basicly the same as "c_can_poll", in both
> cases they call the function with the spinlock in the rx chain.

You don't need to protect against RX. Sorry, forgot that. On the c_can
this is necessary due to concurrent accesses to the same message RAM.

> Looking at the patch Wolfgang sugested, I became uncertain of what this
> patch actually wants to protect.
> Is it the registers in the cpu can interface? (mailboxes and control
> regs, i don't know the hw)

As mentioned above, on the c_can there is definitely a race with the
message ram due to the busy wait after accessing it. See:

  http://lxr.linux.no/#linux+v3.6.8/drivers/net/can/c_can/c_can.c#L237

> Or is it the potential race between "c_can_start_xmit" and "c_can_do_tx" ?
> Or even the access to the net api?
> 
> Would someone care to explain?

I will try. In at91_start_xmit, if we get interrupted

	if (!(at91_read(priv, AT91_MSR(get_tx_next_mb(priv))) &
              AT91_MSR_MRDY) ||
             (priv->tx_next & get_next_mask(priv)) == 0)

		/* HERE */

		netif_stop_queue(dev);

and then at91_irq_tx() is called executing netif_wake_queue() we may end
up with a stopped tx queue. But I'm not yet 100% sure.

Wolfgang.

