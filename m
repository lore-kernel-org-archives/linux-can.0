From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: can acknowledgment
Date: Thu, 05 Sep 2013 22:12:40 +0200
Message-ID: <5228E5B8.3010201@grandegger.com>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com> <11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp> <CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com> <818b112277dbc87b883edf93f165ecff@grandegger.com> <CAJU5jULyMTQYRuaJ2UMgONaGtm8CPfdW4-u1Dtx59ndzUNC=Zw@mail.gmail.com> <6aada00421e51a3bffc2e4354e6fbb34@grandegger.com> <CAJU5jULo5Lu1Qbe2Qibr78OZuAMhyD=bD+vP+xrXERV2ZeN-2A@mail.gmail.com> <430e94b292fb21c91a1f128f83bb8ad3@grandegger.com> <CAJU5jULTsLvi4BrB5kuKC7QGVeUjTKY4ad_UA7sJ9aoXNax__g@mail.gmail.com> <57acf912689fb58466cb5aaac1993a59@grandegger.com> <CAJU5jU+F6t+WSLnsF8j7V2v9WBW+BVqQFf=00E2469RybocjzA@mail.gmail.com> <5228DA82.4050203@grandegger.com> <CAJU5jUKkim-Pp5=VZjUfKUfRYB8b8zufwh9jtYFnhAcaYNgN5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:47607 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab3IEUMm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Sep 2013 16:12:42 -0400
In-Reply-To: <CAJU5jUKkim-Pp5=VZjUfKUfRYB8b8zufwh9jtYFnhAcaYNgN5w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Muldoon <mbmuldoon07@gmail.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

On 09/05/2013 09:45 PM, Michael Muldoon wrote:
> Here it is:
> 
> Linux version 3.2.20 (tomh@turbo_tom) (gcc version 4.5.3 (Buildroot
> 2012.05) ) #2 Wed Dec 5 14:33:28 CST 2012
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
> CPU: VIVT data cache, VIVT instruction cache
> Machine: Atmel AT91SAM9G20-EK

Even if reported, this seems not to be a Atmel AT91SAM9G20-EK board.
What do you find in "arch/arm/mach-at91/board-sam9g20ek.c".

...
> can: controller area network core (rev 20090105 abi 8)
> NET: Registered protocol family 29
> CAN device driver interface
> can: raw protocol (rev 20090105)
> mcp251x spi0.0: probed
> mcp251x spi0.2: probed
> mcp251x spi0.0: CNF: 0x01 0xff 0x02
> mcp251x spi0.2: CNF: 0x01 0xff 0x02

Strange. The latter two line should not show up before the devices are
opened (with ifconfig or ip.. Also "drivers/net/can/mcp251x.c" seems to
be special.

And how to you configure and start the CAN devices?

Wolfgang.


