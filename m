From: John Fastabend <john.fastabend@gmail.com>
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
Date: Tue, 13 Mar 2018 21:03:40 -0700
Message-ID: <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Taht <dave.taht@gmail.com>, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Martin Elshuber <martin.elshuber@theobroma-systems.com>
List-Id: linux-can.vger.kernel.org

On 03/13/2018 11:35 AM, Dave Taht wrote:
> On Tue, Mar 13, 2018 at 11:24 AM, Jakob Unterwurzacher
> <jakob.unterwurzacher@theobroma-systems.com> wrote:
>> During stress-testing our "ucan" USB/CAN adapter SocketCAN driver on Linux
>> v4.16-rc4-383-ged58d66f60b3 we observed that a small fraction of packets are
>> delivered out-of-order.
>>

Is the stress-testing tool available somewhere? What type of packets
are being sent?


>> We have tracked the problem down to the driver interface level, and it seems
>> that the driver's net_device_ops.ndo_start_xmit() function gets the packets
>> handed over in the wrong order.
>>
>> This behavior was not observed on Linux v4.15 and I have bisected the
>> problem down to this patch:
>>
>>> commit c5ad119fb6c09b0297446be05bd66602fa564758
>>> Author: John Fastabend <john.fastabend@gmail.com>
>>> Date:   Thu Dec 7 09:58:19 2017 -0800
>>>
>>>    net: sched: pfifo_fast use skb_array
>>>
>>>    This converts the pfifo_fast qdisc to use the skb_array data structure
>>>    and set the lockless qdisc bit. pfifo_fast is the first qdisc to
>>> support
>>>    the lockless bit that can be a child of a qdisc requiring locking. So
>>>    we add logic to clear the lock bit on initialization in these cases
>>> when
>>>    the qdisc graft operation occurs.
>>>
>>>    This also removes the logic used to pick the next band to dequeue from
>>>    and instead just checks a per priority array for packets from top
>>> priority
>>>    to lowest. This might need to be a bit more clever but seems to work
>>>    for now.
>>>
>>>    Signed-off-by: John Fastabend <john.fastabend@gmail.com>
>>>    Signed-off-by: David S. Miller <davem@davemloft.net>
>>
>>
>> The patch does not revert cleanly, but moving to one commit earlier makes
>> the problem go away.
>>
>> Selecting the "fq" scheduler instead of "pfifo_fast" makes the problem go
>> away as well.
> 

Is this a single queue device or a multiqueue device? Running
'tc -s qdisc show dev foo' would help some.

> I am of course, a fan of obsoleting pfifo_fast. There's no good reason
> for it anymore.
> 
>>
>> Is this an unintended side-effect of the patch or is there something the
>> driver has to do to request in-order delivery?
>>
If we introduced a OOO edge case somewhere that was not
intended so I'll take a look into it. But, if you can provide
a bit more details on how stress testing is done to cause the
issue that would help.

Thanks,
John

>> Thanks,
>> Jakob
> 
> 
> 
