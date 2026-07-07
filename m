Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94077231827
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410415; cv=none; b=mfdI23vqbeGVRVqROZW+qRxuQT9ZloE4aL6im0M3lwffjjHBLzYNiTrxEmQNJ13oaYWuulIsfxcUpWhi9pvLqvLB5BNEPpOsXPCbnkn5SKPXTSrDPGvNzYbDpnFAxO78IrcU6mpw9OXGyEnN/vosIawdbH/EKGsG/5O/6PAOcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410415; c=relaxed/simple;
	bh=C1cyOiqGRaoCHDZ2ewHKGVyyljHqiN8f8rqJQH3aJTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AgNEiFZITRpzNBEqdic4QikEDZdwVkztvMxzDpn6igpm4S8KosJj/X/qYASixpd16yOLpZ5Jbej3Aj3/QsS+wgrFyG95iqkRUZTkaWXvdusN57aoshoOUDoECiyQwJpI8Nzv57RIHPUs1RB/pf+oizQjoEWF2iI7ev5HPfRZ/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OToifR30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OToifR30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325F01F00A3A;
	Tue,  7 Jul 2026 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783410414;
	bh=S4xlE3C6DLD0d+8Ucao6L0PqnkvQkT4rdoXZRU9tGM8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OToifR30++w6t4EkgysiyrFB/r/Uk01MHPeM8ZBGJobn76KX6FUW80yJOX5Gt27FQ
	 OrI+DY/Mb/a4eg6FATeTlI/4kurI7Q4Z3OqsqYWkQvcCLNCAlUamxkh7RQM7+ubBLi
	 bZY2d19oh6qyfBNvSgJBp07LdTlHF/KRF/UL0EAPFZaNSceM+IFtcH0WLGv4OvEfx6
	 /uI9TKgbRFw4aFSkB+2Ck2FiIQKapc0ACdepNdOhjHxo94BNJYFXrq5aCRZuVK2F0w
	 zIoc71TefCoKy9dXXviymeNYvNFhHIW5lNKsMgoHTc0npymhU1te6pOLKnBmxdTZzp
	 YLotlm5ZVOfxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: Convert %pK back to %p
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260706073824.xixrLxoD@linutronix.de>
References: <20260706073824.xixrLxoD@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:46:53 +0000
Message-Id: <20260707074654.325F01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Replacing `%pK` with `%p` breaks userspace tracing ABI and `kp=
tr_restrict` runtime configurability.
- [Medium] Incomplete refactoring misses `net/bluetooth/af_bluetooth.c`, le=
aving inconsistent pointer formatting behavior.
--

commit b2c57f416d95fe882e14b5fd13915b835f475930
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

net: Convert %pK back to %p

This commit reverts a 2011 change that converted %p usage to %pK in the
networking subsystem. It replaces %pK with %p across various procfs output
files, stating that %p now defaults to a hashed pointer anyway.

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 209ef7522508f..aa31af06e5e3b 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c

[ ... ]

> @@ -2806,7 +2806,7 @@ static void get_tcp4_sock(struct sock *sk, struct s=
eq_file *f, int i)
>  				      READ_ONCE(tp->copied_seq), 0);
> =20
>  	seq_printf(f, "%4d: %08X:%04X %08X:%04X %02X %08X:%08X %02X:%08lX "
> -			"%08X %5u %8d %llu %d %pK %lu %lu %u %u %d",
> +			"%08X %5u %8d %llu %d %p %lu %lu %u %u %d",

[Severity: Critical]
Does replacing %pK with %p in get_tcp4_sock() break the userspace tracing
ABI and bypass the kernel.kptr_restrict sysctl?

Under kptr_restrict=3D1 (the default on most distributions), %pK returns the
raw kernel pointer to users with the syslog capability. By reverting to %p,
a hashed pointer is unconditionally returned instead.=20

While the commit message notes that hash_pointers can be disabled at boot,
does this break the runtime configurability provided by the
kernel.kptr_restrict sysctl?=20

Will existing tracing tools that correlate /proc sockets with kernel memory
receive hashes and fail instead of raw pointers?

[ ... ]

> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a1..6a8174977c87a 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c

[ ... ]

> @@ -3554,7 +3554,7 @@ static int unix_seq_show(struct seq_file *seq, void=
 *v)
>  		struct unix_sock *u =3D unix_sk(s);
>  		unix_state_lock(s);
> =20
> -		seq_printf(seq, "%pK: %08X %08X %08X %04X %02X %5llu",
> +		seq_printf(seq, "%p: %08X %08X %08X %04X %02X %5llu",

[Severity: Critical]
Does this also expose unix socket structures directly as hashed pointers in
unix_seq_show(), bypassing sysctl restrictions?

Similar to the tcp change above, will tracing tools no longer be able to
resolve these pointers when kptr_restrict=3D1 is set?

[ ... ]

[Severity: Medium]
Does this commit leave the networking subsystem in an inconsistent state by
missing net/bluetooth/af_bluetooth.c?

Looking at bt_seq_show() in net/bluetooth/af_bluetooth.c, it still uses %pK:

    seq_printf(f, "%pK %-6d %-6u %-6u %-6u %-6llu %-6llu",

Is this the only remaining use of %pK in the net/ subsystem that was missed
by the refactoring? This appears to leave bluetooth procfs files respecting
kptr_restrict while the other protocols do not.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706073824.xixr=
LxoD@linutronix.de?part=3D1
