From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: AW: CAN Interface on Toradex Board
Date: Thu, 24 Oct 2013 09:28:27 +0200
Message-ID: <35798e892fe0606d15b87c9b366199dc@grandegger.com>
References: <F1A135976112904197F6276B89309FEF2603BC@sgexc1.bfft.de>
 <526805E9.1060702@hartkopp.net>
 <F1A135976112904197F6276B89309FEF2603E1@sgexc1.bfft.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from uranus.manitu.net ([217.11.48.8]:59729 "EHLO uranus.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358Ab3JXH23 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 24 Oct 2013 03:28:29 -0400
In-Reply-To: <F1A135976112904197F6276B89309FEF2603E1@sgexc1.bfft.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Spies, Raphael | BFFT GmbH" <raphael.spies@bfft.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On Thu, 24 Oct 2013 06:44:30 +0000, "Spies, Raphael | BFFT GmbH"

<raphael.spies@bfft.de> wrote:

> Hello everyone,

> 

> thanks for the help so far..

> 

> 

>> 	Can you see the can0 interface itself?

> 

> Yes, I Can see the can interface. IP Link shows:

> 

> 2: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT qlen 10

>     link/can 

>     can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0 

>     bitrate 0 sample-point 0.000 

>     tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0

>     sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1

>     clock 12000000

> 

>>	when invoking 'dmesg' ?

> 

> [    2.067414] CAN device driver interface

> [    2.079435] sja1000 CAN netdevice driver

> [    2.092644] sja1000_platform sja1000_platform.0: sja1000_platform

> device registered (reg_base=c9800000, irq=192)

> ...

> [    5.051783] can: controller area network core (rev 20090105 abi 8)

> [    5.063383] NET: Registered protocol family 29

> [    5.072990] can: raw protocol (rev 20090105)

> [    5.082193] can: broadcast manager protocol (rev 20090105 t)

> 

> 

>> 	This looks like the installed iproute2 package is broken.

> 

> I downloaded them from the given link in the documentation:

>

http://developer.toradex.com/files/toradex-dev/uploads/media/Colibri/Linux/Extra/can-packages.tar.bz2

> on the distribution in the image V2 of Toradex there is due to the

> hardfloat architecture no working package manager, so I have to install

> them manually

> 

> 

>>	 ls -l `which ip`

>>	 to check if 'ip' is linked to the busybox binary.

> 

> "Which ip" gives "/bin/ip" and is in my opinion linked to iproute2



What does "ip link help" list?



Wolfgang.
