From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: KMSAN: uninit-value in can_receive
Date: Mon, 18 Nov 2019 21:25:18 +0100
Message-ID: <a5f73d92-fdf2-2590-c863-39a181dca8e1@hartkopp.net>
References: <0000000000005c08d10597a3a05d@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000005c08d10597a3a05d@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com>, davem@davemloft.net, glider@google.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

On 18/11/2019 20.05, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9c6a7162 kmsan: remove unneeded annotations in bio
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=14563416e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9e324dfe9c7b0360
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=b02ff0707a97e4e79ebb
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang 
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in can_receive+0x23c/0x5e0 net/can/af_can.c:649
> CPU: 1 PID: 3490 Comm: syz-executor.2 Not tainted 5.4.0-rc5+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
> Google 01/01/2011
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
>   kmsan_report+0x128/0x220 mm/kmsan/kmsan_report.c:108
>   __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:245
>   can_receive+0x23c/0x5e0 net/can/af_can.c:649
>   can_rcv+0x188/0x3a0 net/can/af_can.c:685

In line 649 of 5.4.0-rc5+ we can find a while() statement:

while (!(can_skb_prv(skb)->skbcnt))
	can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);

In linux/include/linux/can/skb.h we see:

static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
{
	return (struct can_skb_priv *)(skb->head);
}

IMO accessing can_skb_prv(skb)->skbcnt at this point is a valid 
operation which has no uninitialized value.

Can this probably be a false positive of KMSAN?

Regards,
Oliver
