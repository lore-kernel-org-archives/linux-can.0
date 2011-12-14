From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: backporting can & can-j1939
Date: Wed, 14 Dec 2011 16:43:51 +0100
Message-ID: <20111214154351.GB6112@e-circ.dyndns.org>
References: <20111209150133.GA1470@e-circ.dyndns.org>
 <loom.20111209T175414-826@post.gmane.org>
 <20111212081217.GA351@e-circ.dyndns.org>
 <loom.20111212T121257-904@post.gmane.org>
 <20111212124031.GD351@e-circ.dyndns.org>
 <loom.20111212T160733-221@post.gmane.org>
 <20111213095312.GC430@e-circ.dyndns.org>
 <loom.20111213T155714-170@post.gmane.org>
 <20111213155110.GA314@e-circ.dyndns.org>
 <loom.20111214T140958-737@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:11485 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932110Ab1LNPn4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 14 Dec 2011 10:43:56 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111214T140958-737@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Wed, Dec 14, 2011 at 01:29:08PM +0000, Wolfgang wrote:
> Your proposal worked perfect, I can still hardly believe it.

Ok, that relieves a bit the pressure.
> 
> on the target:
> 
> $ dmesg | fgrep -i can
> 
> mpc52xx_can 80001300.mscan: MSCAN at 0xd1080300, irq 16, clock 100000000 Hz
> mpc52xx_can 80001380.mscan: MSCAN at 0xd1084380, irq 17, clock 100000000 Hz
> can: controller area network core (rev 20090105 abi 8)
> can: raw protocol (rev 20090105)
> can: broadcast manager protocol (rev 20090105 t)
> can: netlink gateway (rev 20101209)
> can: SAE J1939
> 
> 
> but when I type (according  to the j1939.txt)
> 
> $ ip link set can0 j1939 on

Hold here: Your 2.6.31 is too old for this feature.
You must do : $ echo can0 > /proc/net/can-j1939/net
as a legacy measure.

You will be able to use $ip for adding/removing addressing info.

> 
> it says:
> 
> Error: either "dev" is duplicate, or "j1939" is a garbage.

This makes me think you have the original 'stock' iproute2, and not
the iproute2-j1939 one (but I'm not sure yet today).

I'll come back on this tomorrow...
Kurt

> 
> Thank you very much so far!!

Thank you for the patience with operating as a 'test user'!

Kurt
