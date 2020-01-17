From: syzbot <syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com>
Subject: Re: Re: general protection fault in j1939_sk_bind
Date: Fri, 17 Jan 2020 04:24:31 -0800
Message-ID: <0000000000000e637b059c55069e@google.com>
References: <20200117122429.GB11961@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-io1-f72.google.com ([209.85.166.72]:45985 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgAQMYc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2020 07:24:32 -0500
Received: by mail-io1-f72.google.com with SMTP id c23so14929785ioi.12
        for <linux-can@vger.kernel.org>; Fri, 17 Jan 2020 04:24:31 -0800 (PST)
In-Reply-To: <20200117122429.GB11961@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, o.rempel@pengutronix.de, toggle-mailboxes@pengutronix.de, syzkaller-bugs@googlegroups.com

> On Fri, Jan 17, 2020 at 01:06:01AM -0800, syzbot wrote:
>> syzbot suspects this bug was fixed by commit:

>> commit 00d4e14d2e4caf5f7254a505fee5eeca8cd37bd4
>> Author: Oleksij Rempel <o.rempel@pengutronix.de>
>> Date:   Fri Dec 6 14:18:35 2019 +0000

>>      can: j1939: j1939_sk_bind(): take priv after lock is held

>> bisection log:   
>> https://syzkaller.appspot.com/x/bisect.txt?x=1001b266e00000
>> start commit:   32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of  
>> git://git.ke..
>> git tree:       upstream
>> kernel config:   
>> https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
>> dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
>> syz repro:       
>> https://syzkaller.appspot.com/x/repro.syz?x=177c34a2e00000

>> If the result looks correct, please mark the bug fixed by replying with:

> #syz fix: can: j1939: j1939_sk_bind(): take priv after lock is held

Your 'fix:' command is accepted, but please keep  
syzkaller-bugs@googlegroups.com mailing list in CC next time. It serves as  
a history of what happened with each bug report. Thank you.


> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
