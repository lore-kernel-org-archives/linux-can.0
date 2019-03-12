From: syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>
Subject: Re: WARNING in hsr_addr_subst_dest
Date: Mon, 11 Mar 2019 23:27:00 -0700
Message-ID: <000000000000d7206e0583dfc6b3@google.com>
References: <0000000000001b1a1d057e776c92@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000001b1a1d057e776c92@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk, davem@davemloft.net, hch@lst.de, linux-block@vger.kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri May 26 11:53:19 2017 +0000

     blk-mq: merge bio into sw queue before plugging

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1681996f200000
start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1581996f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1181996f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
dashboard link: https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107db700c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12304827400000

Reported-by: syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com
Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
