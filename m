From: syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
Date: Fri, 22 Mar 2019 15:45:00 -0700
Message-ID: <000000000000e1f98d0584b69aa6@google.com>
References: <00000000000080601805795ada2e@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <00000000000080601805795ada2e@google.com>
Sender: netdev-owner@vger.kernel.org
To: andy@greyhouse.net, davem@davemloft.net, dvyukov@google.com, hans.verkuil@cisco.com, helen.koike@collabora.com, hverkuil@xs4all.nl, j.vosburgh@gmail.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maheshb@google.com, mchehab@kernel.org, mchehab@s-opensource.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, vfalico@gmail.com
List-Id: linux-can.vger.kernel.org

syzbot has bisected this bug to:

commit f2fe89061d79706eca5c47e4efdc09bbc171e74a
Author: Helen Koike <helen.koike@collabora.com>
Date:   Fri Apr 7 17:55:19 2017 +0000

     [media] vimc: Virtual Media Controller core, capture and sensor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ea247d200000
start commit:   9f51ae62 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11ea247d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ea247d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62118286bb772a24
dashboard link: https://syzkaller.appspot.com/bug?extid=06283a66a648cd073885
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15701a33400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154c8e4d400000

Reported-by: syzbot+06283a66a648cd073885@syzkaller.appspotmail.com
Fixes: f2fe89061d79 ("[media] vimc: Virtual Media Controller core, capture  
and sensor")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
