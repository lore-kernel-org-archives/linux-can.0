From: syzbot <syzbot+f03d384f3455d28833eb@syzkaller.appspotmail.com>
Subject: Re: general protection fault in j1939_netdev_start
Date: Wed, 11 Mar 2020 13:17:03 -0700
Message-ID: <00000000000064f9a805a099eb8a@google.com>
References: <00000000000030395e059f6aaa09@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00000000000030395e059f6aaa09@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, jiri@mellanox.com, jiri@resnulli.us, kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, mareklindner@neomailbox.ch, mkl@pengutronix.de, netdev@vger.kernel.org, robin@protonic.nl, socketcan@hartkopp.net, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 8330f73fe9742f201f467639f8356cf58756fb9f
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Wed Sep 4 07:40:47 2019 +0000

    rocker: add missing init_net check in FIB notifier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165cdcb1e00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=155cdcb1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=115cdcb1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=f03d384f3455d28833eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162b8331e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f10a2de00000

Reported-by: syzbot+f03d384f3455d28833eb@syzkaller.appspotmail.com
Fixes: 8330f73fe974 ("rocker: add missing init_net check in FIB notifier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
