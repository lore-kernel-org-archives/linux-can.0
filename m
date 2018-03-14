From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [bug, bisected] pfifo_fast causes packet reordering
Date: Wed, 14 Mar 2018 11:09:02 +0100
Message-ID: <52581141-db46-8657-e0b5-161e236caa1b@theobroma-systems.com>
References: <946dbe16-a2eb-eca8-8069-468859ccc78d@theobroma-systems.com>
 <CAA93jw5FSbvg8AZ=EmneW8juqd8LCgp=xUrSxYm2GBEucKkT3w@mail.gmail.com>
 <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95844480-d020-9000-53ef-0da8b965ce6e@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Fastabend <john.fastabend@gmail.com>, Dave Taht <dave.taht@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Martin Elshuber <martin.elshuber@theobroma-systems.com>
List-Id: linux-can.vger.kernel.org

On 14.03.18 05:03, John Fastabend wrote:
>>> During stress-testing our "ucan" USB/CAN adapter SocketCAN driver on Linux
>>> v4.16-rc4-383-ged58d66f60b3 we observed that a small fraction of packets are
>>> delivered out-of-order.
>>>
> 
> Is the stress-testing tool available somewhere? What type of packets
> are being sent?

Not public, no, the problem is that you'd need a CAN adapter as well.

The test is simple, sending CAN frames with an increasing counter and a 
random length payload:

[  tx thread                      rx thread    ]
        |                              ^
        v                              |
[ interface 0 ] ---- cable ----> [ interface 1 ]

I'll see if I can come up with a UDP testcase that works with normal 
ethernet interfaces.

> Is this a single queue device or a multiqueue device? Running
> 'tc -s qdisc show dev foo' would help some.

Here you go:

root@rk3399-q7:~# tc -s qdisc show dev can0
qdisc pfifo_fast 0: root refcnt 2 bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 
1 1 1 1 1
  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
  backlog 0b 0p requeues 0

> If we introduced a OOO edge case somewhere that was not
> intended so I'll take a look into it. But, if you can provide
> a bit more details on how stress testing is done to cause the
> issue that would help.

Will do.

Thanks,
Jakob
