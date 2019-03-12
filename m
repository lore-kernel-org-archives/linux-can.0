From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: WARNING in hsr_forward_skb
Date: Tue, 12 Mar 2019 13:01:54 +0100
Message-ID: <7dd5ffca-803d-9d5e-7fa4-f9eed2249d26@hartkopp.net>
References: <0000000000004cfa120583e1dfc3@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <0000000000004cfa120583e1dfc3@google.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>, arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk, davem@davemloft.net, hch@lst.de, linux-block@vger.kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-can.vger.kernel.org

Hi all,

I'm not sure why a Kernel 4.12.0-rc2+ is used here, but I do not get any 
problems on the my latest 5.0.0-06622-g1fc1cd8399ab tree and I strongly 
assume this patch showing up in 4.12-rc6

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit?id=74b7b490886852582d986a33443c2ffa50970169

fixes the problem.

Best regards,
Oliver

On 3/12/19 9:57 AM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit ab42f35d9cb5ac49b5a2a11f940e74f58f207280
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri May 26 11:53:19 2017 +0000
> 
>      blk-mq: merge bio into sw queue before plugging
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e68713200000
> start commit:   ab42f35d blk-mq: merge bio into sw queue before plugging
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15e68713200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e68713200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
> userspace arch: amd64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f6d1fd400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17290fdd400000
> 
> Reported-by: syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com
> Fixes: ab42f35d ("blk-mq: merge bio into sw queue before plugging")
