From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Stuck vcan
Date: Tue, 11 Mar 2014 22:29:04 +0100
Message-ID: <531F8020.7090603@hartkopp.net>
References: <CANGgnMZLZ+Uhdjpw0QC1ER74FFyot6sjSpcL0Q+HK7ydQTynsg@mail.gmail.com>	<531EB5A4.1090302@hartkopp.net> <CANGgnMbtfaowdGjVRbQ9L8TJBKmbAaNxjApPsc=JDM7e28U8LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:63321 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbaCKV3H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Mar 2014 17:29:07 -0400
In-Reply-To: <CANGgnMbtfaowdGjVRbQ9L8TJBKmbAaNxjApPsc=JDM7e28U8LA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>
Cc: linux-can@vger.kernel.org



On 11.03.2014 21:37, Austin Schuh wrote:

> # ip link show vcan0
> 17: vcan0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc noqueue state UNKNOWN
> mode DEFAULT qlen 10
>     link/can
> 
> Both times, I get the following.
> 
> Mar 11 13:28:58 aschuh-peloton kernel: [96229.460901] Dead loop on
> virtual device vcan0, fix it urgently!

As you can see above the qdisc is 'noqueue'

Please check out the __dev_queue_xmit() function in

http://lxr.free-electrons.com/source/net/core/dev.c#L2782

which creates the 'fix urgently' message.

I assume when creating a qdisc which is not 'noqueue' the handling for skb
queueing is forced.

See:
http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

Regards,
Oliver

