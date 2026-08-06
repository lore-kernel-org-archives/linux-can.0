Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA03A1A27
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024287; cv=none; b=W7muw327VZIRFFFsIV6I3GXrhAjLiaF16gFytRjBhlVxY1qkIa1EXXFHXOsUWD9CfStI0kCBtCe1W/pQ2PzPyE91IkmWsbTRRVgNswuqWehaDDbTBqwpxkyS4qXvz7lSMi2U9XuOUEltcdqo1zJEiqsUUvOU1RqVAkqDTELXGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024287; c=relaxed/simple;
	bh=qWvdI8eabruu3vjgEu5WNlu0VqgWanN2DOKFwA4OizA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a+YFlhVUp4YIPPOcBRnHeQ6/YD0o2e5ERdtndAbfq2cyxCIUteqdvyPwhV+D9LL4J04kiqXRgISkeLvxW+jfx3Y1wv4ir/GtBoDgqSOQ7FxTD0eg5GJJyV1b4+zLX70HccG51YPuDSR+aLHnbpgPIcUhRnl2qJWIw42qOSpm9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jufMrcTw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jufMrcTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343781F000E9;
	Thu,  6 Aug 2026 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024285;
	bh=flXt1LT9wdy3Jjov9MaPI03Jo/Xnx05NC8L07wnzGa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jufMrcTwZvmKohyAhjt0c8Qcn+Ka9PCzsPwitJ97JRz12neL6IsehG9D1lXxRJcvt
	 1UvGdwiQqhme+9EqAL5iXDOp948ozKaG1tBdtLD1i3WsIv/UIb46euDXsMII9k9/Cq
	 AFSDc3YZVhEq/KPiWecYP11AqJXcfPzsn2BEk82Zbl0tQJNewuvP9gzDdYlowdbB+r
	 UvZk6/SdD4P/kh1YXQJOkBBn5p8uqLHVGCt5jtR/W0v2xZBq2Yxa4oDEhm4sMrWw0R
	 1f6UO+o+SUfDtdSS/Mr8sm5zKx/gJAumuEifj0osNW9atT7rSmDdJw7uKTWuCHIMqq
	 BKf1XLhE+SP+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v2 3/3] can: add can diag interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Filippo Storniolo" <fstornio@redhat.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260806-feat-can-diag-v2-3-832597ee4cb9@redhat.com>
References: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
 <20260806-feat-can-diag-v2-3-832597ee4cb9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:51:22 +0000
Message-Id: <20260806135125.343781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Netlink UAPI attributes embed binary structures with implicit comp=
iler padding
--

--- Patch [3]: [PATCH can-next v2 3/3] can: add can diag interface ---
commit 98771deaa2e2d4a790b170eb8967f6122234dec8
Author: Filippo Storniolo <fstornio@redhat.com>

can: add can diag interface

This commit adds the can_diag interface for querying CAN sockets from
userspace using the ss tool. It defines the userspace ABI including netlink
request and response structures to expose socket properties.

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

[Severity: High]
Does this structure introduce implicit compiler padding? With a 64-bit, 32-=
bit,
and 8-bit field, it appears there are 3 bytes of implicit padding at the en=
d.
This can lead to architecture-dependent layout mismatches in the UAPI.

Additionally, modern Netlink design rules strongly discourage passing binary
structures directly inside attributes. Should these structure members be br=
oken
out into individual Netlink attributes to ensure proper validation and futu=
re
extensibility?

> diff --git a/net/can/diag.c b/net/can/diag.c
> new file mode 100644
> index 0000000000000..e9132ba3f8cc5
> --- /dev/null
> +++ b/net/can/diag.c
[ ... ]
> +static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
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
> +	}

[Severity: High]
Does sending this binary structure directly as a raw attribute prevent prop=
er
validation and extensibility?=20

Once this ships in a release, the UAPI is frozen and this layout becomes
unfixable. Could this be changed to send the individual fields as separate,
strongly-typed attributes instead of embedding the C structure directly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-feat-can-d=
iag-v2-0-832597ee4cb9@redhat.com?part=3D3
