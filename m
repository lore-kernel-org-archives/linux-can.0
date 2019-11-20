From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Wed, 20 Nov 2019 21:10:24 +0100
Message-ID: <c1f80bac-bb75-e671-ba32-05cfae86569c@hartkopp.net>
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
 <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
 <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
 <7f5c4546-0c1a-86ae-581e-0203b5fca446@pengutronix.de>
 <1f7d6ea7-152e-ff18-549c-b196d8b5e3a7@hartkopp.net>
 <9e06266a-67f3-7352-7b87-2b9144c7c9a9@gmail.com>
 <3142c032-e46a-531c-d1b8-d532e5b403a6@hartkopp.net>
 <92c04159-b83a-3e33-91da-25a727a692d0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <92c04159-b83a-3e33-91da-25a727a692d0@gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Eric Dumazet <eric.dumazet@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

On 19/11/2019 22.09, Eric Dumazet wrote:
> On 11/19/19 12:24 PM, Oliver Hartkopp wrote:
>> Please check commit d3b58c47d330d ("can: replace timestamp as unique skb attribute").
> 
> Oh well... This notion of 'unique skb attribute' is interesting...

Yes. The problem is that the joined filter needs to detect the identical 
skb which is delivered several times to raw_rcv() to process filters 
that are logical ANDed.

>> can_skb_prv(skb)->skbcnt is set to 0 at skb creation time when sending CAN frames from local host or receiving CAN frames from a real CAN interface.
> 
> We can not enforce this to happen with a virtual interface.

You are right. I just discovered that I'm not able to send CAN frames 
via PF_PACKET sockets anymore.

Receiving with a simple test program and Wireshark is fine - but sending 
does not work. PF_PACKET is not creating the same kind of skbs as e.g. 
the CAN_RAW socket does.

So the KMSAN detection was right at the end :-(

I'll take a closer look to enable PF_PACKET to send CAN frames again 
which will fix up the entire  problem.

Thanks for your feedback!

Best,
Oliver
