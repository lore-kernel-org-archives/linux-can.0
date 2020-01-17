From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: general protection fault in j1939_sk_bind
Date: Fri, 17 Jan 2020 13:24:29 +0100
Message-ID: <20200117122429.GB11961@pengutronix.de>
References: <000000000000a367e3059691c6b4@google.com>
 <0000000000002ab713059c524079@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35479 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgAQMYd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2020 07:24:33 -0500
Content-Disposition: inline
In-Reply-To: <0000000000002ab713059c524079@google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: syzbot <syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com>
Cc: linux-can@vger.kernel.org, "syzkaller-bugs@googlegroups.comhange-folder>?" <toggle-mailboxes@pengutronix.de>

On Fri, Jan 17, 2020 at 01:06:01AM -0800, syzbot wrote:
> syzbot suspects this bug was fixed by commit:
> 
> commit 00d4e14d2e4caf5f7254a505fee5eeca8cd37bd4
> Author: Oleksij Rempel <o.rempel@pengutronix.de>
> Date:   Fri Dec 6 14:18:35 2019 +0000
> 
>     can: j1939: j1939_sk_bind(): take priv after lock is held
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1001b266e00000
> start commit:   32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177c34a2e00000
> 
> If the result looks correct, please mark the bug fixed by replying with:

#syz fix: can: j1939: j1939_sk_bind(): take priv after lock is held

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
