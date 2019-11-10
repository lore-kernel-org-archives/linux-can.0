From: syzbot <syzbot+07ca5bce8530070a5650@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in j1939_sk_recv
Date: Sun, 10 Nov 2019 14:55:00 -0800
Message-ID: <000000000000a68113059705e7d4@google.com>
References: <000000000000a3cc890597025437@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <000000000000a3cc890597025437@google.com>
Sender: netdev-owner@vger.kernel.org
To: bst@pengutronix.de, davem@davemloft.net, dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f08e72e00000
start commit:   5591cf00 Add linux-next specific files for 20191108
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12f08e72e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f08e72e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
dashboard link: https://syzkaller.appspot.com/bug?extid=07ca5bce8530070a5650
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165ad206e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cf9c3ce00000

Reported-by: syzbot+07ca5bce8530070a5650@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
