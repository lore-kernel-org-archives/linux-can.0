Received: from bg-bec.cloudflare-smtp.org (bg-bec.cloudflare-smtp.org [104.30.16.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300AE49C4DA
	for <linux-can@vger.kernel.org>; Thu, 10 Sep 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.30.16.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052635; cv=none; b=CXLiy8T42QeFFvli+1E/53DvWykT+NSKn3Ob1lPvWVcKrv2ZiMi96KKx6SLq0gXXCDjspXRcwiF6btUshUcGn1iUM8AgzUcHvV6NxmLZ7b37UYdlVwxxSHmP3yHqlUNve0kGAU9L8lGeC7geA2HpsfwSCIaNSBiOdtAuuO6vvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052635; c=relaxed/simple;
	bh=GoX9FyVzwtAl5KrZNOVZWeiSnDzUZvNTKJ9UxxAUGKg=;
	h=From:Message-ID:Date:Subject:To:Cc:MIME-Version:Content-Type; b=UAaDivrYbUfy6OtiRsSmEbS8zOA42DxLSruUwqZF8TLMw5FUmVqwxjMiwqt4nlQ6KN7B6TYJz4BzTUA6hVQ1CXsYDG090Tt3UwsdJHTn24zTP9IM1oXMlZzFYxAzORfk1+GP5xHBN9PkbyeHloVWUIROswgDAEchsi1p6LQ+Fuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=cf-bounce.bugs.sh; dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b=Gk+FFMx+; dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=UolOn0yF; arc=none smtp.client-ip=104.30.16.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cf-bounce.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare-smtp.org header.i=@cloudflare-smtp.org header.b="Gk+FFMx+";
	dkim=pass (2048-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="UolOn0yF"
DKIM-Signature: v=1; a=rsa-sha256; s=cf2024-1; d=cloudflare-smtp.org; c=relaxed/relaxed;
	h=Cc:To:Subject:Date:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1789052633; x=1789657433; bh=9mcCJYBOvgbRqUansu
	4tqwyDHJn2WYXOCjsqowyaeoA=; b=Gk+FFMx+U4aRWb3vqOns334tIIcRCbqXEjkZ6yJ3MQiJr
	3TX+pY16Ip8Smlhs9Od2qBlBj22mPg/y5gsuoP3QIERVZCMZcCW37ISjxI3KvY+JqU4yQA1zhmV
	dAIgIqVrIN+kBi9AyK21wciSb5OrK21347+umgG6QkQ3G0H7SDjTMc0rJHELuZ4hVS26x1iBHDB
	0Ry5sI6c0S/D7q7kiJGZNF9zJfjGP17uxT6In1XmjutJ0jXjpnUxk8yMf7h1nza1/A0uCf5/9FN
	F/DWwCskMZEKtNtt6tNR1BQJAAv81WETxrbvCyIwYN/dY8tWB5QTZvYlrkXC4wASumxDSPvQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=cf-bounce; d=bugs.sh; c=relaxed/relaxed;
	h=Cc:To:Subject:Date:From:Feedback-ID:from:reply-to:resent-date
	:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help
	:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post
	:list-owner:list-archive; t=1789052633; x=1789657433; bh=9mcCJYBOvgbRqUansu
	4tqwyDHJn2WYXOCjsqowyaeoA=; b=UolOn0yFv86+Jq7YyLqSIsY87A0lQJKXY6Q7TiyiB5vl4
	grs67x3fK7Mzp7dVGPwFGqMTmUUazW4uC3zZnFyfCGsDWq69+cRbBjSat7yThntkRZVQV0jlMED
	Rageb89WEnjE5y84Kc9Mpfs6HKzmoe92m4QT4KPz+BzIlByenqJ7ns0kZcw1wi7Q9GeZj1Z3O/D
	REHitE5eUGwKp4K+Sa+Bnj+/yI7tARyrQb0bBuXdaBLsTUch6UDePv7nLOkxhHlNmlsGO3+uoaO
	C3tZyorLk8XQRqSTCjaZ+YBcUJwcLsZwzdOHrhLIspyey3Hn1fQYl7Ujb7ANdIMMCoY7gfVQ==;
Feedback-ID: bugs.sh:5:6:Cloudflare
From: co <co+4bda3bf8e1a2b780@bugs.sh>
Message-ID: <XNNBJQCVSRi1dUNtFoqHoHlP3XDSNifVcPOu@bugs.sh>
Date: Thu, 10 Sep 2026 15:03:41 +0000
Subject: [BUG] drivers/net: out-of-bounds in pcan_usb_pro_decode_buf()
To: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
Cc: "Wolfgang Grandegger" <wg@grandegger.com>, =?utf-8?b?U3TDqXBoYW5lIEdy?=
 =?utf-8?b?b3NqZWFu?= <s.grosjean@peak-system.fr>, linux-kernel@vger.kernel.org, co <co+4bda3bf8e1a2b780@bugs.sh>
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
    crash   out-of-bounds in pcan_usb_pro_decode_buf()
    commit  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/trace/linux-trace")

Config, environment, the sanitizer report and a C reproducer follow.

=3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    If you patch the bug based on our artifacts, a tag would be
    appreciated:

Reported-by: co+4bda3bf8e1a2b780@bugs.sh

    Everything in this mail is validated by the reproducer below.

    We also hold an LLM-generated root-cause analysis and a candidate
    patch. The patch passes an A/B test: the same reproducer panics the
    unpatched kernel and runs clean on the patched one. Neither has had
    human review, so both still require validation before you send or
    apply them. Available on:

        patch.diff  https://bugs.sh/b/4bda3bf8e1a2b780/patch.diff
        report.md   https://bugs.sh/b/4bda3bf8e1a2b780/report.md

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
    VM setup       https://bugs.sh/b/4bda3bf8e1a2b780/run.sh
    config         https://bugs.sh/b/4bda3bf8e1a2b780/config.gz
    poc            https://bugs.sh/b/4bda3bf8e1a2b780/repro.c

=3D=3D Sanitizer Report =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in pcan_usb_pro_decode_buf (drivers/net/can/=
usb/peak_usb/pcan_usb_pro.c:562 (discriminator 6) drivers/net/can/usb/peak_=
usb/pcan_usb_pro.c:753 (discriminator 6))
Read of size 15 at addr ffff888030c74c00 by task swapper/1/0
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W           7.3.0-rc=
1-00234-g6a1094c34d17 #66 PREEMPT(full)
Call Trace:
<IRQ>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
__asan_memcpy (mm/kasan/shadow.c:105 (discriminator 1))
pcan_usb_pro_decode_buf (drivers/net/can/usb/peak_usb/pcan_usb_pro.c:562 (d=
iscriminator 6) drivers/net/can/usb/peak_usb/pcan_usb_pro.c:753 (discrimina=
tor 6))
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
Allocated by task 5028:
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
The buggy address belongs to the object at ffff888030c74800
which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes to the right of


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


