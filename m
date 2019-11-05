From: syzbot <syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Write in j1939_sock_pending_del
Date: Tue, 05 Nov 2019 03:45:00 -0800
Message-ID: <00000000000058481f059697f6e7@google.com>
References: <000000000000de1eec059692c021@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000de1eec059692c021@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bst@pengutronix.de, davem@davemloft.net, dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11150314e00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13150314e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15150314e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=07bb74aeafc88ba7d5b4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fd7044e00000

Reported-by: syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
