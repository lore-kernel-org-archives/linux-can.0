Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5A43C077;
	Wed,  3 Jun 2026 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491095; cv=pass; b=CRN03CGhzfnrW1ks27bk81ZomALADQAR5jRaYY5PSynHy673mwVZZy64d0PeDNMVsqmtFf+OT2J5eruF/oYNvoPmo3DsTdob1OPyAZjrIng6749xfG+ReV9ZQcwRnkqPZ91mPSsJXORw8V/ilYe9+77uPipQgWtlWN8j0JVk3VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491095; c=relaxed/simple;
	bh=JMq5UWb+EMGSNcSbGDLsSgTYR0F0f5hnCXf6E3ORmGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tH43WNPMUJK8qqWwLQl3srWPOLUrzKYmv55YkGAe5ZEjajAQ5wVFWJx3g7plS+T9mWhco7MEzIcEpp867rMK2+0vf0I6PdeQ6F9X/ZE83zd4MIkScMgqjFn8VCiNJnoRYuxvKyGEOXdcUTd6cSQfC84J9FWMv2dx5KoS8wSmbJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=awx9ki/L; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ca32LwXN; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="awx9ki/L";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ca32LwXN"
ARC-Seal: i=1; a=rsa-sha256; t=1780490905; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=riyEm5JQ+GsiXRngLz0S1tMHffH7ayyzHEoi0VeYTancEX+tptGfcDqthVTRWt11lv
    mUHN9MVjxOHkvfM+27jqPntW3lfWIy5vIeTriZt3CSQNMMGvZ0gqKAqCvjLILbOf73mc
    YOZTsZ2dsW5AxXgw0gYnwIRMUL3v4r8zpkqD9x5oAU34OsPzKW71013A34yCiXE0KdkE
    o+cJ9fBl31dNoQkRebojAnMsggY7QQbWTRcJ+jKHQhv3UWXCxMVtnmdPfJo/8aB+GLUy
    4TX4xD2NQJKeHp2lQRruopYiL38ar9NtBzPKMFxINiAX+QxpEJ8Mb5/Uq9ObUN6jiLwt
    wztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780490905;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=in/kH2aiZrg6By3S7ArPkKZaBDXFzOBlC8Oa4OSl1sM=;
    b=VONZ2tEhFUeD4MTShOYRLF4H6ZrOEgSu1CwCXighqANbvS+1SNMiNcFF8ImXdoIFv8
    YMDCIsd8WY3oegvSDUgx6Qdfz5iBH1OYolAjL4neIPiMJ2yuBOCanLK1ZwozODfV2MAF
    AX+dExqhIl5NtJKTdpDrjpnp/euiZ4/Wo0wHyeYG2N44/UzylomvhTc/+eWInndnTDNg
    tnq0EZ0JMTSF1yfJKzmAzBmbGKU/2UBPJmhpl8z5eKDdkR2LZzzGViEq+1ar75Qg3wyQ
    Mk84Q0OiRe0860gzJoQ7tsqw4iF835RIDg3RSoMK7OJF1og+XzD8WnZKzVBYOnbQvfxN
    dCtw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780490905;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=in/kH2aiZrg6By3S7ArPkKZaBDXFzOBlC8Oa4OSl1sM=;
    b=awx9ki/LT6/TcM1kb5G0KHyEsv5aLnauLl68ho1NQOu68elZSYgJSfRIUBTY/wOaux
    nZhC+BiUk2aeV+1RIFfr0XilQTI0hl+ElYTqQCOoKV5F3hp18DfFEDC3gENuyh92W6L9
    pxNrHNgURZQJryVd5ggTwDaSPEgxCRAAkoOwBdxcSwEaBkIsg3Sv4h/Zwhgr7u+IFwKI
    wf3cpWgvSYp6ONv6apLHqpMSPtdNaxHg9UiOoVnE4xyXjXYmobtsV4sVbYvsp5vFwJ0l
    vXBmlNZV3u/a9SmzQ6ou7hIRiPxicaH+Dh6aC/pDqE/x3BjwcRfK7biUe2OEiCJiLMpj
    EV+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780490905;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=in/kH2aiZrg6By3S7ArPkKZaBDXFzOBlC8Oa4OSl1sM=;
    b=ca32LwXNb3DlaKXtZtbcZsSCrtcTo697Lij/84OFgo5iFHschiMVxEtq4g5vTVuRKz
    qMb/jEC9zeWGm8zGVrBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.90.236]
    by smtp.strato.de (RZmta 55.0.1 DYNA|AUTH)
    with ESMTPSA id Kba96d253CmPWII
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Jun 2026 14:48:25 +0200 (CEST)
Message-ID: <f80790ca-64e3-4581-a6d7-8e53e8949026@hartkopp.net>
Date: Wed, 3 Jun 2026 14:48:25 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [can?] memory leak in can_rx_register
To: syzbot <syzbot+24201717ed2da31b8fae@syzkaller.appspotmail.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mkl@pengutronix.de,
 syzkaller-bugs@googlegroups.com
References: <6a1ffdd9.278b5b03.2bcf39.004b.GAE@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <6a1ffdd9.278b5b03.2bcf39.004b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I don't see any CAN netdevice name in the logs.

So it is likely some bonding/teaming magic again, which should be fixed 
by "bonding: refuse to enslave CAN devices"

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8ba68464e4787b6a7ec938826e16124df20fd23d

Best regards,
Oliver

On 03.06.26 12:11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    af4e9ef3d784 uaccess: Fix scoped_user_read_access() for 'p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a7935a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=24201717ed2da31b8fae
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      [OBSOLETE] https://syzkaller.appspot.com/x/repro.syz?x=14986d5a580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/70cb2ebe1e6e/disk-af4e9ef3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/945fea3c8a6d/vmlinux-af4e9ef3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fa6a6a5cbcc8/bzImage-af4e9ef3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+24201717ed2da31b8fae@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888127ebfb40 (size 80):
>    comm "syz.5.22", pid 6143, jiffies 4294942019
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 10 8b fd 08 81 88 ff ff  ................
>      02 00 00 00 ff 07 00 c0 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 976436cd):
>      kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>      slab_post_alloc_hook mm/slub.c:4520 [inline]
>      slab_alloc_node mm/slub.c:4844 [inline]
>      kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4851
>      can_rx_register+0xbf/0x220 net/can/af_can.c:461
>      isotp_bind+0x470/0x510 net/can/isotp.c:1345
>      __sys_bind_socket net/socket.c:1874 [inline]
>      __sys_bind_socket net/socket.c:1866 [inline]
>      __sys_bind+0x131/0x160 net/socket.c:1905
>      __do_sys_bind net/socket.c:1910 [inline]
>      __se_sys_bind net/socket.c:1908 [inline]
>      __x64_sys_bind+0x1c/0x30 net/socket.c:1908
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> BUG: memory leak
> unreferenced object 0xffff888127ebfaf0 (size 80):
>    comm "syz.5.22", pid 6143, jiffies 4294942019
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 cb fd 08 81 88 ff ff  ................
>      00 00 00 80 ff ff ff df 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 4af33172):
>      kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>      slab_post_alloc_hook mm/slub.c:4520 [inline]
>      slab_alloc_node mm/slub.c:4844 [inline]
>      kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4851
>      can_rx_register+0xbf/0x220 net/can/af_can.c:461
>      isotp_bind+0x29f/0x510 net/can/isotp.c:1352
>      __sys_bind_socket net/socket.c:1874 [inline]
>      __sys_bind_socket net/socket.c:1866 [inline]
>      __sys_bind+0x131/0x160 net/socket.c:1905
>      __do_sys_bind net/socket.c:1910 [inline]
>      __se_sys_bind net/socket.c:1908 [inline]
>      __x64_sys_bind+0x1c/0x30 net/socket.c:1908
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> BUG: memory leak
> unreferenced object 0xffff888127d994b0 (size 80):
>    comm "syz.6.23", pid 6176, jiffies 4294942079
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 10 8b a8 13 81 88 ff ff  ................
>      02 00 00 00 ff 07 00 c0 00 00 00 00 00 00 00 00  ................
>    backtrace (crc 179b079f):
>      kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>      slab_post_alloc_hook mm/slub.c:4520 [inline]
>      slab_alloc_node mm/slub.c:4844 [inline]
>      kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4851
>      can_rx_register+0xbf/0x220 net/can/af_can.c:461
>      isotp_bind+0x470/0x510 net/can/isotp.c:1345
>      __sys_bind_socket net/socket.c:1874 [inline]
>      __sys_bind_socket net/socket.c:1866 [inline]
>      __sys_bind+0x131/0x160 net/socket.c:1905
>      __do_sys_bind net/socket.c:1910 [inline]
>      __se_sys_bind net/socket.c:1908 [inline]
>      __x64_sys_bind+0x1c/0x30 net/socket.c:1908
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> BUG: memory leak
> unreferenced object 0xffff888127d99460 (size 80):
>    comm "syz.6.23", pid 6176, jiffies 4294942079
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 cb a8 13 81 88 ff ff  ................
>      00 00 00 80 ff ff ff df 00 00 00 00 00 00 00 00  ................
>    backtrace (crc ca0c0020):
>      kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>      slab_post_alloc_hook mm/slub.c:4520 [inline]
>      slab_alloc_node mm/slub.c:4844 [inline]
>      kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4851
>      can_rx_register+0xbf/0x220 net/can/af_can.c:461
>      isotp_bind+0x29f/0x510 net/can/isotp.c:1352
>      __sys_bind_socket net/socket.c:1874 [inline]
>      __sys_bind_socket net/socket.c:1866 [inline]
>      __sys_bind+0x131/0x160 net/socket.c:1905
>      __do_sys_bind net/socket.c:1910 [inline]
>      __se_sys_bind net/socket.c:1908 [inline]
>      __x64_sys_bind+0x1c/0x30 net/socket.c:1908
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

