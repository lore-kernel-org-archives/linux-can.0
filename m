From: syzbot <syzbot+06283a66a648cd073885@syzkaller.appspotmail.com>
Subject: Re: INFO: task hung in vivid_stop_generating_vid_cap
Date: Thu, 07 Nov 2019 05:42:06 -0800
Message-ID: <000000000000c9f0a40596c1d46b@google.com>
References: <00000000000080601805795ada2e@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <00000000000080601805795ada2e@google.com>
Sender: netdev-owner@vger.kernel.org
To: andy@greyhouse.net, davem@davemloft.net, dvyukov@google.com, hans.verkuil@cisco.com, helen.koike@collabora.com, hverkuil-cisco@xs4all.nl, hverkuil@xs4all.nl, j.vosburgh@gmail.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maheshb@google.com, mchehab+samsung@kernel.org, mchehab@kernel.org, mchehab@s-opensource.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tfiga@chromium.org, vfalico@gmail.com
List-Id: linux-can.vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit d65842f7126aa1a87fb44b7c9980c12630ed4f33
Author: Hans Verkuil <hverkuil@xs4all.nl>
Date:   Mon Nov 19 11:09:00 2018 +0000

     media: vb2: add waiting_in_dqbuf flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1417a04a600000
start commit:   9f51ae62 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=62118286bb772a24
dashboard link: https://syzkaller.appspot.com/bug?extid=06283a66a648cd073885
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15701a33400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154c8e4d400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: media: vb2: add waiting_in_dqbuf flag

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
