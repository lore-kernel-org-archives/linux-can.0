Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16739EB47
	for <linux-can@vger.kernel.org>; Wed, 29 Jul 2026 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316428; cv=none; b=C33xwek62Ufp1U3OpNdLDxY8lpXaCRP4dHhAWXD1qDE3gIJxV6PepCrsKwYpO//IGVJw1t9GoFxuf7fXGTdhoBeN5TcdJAhqpnxcb8UdYAO5W5VplTy+DLnUCO0UBJJrWSpCmcIad7ZkI3VOM1hz8ew6DhkofzxKw1uDK19remo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316428; c=relaxed/simple;
	bh=NcWCCVsgK4L6L9PwEMlB+ktS5AIDdtSLs259y4lJoZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=emvEZzPBNHS3ENKahWEgxas3TY56lBBc6iBFynUWEjbrA1bavTR8bWD2A02lbzXAR9hQynWIH21fAQ4BY8/E6YNGKoMjmMVwhIJQ6XSKFQKPrx15SBXYwlt9LwmxnGAMUENAwIH8oKRudUaMCVE3YN8/mCFpUpiApt+6oD9j7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfHzN/Ij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfHzN/Ij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D865D1F000E9;
	Wed, 29 Jul 2026 09:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785316427;
	bh=CjO81RgJRXSH2cgBHHrDdKQ+UB9AHNKvWfPzOd1tdkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cfHzN/IjdAtdJPGHfq0pSGEfddc5XCM0UlA2keLpEZwqrBcg1uj9e+3h7VKyeV0lc
	 yIAeonuWjuasw3Zf7xYY5kUWyH7m2LDvpJHJHwVZuS0jyDeYts0SAzNlA41dRyimsd
	 M5iynmAgXdvJGKtBY6yEvsJSEH/ZGnievDBV8i2+pcqC3M4cWoujj77eka2Lr00Z9t
	 7LFbKQoASyj96J9QK/f7tvv+Ei0vJUXNWnznFaywmn57FXSr31hbYEc87j7Q7BQA8Q
	 UEh4If1UusOPNtlrI1vUUyQar4v3HVeKhNhQSA+fncEkiMeYG6Yiu4IseoCk920RGK
	 Eq/HdKz+bMWcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] can: isotp: check register_netdevice_notifier()
 error in module init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Minhong He" <heminhong@kylinos.cn>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260729085656.134523-1-heminhong@kylinos.cn>
References: <20260728031038.76524-1-heminhong@kylinos.cn>
 <20260729085656.134523-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 09:13:46 +0000
Message-Id: <20260729091346.D865D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error checks for can_rx_register() in isotp_bind().
--

--- Patch [1]: [PATCH net v2] can: isotp: check register_netdevice_notifier=
() error in module init ---
commit 059042597b87e317cf8905dce3a8140167d9528a
Author: Minhong He <heminhong@kylinos.cn>

can: isotp: check register_netdevice_notifier() error in module init

This commit registers the netdevice notifier before calling
can_proto_register() and checks its return value. If the protocol
registration fails, it properly unregisters the notifier before
returning the error.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..ae6260e98a7a6 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

This is a pre-existing issue, but I noticed a potential problem in
isotp_bind() when reviewing this file:

net/can/isotp.c:isotp_bind() {
	...
	if (isotp_register_rxid(so))
		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
				isotp_rcv, sk, "isotp", sk);

	/* no consecutive frame echo skb in flight */
	so->cfecho =3D 0;

	/* register for echo skb's */
	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
			isotp_rcv_echo, sk, "isotpe", sk);

	/* switch to new settings */
	so->ifindex =3D ifindex;
	...
}

[Severity: High]
Does this code silently ignore the return values of can_rx_register()?

If an unprivileged user inside a container calls bind() under memory
pressure, can_rx_register() could fail and return -ENOMEM. Because the
error is not handled, the socket would proceed to be marked as bound.

Later during close, isotp_release() calls can_rx_unregister()
unconditionally. Since the receiver was never successfully registered, this
would trigger the pr_warn("can: receive list entry not found...") inside
af_can.c.

Could a user repeatedly trigger this to generate unbounded kernel log spam,
creating a denial of service vector?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729085656.1345=
23-1-heminhong@kylinos.cn?part=3D1
