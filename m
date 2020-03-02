From: syzbot <syzbot+b5ec6fd05ab552a78532@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in slcan_open
Date: Sun, 01 Mar 2020 22:30:09 -0800
Message-ID: <00000000000099fb63059fd95165@google.com>
References: <0000000000000e4f720598bb95f8@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000000e4f720598bb95f8@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, dvyukov@google.com, jouni.hogander@unikie.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

This bug is marked as fixed by commit:
slcan: Fix use-after-free Read in slcan_open
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
