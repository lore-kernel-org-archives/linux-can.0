From: syzbot <syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in j1939_xtp_rx_abort_one
Date: Tue, 05 Nov 2019 18:43:01 -0800
Message-ID: <000000000000e46daf0596a48179@google.com>
References: <0000000000005ed7710596937e86@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000005ed7710596937e86@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bst@pengutronix.de, davem@davemloft.net, dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1157fb1ae00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1357fb1ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1557fb1ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=db4869ba599c0de9b13e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1435c078e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139a3542e00000

Reported-by: syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
