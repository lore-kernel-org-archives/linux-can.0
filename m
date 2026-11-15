Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703327;
	b=qoumtdVtZvDQG7MLUvfvZXqTbTRD4k/bB2puEAYmnpS8UXSHqUWuFLOz24FYrYg0K8ap
	 9Pk5Rhii0x8GtuLDjy4Xb1xQ6bDddPRX5bnOpVVxkpLNRj1BIFE7jN0uXViM/+LHU9yVL
	 ytnS/1iVp+fPPXUc2WaltPGPfnjeJATowLxp0ifBwYBFTFZ70YLYd2pY8e/HgI38hXjFt
	 5Q5z0VhBj6xy9xZQiwFurVLdpIXhs/YVWe4SPo/s/DmN98DV13HEu77clQ1poCqkRDTsW
	 sK316Muq/WpLBRtiVohjWjg/qDGmGG8OOBToT9/d03/URESqUBscKz3YB2JdX/spW6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703327;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=i+2glsOkOUlqSUeow6CGKfh2fE9QUhc4bDxETCjeRx4=;
	b=gtDIO6VN7BjelkuhDAOKQRxwQFwYss8b4dH/Xsu+vi8LROts9UtPEx1Rf8TRwbfHnugM
	 XkCx5yZH2x9FjyU15sySOFChUhFTLuViavXV0MrH5ullBdZGmHwtb7Yv4BACwNNrBjM3V
	 hTHIY7Er4SNrpbyU3YLD16Kapgpwf8HJjZ/gWT5b0YVJXWrOr+AZlnI0NDb8/iOimGRct
	 VG2aqH1PJ8dp0demQRdKEooidL3Mh5V3iknt7nLds8VDtbLfiwSafAfx4Pz5sTHAqe6q0
	 E+6RJiJcIVeuhdD+wKaUEOlrwOG/MXKxTFcIXhgm1R9hBaAFejn1r8ZcAvlH4jNmcsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAjlEXkn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FFC606A323
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAjlEXkn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FED71F000C4;
	Sun, 15 Nov 2026 00:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703326;
	bh=i+2glsOkOUlqSUeow6CGKfh2fE9QUhc4bDxETCjeRx4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KAjlEXknZsKKcCXgDcthd3W0x4C6D+Z584XZBoSf+lBkFlQgCqYqsMx5aDLKXwnCW
	 nHFQjltRGPriaPPM+OZTAka7NROF2/XNJYqViTbsEpribrlDfxdRckx1emWF59Lu/G
	 rvTXveWO1pqztd+k0ejGmo3/E0hvSMNuP6UwsJ3VaL6QMS3YpHwa0R32anOCA2tKkH
	 CYB2iljrFhjTACcj7uAmi08osdDJsvZfcaxHW6PLJltHr0QhWfrYwBNNfi+fYcKMTO
	 P0kWtp/lFfcmBEtfIlUjQP7RTU9sJRaynxhKec0uonBIPTJLfMnvGwrzwVZiI61bWP
	 K5i7gYb2jdRXQ==
Subject:
 Re: [PATCH v5 1/5] can: bcm: copy the CAN frames outside of lock_sock()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 kuba@kernel.org
Date: Sun, 15 Nov 2026 00:42:05 +0000
Message-ID: <179470332579.488853.5643594273401866523@kernel.org>
In-Reply-To: <20261113-can-bcmlock-memcg-v5-1-634c0e04bc72@hartkopp.net>
References: <20261113-can-bcmlock-memcg-v5-1-634c0e04bc72@hartkopp.net>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch's commit message describes the bug as 'a stalled
  copy on any CAN_BCM socket can block RTNL'.

--

can: bcm: copy the CAN frames outside of lock_sock()

This patch moves the user space copy of the CAN frames for TX_SETUP,
RX_SETUP and TX_SEND in bcm_sendmsg() so it happens before lock_sock().
The frames go into a stack buffer or a kvmalloc() buffer, and the
handlers read them from a kvec based msghdr. The aim is to stop a stalled
user copy from holding lock_sock() while bcm_notify() waits for it under
RTNL.

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

[ ... ]

> +	iov_iter_kvec(&fmsg.msg_iter, ITER_SOURCE, &kv, 1, flen);
> +
>  	lock_sock(sk);

[Severity: Medium]
With only this patch applied, can a stalled user copy on a CAN_BCM socket
still block RTNL?

The commit message describes the problem as:

  So a stalled copy on any CAN_BCM socket can block RTNL on the
  unregistration or namespace change of a CAN device in this namespace

bcm_notify() still takes lock_sock() on every CAN_BCM socket in the
namespace while it holds RTNL:

net/can/bcm.c:bcm_notify() {
    ...
	case NETDEV_UNREGISTER:
		lock_sock(sk);
    ...
}

On a CAN_BCM socket, SOL_SOCKET options are handled by the generic
sk_setsockopt() and sk_getsockopt(). Both still access user memory while
sockopt_lock_sock() is held:

sk_setsockopt(SO_ATTACH_FILTER)
    copy_bpf_fprog_from_user()
    sk_attach_filter()->__get_filter()
        copy_from_user(fp->insns, fprog->filter, fsize)

SO_ATTACH_REUSEPORT_CBPF works the same way. For SO_GET_FILTER,
sk_getsockopt() calls sk_get_filter()->copy_to_sockptr() under the socket
lock.

Suppose the filter array sits on a FUSE or userfaultfd backed mapping in
an unprivileged user and network namespace. The copy can then stall while
it holds the socket lock. If a vcan device in that namespace is removed,
bcm_notify() would wait on that lock under RTNL.

The commit message says these SOL_SOCKET paths are "not specific to
CAN_BCM and not addressed by this patch". The RTNL stall itself, however,
comes from bcm_notify() taking lock_sock() under RTNL, and that is
specific to CAN_BCM.

The later patch in this series, "can: bcm: use a private mutex instead of
lock_sock()", appears to close this gap. At the end of the series,
bcm_notify() takes mutex_lock(&bo->conf_lock), and the generic SOL_SOCKET
options never take conf_lock.

This patch is tagged for stable. Should the commit message say that the
RTNL stall is only fully fixed together with that follow-up patch, so the
two get backported together?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-can-bcmlock-memcg-v5-0-634c0e04bc72%40hartkopp.net
