Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405A939CCF3
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049578; cv=none; b=X22ezsMVkUij3GSLRWGoVLkRovHPJ/XsSH8uPxSNKhhVvTempyUOLr3nbsuxOhV3EqQIP9hXfIbU7V41qp9W7IYK6eCVOUF2R9dF4+xmZypNQj2bWAiAO+eqmCqKZ97QC+QVB9cRNtBvyg6SZJGcB+TCBwZ2PRJHxh8t3/kfD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049578; c=relaxed/simple;
	bh=JSLc7RBs2PAL8VMk1vrnP1UQSLiFPa9SEx5Z1Sl++tM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QLrQ8ptml3Dc1PMKMj70i5/PtvFg3Q7TqG1n+tokzS1xMzjGZrjtvfrYiHRqOzTpi3bG/jU97kyj7vCAETKfIyRdKMapR6/UrBMczkanx1H8Msgm88mU4lnk5wpPSXS5m0LX7C1F8M8C93/AgDMX0WJS305astHTBtucSy6BHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDvxarld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDvxarld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FADE1F000E9;
	Tue, 14 Jul 2026 17:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049576;
	bh=nZOBrAkhGqZGsURwSHhKhhm9N0IvGmwvCBD2nCvQq0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDvxarld6E9mvvr1vhfZ6pIfSdQ4U22sbmbuOGvsYie8E8VtGJ74GctQngvekP/Oz
	 elbxYZNTdqTdqr/y55d+lqm/eHkZYLE3u0zd9pcEuQv2DtTTDSv24gf/n1neBGo5Gb
	 2ZaxOQ+LR14yNDIf7g+jjaV8y/UovM784yLPCJbBR9r5PXYqkNGpogVnXx70qKc1Rs
	 3f4tdNerH5Tig1euVbAZceltdGabvLf8pvra/lffYDHvFNmiLLWhUPor8USDxRttTs
	 6e+pTa9mnKyxCXS/W/UYlcJj+rqCC8y6xs61TY5BG2WU/KqbNYaY9xlt/icLuAYxiC
	 amC0WbOoIfjOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 01/11] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v15-1-562f7e3e42da@hartkopp.net>
References: <20260714-bcm_fixes-v15-0-562f7e3e42da@hartkopp.net>
 <20260714-bcm_fixes-v15-1-562f7e3e42da@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:19:35 +0000
Message-Id: <20260714171936.6FADE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] RCU List API Violation and Data Race in BCM operations list
- [High] Unprotected Data Race modifying CAN frames and filter state from u=
serspace
--

--- Patch [1]: [PATCH v15 01/11] can: bcm: defer rx_op deallocation to work=
queue to fix thrtimer UAF ---
commit f443af2888a268be3aea6c068673db99b62a8a27
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Commit f1b4e32aca08 replaced synchronize_rcu() with call_rcu() and introduc=
ed
the RX_NO_AUTOTIMER flag. This patch resolves a thrtimer UAF by deferring
timer cancellation and memory free to a dedicated unbound workqueue. A
reference on op->sk is also taken to ensure the socket is not freed out from
under an armed timer.

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

[Severity: High]
This isn't a bug introduced by this patch, but does bcm_tx_setup() insert i=
nto
tx_ops using list_add() without RCU memory release barriers?

When bcm_proc_show() concurrently iterates tx_ops without RCU primitives, c=
an
this missing dependency ordering lead to wild pointer dereferences?

bcm_tx_setup()
    list_add(&op->list, &bo->tx_ops);

bcm_rx_setup()
    list_add(&op->list, &bo->rx_ops);

bcm_proc_show()
    list_for_each_entry(op, &bo->tx_ops, list) {


[Severity: High]
This is a pre-existing issue, but do bcm_tx_setup() and bcm_rx_setup() modi=
fy
op->frames directly from user memory without holding their respective spinl=
ocks?

If memcpy_from_msg() modifies op->frames while bcm_can_tx() reads them
concurrently in softirq context, can it result in the transmission of parti=
ally
written CAN frames?

bcm_tx_setup()
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

bcm_rx_setup()
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);

>  		op->ifindex =3D ifindex;
> =20
>  		/* initialize uninitialized (kzalloc) structure */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v15-0-562f7e3e42da@hartkopp.net?part=3D1
