Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402510;
	b=zNXQxROJGoyvK/gThQLvI5z4SAbv5Sr9GIQuC9aEkiEg6cIId/zNKjoQOhW7wQ6g6XoP
	 DojPhIEibCCnky0Dn98YJYrkzNSXAnguPEH4w6MKMUFEgtTKSSnpL3PidZ5tgL4vSTxRG
	 iuMTK8xcr353+jC+SW62GsTdr+i/7Uipna0VgYTl1eRuoVty143NTF1UnFoyhXNUGD/LK
	 p3aU5olMyub9SEqqpw867MA/S3K+XI/2tQpPeWnf813i1eXo4loZk8ALnmAxosltikLPN
	 6jtATLTiQI5FcNVBafVQUtxSQkDM3yv8wxOi+4a6o1z43VJ1ueHb5V/qWozH3c/0dDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402510;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uSN+PqJOPH6uaFhGhu5ZXBYndooc3zNAKRW/AVVZyCQ=;
	b=qCTUhO8j+bbv3AxatHSe/Pi442fRVsJ3wIy5m/AIhdmWT+g9uIT7GFkE23Xz3vKjIsuv
	 A0r1uyeW02ogtW5COlrD+aoZbpSkTM+yV16p1h1fZfbKsamkaUgLTdNj7HJyql0Yn1YP5
	 ySgm82H4KgLxLBEJ58p4qBNkXlu9iKiluIGJ3UsWAXatUpJ4rUXN7+Amvmufgg9EcqAw3
	 5dNG8ILYzXwCPbGHUPvq0MyvpTI/0D80XJg1c9122pLgh1EChCpWKWuTaFh107dhoEakn
	 OaOX3OoZ6yaxotuODFl0hNIi6BkNMIelBdkIZhmB2fj1roNDkLMzjz5Wpw1SZ5iF9XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blliLupd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA25606A321
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blliLupd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D001F00A05;
	Wed, 11 Nov 2026 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794402510;
	bh=uSN+PqJOPH6uaFhGhu5ZXBYndooc3zNAKRW/AVVZyCQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=blliLupd8ptThKvF8r9fEwSgY97u+sZwIuepfTjzRrkolxmMpJ9HOwahJ1h/3KX1i
	 BO/7xAS+0hFRLY20d5xNZ7oHGOPzP3V64T6lnRuoKEasWaWRL3YqttwPBaKd8Gf/0z
	 8y8xC/eV+QKAPj3/CSmtopsKI3PpQdfSOGMi/3Sx1GIxorzfRuZvsKqVIQneoSVtNA
	 QRm24C0IL2gOjnqOeNTFSLv4jVpBHPjt8n71ehafj+bvBz0V5mAj+bf2JgehFbLtuD
	 ZjkpoenT7THQX0Ls+dvt5DTdJl9gjm8qTgnJvPrwK9ByOY6vqiHlvKsYKxeS0f90Tu
	 r9txHmAkM8p1g==
Subject:
 Re: [PATCH v3 1/3] can: bcm: copy the CAN frames outside of lock_sock()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Date: Wed, 11 Nov 2026 13:08:29 +0000
Message-ID: <179440250969.488853.8384338061112608293@kernel.org>
In-Reply-To: <20261109-can-bcmlock-memcg-v3-1-2d798ca30578@hartkopp.net>
References: <20261109-can-bcmlock-memcg-v3-1-2d798ca30578@hartkopp.net>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fully fix the problem its commit message
  describes.

--

can: bcm: copy the CAN frames outside of lock_sock()

This patch moves the user space copies of the CAN frames for TX_SETUP,
RX_SETUP and TX_SEND in bcm_sendmsg() so they happen before lock_sock().
The frames are then handed to the opcode handlers through a kvec based
msghdr. The goal is that a stalled copy can no longer hold the socket lock
while bcm_notify() waits for it under RTNL.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 7bd2aa39777af..3f4c8d8283376 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1663,6 +1668,47 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  	if ((size - MHSIZ) % cfsiz)
>  		return -EINVAL;
>  
> +	/* Copy the CAN frames from user space before lock_sock(), so a
> +	 * stalled copy can not block bcm_notify() waiting for lock_sock()
> +	 * under RTNL. Only the frames the opcode handler reads are copied.
> +	 * The handlers keep their checks and read the frames from fmsg.
> +	 */

[Severity: High]
Does this fully close the RTNL stall described in the commit message?

bcm_notify() still sleeps on the socket lock of every CAN_BCM socket in
the netns while it holds RTNL:

net/can/bcm.c:bcm_notify() {
    ...
	case NETDEV_UNREGISTER:
		lock_sock(sk);
    ...
}

A CAN_BCM socket also goes through the generic SOL_SOCKET handling. Some
of those options access user memory while holding the same lock:

sk_setsockopt()
  sockopt_lock_sock(sk)    /* lock_sock() outside BPF context */
  case SO_ATTACH_FILTER:
    copy_bpf_fprog_from_user()
    sk_attach_filter()
      __get_filter()
        copy_from_user(prog->insns, fprog->filter, fsize)

SO_ATTACH_REUSEPORT_CBPF and SO_ATTACH_BPF also copy from user memory
under this lock. getsockopt(SO_GET_FILTER) reaches sk_get_filter(), which
calls copy_to_sockptr() into user memory under sockopt_lock_sock(sk).

So an unprivileged user could open a CAN_BCM socket and call
setsockopt(SO_ATTACH_FILTER) with fprog.filter pointing at a FUSE backed
mapping whose read never completes. If a vcan device in that user and
network namespace is then deleted, the RTNL holder blocks in
bcm_notifier()->bcm_notify()->lock_sock() for as long as the copy stalls.
The commit message uses this same scenario as its motivation.

The commit message says the SOL_SOCKET paths are not addressed. The new
comment here, though, says a stalled copy can not block bcm_notify(). That
is only true for the copies in bcm_sendmsg().

Would it be more robust to change bcm_notify() itself rather than each
copy path? For example, it could avoid sleeping on lock_sock() under RTNL
by deferring the per-socket teardown to a work item. Another option is to
protect bo->bound, bo->ifindex and the op lists with a BCM private lock
that is never held across user access.

The later patches in this series ("can: bcm: do not remove the procfs
entry in bcm_notify()" and "can: enable memcg accounting for user
triggered allocations") do not seem to change this. At the end of the
series, bcm_notify() still calls lock_sock(sk) under RTNL.

> +	switch (msg_head.opcode) {
> +	case TX_SETUP:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-can-bcmlock-memcg-v3-0-2d798ca30578%40hartkopp.net
