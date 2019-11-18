From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Mon, 18 Nov 2019 21:49:30 +0100
Message-ID: <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
 <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org



On 18/11/2019 21.29, Marc Kleine-Budde wrote:
> On 11/18/19 9:25 PM, Oliver Hartkopp wrote:

>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
>>>
>>> =====================================================
>>> BUG: KMSAN: uninit-value in can_receive+0x23c/0x5e0 net/can/af_can.c:649
>>> CPU: 1 PID: 3490 Comm: syz-executor.2 Not tainted 5.4.0-rc5+ #0

>>
>> In line 649 of 5.4.0-rc5+ we can find a while() statement:
>>
>> while (!(can_skb_prv(skb)->skbcnt))
>> 	can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
>>
>> In linux/include/linux/can/skb.h we see:
>>
>> static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
>> {
>> 	return (struct can_skb_priv *)(skb->head);
>> }
>>
>> IMO accessing can_skb_prv(skb)->skbcnt at this point is a valid
>> operation which has no uninitialized value.
>>
>> Can this probably be a false positive of KMSAN?
> 
> The packet is injected via the packet socket into the kernel. Where does
> skb->head point to in this case? When the skb is a proper
> kernel-generated skb containing a CAN-2.0 or CAN-FD frame skb->head is
> maybe properly initialized?

The packet is either received via vcan or vxcan which checks via 
can_dropped_invalid_skb() if we have a valid ETH_P_CAN type skb.

We additionally might think about introducing a check whether we have a 
can_skb_reserve() created skbuff.

But even if someone forged a skbuff without this reserved space the 
access to can_skb_prv(skb)->skbcnt would point into some CAN frame 
content - which is still no access to uninitialized content, right?

Regards,
Oliver
