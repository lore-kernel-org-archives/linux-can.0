From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: WARNING in hsr_forward_skb
Date: Tue, 12 Mar 2019 17:21:24 +0100
Message-ID: <CACT4Y+ayyFe6oek8MdnUd1LsB_+1kpJatBLnmF_jCttQPyCK0g@mail.gmail.com>
References: <0000000000004cfa120583e1dfc3@google.com> <7dd5ffca-803d-9d5e-7fa4-f9eed2249d26@hartkopp.net>
 <CACT4Y+ZoDc=_a_W=wVMYj+VLW8WFBDbQJGB17dZTSvYinWhebA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+ZoDc=_a_W=wVMYj+VLW8WFBDbQJGB17dZTSvYinWhebA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>, arvid.brodin@alten.se, Jens Axboe <axboe@fb.com>, Jens Axboe <axboe@kernel.dk>, David Miller <davem@davemloft.net>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
List-Id: linux-can.vger.kernel.org

On Tue, Mar 12, 2019 at 5:09 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Mar 12, 2019 at 1:02 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >
> > Hi all,
> >
> > I'm not sure why a Kernel 4.12.0-rc2+ is used here, but I do not get any
> > problems on the my latest 5.0.0-06622-g1fc1cd8399ab tree and I strongly
> > assume this patch showing up in 4.12-rc6
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit?id=74b7b490886852582d986a33443c2ffa50970169
> >
> > fixes the problem.
>
>
> Hi Oliver,
>
> You can see how bisection progressed and got to 4.12.0-rc2+ in the
> bisection log.
>
> The commit that it come up with looks unrelated.
> I've started collecting such cases at:
> https://github.com/google/syzkaller/issues/1051
> and added for this case:
>
> =====
> Bisected to wrong commit.
> Root cause: broken kernel boots, bugs that happen on all tests.
> Boot is broken for several releases with "WARNING in hsr_forward_skb",
> this switches to a bug that happens during every test "INFO: trying to
> register non-static key in can_notifier", which then leads to a
> completely random commit.
> =====

Broken boots did not happen here. "WARNING in hsr_forward_skb" is the
crash that we pursued, so it started correctly. But then diverged to
an unrelated "INFO: trying to register non-static key in
can_notifier".

> > On 3/12/19 9:57 AM, syzbot wrote:
> > > syzbot has bisected this bug to:
> > >
> > > commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
> > > Author: Ming Lei <ming.lei@redhat.com>
> > > Date:   Fri May 26 11:53:19 2017 +0000
> > >
> > >      blk-mq: merge bio into sw queue before plugging
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e68713200000
> > > start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
> > > git tree:       upstream
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=15e68713200000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11e68713200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> > > dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
> > > userspace arch: amd64
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f6d1fd400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17290fdd400000
> > >
> > > Reported-by: syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com
> > > Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/7dd5ffca-803d-9d5e-7fa4-f9eed2249d26%40hartkopp.net.
> > For more options, visit https://groups.google.com/d/optout.
