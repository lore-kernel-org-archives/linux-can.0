From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: CPU load inhibits CAN interrupts
Date: Tue, 10 Apr 2012 19:48:03 +0200
Message-ID: <4F847253.5080507@grandegger.com>
References: <4F84464E.7030403@mobile.put.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:58676 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab2DJRsO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Apr 2012 13:48:14 -0400
In-Reply-To: <4F84464E.7030403@mobile.put.edu.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Krzysztof Witkowski <Krzysztof.Witkowski@mobile.put.edu.pl>
Cc: linux-can@vger.kernel.org

On 04/10/2012 04:40 PM, Krzysztof Witkowski wrote:
> I have an Ubuntu box with 3.2 kernel, CPU with 2 cores and PEAK-PCI card
> (SJA1000 controller attached via PCI bus)
> 
> I'm testing receive capabilities of the card on 1Mbit network using
> peak_pci module. It can handle about ~4000 packets per second, the
> corresponding interrupt is also raised ~4000 times per second (as
> /proc/interrupts shows) and it does not cause high CPU load on the system.
> 
> However, if I generate artificial CPU load with stress command:
> 
>    chrt --idle 0 stress -c 2

What does "-c 2" do? My "chrt" command does not have that option.

> the Receive Interrupts from SJA1000 are no longer raised at all and
> therefore no messages are received. At the same time network card (e100)
> on the same IRQ is working properly.

That's wired. Interrupt processing of the SJA1000 is done in the
interrupt context.

> Why CPU load inhibits hardware interrupts and what can be done about it?

Hm, what does "ip -d -s can0" report while you are producing CPU load
with the stress command above.

> Or should I suspect hardware malfunction?

More likely it's a bug.

Wolfgang.
