From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: sja1000 interrupt problem
Date: Sat, 09 Nov 2013 20:42:18 +0100
Message-ID: <527E901A.4070907@grandegger.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>	<3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>	<99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>	<CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>	<5254608B.4080208@grandegger.com>	<CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com>	<be0d6725fff5298d3fb8417e4800348b@grandegger.com>	<CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com>	<84ba410d04a85a783d1c1994f98d1f31@grandegger.com> <CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:43435 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756302Ab3KITmX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 9 Nov 2013 14:42:23 -0500
In-Reply-To: <CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Austin,

On 11/08/2013 12:43 AM, Austin Schuh wrote:
>>>
>>> The dump is attached.
>>
>> I do not see any sja1000_rx() calls. Either they never happen or more
>> likely the trace is not long enough. Could you try with a larger buffer
>> using "echo 20000 > buffer_size_kb"? I also do not see some pr_info()
>> related functions at the end of the trace. Are you sure is has stopped
>> (cat tracing_on or message in dmesg)?
>>
>> Also please do an "echo 0 > trace" to clear the trace content.
>>
>> Wolfgang.
> 
> Hi Wolfgang,
> 
> I'm pretty certain that the trace is long enough.  I tried again with
> echo -e -n 100000 > buffer_size_kb and I still don't see any calls to
> sja1000_rx.
> 
> I added some pr_info prints at the front of sja1000_rx and
> sja1000_interrupt.  For each packet sent and then received, I see the
> following.  The following lines are from me sending 4 packets.

sja1000_interrupt() is normally called for each SJA1000 device (shared
interrupt).

> Nov  7 15:35:52 vpc5 kernel: [   75.136107] Got an sja1000 interrupt.
> Nov  7 15:35:52 vpc5 kernel: [   75.136123] Unhandled IRQ 18... stop tracing...

I'm confused. Why is the IRQ "unhandled" without calling
sja1000_interrupt() twice. Ah, this is due to threaded interrupt
handling, where the spurious interrupt check is called for each
handler/device. Therefore the trigger is simply bad.

> Nov  7 15:35:52 vpc5 kernel: [   75.136130] Got an sja1000 interrupt.
> Nov  7 15:35:52 vpc5 kernel: [   75.136139] Received packet.
> Nov  7 15:35:52 vpc5 kernel: [   75.136146] sja1000_rx
> Nov  7 15:35:52 vpc5 kernel: [   75.136155] TX complete.
> Nov  7 15:35:52 vpc5 kernel: [   75.136174] Returning IRQ_HANDLED
> Nov  7 15:35:52 vpc5 kernel: [   75.136207] Returning IRQ_HANDLED
...

This is the working case. How does it look like when the device stops
receiving messages. You should also label the device.

> I didn't rerun any traces, since my analysis of the syslog is that it
> won't give you the information you are looking for without moving the
> tracing_off call somewhere else.

Well, we know that messages are received properly for some time. We need
to trigger the malfunctioning. I understood that it happens just once a
day that the interrupts get stuck, right?

Wolfgang.
