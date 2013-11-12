From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Tue, 12 Nov 2013 23:15:16 +0100
Message-ID: <5282A874.5050809@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>	<3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>	<99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>	<CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>	<5254608B.4080208@grandegger.com>	<CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com>	<be0d6725fff5298d3fb8417e4800348b@grandegger.com>	<CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com>	<84ba410d04a85a783d1c1994f98d1f31@grandegger.com>	<CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com>	<527E901A.4070907@grandegger.com> <CANGgnMbb+VResUC6h+cK6Hfe5PLJx9R9ao6bMdJM2e5BPaDamw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36372 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab3KLWPU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2013 17:15:20 -0500
In-Reply-To: <CANGgnMbb+VResUC6h+cK6Hfe5PLJx9R9ao6bMdJM2e5BPaDamw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Austin,

On 11/12/2013 03:59 AM, Austin Schuh wrote:
> Hi Wolfgang,
> 
> On Sat, Nov 9, 2013 at 11:42 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Hi Austin,
>>
>> On 11/08/2013 12:43 AM, Austin Schuh wrote:
>>>>>
>>>>> The dump is attached.
>>>>
>>>> I do not see any sja1000_rx() calls. Either they never happen or more
>>>> likely the trace is not long enough. Could you try with a larger buffer
>>>> using "echo 20000 > buffer_size_kb"? I also do not see some pr_info()
>>>> related functions at the end of the trace. Are you sure is has stopped
>>>> (cat tracing_on or message in dmesg)?
>>>>
>>>> Also please do an "echo 0 > trace" to clear the trace content.
>>>>
>>>> Wolfgang.
>>>
>>> Hi Wolfgang,
>>>
>>> I'm pretty certain that the trace is long enough.  I tried again with
>>> echo -e -n 100000 > buffer_size_kb and I still don't see any calls to
>>> sja1000_rx.
>>>
>>> I added some pr_info prints at the front of sja1000_rx and
>>> sja1000_interrupt.  For each packet sent and then received, I see the
>>> following.  The following lines are from me sending 4 packets.
>>
>> sja1000_interrupt() is normally called for each SJA1000 device (shared
>> interrupt).
>>
>>> Nov  7 15:35:52 vpc5 kernel: [   75.136107] Got an sja1000 interrupt.
>>> Nov  7 15:35:52 vpc5 kernel: [   75.136123] Unhandled IRQ 18... stop tracing...
>>
>> I'm confused. Why is the IRQ "unhandled" without calling
>> sja1000_interrupt() twice. Ah, this is due to threaded interrupt
>> handling, where the spurious interrupt check is called for each
>> handler/device. Therefore the trigger is simply bad.
>>
>>> Nov  7 15:35:52 vpc5 kernel: [   75.136130] Got an sja1000 interrupt.
>>> Nov  7 15:35:52 vpc5 kernel: [   75.136139] Received packet.
>>> Nov  7 15:35:52 vpc5 kernel: [   75.136146] sja1000_rx
>>> Nov  7 15:35:52 vpc5 kernel: [   75.136155] TX complete.
>>> Nov  7 15:35:52 vpc5 kernel: [   75.136174] Returning IRQ_HANDLED
>>> Nov  7 15:35:52 vpc5 kernel: [   75.136207] Returning IRQ_HANDLED
>> ...
>>
>> This is the working case. How does it look like when the device stops
>> receiving messages. You should also label the device.
> 
> I haven't been able to run the code long enough with all the debug
> turned on because my syslog grows way too big.  This only happens on
> the PC connected to the highly loaded CAN bus.  I have another PC
> connected to a lightly loaded bus, and I don't see nearly as many
> problems with that PC.  I just figured out how to not fill my syslog
> up, so I'll get back to you when I have something interesting to show.
> 
>>> I didn't rerun any traces, since my analysis of the syslog is that it
>>> won't give you the information you are looking for without moving the
>>> tracing_off call somewhere else.
>>
>> Well, we know that messages are received properly for some time. We need
>> to trigger the malfunctioning. I understood that it happens just once a
>> day that the interrupts get stuck, right?
>>
>> Wolfgang.
> 
> I now have a number of datapoints.  These are the timestamps from when
> it disabled the IRQ.  After each of these, I rebooted the machine to
> be safe, though it works to instead take the interface down and bring
> it back up again.  I'm seeing anywhere from 13 hours - 2 hours.
> 
> [47430.043798] Disabling IRQ #18
> [21439.136781] Disabling IRQ #18
> [5641.564900] Disabling IRQ #18
> [45129.357272] Disabling IRQ #18

Be aware that it prints these messages not before having detected more
than 99000 unhandled IRQs in sequence. See:

  http://lxr.linux.no/#linux+v3.12/kernel/irq/spurious.c#L308

Either the SJA1000 is stuck or the interrupt does not go away. Maybe we
have a race with interrupt acknowledgement.

> I moved the trace disable to the end of sja1000_interrupt when I get
> an interrupt from can1, since that is the last event in the trace.
> Attached is the new trace.  It should have more interesting
> information in it.

This does disable the trace after the first interrupt served for CAN1.
Or do I miss something? What do you want to trigger?

>>From the syslog:
> Nov 11 17:56:14 vpc5 kernel: [   79.069060] Unhandled IRQ 18...
> irqs_unhandled: 1, irq_count: 27
> Nov 11 17:56:14 vpc5 kernel: [   79.069097] peak_pci 0000:05:00.0
> can0: Got an sja1000 interrupt.
> Nov 11 17:56:14 vpc5 kernel: [   79.069113] peak_pci 0000:05:00.0
> can1: Got an sja1000 interrupt.
> Nov 11 17:56:14 vpc5 kernel: [   79.069132] peak_pci 0000:05:00.0
> can1: Received packet.
> Nov 11 17:56:14 vpc5 kernel: [   79.069157] peak_pci 0000:05:00.0
> can0: TX complete.
> Nov 11 17:56:14 vpc5 kernel: [   79.069161] peak_pci 0000:05:00.0
> can1: sja1000_rx
> Nov 11 17:56:14 vpc5 kernel: [   79.069199] peak_pci 0000:05:00.0
> can0: Returning IRQ_HANDLED
> Nov 11 17:56:14 vpc5 kernel: [   79.069242] peak_pci 0000:05:00.0
> can1: Returning IRQ_HANDLED
> Nov 11 17:56:14 vpc5 kernel: [   79.069269] peak_pci 0000:05:00.0
> can1: Found can1, disabling tracing.

If you use FTRACE, please remove these prinkt's.

> Instead of sending packets between the CAN interfaces, I grabbed
> another CAN device and am using it to send packets on the bus.  This
> is the configuration that I have been seeing the real failures in.  I
> now have 2 machines with the CAN device attached to see if I can catch
> the kprintfs when it dies.  Hopefully one of them will have died by
> tomorrow morning and I'll be able to find something interesting.

It's good to make the test case as simple as possible. If I understand
correctly, just CAN1 does then receive messages.

Concerning the trigger. Maybe it's already sufficient to stop the trace
after 10 (or even less) unhandled IRQ 18 by adding:

	if (unlikely(desc->irqs_unhandled == 10)) {
		tracing_off();
		printk("%s: tracing stopped\n", __func__);
	}


in note_interrupt here:

  http://lxr.linux.no/#linux+v3.12/kernel/irq/spurious.c#L306.

Other things to check:

- do the following checks in sja1000_interrupt ever return IRQ_NONE?

  /* check for absent controller due to hw unplug */
        if (status == 0xFF && sja1000_is_absent(priv))
               return IRQ_NONE;

- What is the value of the PITA_ICR register when the device is stuck
  (IRQ 18 disabled)? See:

  http://lxr.linux.no/#linux/drivers/net/can/sja1000/peak_pci.c#L539

Hope it helps to find the problem.

Wolfgang.

