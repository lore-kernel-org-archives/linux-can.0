Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288918;
	b=b5CaEhcv08LU4nyRua/wDoNbFSzLFAPPJCmMg7jh/SZ6vClaFD8hLDCISOmPLQPJRCIr
	 X/05UVM4MY0LTQaw3iLZc23g7POh94dd6cv7O/Vrb87rGTB4+2LHqRbZEj0jI+hwkR5Xn
	 vF/v6QT301D9f09POZywkAjzvmN12PtASkCAKzX/+JQZB2Mmxycze/XAis9x+0i3rQnjZ
	 ifIMgdxwnDqCQltGQOmP0+1Q3Uqua7lrUTqzF0RvpowjA6/SuJyfHq6avqxVB+6Z67gMW
	 dUNMJxJLo8KzAcoe5PaUB/McjSy58nKvcrGDbnVK0dgEDoK7RR4TDIEnU3VlU5VcwlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288918;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GbsFy20ljWztimif3xuY0W258c5GnD3Ak7IjjGi9HGI=;
	b=2Da1A0WOVjoPvaWC0yjaBSrqu3+4rL7YoS6MJkO4TQIMVNUzZK22XMBEssD8gypGf4bh
	 XT79zKiNdsF2XLa02j5Um0p6rVkqhjHdTfMsw2hXINR0lBVliuzj+mOl63BE9/FCxwWiH
	 XuaoAed3+Ak7zl1IrhxINlpaSt8P1eg57ACBXdrkPDgAujURvUMdOMfzq4jB7fOvEox+r
	 dSjCl4TNlDvM25sTkGWrZk1tG3nFLiGL7ltbzbeBXHFevv7MNKwCd4eYT5Egg70YGewko
	 l8d6NSrB9sBiAOVW0H5Tv6LXel6lYOBNaCL8aIJ79S8HAsMaS3wstkQupQAN8DRZaQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPVJUpkX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C430606A332
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPVJUpkX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A461B1F0089F;
	Tue, 10 Nov 2026 05:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288918;
	bh=GbsFy20ljWztimif3xuY0W258c5GnD3Ak7IjjGi9HGI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cPVJUpkXz2Q6YizFJyul2bvY+FxSmtIAfdNu5ijQx1HTQv80wyUg7sEb82JbOAQn/
	 3wcS0SCs9GjycQM3+JtlbOFpb0SAX2wCJNa4LxF+PjePU1Iw01FPAgWUxlXEF2gzrE
	 dNR3Psg+eKA/ga7Yq8wQti9jga6zQ9KFlPAaN3fIwpyHdRCwtDZlPHbynk6aKqAk+d
	 OP7zuSTFZ+W5/Se098xXeWdMcZiiYr+sTiR/VwikCoeFaeF5gU7AXj7l+dUZRJk6eZ
	 dUQMkCDA/KSGLacz2f8XT0033jt+EtoH7mpeCp/g2QNZe2MYo+F8M5IAcrfe9rdhzm
	 snJwQVpawoL3A==
Subject:
 Re: [PATCH v2 1/3] can: bcm: copy the CAN frames outside of lock_sock()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Date: Tue, 10 Nov 2026 05:35:17 +0000
Message-ID: <179428891717.488853.3748927072022061221@kernel.org>
In-Reply-To: <20261108-can-bcmlock-memcg-v2-1-19fafdfc9d12@hartkopp.net>
References: <20261108-can-bcmlock-memcg-v2-1-19fafdfc9d12@hartkopp.net>
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

- [High] The patch is an incomplete fix: an unprivileged user can still
  block RTNL through a stalled user-space copy made while a CAN_BCM…

--

can: bcm: copy the CAN frames outside of lock_sock()

This patch moves the user space copy of the CAN frames for TX_SETUP,
RX_SETUP and TX_SEND in bcm_sendmsg() so it happens before lock_sock().
The frames go into a stack or kvmalloc() buffer and are passed to the
opcode handlers through a kvec based msghdr. The aim is that a stalled
copy can no longer block bcm_notify(), which waits for lock_sock() while
holding RTNL.

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

Does this fully close the RTNL stall the commit message describes for
CAN_BCM sockets?

bcm_notify() still takes lock_sock() under RTNL for every CAN_BCM socket
in the netns, bound or not:

net/can/bcm.c:bcm_notify() {
    ...
	case NETDEV_UNREGISTER:
		lock_sock(sk);
    ...
}

CAN_BCM does not set SOCK_CUSTOM_SOCKOPT. So the generic SOL_SOCKET
paths still read and write user memory on a CAN_BCM socket while holding
that same lock:

setsockopt(SOL_SOCKET, SO_ATTACH_FILTER)
  sk_setsockopt()
    sockopt_lock_sock(sk)
    copy_bpf_fprog_from_user()
    sk_attach_filter()
      __get_filter()
        copy_from_user(prog->insns, fprog->filter, fsize)

getsockopt(SOL_SOCKET, SO_GET_FILTER)
  sk_get_filter()
    sockopt_lock_sock(sk)
    copy_to_sockptr(optval, fprog->filter, ...)

Suppose fprog.filter points into a FUSE backed mapping whose daemon never
answers. The copy_from_user() then sleeps with sk_lock owned. If a vcan
device in the same unprivileged user and net namespace is removed at the
same time:

rtnl_lock()
unregister_netdevice()
  bcm_notifier()
    bcm_notify()
      lock_sock(sk)    <- waits for the stalled setsockopt()

RTNL then stays held for as long as the FUSE daemon chooses.

The commit message acknowledges this:

  "The generic SOL_SOCKET options in sk_setsockopt() and sk_getsockopt(),
  e.g. SO_ATTACH_FILTER, still access user space under the socket lock.
  This is not specific to CAN_BCM and not addressed by this patch."

raw_notify() and isotp_notify() also take lock_sock() under RTNL. They do
so only for sockets bound to the device that is going away. bcm_notify()
does it for every CAN_BCM socket in the netns. So the same unprivileged
RTNL stall still seems reachable on CAN_BCM sockets after this patch,
which is marked for stable.

Would it be better to stop bcm_notify(), and possibly the other CAN
notifiers, from sleeping on lock_sock() under RTNL? Another option is to
do the user copies in the core SOL_SOCKET filter paths before the socket
lock is taken.

> +	switch (msg_head.opcode) {
> +	case TX_SETUP:
> +		if (msg_head.nframes >= 1 && msg_head.nframes <= MAX_NFRAMES)
> +			flen = msg_head.nframes * cfsiz;
> +		break;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-can-bcmlock-memcg-v2-0-19fafdfc9d12%40hartkopp.net
