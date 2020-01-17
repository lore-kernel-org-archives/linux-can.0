From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: KASAN: use-after-free Read in j1939_xtp_rx_abort_one
Date: Fri, 17 Jan 2020 13:26:20 +0100
Message-ID: <20200117122620.GC11961@pengutronix.de>
References: <0000000000005ed7710596937e86@google.com>
 <000000000000a0ef18059c082789@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59135 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAQM0V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2020 07:26:21 -0500
Content-Disposition: inline
In-Reply-To: <000000000000a0ef18059c082789@google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: syzbot <syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, syzkaller-bugs@googlegroups.com

On Mon, Jan 13, 2020 at 08:42:02AM -0800, syzbot wrote:
> syzbot suspects this bug was fixed by commit:
> 
> commit ddeeb7d4822ed06d79fc15e822b70dce3fa77e39
> Author: Oleksij Rempel <o.rempel@pengutronix.de>
> Date:   Sat Nov 9 15:11:18 2019 +0000
> 
>     can: j1939: j1939_can_recv(): add priv refcounting
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a7ec76e00000
> start commit:   de620fb9 Merge branch 'for-5.4-fixes' of git://git.kernel...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9ff8f11e66c1fb1
> dashboard link: https://syzkaller.appspot.com/bug?extid=db4869ba599c0de9b13e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e0d72e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136aa6e8e00000
> 
> If the result looks correct, please mark the bug fixed by replying with:

#syz fix: can: j1939: j1939_can_recv(): add priv refcounting

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
