Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861218;
	b=po/5iZfbMTLbNGAN4sjhr/+UQT5m5aYFQbX9mq0897r56ZSZpPwQqMru9ylqvYwoir8v
	 C15wrap13+xDbHKIh9sDVeElS1ACtk2NgC1leNUaSRkyMeGwWptiiC7CvRef6pNOXYKKk
	 5r/2DdTzfhNl2D+ZNNOt8SfNo3wLu9Ryf0wzBorvG+chj4gmpsC9moQiQ2HEr/nvJHYxU
	 hjw+6axl9GAUCSM8ub8iDfvrn6laCVZusvi23R2Nb0UUahbFaZgR2twUJTcZRP6NlM0Ek
	 JIWzC/087yZmxf8utQB7UYDAeZDxW3bO8GTl/ZLZz68fayputPgguuAh4SPNjBGEHDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861218;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CR1pqSLpqnCO65uIl7FZrJ4oQ4ct+HdZ64AbH9E3/ks=;
	b=dP4ogpWUtlJ6xAbtlIEym1V0Gys39rCMsIIQcSO/FA/MDd63gNBaa/XuaRLmjNbYsV8u
	 zyTjXYJn6dTvf6VjfF70SAjN4k7YOjlB7D0sQhCMD6LC67rAIxIYRcGecah5hROzUrZuc
	 VOdFI5VL53DwSpAeLdMRt+rfd8fDuIGsYbGILUdB0h7w0lOoM5rau4JS0a7/qqtoV/Woh
	 0dBk6FoGUcbj+q+kHEKQgYFZ4rh32pV8/inyIJCvi99EhHjzrbnL4UbCyAO/eXBRNrLI3
	 BdynSHHkpI7XXLIfpgTU+TuZmYxbrNLP1eyoXDehXRf+sTRwsRp3uI6qlf5SZxpZZdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1OhCxZA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD200606A31F
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1OhCxZA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2429B1F000C1;
	Sat, 28 Nov 2026 10:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861218;
	bh=CR1pqSLpqnCO65uIl7FZrJ4oQ4ct+HdZ64AbH9E3/ks=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U1OhCxZA8DBDDwahpMdJxZv0r0IqdcjedLtcqPPgcl2l8rv82lu/oQZ6SEBcxn84V
	 KRw64w5jw+fzxoLyfDUsQKOXlvgfrhYfHRk8SofuBBgf/d1XcxCZzXbjqqPf9JQs7i
	 dKJ8ydr7Y/CKQ9rFrLmPESvJDh0baEOWf2C0zY/UV59TViFDCWw8FIX3D5c6qJ7fRK
	 Myuk2qVHJnkwriwu/Kdr2g2yrbZ6ou86CcxKRtHvdjoi52jR7Rayf2henCljR+9twe
	 RZ4Xdww1cLn4aBmbd9N1ZcLdWOO8MXL+HyeHnSdNcpHFTV/UaCONpHwMNNa+JYXmJ+
	 1amtQcJCwLOkg==
Subject: Re: [PATCH can-next 08/22] can: isotp: reject CAN_ISOTP_CHK_PAD_DATA
 without CAN_ISOTP_RX_PADDING
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:17 +0000
Message-ID: <179586121772.3131.5988598798132812374@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-8-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-8-681ef8d8c2c9@hartkopp.net>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check in isotp_setsockopt_locked()
  (net/can/isotp.c:1761-1764) is too broad.
- [Medium] Documentation/networking/iso15765-2.rst (lines 176-178)
  documents the UAPI semantics of CAN_ISOTP_CHK_PAD_DATA as: 'check…
- [Low] In check_pad() (net/can/isotp.c:420-427), the branch commented
  '/* no valid test against empty value => ignore frame */ return 1;'…

--

can: isotp: reject CAN_ISOTP_CHK_PAD_DATA without CAN_ISOTP_RX_PADDING

With this patch, setsockopt(CAN_ISOTP_OPTS) returns -EINVAL when
CAN_ISOTP_CHK_PAD_DATA is set without CAN_ISOTP_RX_PADDING. The check
runs before the options are copied into so->opt. The goal is to avoid a
configuration in which check_pad() fails for every received frame.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 6471c0ef319a4..0af1a689fdd38 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1758,6 +1758,11 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
>  		    opt->frame_txtime > ISOTP_MAX_FRAME_TXTIME_NS)
>  			return -EINVAL;
>  
> +		/* the padding content check needs the rx padding content */
> +		if ((opt->flags & CAN_ISOTP_CHK_PAD_DATA) &&
> +		    !(opt->flags & CAN_ISOTP_RX_PADDING))
> +			return -EINVAL;

[Severity: High]

Does this also reject CAN_ISOTP_CHK_PAD_LEN | CAN_ISOTP_CHK_PAD_DATA
without CAN_ISOTP_RX_PADDING? That combination works before this patch.

When RX_PADDING is clear, check_pad() tests CHK_PAD_LEN first. It never
gets to the content check:

net/can/isotp.c:check_pad() {
	/* no RX_PADDING value => check length of optimized frame length */
	if (!(so->opt.flags & CAN_ISOTP_RX_PADDING)) {
		if (so->opt.flags & CAN_ISOTP_CHK_PAD_LEN)
			return check_optimized(cf, start_index);

		/* no valid test against empty value => ignore frame */
		return 1;
	}
	...
}

Only CHK_PAD_DATA without CHK_PAD_LEN reaches the return 1. This means
the following statement in the commit message does not hold for the
LEN|DATA combination:

  Without CAN_ISOTP_RX_PADDING check_pad() fails for every frame, so that
  no PDU can be received and every FC aborts the transmission with
  EBADMSG.

The new check returns before memcpy(&so->opt, ...). As a result, every
other option in the same call is discarded too: ext_address,
rx_ext_address, txpad_content, frame_txtime and the remaining flags. An
application that ignores the setsockopt() return value would then keep
running on the default options without noticing.

A "check all padding" mode in userspace tools could produce LEN|DATA
without RX padding. As far as I understand, can-utils -P a is one
example, though I have not verified this.

Would a narrower condition close the broken case without rejecting the
working one? Something like:

	if ((opt->flags & CAN_ISOTP_CHK_PAD_DATA) &&
	    !(opt->flags & (CAN_ISOTP_RX_PADDING | CAN_ISOTP_CHK_PAD_LEN)))
		return -EINVAL;

Fixing check_pad() itself would also work.

[Severity: Medium]

Documentation/networking/iso15765-2.rst describes the flag like this:

  * CAN_ISOTP_CHK_PAD_DATA: check padding bytes on the received frames
    against rxpad_content; if CAN_ISOTP_RX_PADDING is not specified,
    this flag is ignored.

After this patch the flag is no longer ignored, and setsockopt() returns
-EINVAL instead. The documentation is not updated in this patch.

The documented behaviour points to a different fix: check_pad() could
ignore CHK_PAD_DATA when RX_PADDING is clear, by returning 0 in that
branch instead of 1. Would that be closer to the existing UAPI contract?

If rejecting the flag is the intended semantics, should
iso15765-2.rst be updated to match?

[Severity: Low]

This isn't a bug, but with this validation in place the "ignore frame"
return 1 branch in check_pad() can no longer be reached.

All callers (isotp_rcv_fc(), isotp_rcv_sf(), isotp_rcv_ff(),
isotp_rcv_cf()) call check_pad() only when ISOTP_CHECK_PADDING is set.
so->opt.flags is written in two places only: isotp_init() sets it to
CAN_ISOTP_DEFAULT_FLAGS, and the memcpy() below copies it after this new
check.

The comment in that branch also says "ignore frame". The code actually
reports a failed check, which drops the frame or aborts the transmission
with EBADMSG.

Could the comment be updated, or the branch removed or reworded to say
that setsockopt() prevents this state?

> +
>  		memcpy(&so->opt, opt, sizeof(*opt));
>  
>  		/* no separate rx_ext_address is given => use ext_address */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
