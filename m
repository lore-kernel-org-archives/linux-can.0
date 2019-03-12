From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: WARNING in hsr_addr_subst_dest
Date: Tue, 12 Mar 2019 17:09:08 +0100
Message-ID: <CACT4Y+ajX4nQVe-UEKCud87-bBhqL7Xaw9Gxh=JAGDg08q3Hyw@mail.gmail.com>
References: <000000000000d7206e0583dfc6b3@google.com> <11a39c4b-9ac1-e55e-1773-534248a1d1d8@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <11a39c4b-9ac1-e55e-1773-534248a1d1d8@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>, arvid.brodin@alten.se, Jens Axboe <axboe@fb.com>, Jens Axboe <axboe@kernel.dk>, David Miller <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: linux-can.vger.kernel.org

On Tue, Mar 12, 2019 at 1:03 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi all,
>
> I'm not sure why a Kernel 4.12.0-rc2+ is used here, but I do not get any
> problems on the my latest 5.0.0-06622-g1fc1cd8399ab tree and I strongly
> assume this patch showing up in 4.12-rc6
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit?id=74b7b490886852582d986a33443c2ffa50970169
>
> fixes the problem.
>
> Best regards,
> Oliver

Hi Oliver,

You can see how bisection progressed and got to 4.12.0-rc2+ in the
bisection log.

The commit that it come up with looks unrelated.
I've started collecting such cases at:
https://github.com/google/syzkaller/issues/1051
and added for this case:

=====
Bisected to wrong commit.
Root cause: broken kernel boots, bugs that happen on all tests.
Boot is broken for several releases with "WARNING in hsr_forward_skb",
this switches to a bug that happens during every test "INFO: trying to
register non-static key in can_notifier", which then leads to a
completely random commit.
=====


> > commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Fri May 26 11:53:19 2017 +0000
> >
> >      blk-mq: merge bio into sw queue before plugging
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1681996f200000
> > start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1581996f200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1181996f200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
> > userspace arch: amd64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107db700c00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12304827400000
> >
> > Reported-by: syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com
> > Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/11a39c4b-9ac1-e55e-1773-534248a1d1d8%40hartkopp.net.
> For more options, visit https://groups.google.com/d/optout.
