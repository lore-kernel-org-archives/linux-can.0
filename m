Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2092E2286
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113093; cv=none; b=eLDDO0xMC2amIQr20hG+HZIx/lhOa3JR28plaZPip9owzCg8Hq9At0hco8Mc1yweRyl52TQ89O2WHwBS/KGInqKzMtUB1tSsUUafeJckmJWIpH43j5guBgiW03P1Uf/1abSY5eIoJe15fXleB+76Zpv6rS2aR0KK1f6PuPwjvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113093; c=relaxed/simple;
	bh=FMRLCq20oZozdHnKtGsDwHC5V84I+M4/M24tX6nI3PU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=piKZ9UEDUWB6/RaM1WrasOXyBCcM9Qz5VUOFPb1oDdEImZp0WS1ObdDPKX72lmPREMffuxeOzS0BfvOmuujn0U6Wp35rDfiO3ehl+wVKVX9Jo0UTQe5L1K0pcxYq2ojjuSO4ygWgybg4sH0p3fsKVUQKR+Jo4OTQ5G7P2+MXUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NggpBVke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NggpBVke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3BA1F00898;
	Wed, 10 Jun 2026 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781113092;
	bh=sZXeLrSPkh3FzI9LMv6q7kyxJymbwQ55sYcDzKRlcrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NggpBVkepkGb9nZGO2atHcshbgWzBKqa4ghLa+cnL9bxaYWUoMUOW8IH0mAeW3kRq
	 II4v90gA1HkQv5KzZubdBWFC+cPR6UKVN1uUphqK1ziy+PQ+GU15tj7NDIY0cy6CqS
	 Qr4hQq45UNZX4avW55d8lcbkSQ4z/TY2P4uWuANhSsF7fp7hQKMuY6fKgTl6AQ3bAR
	 DT8blIPeDVtZdDNzbS1XYqn8aGuvESi4dPJl0gT9nFRxvOD6yVEgcfaplz4Lhq+wya
	 BWqICT8mLbwc3LZpGFcIPK22qImKcF4LpW0CuNTPODSnxboo1cQlJ7kecMfYJ974aU
	 G8soGp3lfkoKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next 3/3] can: add can diag interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Filippo Storniolo" <fstornio@redhat.com>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260610-feat-can-diag-v1-3-021e3f1631a0@redhat.com>
References: <20260610-feat-can-diag-v1-3-021e3f1631a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:38:11 +0000
Message-Id: <20260610173811.CF3BA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `can_diag` module fails to enforce a dependency on the core `c=
an` module, leading to a crash when locking an uninitialized mutex.
- [Medium] Binary structures are embedded directly inside Netlink attribute=
s, violating Netlink design rules.
--

commit 058ea09f4025994f935c1bd793eb19a873974e20
Author: Filippo Storniolo <fstornio@redhat.com>

can: add can diag interface

Add the can_diag interface for querying sockets from userspace.
ss(8) tool can use this interface to list open sockets. The userspace ABI
is defined in <linux/can_diag.h> and includes netlink request and response
structs.

> diff --git a/include/uapi/linux/can/diag.h b/include/uapi/linux/can/diag.h
> new file mode 100644
> index 0000000000000..7f99f85c42425
> --- /dev/null
> +++ b/include/uapi/linux/can/diag.h
[ ... ]
> +struct can_diag_j1939_addr {
> +	__u64	name;
> +	__u32	pgn;
> +	__u8	addr;
> +};

[Severity: Medium]
Does this violate the Netlink subsystem design guidelines?

The Netlink documentation states to avoid binary structures inside attribut=
es
and suggests breaking each member into its own attribute.

Also, does this structure have implicit trailing padding? Without explicit
padding after the 1-byte field, we might run into architecture-dependent si=
ze
differences, breaking 32-bit vs 64-bit compatibility.

[ ... ]
> diff --git a/net/can/diag.c b/net/can/diag.c
> new file mode 100644
> index 0000000000000..eb623ed118af5
> --- /dev/null
> +++ b/net/can/diag.c
[ ... ]
> +	case CAN_J1939:
> +	{
> +		struct can_diag_j1939_addr j1939_addr;
> +
> +		memset(&j1939_addr, 0, sizeof(j1939_addr));
> +
> +		j1939_addr.name =3D can_addr.can_addr.j1939.name;
> +		j1939_addr.pgn =3D can_addr.can_addr.j1939.pgn;
> +		j1939_addr.addr =3D can_addr.can_addr.j1939.addr;
> +
> +		err =3D nla_put(skb, CAN_DIAG_J1939_ADDR, sizeof(struct can_diag_j1939=
_addr),
> +			      &j1939_addr);

[Severity: Medium]
Does this directly write the binary struct into the Netlink message attribu=
te?
The Netlink guidelines discourage putting binary structs into attributes for
new families.

[ ... ]
> +static int can_diag_dump(struct sk_buff *skb, struct netlink_callback *c=
b)
> +{
> +	int num =3D 0, s_num =3D cb->args[0];
> +	struct can_diag_req *req;
> +	struct net *net;
> +	struct sock *sk;
> +
> +	net =3D sock_net(skb->sk);
> +	req =3D nlmsg_data(cb->nlh);
> +
> +	mutex_lock(&net->can.sklist_lock);

[Severity: High]
Can this attempt to lock an uninitialized mutex?

Since can_diag.ko does not call any exported symbols from can.ko, the kernel
module loader will not enforce a load dependency between them. If a userspa=
ce
tool queries CAN sockets, the kernel might autoload can_diag.ko without loa=
ding
can.ko.

Because can.ko is responsible for registering the pernet operations that
initialize net->can.sklist_lock, can_diag_dump() could end up calling
mutex_lock() on a zeroed, uninitialized mutex, leading to lockdep warnings
or crashes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-feat-can-d=
iag-v1-0-021e3f1631a0@redhat.com?part=3D3
