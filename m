Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B34A64F2
	for <linux-can@vger.kernel.org>; Tue, 15 Sep 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487804; cv=none; b=aOEFaYTcXilassu0FUz9lslvPDJbYGq0CtZD9kc5H4gVe9znIQQT0JdjAPYO16DrOkhub7D7IPWqMdP8Uo55vTHi57vIQYgpVy93FyECfdQvioUs2Jq5MUE1PBdNs7bglIzl48tA+cY6SxHM6XsrnK/OVn1lDfEK/SHBdrYsbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487804; c=relaxed/simple;
	bh=hKbfXdVOs4XvRozhAta7uu/JJurNzhfi55csK8P+3LI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OJGCjbmJBZNakxDjTNjsaHZ9D+8+3TIXne3tVkJCWevKyM4AAp9jAUjbrWOvreXFlicQNpTjlyeIw1UjdwaMqglb0SkElTqVPTm2ulNEoc5yU66p6/AzerBNx2a405a4jghLIbMH81O3WarzteUeSTy85NaTTWZ3ErDuFMCw6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-44cdbcd53b8so545422fac.0
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2026 08:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789487800; x=1790092600;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HoA9W0frTHaeQ396iZMJnY+gg68nN0Xuq0EiTpcHfg8=;
        b=Jo9qA/1n2Frj1Rx+JqS4ty53cB4PajpfSZx+oc3UzuTtms56BHJaC+KPeievSS4iZs
         rUbsvjTq0JMr0zn3W0ZgR8ngmSHbe/mnPRJFaIORKSO3gepqKkOJvy9Q1bdp0LUmD+SG
         48vEJhCWvMekZxqf0kwWNxHkROuTf8rMRLTurgYJpzYsgmvsbBmjHGceoAqFMTosHW+g
         lXbKjceP9UHyJPksWxb3/l9wrfUlNxpIBPBsaMD/PFNmfn7XN8g61UOWOwHgxyEn9JkZ
         Ne5AOjc47Z6O/YP4kGLvEDf8xM0uTHLztsUKdJV1N7N83NmUSsmooc3dor2PQiAF3ddv
         MVQQ==
X-Forwarded-Encrypted: i=1; AKwUvBysEeAWKOihASkLsJYImrQreEW2cTicCaGVIXQgnJTon44VUxO0EcVUZGBW/gqN1rJ+5MJWT3mZE5s=@vger.kernel.org
X-Gm-Message-State: AFuF++lD0oYh73Js08oxYELoBe2dR4xRdOnFCrxhf58TMJsWxk3ZZwog
	DdMVhexpERW3ZzUomEG6Fa/uHUoo0EiaTn/Nj7S7RZow6U0YC1fV5I7X3Ys4k6MKpzIRB1oPICk
	TxAZLjtGJwh+OEvOvnrI0n3rZYok9JSjUBaZdf8nhjVKZAg9AxWMbcpKgVbQ=
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160e:b0:6b3:f762:4d95 with SMTP id
 006d021491bc7-6c53f252e87mr5122804eaf.7.1789487799965; Tue, 15 Sep 2026
 08:56:39 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:56:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa96ab7.4c28b7d0.c1bba.003d.GAE@google.com>
Subject: [syzbot] [can?] WARNING in __netif_receive_skb_core
From: syzbot <syzbot+1aae11dc8d42ec1a87ec@syzkaller.appspotmail.com>
To: dario.binacchi@amarulasolutions.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol@kernel.org, mkl@pengutronix.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    704340f1cd0d Merge tag 'x86_urgent_for_7.3-rc4' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a62471580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=1aae11dc8d42ec1a87ec
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1580bc8e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169f9905580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/192c594c6096/disk-704340f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79d1488deb4b/vmlinux-704340f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd108c2b8ca0/bzImage-704340f1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1aae11dc8d42ec1a87ec@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: ./include/linux/skbuff.h:3003 at skb_reset_mac_len include/linux/skbuff.h:3003 [inline], CPU#0: kworker/u8:1/13
WARNING: ./include/linux/skbuff.h:3003 at __netif_receive_skb_core.constprop.0+0x1706/0x3530 net/core/dev.c:6061, CPU#0: kworker/u8:1/13
Modules linked in:
CPU: 0 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:skb_reset_mac_len include/linux/skbuff.h:3003 [inline]
RIP: 0010:__netif_receive_skb_core.constprop.0+0x1706/0x3530 net/core/dev.c:6061
Code: de 4c 8b bc 24 e8 00 00 00 e8 86 f7 6b f8 85 db 0f 88 11 f2 ff ff 31 db 4d 8d af 81 00 00 00 e9 01 ed ff ff e8 fb fc 6b f8 90 <0f> 0b 90 31 db e9 43 eb ff ff e8 eb fc 6b f8 e8 66 af 4f f8 31 ff
RSP: 0018:ffffc90000007990 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000000101
RDX: ffff88801f2a0000 RSI: ffffffff89a02015 RDI: ffff88801f2a0000
RBP: 000000000000ffff R08: 0000000000000003 R09: 000000000000ffff
R10: 000000000000ffff R11: 0000000000000001 R12: ffff888075f88140
R13: ffffc90000007c10 R14: ffff888075f88140 R15: ffff888075f88140
FS:  0000000000000000(0000) GS:ffff888123b59000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd21e26870 CR3: 00000000729f5000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __netif_receive_skb_one_core+0xb0/0x1e0 net/core/dev.c:6262
 __netif_receive_skb+0x1f/0x120 net/core/dev.c:6377
 process_backlog+0x487/0x1600 net/core/dev.c:6728
 __napi_poll.constprop.0+0xaf/0x450 net/core/dev.c:7787
 napi_poll net/core/dev.c:7850 [inline]
 net_rx_action+0xa40/0xf20 net/core/dev.c:8007
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 do_softirq kernel/softirq.c:546 [inline]
 do_softirq+0xaf/0xf0 kernel/softirq.c:533
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xff/0x120 kernel/softirq.c:473
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 netif_rx net/core/dev.c:5837 [inline]
 netif_rx+0x93/0xb0 net/core/dev.c:5826
 slcan_bump_err drivers/net/can/slcan/slcan-core.c:448 [inline]
 slcan_bump drivers/net/can/slcan/slcan-core.c:463 [inline]
 slcan_unesc drivers/net/can/slcan/slcan-core.c:476 [inline]
 slcan_receive_buf+0x1a66/0x1f30 drivers/net/can/slcan/slcan-core.c:807
 tty_ldisc_receive_buf+0x15a/0x1a0 drivers/tty/tty_buffer.c:398
 tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:452 [inline]
 flush_to_ldisc+0x26b/0x730 drivers/tty/tty_buffer.c:502
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3396
 process_scheduled_works kernel/workqueue.c:3479 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3560
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
