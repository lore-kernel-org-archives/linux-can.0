From: syzbot <syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in j1939_xtp_rx_abort_one
Date: Mon, 13 Jan 2020 08:42:02 -0800
Message-ID: <000000000000a0ef18059c082789@google.com>
References: <0000000000005ed7710596937e86@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <0000000000005ed7710596937e86@google.com>
Sender: netdev-owner@vger.kernel.org
To: bst@pengutronix.de, davem@davemloft.net, dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit ddeeb7d4822ed06d79fc15e822b70dce3fa77e39
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Sat Nov 9 15:11:18 2019 +0000

     can: j1939: j1939_can_recv(): add priv refcounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a7ec76e00000
start commit:   de620fb9 Merge branch 'for-5.4-fixes' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9ff8f11e66c1fb1
dashboard link: https://syzkaller.appspot.com/bug?extid=db4869ba599c0de9b13e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e0d72e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136aa6e8e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: can: j1939: j1939_can_recv(): add priv refcounting

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
