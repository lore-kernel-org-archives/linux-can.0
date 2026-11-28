Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861227;
	b=3inrLZqVfH/gjapt89U6E4tu9sltSzLln9m/G0IPr5p2YvR1WBEOs4OxwTG/UZQsgkXO
	 SavshWrQwgAM5AOOGroy6Kvrbrs80ZLXEbvtGIIsOoChvmL4wD0EXP/wj24qhOa47rc36
	 AQvDcmf+abWGY5pdjbqCNu4l0SH+vJcjjwiw4l5ihIr2uNJX5LQuD0cv4HHc5vdR3y7Gy
	 TbeSMj6csFc0bbjjcwf/MGMF3GRhlGKPFnxkimuaruoJKgFyZ3Tl7jZIeqhj9os8wBesj
	 +mdZO4rahX/E4L5rI8au/4Rz0Cqb0i+KrGffmmfNqfp5EKGDa1VFOyWPgixMioJN/pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861227;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WXBRjbGh7KBV2GvTd+i7hUuv8dxwYbFfQW5ChdEItDE=;
	b=PVsw0NeblHzd8u9cgH0f+FT3Dn52sA4rH5USsDWsrUNAeFwVWhMOfD0InCkPuGv1Oi4d
	 J3C2GAlHjXPDgPYuN9LvpNQOPyCXn4LskrZVq14qmZLg9k6FdO/1EXffPF62cYca2fI3L
	 O0YxRq++AnU80NZUfY3antLlNFPUYogx3uv7V2/hN8ad73jOgXarfOKuN40OgYwWTM2AU
	 CyhmCl3cre0QSq5ReHeahcPBPJb+clURi+7db/GwDDVZdSz+/SKaOIZXCmgiB2cRlRjPZ
	 BiLLl1Sx2AePKzd/fyF58LLNjsGLQNzQpTL4y3JPsiYCUKwILBi2vwW/G8MSJ8PI3rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlDr1vSO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37651606A31C
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlDr1vSO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1A81F000C1;
	Sat, 28 Nov 2026 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861227;
	bh=WXBRjbGh7KBV2GvTd+i7hUuv8dxwYbFfQW5ChdEItDE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PlDr1vSOigdXHhwxymtyKNZhdxYM2p9tSTdgFaOJdlfLFAU+OCGAdFIt9ey5fR+bj
	 fxin+bgR28Fn+RnQkHVKM8048XbcsQqCGr27PhShaFw+wh2LtyzaORdMz87pc7+J9I
	 DSYsat0jegDwEgkKXkBdZDqhdlbCOryG5x+uK5vRY/I5fZMlggdm3g+V+JsclunwqE
	 L2r5Xtrvor8PkLQ29OGrkgUijjTQ+3riPtIF+Ve+NwPAhkmOvhzlq2NeRjg8ZBerbF
	 HsmLeeKV2woLw2jo6QkMXREIRl5xnTBVfEywOX301/Lxvb32KYeQblkSVFhA6JYwKu
	 4UnRWntDkNDYw==
Subject: Re: [PATCH can-next 22/22] can: isotp: introduce CAN_ISOTP_MIN_TX_DL
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:26 +0000
Message-ID: <179586122616.3131.10763616243118441421@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-22-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-22-681ef8d8c2c9@hartkopp.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit says CAN_ISOTP_MIN_TX_DL is added "to perform TX_DL
  related checks" so the meanings of the two defines stay separate.
- [Low] In include/uapi/linux/can/isotp.h the new `#define
  CAN_ISOTP_MIN_TX_DL CAN_MAX_DLEN` (line 165) is the first entry under…

--

can: isotp: introduce CAN_ISOTP_MIN_TX_DL

This commit adds a CAN_ISOTP_MIN_TX_DL define to the isotp UAPI header.
It has the same value as CAN_MAX_DLEN (8), and CAN_ISOTP_DEFAULT_LL_TX_DL
is now based on it.

Several CAN_MAX_DLEN users in net/can/isotp.c are switched to the new
define, so that TX_DL checks stay separate from CAN frame length checks.

> diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
> index bd990917f7c43..580d2aef2c531 100644
> --- a/include/uapi/linux/can/isotp.h
> +++ b/include/uapi/linux/can/isotp.h
> @@ -162,8 +162,9 @@ struct can_isotp_ll_options {
>  
>  /* link layer default values => make use of Classical CAN frames */
>  
> +#define CAN_ISOTP_MIN_TX_DL		CAN_MAX_DLEN

[Severity: Low]
This isn't a bug, but CAN_ISOTP_MIN_TX_DL is a protocol lower bound, not
a default. It is now the first entry under the "link layer default
values" comment, next to CAN_ISOTP_DEFAULT_LL_MTU,
CAN_ISOTP_DEFAULT_LL_TX_DL and CAN_ISOTP_DEFAULT_LL_TX_FLAGS.

It has to come before CAN_ISOTP_DEFAULT_LL_TX_DL, which uses it. Could it
go in its own block above the defaults, or could the comment be updated?
That way, people reading this userspace header won't mistake it for a
default value.

>  #define CAN_ISOTP_DEFAULT_LL_MTU	CAN_MTU
> -#define CAN_ISOTP_DEFAULT_LL_TX_DL	CAN_MAX_DLEN
> +#define CAN_ISOTP_DEFAULT_LL_TX_DL	CAN_ISOTP_MIN_TX_DL
>  #define CAN_ISOTP_DEFAULT_LL_TX_FLAGS	0
>  
>  /*
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 47f91e88dedbe..acea58db9ccde 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -404,7 +404,7 @@ static bool chk_optimized_fail(struct canfd_frame *cf, int start_index)
>  	 * start at cf.data[7] cf->len has to be 7 to be optimal.
>  	 * Note: The data[] index starts with zero.
>  	 */
> -	if (cf->len <= CAN_MAX_DLEN)
> +	if (cf->len <= CAN_ISOTP_MIN_TX_DL)
>  		return (cf->len != start_index);
>  
>  	/* This relation is also valid in the non-linear DLC range, where
> @@ -617,8 +617,8 @@ static void isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
>  	}
>  
>  	/* the PDU must not fit into a SF (FF_DLmin) */
> -	if (ll_dl == CAN_MAX_DLEN)
> -		sf_max = CAN_MAX_DLEN - SF_PCI_SZ4 - ae;
> +	if (ll_dl == CAN_ISOTP_MIN_TX_DL)
> +		sf_max = CAN_ISOTP_MIN_TX_DL - SF_PCI_SZ4 - ae;
>  	else
>  		sf_max = ll_dl - SF_PCI_SZ8 - ae;

[Severity: Low]
The commit message says the new define is used "to perform TX_DL related
checks". Is the check in chk_optimized_fail() really a TX_DL check?

It tests cf->len of a received frame. The function's own comment calls
this the "for CAN_DL <= 8" range, which is what CAN_MAX_DLEN means. The
matching padding check in isotp_fill_dataframe() still uses
CAN_MAX_DLEN:

net/can/isotp.c:isotp_fill_dataframe() {
    ...
		} else if (cf->len > CAN_MAX_DLEN) {
			/* mandatory padding for CAN FD frames */
    ...
}

isotp_rcv_ff() now uses CAN_ISOTP_MIN_TX_DL for the LL_DL == 8 choice
between SF_PCI_SZ4 and SF_PCI_SZ8. isotp_rcv() makes the same choice for
single frames, and its comment calls it the "LL_DL == 8" check, but it
still uses CAN_MAX_DLEN:

net/can/isotp.c:isotp_rcv() {
    ...
		if (cf->len <= CAN_MAX_DLEN) {
			isotp_rcv_sf(sk, cf, SF_PCI_SZ4 + ae, skb, sf_dl);
    ...
}

Both defines expand to 8, so nothing changes at runtime. However, the RX
single frame, RX first frame, RX padding and TX padding paths now use
different constants for the same 8-byte limit.

Would it be more consistent to keep CAN_MAX_DLEN in chk_optimized_fail(),
and to convert both isotp_rcv_ff() and isotp_rcv(), or neither?

The two conversions in isotp_sendmsg() compare against so->tx.ll_dl and
look like real TX_DL checks.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
