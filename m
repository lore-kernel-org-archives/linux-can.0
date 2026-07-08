Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0D4A138B
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532592; cv=none; b=MCbfOnTjZUD5496agYKCu8c2YG49I1WQJqRS6VNzX5OZQUhmFAI8RN1OkWNtX3nDWvplmqWtXb1y9GHnKGVupMtlG7s5GcX8M4oOCUtnxvUUuE9XCKrGbtnIbLdTw2LFvsQ6UbHMn5Vm+CLWxXOsfScegDK0zTMO+Hi5o7rA/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532592; c=relaxed/simple;
	bh=jHgYZkBTN8ZU1aNsB5v3Ub3aexGUA1/rmR89uN7tmtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jp4mhgbvfKPPd/fnj6FH5mKXPzU04B+mQBd3m93WTDMNSdHgzod6WxLrh9QjxSJK/IV+0CzJpiCEuxWpBXpFLRA6wFxTF4Um66oeGYghzr42+2dAjkSNxPgW6Yoc/PRTI8NwudKdjEJ4lJ3ih8zHh8FrnS/Uqp2pDBu1Pyfo8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9bcIQp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9bcIQp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D681F000E9;
	Wed,  8 Jul 2026 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783532591;
	bh=dV/kx1IXPtNh++c9rAhKNfnvqKyOJhSuV5ghxnbaSPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d9bcIQp7gE7kkZofkY190r7/4E35Ch7JMEKqFdWhTuKfglTj/EYqgHJH0gQ5d4LCI
	 UT36F12UJ4+z/TMHKf0S69Dc6eUpaTxw4WwEd+UfF10/HCCsn9EwGAnmnzdrlPUYMW
	 4ByeTLnIOaYoSNQRUvDfPM7YOt6JbhAsjJmihcn/VckI81/XseKz8cbAnkqVvpt4Iz
	 vNc5JJYo/OPWrO01Eedvmz1N00+LharlF53fFAaBJs6rUNAV8bkLAwSyOubFOEln5V
	 s9TVnZTE8M8IiT8lF5/CAC0+YpNKRUQC3zLewGSstGmoZjzb5n6tVt/zHqiDw8TIYW
	 xZFOLPPfBFlLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/10] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260708-bcm_fixes-v8-1-8c2f5f3bc212@hartkopp.net>
References: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
 <20260708-bcm_fixes-v8-1-8c2f5f3bc212@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:43:10 +0000
Message-Id: <20260708174310.94D681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race and potential memory corruption when updating an existin=
g RX operation's filter frames.
- [High] Unsafe lockless iteration over `bo->tx_ops` in procfs handler.
- [High] TOCTOU data race allowing transmission of unvalidated cf->len, lea=
ding to Information Leak.
- [High] Missing validation of cf->len for RX_SETUP messages allows OOB rea=
d on RTR replies.
- [High] Unbounded kernel memory allocation in TX_SETUP and RX_SETUP enable=
s local DoS.
--

--- Patch [1]: [PATCH v8 01/10] can: bcm: defer rx_op deallocation to workq=
ueue to fix thrtimer UAF ---
commit 57a8040fac83846a436e2754c21b148f177f0ef3
Author: Lee Jones <lee@kernel.org>
can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This patch defers the teardown and memory deallocation of bcm_op structures
to a dedicated workqueue. This prevents use-after-free issues caused by
timers firing after RCU grace periods, and avoids sleeping in softirq
context. It also adds socket reference counting during the deferred work.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1060,6 +1081,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;
> =20
>  		/* initialize uninitialized (kzalloc) structure */

[Severity: High]
This is a pre-existing issue, but is there an unsafe lockless iteration
over bo->tx_ops in the procfs handler?

In bcm_tx_setup(), elements are added to the bo->tx_ops list using
list_add(), which lacks the memory barriers of list_add_rcu(). However,
bcm_proc_show() iterates this list using list_for_each_entry() while only
holding rcu_read_lock().

If a user continuously creates TX operations while concurrently reading the
socket's procfs file, could the procfs reader observe an uninitialized next
pointer and cause a crash due to an invalid pointer dereference?

[Severity: High]
This isn't a bug introduced by this patch, but does bcm_tx_setup() contain
a time-of-check to time-of-use (TOCTOU) data race?

If a user updates an existing TX operation while its cyclic timer is firing,
bcm_tx_setup() directly modifies op->frames with user-supplied data before
validating it:

bcm_tx_setup()
  err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
  if (op->flags & CAN_FD_FRAME) {
    if (cf->len > 64)
      err =3D -EINVAL;

If the timer concurrently triggers bcm_tx_timeout_handler(), which calls
bcm_can_tx(), it can copy the partially updated frame into an SKB. Could
the CAN driver then read past the SKB data bounds based on an unvalidated
cf->len, leading to an out-of-bounds read and information leak?

[Severity: High]
This isn't a bug introduced by this patch, but do the allocations in
bcm_tx_setup() and bcm_rx_setup() lack memory limits?

A local user can open a CAN_BCM socket (which doesn't require
CAP_NET_ADMIN) and loop sendmsg() with TX_SETUP or RX_SETUP opcodes
using unique CAN IDs.

Since these functions allocate large structures and frame arrays using
kzalloc() and kmalloc_array() without charging the memory against the
socket's limits (for example, via sk_mem_charge()), could an attacker
exhaust kernel memory and cause a local denial of service?

[ ... ]

> @@ -1221,6 +1243,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;
> =20
>  		/* ifindex for timeout events w/o previous frame reception */

[Severity: High]
This isn't a bug introduced by this patch, but there is a data race when
updating an existing RX operation's filter frames.

When a user updates an existing RX filter via bcm_sendmsg(), bcm_rx_setup()
copies data directly into op->frames using memcpy_from_msg() and clears
op->last_frames via memset() without holding a lock.

Concurrently, can a packet reception trigger bcm_rx_handler() in softirq
context, causing it to read these arrays locklessly and observe torn or
zeroed state?

[Severity: High]
This is a pre-existing issue, but it looks like bcm_rx_setup() is missing
length validation for the supplied RX configuration frames.

When a user configures an RX operation with the RX_RTR_FRAME flag and
supplies a frame with a large cf->len, bcm_rx_setup() copies it via
memcpy_from_msg() but fails to validate the length.

When a matching RTR request is received, bcm_rx_handler() invokes
bcm_can_tx() to reply. Could the CAN driver then blindly trust cf->len
and read out of bounds on the SKB buffer, exposing adjacent kernel heap
memory on the CAN bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v8-0-8c2f5f3bc212@hartkopp.net?part=3D1
