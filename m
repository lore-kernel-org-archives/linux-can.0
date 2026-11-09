Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190709;
	b=w75dMY27tcA+kvLrfAO4cwZ+AM5MxlCuiVIY1fm/yabw0eQoYZb0KhV1ePgGy0TcqyiF
	 k9Ey3/GPGOEvHoyKiiugc7invq2TMvMylQmS/RPsESrOrmfdXIZlVaS62v0hDMDMeV4o4
	 gbstkoB8PLhgjtlsRX31zSxZpzR4milgzCz0S06KygbsFhQ/KnC6FaqLbHzz1eLRLT9Fk
	 UMG2oKdSHe66W9Luc7f20qb/2r9//KZ6NW8SArvfux+jmguiTq6SKoOqjwm4R727lpt0M
	 bF1PphEH7QSrGbc6dqYhdzGsYdT1YnKvByIBy2MJ6nwhbuoR8omsnxKrTeMrg2SHY2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190709;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vJ7ihLtsvAqtI/3JEYTFcUBQa4uCQLcL+soer6ImUOo=;
	b=3b5lLukfitjuoILBkmorhAhgZtTfaNAK277WUecuL3l6zAERQv1YLHwkWFTVf022G50L
	 H6GuPkV1BRTrpStybZgnR+O57WT7GQUJvWmi20DKS18cG0jWs9ybf18G81bNPp6GXaQZC
	 b0JRQTVO/b3enwpnTxYejexVXZF2NOQewVnCIUwAb1NK1+eeex8t6vFjccvgQHTa+zW6g
	 7K1ShSpbxEPoA6tWTypESICm4l78rdvguqZE8pSZV5RV75Sc1Thf+MkLk7ChNQXUaxCwi
	 2KLqHp7VTkOroWdnVf2DKtwbgINsxtTGaqMXkFsMthxf52OriNQThTbdYwxGCbkOf/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2taSXw8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CA606A31C
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2taSXw8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C1B1F0089F;
	Mon,  9 Nov 2026 02:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794190708;
	bh=vJ7ihLtsvAqtI/3JEYTFcUBQa4uCQLcL+soer6ImUOo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l2taSXw8jwk0yGoNnRBCPpOikWx+TJ0m/Y+CIpvlCxm8dUHY33+ujM6D8T+vdq6E6
	 qTwTcRF5nFkJxyCo8sFUr55RF6a5F3sXqgJRS2pI15O50cjV/r5c800eQ3DJvJf0no
	 FOXJ/ag0+zj6ZJqUbv8+5v4sriha/9w97HVtzN++iPGLrrDJmbJox4Q3+nJbDFF55i
	 l9ztV8lfLwp4EspLiD2QdzaPsEYlY0tSg5dp6Z0AsbJT0KMI0yAP+Gic5l3fxydfy2
	 k4v3MnS5Xl7V3tcanHXDHQwsjN0r/2LamJ8S3+urkbbfFX4LWA6NfHusq03ROaLSUy
	 MyW13nXr6Ri5Q==
Subject: Re: [PATCH 1/3] can: bcm: copy the CAN frames outside of lock_sock()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
Date: Mon, 09 Nov 2026 02:18:27 +0000
Message-ID: <179419070782.488853.4274206106803700746@kernel.org>
In-Reply-To: <20261107-can-bcmlock-memcg-v1-1-482d9f5be1fd@hartkopp.net>
References: <20261107-can-bcmlock-memcg-v1-1-482d9f5be1fd@hartkopp.net>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not close the RTNL-blocking vector that its
  commit message describes.
- [Low] The new comment on the stack buffer in bcm_sendmsg() (`struct
  canfd_frame sframe; /* buffer for a single CAN CC / FD frame */`) and…

--

can: bcm: copy the CAN frames outside of lock_sock()

This patch moves the user space copy of the CAN frames for TX_SETUP,
RX_SETUP and TX_SEND in bcm_sendmsg() to before lock_sock(). The frames
go to a stack buffer or a kvmalloc() buffer and are handed to the opcode
handlers through a kvec based msghdr. The goal is that a stalled copy
can no longer hold lock_sock() while bcm_notify() waits for it under
RTNL.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 7bd2aa39777af..9c39f7363ca59 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1643,6 +1643,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  	struct bcm_sock *bo = bcm_sk(sk);
>  	int ifindex;
>  	struct bcm_msg_head msg_head;
> +	struct msghdr fmsg = {};	/* CAN frames copied to kernel memory */
> +	struct kvec kv;
> +	struct canfd_frame sframe;	/* buffer for a single CAN CC / FD frame */

[Severity: Low]
This isn't a bug, but this comment and the commit message don't match
what the code does. The commit message says:

    A single CAN frame is copied to a buffer on the stack, multiple
    frames to a kvmalloc() buffer

The code picks the buffer by byte size, not by frame count:

    if (flen > sizeof(sframe)) {
        frames = kvmalloc(flen, GFP_KERNEL);

sizeof(struct canfd_frame) is 72 (CANFD_MTU). For TX_SETUP or RX_SETUP
without CAN_FD_FRAME, cfsiz is CAN_MTU (16). So 2 to 4 classic CAN
frames (flen of 32, 48 or 64) land in sframe, and kvmalloc() only starts
at the fifth frame.

Could the comment and the commit message say the stack buffer holds up
to sizeof(struct canfd_frame) bytes? A later change that trusts the
"single frame" wording, for example shrinking sframe to struct
can_frame for the CC case, would let the byte-size check overflow the
stack object.

> +	void *frames = &sframe;
> +	size_t flen = 0;
>  	int cfsiz;
>  	int ret; /* read bytes or error codes as return value */
>  
> @@ -1663,6 +1668,47 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  	if ((size - MHSIZ) % cfsiz)
>  		return -EINVAL;
>  
> +	/* Copy the CAN frames from user space before lock_sock(), so a
> +	 * stalled copy can not block bcm_notify() waiting for lock_sock()
> +	 * under RTNL. Only the frames the opcode handler reads are copied.
> +	 * The handlers keep their checks and read the frames from fmsg.
> +	 */

[ ... ]

> +	kv.iov_base = frames;
> +	kv.iov_len = flen;
> +	iov_iter_kvec(&fmsg.msg_iter, ITER_SOURCE, &kv, 1, flen);
> +
>  	lock_sock(sk);

[Severity: High]
Can RTNL still be blocked the same way through other paths on a CAN_BCM
socket?

The commit message names the root cause as bcm_notify() taking
lock_sock() of every CAN_BCM socket in the netns while RTNL is held:

net/can/bcm.c:bcm_notify() {
    ...
	case NETDEV_UNREGISTER:
		lock_sock(sk);
    ...
}

That part is unchanged. bcm_ops has no .setsockopt or .getsockopt, so
SOL_SOCKET options go to the generic sk_setsockopt(), which copies user
memory while holding the socket lock:

net/core/sock.c:sk_setsockopt() {
    ...
	sockopt_lock_sock(sk);

	switch (optname) {
    ...
		ret = copy_bpf_fprog_from_user(&fprog, optval, optlen);
		if (!ret)
			ret = sk_attach_filter(&fprog, sk);
    ...
}

sk_attach_filter()->__get_filter() then does:

	if (copy_from_user(prog->insns, fprog->filter, fsize)) {

fprog->filter is a pointer chosen by the user, and outside of TCP no
capability is needed. SO_ATTACH_REUSEPORT_CBPF follows the same path.
SO_GET_FILTER->sk_get_filter() also writes to user memory with
copy_to_sockptr() while sockopt_lock_sock() is held.

So an unprivileged user in a user and net namespace could do:

    open CAN_BCM socket
    setsockopt(SOL_SOCKET, SO_ATTACH_FILTER) with fprog.filter on a
      FUSE backed mapping that never completes the fault
      -> __get_filter() stalls with the socket lock held
    delete the vcan device (or tear down the netns)
      -> bcm_notifier()->bcm_notify()->lock_sock() sleeps under RTNL

Isn't that the same scenario the commit message describes as fixed? The
statement "The generic SOL_SOCKET options in sk_setsockopt() are not
affected by this patch" doesn't say that this path can still block
RTNL, and it doesn't mention the getsockopt path.

bcm_notify() still takes lock_sock(sk) under NETDEV_UNREGISTER after the
later patches in this series ("can: bcm: do not remove the procfs entry
in bcm_notify()" and "can: enable memcg accounting for user triggered
allocations").

Would it be better to change bcm_notify() so it doesn't sleep on
lock_sock() of unrelated sockets under RTNL, or to defer the per-socket
cleanup out of the RTNL section? Either of those would replace moving
individual copies in bcm_sendmsg() out of the lock.

>  
>  	/* Re-validate under the socket lock: a concurrent bcm_notify()

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd%40hartkopp.net
