From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Tue, 19 Nov 2019 08:35:41 +0100
Message-ID: <1f7d6ea7-152e-ff18-549c-b196d8b5e3a7@hartkopp.net>
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
 <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
 <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
 <7f5c4546-0c1a-86ae-581e-0203b5fca446@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <7f5c4546-0c1a-86ae-581e-0203b5fca446@pengutronix.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org



On 18/11/2019 22.15, Marc Kleine-Budde wrote:
> On 11/18/19 9:49 PM, Oliver Hartkopp wrote:
>>
>>
>> On 18/11/2019 21.29, Marc Kleine-Budde wrote:
>>> On 11/18/19 9:25 PM, Oliver Hartkopp wrote:
>>
>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>> Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
>>>>>
>>>>> =====================================================
>>>>> BUG: KMSAN: uninit-value in can_receive+0x23c/0x5e0 net/can/af_can.c:649
>>>>> CPU: 1 PID: 3490 Comm: syz-executor.2 Not tainted 5.4.0-rc5+ #0
>>
>>>>
>>>> In line 649 of 5.4.0-rc5+ we can find a while() statement:
>>>>
>>>> while (!(can_skb_prv(skb)->skbcnt))
>>>> 	can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
>>>>
>>>> In linux/include/linux/can/skb.h we see:
>>>>
>>>> static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
>>>> {
>>>> 	return (struct can_skb_priv *)(skb->head);
>>>> }
>>>>
>>>> IMO accessing can_skb_prv(skb)->skbcnt at this point is a valid
>>>> operation which has no uninitialized value.
>>>>
>>>> Can this probably be a false positive of KMSAN?
>>>
>>> The packet is injected via the packet socket into the kernel. Where does
>>> skb->head point to in this case? When the skb is a proper
>>> kernel-generated skb containing a CAN-2.0 or CAN-FD frame skb->head is
>>> maybe properly initialized?
>>
>> The packet is either received via vcan or vxcan which checks via
>> can_dropped_invalid_skb() if we have a valid ETH_P_CAN type skb.
> 
> According to the call stack it's injected into the kernel via a packet
> socket and not via v(x)can.

See ioctl$ifreq https://syzkaller.appspot.com/x/log.txt?x=14563416e00000

23:11:34 executing program 2:
r0 = socket(0x200000000000011, 0x3, 0x0)
ioctl$ifreq_SIOCGIFINDEX_vcan(r0, 0x8933, 
&(0x7f0000000040)={'vxcan1\x00', <r1=>0x0})
bind$packet(r0, &(0x7f0000000300)={0x11, 0xc, r1}, 0x14)
sendmmsg(r0, &(0x7f0000000d00), 0x400004e, 0x0)

We only can receive skbs from (v(x))can devices.
No matter if someone wrote to them via PF_CAN or PF_PACKET.
We check for ETH_P_CAN(FD) type and ARPHRD_CAN dev type at rx time.

>> We additionally might think about introducing a check whether we have a
>> can_skb_reserve() created skbuff.
>>
>> But even if someone forged a skbuff without this reserved space the
>> access to can_skb_prv(skb)->skbcnt would point into some CAN frame
>> content - which is still no access to uninitialized content, right?

So this question remains still valid whether we have a false positive 
from KMSAN here.

Regards,
Oliver
