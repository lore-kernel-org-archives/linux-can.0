Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14153E1231
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420076; cv=none; b=NDfZqxklm81xDQV5Ni5Te0zEHxO2cAm+BdjNbNAga+e3fFn9D9PuizOb6qwZ/kHWHzMk7/cwk1PdxdCJvDNrHzKU5xRN9Nh/SbKOiGqsNr7EZQhqI6aJk3E3PwxxAGGuax0TX1B5QMCPe/lbKWJTH31KiqIbnWDXoVr6UJEO3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420076; c=relaxed/simple;
	bh=LT4JexTw9RF6fA3JVJz6fc3PYHT0yZO841OHi/qXCI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FEIbR+IfPdFsk/1nPOqZGBQhznySUei2B0gfoyfnroh31Z3gcREcxwtPLiWh+Uj52oDOGrPlLeyt4KNMQ+oYBx4mCVSywzoNQkfbntzXhf60VP3c9+a7KDSbaP+3qx0/gYmUJGKCAqNiK7wqwcxZkw5FlzIt4gjHEXdVqtVoh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im2qm5QY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im2qm5QY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF871F000E9;
	Tue,  7 Jul 2026 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420072;
	bh=jA1rpmgWie+ABL+ABK6G4pVMUjcBsZFET3ueG07c8j4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=im2qm5QYbMLOmI0p7Q/WOqxuwxXtW2to7bINdWk2N0s3lg7bYyraRsYnIZ5Ey8mj8
	 p0Z41Dz55XVvC37SZCzunc95FMhccDz7nnN4c63cCiMcjIV7UdNpPsMz4wZB8n87Qz
	 kVmUXk/6M+XYGK1GKfsJw+i12Uh08Rgi2hFOqZxzyCvS0ey499eyWKM049RpqVySe/
	 VPRxsGUU82lzhvmuEMLfO71eZLwnCUFCUQSKRQUYzshO5ouCxVtI7kt1EQ/bAIW8he
	 GUglc6JPdMdFoLLLRkOdJ2ZM6DW/BWgSve/YjnN/BH7O+p5bjhrlRcBgur74RZcQRH
	 VST7EY3pJ49Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] can: bcm: defer rx_op deallocation to workqueue
 to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260707-bcm_fixes-v3-1-84600ca6d889@hartkopp.net>
References: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
 <20260707-bcm_fixes-v3-1-84600ca6d889@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:27:52 +0000
Message-Id: <20260707102752.8DF871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing list_add_rcu and list_for_each_entry_rcu for BCM operation=
s lists.
--

--- Patch [1]: [PATCH v3 1/7] can: bcm: defer rx_op deallocation to workque=
ue to fix thrtimer UAF ---
commit 3bf6c2fae3452e20dc5bcc0bb3d49f9026358964
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit replaces direct hrtimer cancellation in softirq context with
a deferred workqueue approach for BCM rx_op deallocation. It queues a work
item from the RCU callback and holds a socket reference until timers are
fully cancelled to avoid a sleep-in-atomic panic.

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
This is a pre-existing issue, but since this patch modifies the BCM op
initialization, I noticed a potential race condition with lockless readers.

Later in bcm_tx_setup() and bcm_rx_setup(), the code adds the newly
initialized op to the socket's operation lists using the standard list API:

    list_add(&op->list, &bo->tx_ops);

Similarly, bcm_proc_show() iterates over bo->tx_ops locklessly using the
standard list_for_each_entry() macro:

    list_for_each_entry(op, &bo->tx_ops, list) {

Because list_add() does not provide smp_store_release() semantics, could a
CPU reorder the initialization of the op's fields or its next pointer?

If this happens, could a concurrent reader in bcm_proc_show() observe a NULL
next pointer or uninitialized object data, potentially causing a crash when
the procfs file is read?

Would it be safer to use list_add_rcu() here and list_for_each_entry_rcu()
for the lockless readers to ensure correct dependency barriers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v3-0-84600ca6d889@hartkopp.net?part=3D1
