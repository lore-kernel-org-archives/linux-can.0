From: syzbot <syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com>
Subject: Re: general protection fault in j1939_sk_bind
Date: Fri, 17 Jan 2020 01:06:01 -0800
Message-ID: <0000000000002ab713059c524079@google.com>
References: <000000000000a367e3059691c6b4@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000a367e3059691c6b4@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bst@pengutronix.de, davem@davemloft.net, dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 00d4e14d2e4caf5f7254a505fee5eeca8cd37bd4
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Fri Dec 6 14:18:35 2019 +0000

     can: j1939: j1939_sk_bind(): take priv after lock is held

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1001b266e00000
start commit:   32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
dashboard link: https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177c34a2e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: can: j1939: j1939_sk_bind(): take priv after lock is held

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
