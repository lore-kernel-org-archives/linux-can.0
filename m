Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D00366553
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556696; cv=none; b=gUZ+Dy7q3hHhYGJdoQcoTxZi1Ck3PrihvCan5Shadkf8BaCk0F+14TWBT8KQtdYKLbvCG7cZHQpDQv/M3tfsFR8fvqSmpcNodpP9Cjlf5/pV43xHyD35csji86n3kyjw5DUecChbQzLKnl6LL4tv/ZtWDmxY+XHKrgn7GcNhyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556696; c=relaxed/simple;
	bh=sG3ErCOG4uiHIICpCOwdYPuTGSZmkwC6RROfqDy/PLo=;
	h=Message-ID:From:Date:Subject:To:Cc:MIME-Version:Content-Type; b=kRqwKPt9bYLV8D+eMN1IIwoAKWA49hl0YXSjwHES05ifIgLLhIm7ZHKR5Sny2/kjp80DYLwj3mXgtK4eIHWUbm4I676yYz44r3eomsNoUm34/xe/x/W97mVdExn4kx66ymcF09wmsZyosbDVJj9AE3vior55yBp8vl//eNZ2uX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=akKMKprz; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=H7MoP9jN; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="akKMKprz";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="H7MoP9jN"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=Cc:To:Subject:Date:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1788556694; x=1789161494; bh=tZxFD+4jm1eZVyWz8d
	GpTcv5maGZf3AgPhJold/6k3M=; b=akKMKprziixsHwFMK1pt7r7pjzlUund6HR0SxwnZ0rsPH
	hk0x6t05ajtGJ5pjSNFbyxZbqqLPU7VsE7l8R2hiOoEqypD3n9bEezRXT6fSWqQj1jO7YtmH92v
	+Ty7ML6B0HDytwXjlcSuwmpfHx+O/mN9EX/mqU/YrbDaLgD77qJZk6FBxOZYHJqrl+D4rVxd0i4
	B0rsXoNIh8yuIX2MnFCH3Z6IvjD1kYYJU7y4sk6ULR/KU1adTDvu+C1dZHaaUVDNeeue9fjk1Rk
	lEgjgn1b4O06d5fEOeURRzk8yUKhkdBtPwnNXGyNO9Sn+RKmKyC7gRMVzyI8t8MOy3l7kNGw==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=Cc:To:Subject:Date:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1788556694; x=1789161494; bh=tZxFD+4jm1eZVyWz8d
	GpTcv5maGZf3AgPhJold/6k3M=; b=H7MoP9jNdtuNohfK3qECkSWxTgqWki2utVtsrd9WioYOb
	T7L0TeBF3lYsw2xOJ5C1JYVwLrRfrxaPydz4bhpmwrdz1ssXtbvvVzuZXeXVEtcdgdH0Z593Z/q
	+QzJUsAcvTABiuSb8GnPMdHObx7cayyctZ6xAG7YJ9o6xPISJ4hdU1ftjWRhJB0maoqyViXWDAN
	aqah5vE7a6oENg3N0kZTS9K1kZEiJCTDlhWw0HNjJt4F771ES5POQZ9imF9QoB1ReeNaROCy4Y2
	BLCa0XQca4aIQXCoLx9haqYqJjufSMjhkHvVEhlCi8V5yNFr3tgQ2/W6UxDYIxt/CpLpyaQQ==;
Feedback-ID: bugs.sh:5:6:Cloudflare
Message-ID: <upsCxxaJjg2FJWhfCx6KjFXLlh8o4IhaHKJi@bugs.sh>
From: co <co+5e2bcf11e7027510@bugs.sh>
Date: Fri, 04 Sep 2026 21:17:50 +0000
Subject: [BUG] drivers/net: out-of-bounds in pcan_usb_decode_buf()
To: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
Cc: "Petr Mladek" <pmladek@suse.com>, "Geert Uytterhoeven" <geert+renesas@glider.be>,
 =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.fr>, "Oleg
 Nesterov" <oleg@redhat.com>, "Biju Das" <biju.das.jz@bp.renesas.com>, "Song
 Liu" <song@kernel.org>, linux-kernel@vger.kernel.org, co <co+5e2bcf11e7027510@bugs.sh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We found a bug reachable in:

    path    drivers/net/can/usb/peak_usb
    crash   out-of-bounds in pcan_usb_decode_buf()
    commit  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/trace/linux-trace")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+5e2bcf11e7027510@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/5e2bcf11e7027510/patch.diff
        report.md   https://bugs.sh/b/5e2bcf11e7027510/report.md

    This is an open science project. The code and the full set of PoCs
    are not public at this moment, as we intend to disclose our findings
    in an ethical way.

    Happy to test patches. Complaints and suggestions about our work
    are welcome at:

        cedalion@bugs.sh

=3D=3D Environment =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    Reproduced on  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/trace/linux-trace")
    VM setup       https://bugs.sh/b/5e2bcf11e7027510/run.sh
    config         https://bugs.sh/b/5e2bcf11e7027510/config.gz
    poc            https://bugs.sh/b/5e2bcf11e7027510/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in pcan_usb_decode_buf (drivers/net/can/usb/=
peak_usb/pcan_usb.c:563 drivers/net/can/usb/peak_usb/pcan_usb.c:630 drivers=
/net/can/usb/peak_usb/pcan_usb.c:740 drivers/net/can/usb/peak_usb/pcan_usb.=
c:758)
Read of size 1 at addr ffff8880253816c1 by task swapper/1/0
Call Trace:
<IRQ>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
pcan_usb_decode_buf (drivers/net/can/usb/peak_usb/pcan_usb.c:563 drivers/ne=
t/can/usb/peak_usb/pcan_usb.c:630 drivers/net/can/usb/peak_usb/pcan_usb.c:7=
40 drivers/net/can/usb/peak_usb/pcan_usb.c:758)
peak_usb_read_bulk_callback (drivers/net/can/usb/peak_usb/pcan_usb_core.c:2=
67)
__usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1741)
dummy_timer (drivers/block/aoe/aoedev.c:523 (discriminator 1) drivers/block=
/aoe/aoedev.c:298 (discriminator 1) drivers/block/aoe/aoedev.c:377 (discrim=
inator 1))
__hrtimer_run_queues (kernel/time/hrtimer.c:2067 kernel/time/hrtimer.c:2124)
hrtimer_run_softirq (kernel/time/hrtimer.c:2141)
handle_softirqs (kernel/softirq.c:645)
__irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq.c:=
767)
irq_exit_rcu (kernel/softirq.c:784)
sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discriminato=
r 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
</IRQ>
asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:674)
default_idle (./arch/x86/include/asm/paravirt.h:62 arch/x86/kernel/process.=
c:768)
default_idle_call (kernel/sched/idle.c:122)
do_idle (kernel/sched/idle.c:199 kernel/sched/idle.c:355)
cpu_startup_entry (kernel/sched/idle.c:454 (discriminator 1))
start_secondary (arch/x86/kernel/smpboot.c:312)
common_startup_64 (arch/x86/kernel/head_64.S:418)
Allocated by task 5007:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
__kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
__kmalloc_noprof (./include/linux/kasan.h:263 mm/slub.c:5414 mm/slub.c:5439)
peak_usb_ndo_open (./include/linux/slab.h:995 drivers/net/can/usb/peak_usb/=
pcan_usb_core.c:451 drivers/net/can/usb/peak_usb/pcan_usb_core.c:583)
__dev_open (net/core/dev.c:1724)
__dev_change_flags (net/core/dev.c:9812)
netif_change_flags (net/core/dev.c:9877)
dev_change_flags (net/core/dev_api.c:68)
devinet_ioctl (net/ipv4/devinet.c:1199)
inet_ioctl (net/ipv4/af_inet.c:1009)
sock_do_ioctl (net/socket.c:1325)
sock_ioctl (net/socket.c:1446)
__x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583 fs/ioctl.c:583)
do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:8=
4)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
The buggy address belongs to the object at ffff888025381680
which belongs to the cache kmalloc-64 of size 64
The buggy address is located 1 bytes to the right of


---
The report format is based on syzbot bug report.

This report is generated by a bot. It may contain errors.
See https://github.com/n132/cedalion for more information.

For any issue with this report, reach out to cedalion@bugs.sh

If the report is already addressed, let us know by replying with:
#co fix: <commit hash>

If the report is a duplicate of another one, reply with:
#co dup: <lore link>

If you want to undo deduplication, reply with:
#co undup


