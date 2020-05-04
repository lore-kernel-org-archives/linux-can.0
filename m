From: syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>
Subject: Re: WARNING in hsr_addr_subst_dest
Date: Sun, 03 May 2020 20:02:04 -0700
Message-ID: <0000000000007851da05a4c9c169@google.com>
References: <0000000000001b1a1d057e776c92@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <0000000000001b1a1d057e776c92@google.com>
Sender: netdev-owner@vger.kernel.org
To: ap420073@gmail.com, arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk, davem@davemloft.net, dvyukov@google.com, hch@lst.de, kuba@kernel.org, linux-block@vger.kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 4b793acdca0050739b99ace6a8b9e7f717f57c6b
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Fri Feb 28 18:01:46 2020 +0000

    hsr: use netdev_err() instead of WARN_ONCE()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130746ffe00000
start commit:   ea200dec Merge tag 'armsoc-fixes' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
dashboard link: https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b5cafee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12574271e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: hsr: use netdev_err() instead of WARN_ONCE()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
