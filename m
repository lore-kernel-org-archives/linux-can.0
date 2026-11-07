Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057248;
	b=k2aDfy2Xjalk1CdhChV9Ulfp18PZCn0y0Z9LVkhPs7FmkbQxEJWicH9Sgnr+u/OLI5am
	 iYiyXcmuxNBxbOcj27mZpuEWJGwGnN6MN0Vug2c5I4sgb7uV9gsnwMBvKlb6xRjcqVy5m
	 eMWHD3Rys5hVvJOi9il6vsTBrUDAfAmGVoUWc/O9ysO0KcTI+gF1EFo+MSBpOLTL/xr+B
	 K8IH7x/QPuZwUFMFDHcGs+s5YiMP+49p6ZvwSG+OqhLioi2NDeB+63IvHm/Sm/riK/k7+
	 etn945arGuLeUNBF5f561zmesxYC/lniS9YNztqI+iytSiVbCDJc4Bn8xgfuhHCbH/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rlJ/KV9W43+kVi2frRB7wfRIXW8dXuvwIETC1wb5XFo=;
	b=RNzvExiQ7ydZvep76fiXQZrtsS8ZC5RZ/UaqcgNlAPDEEI0QJAtUJA5YhZnsWCrsBUNu
	 Vzvj52Suv4Y+T+y4ZIT1Ab6wMxGMq9vMmB6Tob6JLUrp5K53gHWDCKiIidL75V3IfcDQr
	 efWqnTGHLWhXvatjufn5v2SGbl34zjot8LQzUfRT5CWXyNlq/5n2F+4yHpPQoFpxbqwAa
	 E/0pKTNZ3uqlOTE0fKLtFWrn7m7gpzkLQdt+v4IgD1KEjCGRT3XzueZOrcxxdN/g5tJjY
	 510u0dKx4X57xYrbmzN4Upu1opdFkeSc6txbEpjYY2hXPoK/JKUN4LVVXi+RVfgML9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPdw7ERF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F6606A337
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPdw7ERF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593E51F008A1;
	Sat,  7 Nov 2026 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794057247;
	bh=rlJ/KV9W43+kVi2frRB7wfRIXW8dXuvwIETC1wb5XFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FPdw7ERFd8adbd0EJvvYnF6WYsrILCS3nbsc3VVrP6eiBTSxWayu5cCRvT+5I1YzR
	 Fa5JkWTeWODO/YiZlKuoJh588WNp3ZJYcpxS07Gj8qZ2cqXsM8GvwJj90oaJ33R0hL
	 YKFl1ikRqT7tDmlb18FAtsNvYKG6ENgXUEpOrWQW2/Fa+QSczZ+HlOsef89TO8QGf5
	 XvvnfA9L944MD01daI2byD6oKsSu4aX94Vnl+kPkQBipzQQSSCrXxzWb0VktNnd25x
	 9GQCUGCik1n1SWNGcD3zrGBYsce76MOqpAaWZjg5R/+ehMaBzq25YI78EqMrNHrDAX
	 tIiPWP317dZqA==
Message-ID: <sashiko-outbox-202902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] can: enable memcg accounting for user triggered
 allocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
References: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
 <20261107-can-bcmlock-memcg-v1-3-482d9f5be1fd@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:14:06 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] can: j1939: non-zero setsockopt return value in
  j1939_sk_setsockopt_flag() [1]
--

commit b3ee6688711331e68a7e275f9b72d5b3fa8b7ee5
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: enable memcg accounting for user triggered allocations

This commit enables memcg accounting via GFP_KERNEL_ACCOUNT and
SLAB_ACCOUNT for user-triggered allocations in the CAN core, BCM, ISOTP,
J1939, and RAW socket protocols.

Link: https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca475=
4@hartkopp.net/

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 50a598ef5fd4a..c832465876049 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -716,9 +716,14 @@ static int j1939_sk_setsockopt(struct socket *sock, =
int level, int optname,
>  				return -EINVAL;
> =20
>  			count =3D optlen / sizeof(*filters);
> -			filters =3D memdup_sockptr(optval, optlen);
> -			if (IS_ERR(filters))
> -				return PTR_ERR(filters);
> +			filters =3D kmalloc(optlen, GFP_KERNEL_ACCOUNT);
> +			if (!filters)
> +				return -ENOMEM;
> +
> +			if (copy_from_sockptr(filters, optval, optlen)) {
> +				kfree(filters);
> +				return -EFAULT;
> +			}
> =20
>  			for (f =3D filters, c =3D count; c; f++, c--) {
>  				f->name &=3D f->name_mask;

[Severity: Medium]
This problem wasn't introduced by this patch, but should
j1939_sk_setsockopt_flag() return 0 instead of tmp [1]?

net/can/j1939/socket.c:j1939_sk_setsockopt_flag() {
    ...
	lock_sock(&jsk->sk);
	if (tmp)
		jsk->state |=3D flag;
	else
		jsk->state &=3D ~flag;
	release_sock(&jsk->sk);
	return tmp;
}

When userspace enables SO_J1939_PROMISC or SO_J1939_ERRQUEUE with a
non-zero value in j1939_sk_setsockopt(), that value is returned to
userspace from setsockopt(), breaking callers that check for a 0 return on
success.

[1] https://sashiko.dev/#/bug/linux-35e22274-4165-4b2b-985e-c5f5773b9ef9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-can-bcmloc=
k-memcg-v1-0-482d9f5be1fd@hartkopp.net?part=3D3
