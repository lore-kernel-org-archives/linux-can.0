Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A543F0A9
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306760; cv=none; b=SGcHeBuo9s6wKtYEP099k0FkpAyMxRROK1r+elbSHrqUNwU06CBX8dTyXL6neARbBSx5/AZHhQ9u9Vw3ouSl6U1pcsHzCweAsBoPFt2INsCqIe4DD7dL2naIi9PZPpLsyEWVewkEcPxLFGb1DLxjzGUrf90ku35pQqgq9QSJDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306760; c=relaxed/simple;
	bh=GjHpBzGtod54sMkyXvvE5SB2kooJNXIjFbFOpent/J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=izMNA2Tlg2J8HZRJOY91/Utse+uQm863Fx1PleRs7U9IhVfPntpiEMSp8nQqEoEMHB3XiQC3v5L1hSK/zhEDjsDepRiDL652dkXdyTiz9uRfKa0+yrCymo+Wv5MOnHB8UHkr3Ol+dtMRWZC/Hqw/e0W+txaBg40UNtDns7o1+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k85FbS6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k85FbS6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C0D1F00A3A;
	Fri, 17 Jul 2026 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306759;
	bh=8CscWFAP/aEdaVZwXyJcDhTcZQrC0eJXekM3wATVcb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k85FbS6rXtcepEVn82sfdS/cKWqIeZn4IPwJTdSf3QjJuozVj3eRAy/tFuJQA751l
	 lUkMeB1DUs2oxuKsVhSKyxdveahDa9FdTtDGEzZbBXTftFeRXgkDOVqnlIQ6kkzq5P
	 RBudSAlcKdMwlVB2kA5GPBLjtIg3ScLiFLclkB/lbWrku4sunHS66n/XI4huCUPQFu
	 K7wO9O7yvMOQUjOx6j9hivTPfk15JDPCbQsUNTO2FUKF7PrOUPxSvTDTSjFXFNiaYr
	 ufS4fFxgKQ8g9iOaApcGg3x+EGnU2JmhBR29XSsqKNIznExAXL/I5mcLcnHgr6s0Dy
	 VwBEz3X7pKKTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 03/19] can: raw: add locking for raw flags bitfield
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260716155528.809908-4-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:45:58 +0000
Message-Id: <20260717164558.E1C0D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Holding `rtnl_lock()` across user-space memory copies enables a sy=
stem-wide Denial of Service.
--

--- Patch [3]: [PATCH net 03/19] can: raw: add locking for raw flags bitfie=
ld ---
commit 64cfa8c3c841a4b23931e54d2dfb767381bcd986
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: raw: add locking for raw flags bitfield

This commit integrates separate integer values into a single bitfield and
adds locking to prevent concurrent access during read-modify-write
operations in raw_setsockopt. It introduces a raw_setsockopt_locked
function wrapped by a new raw_setsockopt to handle the locking.

Closes: https://lore.kernel.org/linux-can/20260503112200.22727-1-eulgyukim@=
snu.ac.kr/
Link: https://patch.msgid.link/20260504111928.41856-1-socketcan@hartkopp.net

> diff --git a/net/can/raw.c b/net/can/raw.c
> index a26942e78e688..82d9c0499c95f 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c

[ ... ]

> @@ -769,6 +743,26 @@ static int raw_setsockopt(struct socket *sock, int l=
evel, int optname,
>  	return err;
>  }
> =20
> +static int raw_setsockopt(struct socket *sock, int level, int optname,
> +			  sockptr_t optval, unsigned int optlen)
> +{
> +	struct sock *sk =3D sock->sk;
> +	int err;
> +
> +	if (level !=3D SOL_CAN_RAW)
> +		return -EINVAL;
> +
> +	rtnl_lock();
> +	lock_sock(sk);
> +
> +	err =3D raw_setsockopt_locked(sock, optname, optval, optlen);

[Severity: High]
Does holding rtnl_lock() across raw_setsockopt_locked() allow a system-wide
Denial of Service?

Inside raw_setsockopt_locked(), user-space memory copies are performed
before rtnl_lock() was historically taken:

	case CAN_RAW_FILTER:
		...
		if (count > 1) {
			filter =3D memdup_sockptr(optval, optlen);
			...
		} else if (count =3D=3D 1) {
			if (copy_from_sockptr(&sfilter, optval, sizeof(sfilter)))
				...
		}

Could a local user pass a memory pointer backed by userfaultfd or a slow FU=
SE
mount, intentionally stalling the page fault during memdup_sockptr() or
copy_from_sockptr(), and freeze network configuration for the whole system =
by
holding the global rtnl_lock?

It seems the isotp.c example cited in the commit message only takes
lock_sock() in its wrapper, not rtnl_lock().

> +
> +	release_sock(sk);
> +	rtnl_unlock();
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D3
