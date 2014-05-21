From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Kernel Oops when setting j1939 device on
Date: Wed, 21 May 2014 21:12:15 +0200
Message-ID: <20140521191215.GA581@vandijck-laurijssen.be>
References: <CAJdBzeATNb2pBOdp5bpx86Bw+K00wYwjgFOuRGbtZSPXvMoBuQ@mail.gmail.com>
 <20140520201654.GD25701@vandijck-laurijssen.be>
 <CAJdBzeBEL=pz4imZvywVwZsjj3o7Gh6JshgKrm3aSbYOjMiZ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:18586 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751801AbaEUTMT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 May 2014 15:12:19 -0400
Content-Disposition: inline
In-Reply-To: <CAJdBzeBEL=pz4imZvywVwZsjj3o7Gh6JshgKrm3aSbYOjMiZ6Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Timothy Vieregge <tvieregge@clearpathrobotics.com>
Cc: linux-can@vger.kernel.org

Hey Timothy,

On Tue, May 20, 2014 at 04:46:10PM -0400, Timothy Vieregge wrote:
> I compiled the j1939-v3.8 branch into the kernel.

To be honest, I do not really understand what you did exactly here.
Did you:
* use an ubuntu kernel and compiled the new kernel next to it.
* use an ubuntu kernel and compiled the new kernel with the .config
  from that sock kernel.
* Use some git repository of the ubuntu kernel and merged can-j1939 into that.
* not use anything of an ubuntu kernel.

Can you clarify.

> Also, I'm using the j1939-v3.6 branch of iproute2-j1939.
> 
> I didn't specifically replace any of the modules, I simply loaded the
> ones that were present in the custom kernel (can, vcan and can_raw).

1. did you "insmod xxx" or "modprobe xxx"
2. Didn't you load can-j1939?

> Although I assume that those were changed during the compilation.
> 
> Let me know if you want any more of my system info. The behaviour was
> reproducible in a clean VM

The thing is, I can't yet reproduce the problem on my 3.8.2 kernel.
So I keep looking around.

Kind regards,
Kurt
