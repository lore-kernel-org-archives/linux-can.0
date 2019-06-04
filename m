From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: memory leak in raw_sendmsg
Date: Tue, 4 Jun 2019 14:52:05 -0400
Message-ID: <CAF=yD-K8ooDronfFK0XTCnvK6u1heNL71KW0SFmDPB69xLaseA@mail.gmail.com>
References: <0000000000001bb6d7058a716205@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000001bb6d7058a716205@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com>
Cc: David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Network Development <netdev@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, wg@grandegger.com, patrick.ohly@intel.com
List-Id: linux-can.vger.kernel.org

On Mon, Jun 3, 2019 at 6:24 PM syzbot
<syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    3ab4436f Merge tag 'nfsd-5.2-1' of git://linux-nfs.org/~bf..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=158090a6a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=50393f7bfe444ff6
> dashboard link: https://syzkaller.appspot.com/bug?extid=a90604060cb40f5bdd16
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e42092a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1327b0a6a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a90604060cb40f5bdd16@syzkaller.appspotmail.com
>
> BUG: memory leak
> unreferenced object 0xffff888118308200 (size 224):
>    comm "syz-executor081", pid 7046, jiffies 4294948162 (age 13.870s)
>    hex dump (first 32 bytes):
>      b0 64 19 2a 81 88 ff ff b0 64 19 2a 81 88 ff ff  .d.*.....d.*....
>      00 90 28 24 81 88 ff ff 00 64 19 2a 81 88 ff ff  ..($.....d.*....
>    backtrace:
>      [<0000000085e706a4>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:55 [inline]
>      [<0000000085e706a4>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<0000000085e706a4>] slab_alloc mm/slab.c:3326 [inline]
>      [<0000000085e706a4>] kmem_cache_alloc+0x134/0x270 mm/slab.c:3488
>      [<000000005a366403>] skb_clone+0x6e/0x140 net/core/skbuff.c:1321
>      [<00000000854d44b1>] __skb_tstamp_tx+0x19f/0x220 net/core/skbuff.c:4434
>      [<0000000091e53e01>] __dev_queue_xmit+0x920/0xd60 net/core/dev.c:3813
>      [<0000000043e22300>] dev_queue_xmit+0x18/0x20 net/core/dev.c:3910
>      [<0000000091bdc746>] can_send+0x138/0x2b0 net/can/af_can.c:290
>      [<000000002dddbaef>] raw_sendmsg+0x1bb/0x300 net/can/raw.c:780

The CAN protocol seems to be missing an error queue purge on socket
destruction. Verified that this still happens on net-next and the
following stops the warning:

    static void can_sock_destruct(struct sock *sk)
    {
             skb_queue_purge(&sk->sk_receive_queue);
    +       __skb_queue_purge(&sk->sk_error_queue);
    }

I would have to double check socket destruct semantics to be sure, but
judging from inet_sock_destruct there is no need to take the list
lock.

This appears to be going back to the introduction of tx timestamps for
CAN in commit 51f31cabe3ce ("ip: support for TX timestamps on UDP and
RAW sockets")

There don't seem to be any other protocols families that setup
tx_flags but lack the error queue purge.
