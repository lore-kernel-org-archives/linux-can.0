From: syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>
Subject: Re: WARNING in hsr_forward_skb
Date: Tue, 12 Mar 2019 01:57:00 -0700
Message-ID: <0000000000004cfa120583e1dfc3@google.com>
References: <0000000000009f94c1057e772431@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000009f94c1057e772431@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk, davem@davemloft.net, hch@lst.de, linux-block@vger.kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri May 26 11:53:19 2017 +0000

     blk-mq: merge bio into sw queue before plugging

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e68713200000
start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15e68713200000
console output: https://syzkaller.appspot.com/x/log.txt?x=11e68713200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f6d1fd400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17290fdd400000

Reported-by: syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com
Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
