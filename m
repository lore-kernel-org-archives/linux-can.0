From: syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>
Subject: Re: kernel BUG at arch/x86/mm/physaddr.c:LINE! (2)
Date: Wed, 20 Mar 2019 13:35:00 -0700
Message-ID: <000000000000462a4105848c8e12@google.com>
References: <0000000000001c2b95057ad0935b@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000001c2b95057ad0935b@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, hverkuil@xs4all.nl, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@kernel.org, mchehab@s-opensource.com, mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit 6d469a202ee73196d0df76025af80bd6a379e658
Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date:   Sun May 14 17:07:21 2017 +0000

     Merge tag 'v4.12-rc1' into patchwork

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12639fd7200000
start commit:   6d469a20 Merge tag 'v4.12-rc1' into patchwork
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15639fd7200000
console output: https://syzkaller.appspot.com/x/log.txt?x=11639fd7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=6c0effb5877f6b0344e2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1312062b400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131bd093400000

Reported-by: syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com
Fixes: 6d469a20 ("Merge tag 'v4.12-rc1' into patchwork")
