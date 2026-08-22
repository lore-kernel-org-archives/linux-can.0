Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6913CF82
	for <linux-can@vger.kernel.org>; Sat, 22 Aug 2026 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787357432; cv=none; b=XnjaQ3aougLHzomf/NyDBig5XaQqGou6ZEK2wsPqFVKR1+F+dcVQ8HH26rsnow+l/yxyAh/krBPFZvYed9FT9EmPjBcp6HpZeprkE8yP2ikmqGGUWUnORdCuaKVxVPXVNO80BEhrWwAwtTBwVRDTTqZDgcPq9Z6VSiz6gmoTUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787357432; c=relaxed/simple;
	bh=FVN2LMF/FK+Aeu6PGpLb3LXWKmQlQh1FX1F6t8vu+84=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K2HLbb0M3v0IHwLs4StIp8XgZOlrH1bE3ICG3dNaOkUBcd2+uJdJlaYFGl0btYOzqof0vm3JpZRdKKV+AM2KkQeyUAIiEAe+2+KAbqpXSy7lh6w/Hqa6LCpjU3FsQpS+klRQtxtOiKTGcXIuDqT7O09dhPLpOZJs63CC1FcaeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4b2fb8f0df0so1390624b6e.0
        for <linux-can@vger.kernel.org>; Fri, 21 Aug 2026 17:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787357429; x=1787962229;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbWxMz1Ymw+pqOlRPvrjueGbvxjNk5Dz1beiKhLDvzc=;
        b=aqqEF+1kx79+rhjysPkzg4aLKo4Fx7+8NbFJGnEol/vd5+C+/HksnREgj7BeHvihDb
         DtWGknrvfRa65MG/D09xSm+xHPLmjGg+NQGlsjZ/zPUAElf/jcJ8Ick7r9k7IugiTFNL
         eQI/W2afG35ZKBQj+Nv2jfVJRE6NQabdg4jSGw9e3bFDe5AnbtJK9cW9eTzJRO98qnwZ
         NjAxIWvO5hhCaKMpVKol8op0E8DVhHl6AwTY/mucUzsWivUsNi7XFnGRg1qLJ/Iuumtu
         P4boTDknV5BbWiALHnmX/w0rX8ir7RHEEJBUwPWo6uJU07SX73D+3ktPmaUJDA7ijahd
         I8kg==
X-Forwarded-Encrypted: i=1; AHgh+RpbL7YbS8PRgvGf4MONw07rBmXOb46PAkFbz+uzSWBbx5cIYLgh3jFG2sh6aiNYvbSRYg2JKuvRV/E=@vger.kernel.org
X-Gm-Message-State: AFuF++lhdx+9LCGkSEagCyyYk2N7rSXK+UD81J8ub0obJqF4ZA6zfBH8
	B+Nj4Y3emWBF/utdArpt8wGmy2go2tuBqPDCV6tEfE01aHA5sIAw+RsQREw1/DNeL4eYSfIr0Qu
	yflk5bPhaf0YkT4TkXgS2otjjdXEFVhh/a0XGrOpOBjSuwNhuZ6Jgek80YkU=
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4487:b0:4a4:adaf:5576 with SMTP id
 5614622812f47-4b2ef0d4439mr12974564b6e.4.1787357429494; Fri, 21 Aug 2026
 17:10:29 -0700 (PDT)
Date: Fri, 21 Aug 2026 17:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a88e8f5.91706f20.16b6e3.02ac.GAE@google.com>
Subject: [syzbot] [can?] memory leak in j1939_netdev_start (2)
From: syzbot <syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com>
To: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de, 
	robin@protonic.nl, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d3ae59288f1 Linux 7.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14728679580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11ad91fcc8fa7933
dashboard link: https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165f3949580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c8b6c6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/735a458674ac/disk-8d3ae592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fbf50adb0745/vmlinux-8d3ae592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6effa5f7f690/bzImage-8d3ae592.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812c9ca000 (size 8192):
  comm "syz.0.17", pid 6047, jiffies 4294942443
  hex dump (first 32 bytes):
    c0 36 87 2e 81 88 ff ff c0 36 87 2e 81 88 ff ff  .6.......6......
    00 00 00 00 00 00 00 00 00 80 77 2e 81 88 ff ff  ..........w.....
  backtrace (crc d013ab57):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    j1939_priv_create net/can/j1939/main.c:131 [inline]
    j1939_netdev_start+0x168/0x710 net/can/j1939/main.c:268
    j1939_sk_bind+0x223/0x5a0 net/can/j1939/socket.c:506
    __sys_bind_socket net/socket.c:1920 [inline]
    __sys_bind_socket net/socket.c:1912 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1951
    __do_sys_bind net/socket.c:1956 [inline]
    __se_sys_bind net/socket.c:1954 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1954
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812e8736c0 (size 192):
  comm "syz.0.17", pid 6047, jiffies 4294942443
  hex dump (first 32 bytes):
    00 a0 9c 2c 81 88 ff ff 00 a0 9c 2c 81 88 ff ff  ...,.......,....
    08 07 06 05 04 03 02 01 20 00 00 00 00 00 00 00  ........ .......
  backtrace (crc 2ba0e4b2):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    j1939_ecu_create_locked+0x5c/0x200 net/can/j1939/bus.c:155
    j1939_local_ecu_get+0x102/0x140 net/can/j1939/bus.c:293
    j1939_sk_bind+0x38c/0x5a0 net/can/j1939/socket.c:529
    __sys_bind_socket net/socket.c:1920 [inline]
    __sys_bind_socket net/socket.c:1912 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1951
    __do_sys_bind net/socket.c:1956 [inline]
    __se_sys_bind net/socket.c:1954 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1954
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812c9c8000 (size 8192):
  comm "syz.0.24", pid 6048, jiffies 4294942445
  hex dump (first 32 bytes):
    40 ab e4 12 81 88 ff ff 40 ab e4 12 81 88 ff ff  @.......@.......
    00 00 00 00 00 00 00 00 00 80 77 2e 81 88 ff ff  ..........w.....
  backtrace (crc da7feccc):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    j1939_priv_create net/can/j1939/main.c:131 [inline]
    j1939_netdev_start+0x168/0x710 net/can/j1939/main.c:268
    j1939_sk_bind+0x223/0x5a0 net/can/j1939/socket.c:506
    __sys_bind_socket net/socket.c:1920 [inline]
    __sys_bind_socket net/socket.c:1912 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1951
    __do_sys_bind net/socket.c:1956 [inline]
    __se_sys_bind net/socket.c:1954 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1954
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888112e4ab40 (size 192):
  comm "syz.0.24", pid 6048, jiffies 4294942445
  hex dump (first 32 bytes):
    00 80 9c 2c 81 88 ff ff 00 80 9c 2c 81 88 ff ff  ...,.......,....
    08 07 06 05 04 03 02 01 20 00 00 00 00 00 00 00  ........ .......
  backtrace (crc 73ecd91d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    j1939_ecu_create_locked+0x5c/0x200 net/can/j1939/bus.c:155
    j1939_local_ecu_get+0x102/0x140 net/can/j1939/bus.c:293
    j1939_sk_bind+0x38c/0x5a0 net/can/j1939/socket.c:529
    __sys_bind_socket net/socket.c:1920 [inline]
    __sys_bind_socket net/socket.c:1912 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1951
    __do_sys_bind net/socket.c:1956 [inline]
    __se_sys_bind net/socket.c:1954 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1954
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812c9d6000 (size 8192):
  comm "syz.0.25", pid 6050, jiffies 4294942445
  hex dump (first 32 bytes):
    80 3d 69 13 81 88 ff ff 80 3d 69 13 81 88 ff ff  .=i......=i.....
    00 00 00 00 00 00 00 00 00 80 77 2e 81 88 ff ff  ..........w.....
  backtrace (crc cb2b95df):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    j1939_priv_create net/can/j1939/main.c:131 [inline]
    j1939_netdev_start+0x168/0x710 net/can/j1939/main.c:268
    j1939_sk_bind+0x223/0x5a0 net/can/j1939/socket.c:506
    __sys_bind_socket net/socket.c:1920 [inline]
    __sys_bind_socket net/socket.c:1912 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1951
    __do_sys_bind net/socket.c:1956 [inline]
    __se_sys_bind net/socket.c:1954 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1954
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff888113693d80 (size 192):
  comm "syz.0.25", pid 6050, jiffies 4294942445
  hex dump (first 32 bytes):
    00 60 9d 2c 81 88 ff ff 00 60 9d 2c 81 88 ff ff  .`.,.....`.,....
    08 07 06 05 04 03 02 01 20 00 00 00 00 00 00 00  ........ .......
  backtrace (crc 35e45c5a):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    j1939_ecu_create_locked+0x5c/0x200 net/can/j1939/bus.c:155
    j1939_local_ecu_get+0x102/0x140 net/can/j1939/bus.c:293
    j1939_sk_bind+0x38c/0x5a0 net/can/j1939/socket.c:529
    __sys_bind_socket net/socket.c:1920 [inline]
    __sys_bind_socket net/socket.c:1912 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1951
    __do_sys_bind net/socket.c:1956 [inline]
    __se_sys_bind net/socket.c:1954 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1954
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812c9d4000 (size 8192):
  comm "syz.0.26", pid 6051, jiffies 4294942446
  hex dump (first 32 bytes):
    c0 e3 ed 12 81 88 ff ff c0 e3 ed 12 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 80 77 2e 81 88 ff ff  ..........w.....
  backtrace (crc eb403d26):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4597 [inline]
    slab_alloc_node mm/slub.c:4917 [inline]
    __kmalloc_cache_noprof+0x356/0x440 mm/slub.c:5485
    _kmalloc_noprof include/linux/slab.h:988 [inline]
    _kzalloc_noprof include/linux/slab.h:1309 [inline]
    j1939_priv_create net/can/j1939/main.c:131 [inline]
    j1939_netdev_start+0x168/0x710 net/can/j1939/main.c:268
    j1939_sk_bind+0x223/0x5a0 net/can/j1939/socket.c:506
    __sys_bind_socket net/socket.c:1920 [inline]
    __sys_bind_socket net/socket.c:1912 [inline]
    __sys_bind+0x131/0x160 net/socket.c:1951
    __do_sys_bind net/socket.c:1956 [inline]
    __se_sys_bind net/socket.c:1954 [inline]
    __x64_sys_bind+0x1c/0x30 net/socket.c:1954
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
