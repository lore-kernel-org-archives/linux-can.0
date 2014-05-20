From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Kernel Oops when setting j1939 device on
Date: Tue, 20 May 2014 22:16:54 +0200
Message-ID: <20140520201654.GD25701@vandijck-laurijssen.be>
References: <CAJdBzeATNb2pBOdp5bpx86Bw+K00wYwjgFOuRGbtZSPXvMoBuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:53215 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750832AbaETURB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 May 2014 16:17:01 -0400
Content-Disposition: inline
In-Reply-To: <CAJdBzeATNb2pBOdp5bpx86Bw+K00wYwjgFOuRGbtZSPXvMoBuQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Timothy Vieregge <tvieregge@clearpathrobotics.com>
Cc: linux-can@vger.kernel.org

Hey,

On Tue, May 20, 2014 at 11:21:33AM -0400, Timothy Vieregge wrote:
> After creating a vcan device (vcan0) I run the command
> 
> ip link set vcan0 j1939 on
> 
> and the terminal locks up and and my network goes down.

The backtrace explains this behaviour. You encountered a problem
with the rtnl locks on.

> When I use dmesg it shows a kernel NULL pointer dereference.
> Anyone know if I'm doing something wrong, or if it's a bug?

I should look deeper into this.

> 
> I've attached the dmesg output and I'm running Ubuntu 12.04 with the
> 3.8 kernel in a VM

How did you add the can-j1939 support?
Did you replace can.ko too?

Kurt
