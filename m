From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: WARNING in hsr_addr_subst_dest
Date: Tue, 12 Mar 2019 13:02:47 +0100
Message-ID: <11a39c4b-9ac1-e55e-1773-534248a1d1d8@hartkopp.net>
References: <000000000000d7206e0583dfc6b3@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000000000000d7206e0583dfc6b3@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>, arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk, davem@davemloft.net, hch@lst.de, linux-block@vger.kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

Hi all,

I'm not sure why a Kernel 4.12.0-rc2+ is used here, but I do not get any 
problems on the my latest 5.0.0-06622-g1fc1cd8399ab tree and I strongly 
assume this patch showing up in 4.12-rc6

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit?id=74b7b490886852582d986a33443c2ffa50970169

fixes the problem.

Best regards,
Oliver

On 3/12/19 7:27 AM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri May 26 11:53:19 2017 +0000
> 
>      blk-mq: merge bio into sw queue before plugging
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1681996f200000
> start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1581996f200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1181996f200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
> userspace arch: amd64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107db700c00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12304827400000
> 
> Reported-by: syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com
> Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
