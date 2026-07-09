Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CB3BE161
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593518; cv=none; b=JNS6glihGjmEBFwuOICFeQCypYqriDh+GmbVyx4tYZzltPjDCzYddoIbwQxtmD0/hfJzONgUnX632C7Vy10gfe1zilz9Kgyb9Ny6Y7zCP3AM7q5V98Xb62gWpZEHXZru435p9smpbvuwYdkHV6ARYDdeUEpUK1mJJSXcr5QfHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593518; c=relaxed/simple;
	bh=EHBKTI8q9WJhF0JdhYuUYXzRKk9J9Nfc1sC9ceCyVe4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VdYRtuDnJ0z9pZyMO32dxaLWKZ6wvyNaN8AWvDS1LdsaFEdQbLuSsV1cmdTsy7q92GytdrJ3U4eOD6crCbOcHq/FJAu3nV6gP1Kz6JdDvHf8w6c0o4zlrEWF7chS+NquyYQLuwbAx6xI2FXvTNGlOqG3TxW12cefPX7lkXAGtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnFusmiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnFusmiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1761F000E9;
	Thu,  9 Jul 2026 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783593514;
	bh=mZzdINcwO9k8NL6H4Q/ZnhVp5WaDT5wmaSkgRqoZlX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jnFusmiJV9ZUKRviexVhdhVGj0dAqe3GwKJ+pdH+wvQ9Ba+on/VB203KVSLA4woy4
	 AsY7Ma4HQ66qxYVbBf6T61x0DphRIQGMDwyIBTwhsI3+vL2RnE6yXADWEQh5rs8ErC
	 m63uy2nBJHQ6XOCg+of/H7k6DYVhxKSGgOjoPtwcKNRIIS4W7X0KbYu3dH7Oozfd/e
	 6sitzQ6kgjPeVCwB6UEimGWK500ghfjEHkMYkQTOGzWo8jnI1HjCz4Q1WyOq5oTBBG
	 FqDqnfSXJajmEm3Mi+ajJ9Cb8zevZSA0MvcQCOuE9elGHhsnTAP1/XpkCzLlwg/xWK
	 L34BnxkXnhhzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/10] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v10-1-57fff38e34ce@hartkopp.net>
References: <20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net>
 <20260709-bcm_fixes-v10-1-57fff38e34ce@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:38:33 +0000
Message-Id: <20260709103834.2F1761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Inconsistent use of RCU list primitives can lead to data races and=
 crashes when reading `/proc/net/can-bcm/*`.
- [High] Data race on `op->frames` during runtime updates in `bcm_tx_setup(=
)` and `bcm_rx_setup()`.
--

--- Patch [1]: [PATCH v10 01/10] can: bcm: defer rx_op deallocation to work=
queue to fix thrtimer UAF ---
commit 07fedad11f0f52be9c8ac130e930be315886f42d
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Commit f1b4e32aca08 replaced synchronize_rcu() with call_rcu() but
omitted flag checks for thrtimer, creating a TOCTOU race and UAF.
This resolves the race by deferring timer cancellation and memory free
to a dedicated unbound workqueue, which avoids sleeping in RCU callbacks.

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
This is a pre-existing issue, but I noticed it while reviewing the op setup
changes. Does the list insertion in bcm_tx_setup() and bcm_rx_setup() need
to use list_add_rcu() instead of list_add()?

It looks like bcm_tx_setup() adds to the list like this:

net/can/bcm.c:bcm_tx_setup() {
    ...
    list_add(&op->list, &bo->tx_ops);
    ...
}

Since readers like bcm_proc_show() iterate the tx_ops list inside an RCU
read-side critical section, could the lack of memory barriers in list_add()
allow a lockless reader to observe a partially initialized list node?
Also, bcm_proc_show() appears to use the non-RCU list_for_each_entry()
iterator.

[Severity: High]
This isn't a bug introduced by this patch, but there might be a data race on
op->frames during runtime updates.

In bcm_tx_setup() and bcm_rx_setup(), it appears the memory content of
op->frames can be updated directly from userspace messages:

net/can/bcm.c:bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Does this allow concurrent readers to access partially updated memory?
For example, bcm_can_tx() calculates the frame pointer under op->bcm_tx_lock
but then accesses the memory content via skb_put_data() outside the lock.

Could this result in torn CAN frames being transmitted, or incorrect rx
filtering if a concurrent bcm_rx_handler() reads op->frames while it is
being modified?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v10-0-57fff38e34ce@hartkopp.net?part=3D1
