From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: Stuck vcan
Date: Tue, 11 Mar 2014 14:55:22 -0700
Message-ID: <CANGgnMYEmR0msgSPEnJh837SU6uPND17HcfZK6Mgohieimq9Pw@mail.gmail.com>
References: <CANGgnMZLZ+Uhdjpw0QC1ER74FFyot6sjSpcL0Q+HK7ydQTynsg@mail.gmail.com>
	<531EB5A4.1090302@hartkopp.net>
	<CANGgnMbtfaowdGjVRbQ9L8TJBKmbAaNxjApPsc=JDM7e28U8LA@mail.gmail.com>
	<531F8020.7090603@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:48145 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbaCKVzX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Mar 2014 17:55:23 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so12444582igb.3
        for <linux-can@vger.kernel.org>; Tue, 11 Mar 2014 14:55:22 -0700 (PDT)
In-Reply-To: <531F8020.7090603@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Tue, Mar 11, 2014 at 2:29 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
>
> On 11.03.2014 21:37, Austin Schuh wrote:
>
>> # ip link show vcan0
>> 17: vcan0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc noqueue state UNKNOWN
>> mode DEFAULT qlen 10
>>     link/can
>>
>> Both times, I get the following.
>>
>> Mar 11 13:28:58 aschuh-peloton kernel: [96229.460901] Dead loop on
>> virtual device vcan0, fix it urgently!
>
> As you can see above the qdisc is 'noqueue'
>
> Please check out the __dev_queue_xmit() function in
>
> http://lxr.free-electrons.com/source/net/core/dev.c#L2782
>
> which creates the 'fix urgently' message.
>
> I assume when creating a qdisc which is not 'noqueue' the handling for skb
> queueing is forced.
>
> See:
> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
>
> Regards,
> Oliver
>

Thanks for the pointers Oliver.  I'll take a look and see what I can
find.  It will probably be a week or two before I can really sit down
and dig through this.

Austin
