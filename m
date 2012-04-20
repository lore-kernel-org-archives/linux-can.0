From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: CAN messages being lost on i.MX25 with flexcan
Date: Fri, 20 Apr 2012 09:59:29 +0200
Message-ID: <4F911761.6040807@grandegger.com>
References: <jmonvu$nu8$1@dough.gmane.org> <4F8FEF02.7040503@grandegger.com> <jmoses$rmu$1@dough.gmane.org> <4F8FFAB3.1040906@grandegger.com> <jmouls$dcl$1@dough.gmane.org> <4F901500.9070009@grandegger.com> <jmqtg4$pa5$1@dough.gmane.org> <4F90FC53.9030709@grandegger.com> <jmqv1m$38p$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:56879 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab2DTH7b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Apr 2012 03:59:31 -0400
In-Reply-To: <jmqv1m$38p$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

On 04/20/2012 08:17 AM, Martin Kozusky wrote:
> Dne 20.4.2012 8:04, Wolfgang Grandegger napsal(a):
...
>> You are obviously hitting the resource limits. Do you need -rt? It makes
>> your system slower.
> 
> I don't know what steps are necessary to make the kernel (and can
> driver) -rt :(  I will first try to finish my app and see how it behaves.

Forget my comment. I was thinking that you are already using a -rt
kernel (with the real-time preemption patch), but that's obviously not
the case. Sorry for the noise.

...
>> Good. What does the CAN statistics show ($ ip -d -s link show can0)?
> 
> Now it shows (after some time of experimenting, it was disconnected from
> canbus for a while)
> 
> 2: can0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN mode DEFAULT
> qlen 10
>     link/can
>     can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
>     bitrate 250000 sample-point 0.857
>     tq 285 prop-seg 5 phase-seg1 6 phase-seg2 2 sjw 1
>     flexcan: tseg1 4..16 tseg2 2..8 sjw 1..4 brp 1..256 brp-inc 1
>     clock 66500000
>     re-started bus-errors arbit-lost error-warn error-pass bus-off
>     0          0          0          1          0          0
>     RX: bytes  packets  errors  dropped overrun mcast
>     4758311    602831   212     0       212     0

There have been some RX FIFO overflow errors, which means messages are
lost by the hardware.

Wolfgang.
