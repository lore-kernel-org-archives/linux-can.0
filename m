From: syzbot <syzbot+49595536c57ef38095ed@syzkaller.appspotmail.com>
Subject: Re: WARNING in j1939_sk_queue_activate_next
Date: Thu, 21 Nov 2019 01:26:01 -0800
Message-ID: <000000000000bb10ec0597d7e2bb@google.com>
References: <00000000000028f3c20597d2d8ee@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <00000000000028f3c20597d2d8ee@google.com>
Sender: netdev-owner@vger.kernel.org
To: bst@pengutronix.de, davem@davemloft.net, dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152c6bace00000
start commit:   c74386d5 afs: Fix missing timeout reset
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=172c6bace00000
console output: https://syzkaller.appspot.com/x/log.txt?x=132c6bace00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4737c15fc47048f2
dashboard link: https://syzkaller.appspot.com/bug?extid=49595536c57ef38095ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b8ba86e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce855ae00000

Reported-by: syzbot+49595536c57ef38095ed@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
