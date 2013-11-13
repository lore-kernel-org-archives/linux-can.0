From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: sja1000 interrupt problem
Date: Wed, 13 Nov 2013 07:44:23 +0100
Message-ID: <52831FC7.3040509@hartkopp.net>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com> <3a4a0c6ac898fbe27a8fe95cb147634c@grandegger.com> <99984642-b542-4078-a5ba-3dfb66188ce5@email.android.com> <CANGgnMb130WSkOkreRyRg9cXhMn=MXhGmhMqXKMOTkiTMD4vqQ@mail.gmail.com> <5254608B.4080208@grandegger.com> <CANGgnMYN3epBb_b=AywUQbN_LQLu6C6ebCfE0xifzoS0Yw1y1g@mail.gmail.com> <be0d6725fff5298d3fb8417e4800348b@grandegger.com> <CANGgnMZpPGctUWGcg7Lp-QFPc7d6A5GeL9KQYnpeYMR8WukgdA@mail.gmail.com> <84ba410d04a85a783d1c1994f98d1f31@grandegger.com> <CANGgnMY4noiSSTXcuOJo36BXZhh0qOrJN_OXx8EZXE0_Gq4Z1g@mail.gmail.com> <527E44EB.9020605@hartkopp.net> <CANGgnMa6E9wx24YCexcMa=PMCEZBZw9b-Aa1MJR=-3UyDmHdpw@mail.gmail.com> <52829CF1.4010902@hartkopp.net> <CANGgnMZM-9cObw=Bh-VCsbn4b68+jhxCEptOaepbNna+KSGZmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:24727 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab3KMGo0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2013 01:44:26 -0500
In-Reply-To: <CANGgnMZM-9cObw=Bh-VCsbn4b68+jhxCEptOaepbNna+KSGZmQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org



On 13.11.2013 00:22, Austin Schuh wrote:

> Here is what is in the syslog from the same machine sending to it's
> self with a non-realtime kernel.
> 
> # uname -a
> Linux vpc5 3.10-3-amd64 #1 SMP Debian 3.10.11-2 (2013-09-10) x86_64 GNU/Linux
> 
> <6>[  169.993870] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
> <6>[  169.993904] peak_pci 0000:05:00.0 can1: Received packet.
> <6>[  169.993923] peak_pci 0000:05:00.0 can1: sja1000_rx
> <6>[  169.993994] peak_pci 0000:05:00.0 can1: Returning IRQ_HANDLED
> <6>[  169.994013] peak_pci 0000:05:00.0 can1: Found can1, disabling tracing.
> <6>[  169.994029] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
> <6>[  169.994048] peak_pci 0000:05:00.0 can0: TX complete.
> <6>[  169.994061] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED

This looks indeed much better :-)

> 
> When I attach the CAN device which continually sends, I get the
> following.  (The front might be snipped improperly, not sure.)
> 
> <6>[  640.823323] peak_pci 0000:05:00.0 can1: Got an sja1000 interrupt.
> <6>[  640.823331] peak_pci 0000:05:00.0 can1: Returning IRQ_NONE
> <6>[  640.823334] peak_pci 0000:05:00.0 can0: Got an sja1000 interrupt.
> <6>[  640.823344] peak_pci 0000:05:00.0 can0: Received packet.
> <6>[  640.823346] peak_pci 0000:05:00.0 can0: sja1000_rx
> <6>[  640.823391] peak_pci 0000:05:00.0 can0: Returning IRQ_HANDLED

This is a correct behaviour too:

The shared IRQ is handled by can1 (which had nothing to do) and then the chain
goes to can0 which handles the reception correctly.

@Wolfgang: Do we need an additional protection for the PITA handling in
peak_pci.c ?

@Austin:
I have another idea to test, if it just shows up in the mainline driver:

Can you please download the out-of-tree driver from PEAK (version 7.9):

http://www.peak-system.com/linux/index.htm

I wonder if this one actually compiles with a -rt kernel and if it shows up
the same issue then.

Best regards,
Oliver

