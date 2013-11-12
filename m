From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: sja1000 interrupt problem
Date: Tue, 12 Nov 2013 15:22:07 -0800
Message-ID: <CANGgnMZM-9cObw=Bh-VCsbn4b68+jhxCEptOaepbNna+KSGZmQ@mail.gmail.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
	<3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com>
	<99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com>
	<CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com>
	<5254608B.4080208@grandegger.com>
	<CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com>
	<be0d6725fff5298d3fb8417e4800348b@grandegger.com>
	<CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com>
	<84ba410d04a85a783d1c1994f98d1f31@grandegger.com>
	<CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com>
	<527E44EB.9020605@hartkopp.net>
	<CANGgnMa6E9wx24YCexcMa=PMCEZBZw9b-Aa1MJR=-3UyDmHdpw@mail.gmail.com>
	<52829CF1.4010902@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:52535 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab3KLXWI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Nov 2013 18:22:08 -0500
Received: by mail-ie0-f173.google.com with SMTP id x13so7994168ief.4
        for <linux-can@vger.kernel.org>; Tue, 12 Nov 2013 15:22:07 -0800 (PST)
In-Reply-To: <52829CF1.4010902@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Tue, Nov 12, 2013 at 1:26 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 12.11.2013 03:59, Austin Schuh wrote:
>
>>> From the trace it is pretty hard to know which CAN interface is in charge.
>>> (2) Can you please add the output of dev->ifindex in the pr_info() calls?
>>
>> Gladly.  See the updated logs.
>>
>> [  556.019246] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
>> [  556.019268] Unhandled IRQ 18... stop tracing...
>> [  556.019280] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
>> [  556.019289] peak_pci 0000:05:00.0 can1: Received packet.
>> [  556.019299] peak_pci 0000:05:00.0 can1: sja1000_rx
>> [  556.019307] peak_pci 0000:05:00.0 can0: TX complete.
>> [  556.019318] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
>> [  556.019362] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED
>>
>
> This looks pretty broken regarding the IRQ handling.
> Maybe the IRQ thread handling has a real problem in the -rt kernel ?!?

Sounds pretty plausible right now.

>>> (3) Is it possible to use a standard (non-RT) kernel on your system to confirm
>>> this issue on a unmodified system?
>>
>> It will be a bit of time before I can schedule enough time on the PC
>> in question with a non-realtime kernel.  I'll see what I can do.
>
> That would be a valuable information to go deeper into this problem.

Here is what is in the syslog from the same machine sending to it's
self with a non-realtime kernel.

# uname -a
Linux vpc5 3.10-3-amd64 #1 SMP Debian 3.10.11-2 (2013-09-10) x86_64 GNU/Linux

<6>[  169.993870] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
<6>[  169.993904] peak_pci 0000:05:00.0 can1: Received packet.
<6>[  169.993923] peak_pci 0000:05:00.0 can1: sja1000_rx
<6>[  169.993994] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED
<6>[  169.994013] peak_pci 0000:05:00.0 can1: Found can1, disabling tracing.
<6>[  169.994029] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
<6>[  169.994048] peak_pci 0000:05:00.0 can0: TX complete.
<6>[  169.994061] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED

<6>[  528.362919] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
<6>[  528.362953] peak_pci 0000:05:00.0 can1: Received packet.
<6>[  528.362970] peak_pci 0000:05:00.0 can1: sja1000_rx
<6>[  528.363038] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED
<6>[  528.363056] peak_pci 0000:05:00.0 can1: Found can1, disabling tracing.
<6>[  528.363071] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
<6>[  528.363088] peak_pci 0000:05:00.0 can0: TX complete.
<6>[  528.363100] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED

When I attach the CAN device which continually sends, I get the
following.  (The front might be snipped improperly, not sure.)

<6>[  640.823323] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
<6>[  640.823331] peak_pci 0000:05:00.0 can1: Returning IRQ_NONE
<6>[  640.823334] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
<6>[  640.823344] peak_pci 0000:05:00.0 can0: Received packet.
<6>[  640.823346] peak_pci 0000:05:00.0 can0: sja1000_rx
<6>[  640.823391] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
<6>[  640.823581] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
<6>[  640.823597] peak_pci 0000:05:00.0 can1: Returning IRQ_NONE
<6>[  640.823604] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
<6>[  640.823618] peak_pci 0000:05:00.0 can0: Received packet.
<6>[  640.823624] peak_pci 0000:05:00.0 can0: sja1000_rx
<6>[  640.823684] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED
<6>[  640.823818] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
<6>[  640.823827] peak_pci 0000:05:00.0 can1: Returning IRQ_NONE
<6>[  640.823829] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
<6>[  640.823838] peak_pci 0000:05:00.0 can0: Received packet.
<6>[  640.823840] peak_pci 0000:05:00.0 can0: sja1000_rx
<6>[  640.823880] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED

Looks like this is related to running a realtime kernel.

> Thanks,
> Oliver
