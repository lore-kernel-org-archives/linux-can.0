From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
Date: Fri, 22 Mar 2019 09:06:41 +0100
Message-ID: <CACT4Y+aVXJuaBsvwM-7UcpDzvPZG8HaFHPnHQMX1ZzE1Emd-Tg@mail.gmail.com>
References: <00000000000080601805795ada2e@google.com> <000000000000e626290584a983c0@google.com>
 <CACT4Y+YVNA6aYe-Ai-ZnU+EhNSNAFhjvXPT0oA+i4rCFpQThcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+YVNA6aYe-Ai-ZnU+EhNSNAFhjvXPT0oA+i4rCFpQThcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>, linux-can@vger.kernel.org
Cc: andy@greyhouse.net, David Miller <davem@davemloft.net>, Hans Verkuil <hverkuil@xs4all.nl>, j.vosburgh@gmail.com, LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>, mchehab@kernel.org, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, vfalico@gmail.com
List-Id: linux-can.vger.kernel.org

On Fri, Mar 22, 2019 at 9:00 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Mar 22, 2019 at 8:08 AM syzbot
> <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 4493b81bea24269df898339dee638d7c5cb2b2df
> > Author: Mahesh Bandewar <maheshb@google.com>
> > Date:   Wed Mar 8 18:55:54 2017 +0000
> >
> >      bonding: initialize work-queues during creation of bond
>
> +linux-can
>
> I think I will disable CONFIG_CAN before v4.12. It causes too many
> false results for v4.12..v4.11 range. It always leads to a wrong
> decision for first 3 steps, then no chances of correct bisection
> anymore.

The same seems to show up for v4.12..v4.13:
all runs: crashed: INFO: trying to register non-static key in can_notifier
https://syzkaller.appspot.com/text?tag=Log&x=1555b12b200000

This was fixed by 74b7b490886852582d986a33443c2ffa50970169 right?



> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176d1617200000
> > start commit:   4493b81b bonding: initialize work-queues during creation o..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=14ed1617200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10ed1617200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=62118286bb772a24
> > dashboard link: https://syzkaller.appspot.com/bug?extid=06283a66a648cd073885
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15701a33400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154c8e4d400000
> >
> > Reported-by: syzbot+06283a66a648cd073885@syzkaller.appspotmail.com
> > Fixes: 4493b81bea24 ("bonding: initialize work-queues during creation of
> > bond")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
