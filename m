From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: SocketCAN: Matlab support
Date: Mon, 19 May 2014 16:06:15 +0200
Message-ID: <201405191606.15857.pisa@cmp.felk.cvut.cz>
References: <CAGm1_ktOSQwWgmoZFuBtn0+hJ4zWiEs7iukzEZoQJWNu+zeDHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:12467 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317AbaESOGg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 10:06:36 -0400
In-Reply-To: <CAGm1_ktOSQwWgmoZFuBtn0+hJ4zWiEs7iukzEZoQJWNu+zeDHA@mail.gmail.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Michal Sojka <sojkam1@fel.cvut.cz>

Hello Yegor,

we have some experience there with Simulink on Linux
with fully preemptive-kernel there at CTU.

Mainly my colleague, Michal Sojka, and his students work
on Simulink embedded coded support. CAN blockset
for embedded Cortex-R4 system is expected to be finished
in next two or three months. This work is part
of our TMS570LS3137 Simulink support.

 http://rtime.felk.cvut.cz/rpp-tms570/

When we have CAN support compliant to the common
Simulink CAN blocks rules implemented for this target
we expect to port that implementation to SocketCAN
and integrate it with our Linux Target for Simulink
Embedded Coder project

  http://lintarget.sourceforge.net/

So that is our actual state of progress in this
area. We would be happy to find others with
interrest in similar projects.

Best wishes,

             Pavel Pisa

On Friday 16 of May 2014 12:14:45 Yegor Yefremov wrote:
> Has anyone experience with Matlab and SocketCAN? So far I couldn't
> find anything usable via Google.
>
> Regards,
> Yegor
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
