From: syzbot <syzbot+a47537d3964ef6c874e1@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_deactivate
Date: Fri, 08 Nov 2019 15:22:00 -0800
Message-ID: <0000000000008207e30596de0cf3@google.com>
References: <0000000000006264c60596d8c5fa@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000006264c60596d8c5fa@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bst@pengutronix.de, davem@davemloft.net, dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com, kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rempel-privat.de, lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17325552e00000
start commit:   847120f8 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14b25552e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b25552e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=a47537d3964ef6c874e1
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164973b4e00000

Reported-by: syzbot+a47537d3964ef6c874e1@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
