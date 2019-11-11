From: syzbot <syzbot+ca172a0ac477ac90f045@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr_locked
Date: Sun, 10 Nov 2019 19:57:01 -0800
Message-ID: <000000000000b98cf305970a1fd3@google.com>
References: <00000000000082c66d059705e442@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <00000000000082c66d059705e442@google.com>
Sender: netdev-owner@vger.kernel.org
To: bst@pengutronix.de, davem@davemloft.net, dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bc06d6e00000
start commit:   00aff683 Merge tag 'for-5.4-rc6-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13bc06d6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15bc06d6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=ca172a0ac477ac90f045
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144150e2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aaa9fce00000

Reported-by: syzbot+ca172a0ac477ac90f045@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
