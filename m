From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Tue, 19 Nov 2019 08:53:33 -0800
Message-ID: <9e06266a-67f3-7352-7b87-2b9144c7c9a9@gmail.com>
References: <0000000000005c08d10597a3a05d@google.com>
 <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
 <deedd609-6f3b-8035-47e1-252ab221faa1@pengutronix.de>
 <7934bc2b-597f-0bb3-be2d-32f3b07b4de9@hartkopp.net>
 <7f5c4546-0c1a-86ae-581e-0203b5fca446@pengutronix.de>
 <1f7d6ea7-152e-ff18-549c-b196d8b5e3a7@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1f7d6ea7-152e-ff18-549c-b196d8b5e3a7@hartkopp.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org



On 11/18/19 11:35 PM, Oliver Hartkopp wrote:
> 

> 
> See ioctl$ifreq https://syzkaller.appspot.com/x/log.txt?x=14563416e00000
> 
> 23:11:34 executing program 2:
> r0 = socket(0x200000000000011, 0x3, 0x0)
> ioctl$ifreq_SIOCGIFINDEX_vcan(r0, 0x8933, &(0x7f0000000040)={'vxcan1\x00', <r1=>0x0})
> bind$packet(r0, &(0x7f0000000300)={0x11, 0xc, r1}, 0x14)
> sendmmsg(r0, &(0x7f0000000d00), 0x400004e, 0x0)
> 
> We only can receive skbs from (v(x))can devices.
> No matter if someone wrote to them via PF_CAN or PF_PACKET.
> We check for ETH_P_CAN(FD) type and ARPHRD_CAN dev type at rx time.

And what entity sets the can_skb_prv(skb)->skbcnt to zero exactly ?

> 
>>> We additionally might think about introducing a check whether we have a
>>> can_skb_reserve() created skbuff.
>>>
>>> But even if someone forged a skbuff without this reserved space the
>>> access to can_skb_prv(skb)->skbcnt would point into some CAN frame
>>> content - which is still no access to uninitialized content, right?
> 
> So this question remains still valid whether we have a false positive from KMSAN here.

I do not believe it is a false positive.

It seems CAN relies on some properties of low level drivers using alloc_can_skb() or similar function.

Why not simply fix this like that ?

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 128d37a4c2e0ba5d8db69fcceec8cbd6a79380df..3e71a78d82af84caaacd0ef512b5e894efbf4852 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -647,8 +647,9 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
        pkg_stats->rx_frames_delta++;
 
        /* create non-zero unique skb identifier together with *skb */
-       while (!(can_skb_prv(skb)->skbcnt))
+       do {
                can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
+       } while (!(can_skb_prv(skb)->skbcnt));
 
        rcu_read_lock();
 
