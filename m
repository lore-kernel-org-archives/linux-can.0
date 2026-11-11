Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434081;
	b=xNDWk80sCjTC/LxH5n4y8Gl26N3VKFx1R3oauh17ReQlkg95u5mzul5E9NjiL56jHbQn
	 j29JECAc5IvJpSunZC7ivkVb9DTtgCSlmYZYgyMpZth2HCAx4FP7/GWdswXQRy6ylXkK5
	 9+ijP1owuBja6EaFKv81GflJdH41dmAheFa/ARj/vT8FhdTnPXBgQlpcNxHUQSyf/+iPz
	 m2giPEcFyvn4GqMDIG11fM3+wMHE8zIHJR3iUdkcmOhMDuDsdNNOteXy5lwP/oeQ0NQJ5
	 fK+HjgPG1zWiB9w33ygjMzzWMpcrLkGinuTNKf0i+FhS/FmavQgbR5YfWE5Hh+lUrtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434081;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2rS138tZ8RE3buif2rtlqT+xmKuZZmZLB5+CNF7K6Kk=;
	b=1ZiHuKJKRz10jAvllFWninwFd94tsrg3SltqLpMg4Sj+fYimpKjzfToVyMRKBNHsnEaQ
	 f0UbICUf6cug4A2ljwMBN4GkpGCmFZDyhK12+73gn3D48haffiSEl3sGSxe3Ab2Mo7nh+
	 FEyrvq/7ItZ9l6JX7lm1wuWI2mvZtnuR/WU+e6gAQOyv1bTG14iyUlAbl8JxQMguSiXj9
	 4U7hObr3b8dVg3Wju499grvlQOM6J6IVLCICKfu2FfXkeIhKJqsI7+llm5pN6NxIpa4BM
	 o1BcZoW4aL4avFBrEk1y/qrl2cWspMP+QU2SNFT/oCHmtzZ+ChOm7Fugeu3MgAgfrIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1ixBxvB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F34606A33E;
	Wed, 11 Nov 2026 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1ixBxvB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C851F00A06;
	Wed, 11 Nov 2026 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434081;
	bh=2rS138tZ8RE3buif2rtlqT+xmKuZZmZLB5+CNF7K6Kk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I1ixBxvBR9WfSewv1oaLsCZ3oPQmwNI7tN27NDmjLp3ZTp1CTaC2j4CmvhyltzL9G
	 Db5X2y1xha2zCgxMzPfp0h/koTSbHUUtDueoVRb2YFsEcY9CPWCza1RAGbGdTrl/hx
	 q9kFxsaJ8p937DGkvLtqMvAYCRZ0cc/uL2URvLXKUzJWvI4BrQupS0Qk1xcjQ8jFe8
	 U1wdYSvUyMlzorKS9bh0sdl6S12yvnd4q/3CtYv49Y6gZoZYoqlo6/9QPBVIt2/mms
	 +555WGO/TUYw20zrj4fXc3ChViuSUb5Cu1QdGJOYQ071ObI5gFJjf78GqbUGctEpQx
	 5OqZigXu24lLQ==
Subject: Re: [PATCH] can: bcm: Account cyclic transmissions only on success
From: netdev-bot+sashiko@kernel.org
To: raoxu@uniontech.com
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Wed, 11 Nov 2026 21:54:40 +0000
Message-ID: <179443408049.488853.9633574112206236032@kernel.org>
In-Reply-To: <45A9B6D8611C63C9+20261110052315.253367-1-raoxu@uniontech.com>
References: <45A9B6D8611C63C9+20261110052315.253367-1-raoxu@uniontech.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In bcm_can_tx() (net/can/bcm.c:378), the patch changes the
  condition to `if (!err && (!cyclic || op->currframe == idx))`.
- [Low] The commit fixes a user-visible BCM bug: cyclic transmissions and
  the ival1 count are used up, and TX_EXPIRED can be reported, without…

--

can: bcm: Account cyclic transmissions only on success

This patch changes bcm_can_tx() so that op->currframe and op->count only
move forward when can_send() returns success. The goal is to stop the BCM
timer from using up the configured ival1 transmissions, and reporting
TX_EXPIRED, when no frame was sent, for example while the interface is down.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 7bd2aa39777af..cd66b23bf95c2 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -375,7 +375,7 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
>  	 * we were sending - a concurrent TX_RESET_MULTI_IDX means this
>  	 * frame's bookkeeping belongs to a sequence that no longer exists
>  	 */
> -	if (!cyclic || op->currframe == idx) {
> +	if (!err && (!cyclic || op->currframe == idx)) {

[Severity: Medium]

What happens here when can_send() keeps failing with a persistent error?

With the new !err gate, op->count is never decremented. The timer logic
depends on op->count reaching zero:

net/can/bcm.c:bcm_tx_timeout_handler() {
    ...
	tx_ival1 = op->kt_ival1 && (op->count > 0);
    ...
		if (!count && (flags & TX_COUNTEVT)) {
			/* create notification to user */
    ...
}

net/can/bcm.c:bcm_tx_set_expiry() {
    ...
	if (op->kt_ival1 && op->count)
		ival = op->kt_ival1;
	else if (op->kt_ival2) {
		ival = op->kt_ival2;
	} else {
		spin_unlock_bh(&op->bcm_tx_lock);
		return false;
	}
    ...
}

While the error lasts, the op stays in the ival1 phase with no limit. It
never switches to ival2 and never sends TX_EXPIRED.

An op with ival2 == 0 used to stop on its own after count attempts. It now
keeps re-arming at ival1 until the error clears or userspace sends
TX_DELETE.

Several can_send() failures on this path look persistent:

- -ENETDOWN while the interface is administratively down. The NETDEV_DOWN
  handling in bcm_notifier() only sets sk->sk_err. Only NETDEV_UNREGISTER
  cancels the tx_op timers.
- -EMSGSIZE when a CAN_FD_FRAME op targets a device with CAN_MTU, or after
  the MTU is lowered. bcm_tx_setup() only checks cf->len.
- -EPERM and -EINVAL.
- -ENOBUFS once the qdisc fills on a stopped or bus-off controller.

This also changes what count means in the UAPI. It used to count ival1
transmission attempts. It now counts frames that can_send() accepted. The
value reported through TX_READ and TX_STATUS changes to match.

Documentation/networking/can.rst describes count as a timer schedule:
"run 'count' times with ival1". It describes TX_EXPIRED as "Notification
when counter finishes sending at initial interval". It does not say that
failed sends are retried at ival1 with no limit.

The commit message only covers the opposite symptom, TX_EXPIRED being
reported too early.

Was this change in meaning intended? If so, could the commit message and
the documentation describe it? Should there be a limit when the error is
permanent, such as -ENETDOWN or -EMSGSIZE?

[Severity: Low]

Should this commit have a Fixes: tag?

The behaviour being changed goes back to the original BCM code. git blame
points at ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol").
The count decrement was later moved into bcm_can_tx() by c2aba69d0c36a4.
The TX_RESET_MULTI_IDX guard was added by 749179c2e25b95.

Could the commit name one of these in a Fixes: tag? If it is not meant for
stable, could it say that this is a behaviour change instead?

>  		op->currframe++;
>  
>  		/* reached last frame? */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/45A9B6D8611C63C9%2B20261110052315.253367-1-raoxu%40uniontech.com
