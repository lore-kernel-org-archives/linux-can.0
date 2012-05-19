From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Strange error with jspy utility
Date: Sat, 19 May 2012 11:06:01 +0200
Message-ID: <4FB76279.6040201@hartkopp.net>
References: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:39313 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab2ESJGC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 19 May 2012 05:06:02 -0400
In-Reply-To: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Abdul Khan <akhan@symboticware.com>
Cc: linux-can@vger.kernel.org

Hi Abdul,

On 18.05.2012 23:50, Abdul Khan wrote:

> I am facing strange error with jspy utility provided with j1939-utils
> package. I am using can-j1939-utils, iproute2 and
> can-j1939-linux-3.3.0-rc6 provided by Kurt.


Are you sure that at least your CAN interfaces are running properly?

> #./dmesg | grep can
> 
> OUTPUT:
> ===================
> [    1.289519] rtc_cmos 00:05: RTC can wake from S4
> [    1.455446] md: Scanned 0 and added 0 devices.
> [    4.561925] can: controller area network core (rev 20090105 abi 8)
> [    4.563889] can: raw protocol (rev 20090105)
> [    4.601750] sja1000_isa sja1000_isa.0: can0: bit-timing not yet defined
> [    4.606770] sja1000_isa sja1000_isa.1: can1: bit-timing not yet defined
> [  598.521246] can: SAE J1939
> ===================


The sja1000 interfaces usually tell you when the are set in dmesg.
This is definitely missing in this grep'ed output.

E.g.

# ip -details link show

Should give something like this:

8: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
    link/can
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 500000 sample-point 0.875
    tq 125 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
9: can1: <NOARP,ECHO> mtu 16 qdisc noop state DOWN qlen 10
    link/can
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
    bitrate 500000 sample-point 0.812
    tq 125 prop-seg 6 phase-seg1 6 phase-seg2 3 sjw 1
    sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000

Regards,
Oliver
