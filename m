Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570087;
	b=mjyJ2swiQJsKVVjB9Jvql05Mnn1CG5KvVYnPdMWtIzPXXt/WeDah883p2cBOU5z+0zFK
	 Xjkyr78vAl9tLnWGhbB4qcvC3JENxNNi94CFCBQ9sN6snwBWjU0/t4xnWBYdJ/Yarj+TW
	 wjEpYkxKrlRdF+9JDY4nyt66H7vqZshloH50MK4yYpDEwt6s5Xk9uU+GVtRhCSaRmcb9a
	 y4mh/WL3PrONz7EWrYMe6htQYvFyF619RNqjyFwgVgr/mYukzPxPXCqaTszZUaoGM6NUu
	 RYjDZhSg1nTxvGco7NK0Mu/VG2bkSEd2pf5cN4ayQgSf+hBUNE6TMGSsUnFIAgHATJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570087;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T0lp4s99YN+4X8g/mpiaxZu9bufNF/4Xn7Jf2mymh4Y=;
	b=rN9Hm0xdLKhkqZPe/lotu4SDYZZkGaLvq9wq/p0TpTKQ7HBjt6YmfcfPWiMIGxDKvIwl
	 x2HX7coutvLZ9WST2PIZXZrFp91qxj40P3hyDNZYSQqbM0NSimfHaZlsI+1PWUEkmsxFb
	 vQnUxBOdhoG0IdAgIP8/nelrfeBHPS59tDXTkS0NVQjaGKAqZiyddwAEsbKRew8L5g50O
	 JbxohmZP0+SOopB5xNw+kOp68HQzS7P2WO+nUgGYKZas4j8dHAqS2BZC47GJYIItZp0Nq
	 P9dOYLtZLg24iaSw9SW+7qouNwe1HdvgQx0et1CZbWfEVI6hm58LWUeOupU+e5SD57w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XDSg/Ak9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E182606A321
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDSg/Ak9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3B91F000C5;
	Fri, 13 Nov 2026 11:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794570087;
	bh=T0lp4s99YN+4X8g/mpiaxZu9bufNF/4Xn7Jf2mymh4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XDSg/Ak9zyMD0RGXptF8khBwzLKy+HFzAV9jftb47vsEOlVDs0ujD0XKM9p1x/4En
	 TPX4HS7mn7XgW3Orp1V2biUu1tEk85WKpxh5s1lt7taDQmPA5tAAXpmO84pMt4KvEd
	 EJwDBRHxoq7Z5xKWJbX0rF8gJ/6RqXZj3h38ki6xxpdXKS7kgmi65Wj8RLsJ46zR7/
	 JRBAfBXWauc3Y1IvmF5PXUt+EvI85It3XNS3cSG9Likx8cBJERTMif+QIDbT0sXSOe
	 ZRfYnLMdoIOsZZr+fnRIjQpd1YVy8yZxr7Z73afWVVIOJ0Q4owG6qjWX8B8NEJR0K9
	 0yPPoZNUSinbA==
Message-ID: <sashiko-outbox-212736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v4 3/3] can: add can diag interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Filippo Storniolo" <fstornio@redhat.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261113-feat-can-diag-v4-3-c28842c74c95@redhat.com>
References: <20261113-feat-can-diag-v4-0-c28842c74c95@redhat.com>
 <20261113-feat-can-diag-v4-3-c28842c74c95@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:41:26 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: diag: unaligned 64-bit J1939_NAME and cdiag_ino in
  sk_diag_fill()
--

commit 6641e4d72c858dd57e3276451bf5e3299a63d8d2
Author: Filippo Storniolo <fstornio@redhat.com>

can: add can diag interface

This commit adds a SOCK_DIAG netlink interface and UAPI definitions for
monitoring open AF_CAN sockets from userspace.

> diff --git a/net/can/diag.c b/net/can/diag.c
> new file mode 100644
> index 0000000000000..11281f75ecd52
> --- /dev/null
> +++ b/net/can/diag.c
[ ... ]
> +static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
> +			struct can_diag_req *req, /* will be used for filtering */
> +			struct user_namespace *user_ns,
> +			u32 portid, u32 seq, u32 flags, u64 sk_ino)
> +{
> +	struct sockaddr_can can_addr;
> +	struct can_diag_msg *rep;
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh =3D nlmsg_put(skb, portid, seq, SOCK_DIAG_BY_FAMILY, sizeof(*rep), =
flags);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	rep =3D nlmsg_data(nlh);
> +	memset(rep, 0, sizeof(struct can_diag_msg));
> +
> +	rep->cdiag_family =3D AF_CAN;
> +	rep->cdiag_type =3D sk->sk_type;
> +	rep->cdiag_ino =3D sk_ino;
[ ... ]
> +	case CAN_J1939:
> +	{
> +		name_t	j1939_name;
> +		pgn_t	j1939_pgn;
> +		__u8	j1939_addr;
> +
> +		j1939_name =3D can_addr.can_addr.j1939.name;
> +		j1939_pgn =3D can_addr.can_addr.j1939.pgn;
> +		j1939_addr =3D can_addr.can_addr.j1939.addr;
> +
> +		err =3D nla_put(skb, CAN_DIAG_J1939_NAME, sizeof(j1939_name), &j1939_n=
ame);

[Severity: Medium]
Should CAN_DIAG_J1939_NAME be emitted with nla_put_u64_64bit() instead of
nla_put()?

struct nlmsghdr (16 bytes), struct can_diag_msg (32 bytes), and the optional
CAN_DIAG_UID attribute (8 bytes) leave the attribute stream 8-byte aligned.
Because struct nlattr is 4 bytes, nla_put() places the 8-byte j1939_name
payload at a 4-byte-aligned offset and leaves the finished netlink message
length at a multiple of 4 rather than 8 (after the 8-byte CAN_DIAG_J1939_PGN
and padded 8-byte CAN_DIAG_J1939_ADDR attributes).

When can_diag_dump() packs another socket message into the same skb after a
CAN_J1939 socket, nlmsg_put() aligns only to NLMSG_ALIGNTO (4 bytes), so the
next struct can_diag_msg starts at an unaligned offset and rep->cdiag_ino =
=3D
sk_ino performs an unaligned 64-bit write in the kernel and unaligned reads
in userspace.  Using nla_put_u64_64bit() with a pad attribute and marking
cdiag_ino as __aligned_u64 in struct can_diag_msg would keep both the
attribute and subsequent messages aligned before the UAPI is frozen.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-feat-can-d=
iag-v4-0-c28842c74c95@redhat.com?part=3D3
