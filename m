Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071563;
	b=SMVhJ5QNRK1k0XZZvk9DQspNKRbOIAdbzdD+iI9WldCO2OheiJnTIgmUtt5jSGlQyyAs
	 NIl3Mvtd0ezkFyKxANIx7U+XYS7OcNlh8GLX11n1Bv+bMLXLyE3c3NYdb3IquNz7Q0wbI
	 5nIEJ2DLZajabDYci75wibaJe+GVPHc1ZGZIiJnJLzHoAnc24qsNHUealgXBDyq6OXh86
	 nZvRR8dP4Q32U2D7UJ8VhI0mQU5eViuqn9WUIv9GUHWRjhDhulVqq/nHgA+xx3EpyhYCQ
	 4wKBo3BZtJmbvz+3dhj+GK8gTmCxMLJtv2jhXth+++drqHYZJBddhuA5iXPo7F3LILg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071563;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=phnBu4XvbVAIGJqNbUWargoD4yqKUX6fsdtYoFEsmsA=;
	b=QvHxm5sx74gTf+2vTXgIqPr8dYbfcv4HEX6sZqTmE2UIY+h0PR23ySoj0pUZRBH9bh3a
	 mULGwYFg8o3M6mIsdo2OPmUbfL3zEjFdi0+Yj/iI1G2bc0fbiQRYWO3r/K6azVlbfteqM
	 g45+qe3luv6NduWsZDsZseoTUaV6V5/R6NB/sjIE0ZaaU2O198tWQ7nqAucvCnNY/RIcr
	 JgrGHDTVVZyp+E9FsxH1KpgA08kBb+cVyokAZexs0PHk8rdC6CQAEiKd/xRaZmRRKuttJ
	 M53NA9AvaT1f+r7iV2kLJoSY17AvAK9W58Q1P+pl6szzOaAfZ2WwQDW/bMFJwetnXow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgxHtC4j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406B5606A325
	for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgxHtC4j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68611F000CB;
	Thu, 19 Nov 2026 06:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795071563;
	bh=phnBu4XvbVAIGJqNbUWargoD4yqKUX6fsdtYoFEsmsA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FgxHtC4jwKIIBjJG+2hdfT7Y0wwybRzMFHbyuW1j7WkUNdBnw4dg40NHBY/GgmRDc
	 88lavtLKmTmRNaHYm5FfbbSMfeQskDQsBuIRaD+0zdcycWEvriz9XXygr4F33//dR2
	 FAbLN1l09cP210j2dxeUE4znLFa+o3KiyZ8JxPVU5O5GU6iz1zF/fxlwtbk6dYpvbf
	 /P6IKju+sEz1dKa7DwS3n9yAM9uOkPvnLDtZ2Flf9zd60+LZoAlecsq2NiAaYK9jn4
	 B5ptrqlLnrtjbu4pYwaI2UgEf65kn1xjZdNXoIgESjLSovSHsq9lF5F3rUn5ersnsd
	 sWv1l/6f0eb5Q==
Subject: Re: [PATCH v6 6/8] can: isotp: always start the rx timeout in
 ISOTP_WAIT_DATA state
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
Date: Thu, 19 Nov 2026 06:59:22 +0000
Message-ID: <179507156226.3132.18273836206289416422@kernel.org>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-6-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-6-6826a6227d36@hartkopp.net>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This fix is incomplete: isotp_rcv_cf() (net/can/isotp.c) can
  still leave so->rx.state at ISOTP_WAIT_DATA with no rx timer running.

--

can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state

This patch starts the rx timeout in isotp_rcv_ff() and isotp_rcv_cf()
whenever reception continues in ISOTP_WAIT_DATA state, before a flow
control frame is sent. Without it, so->rx.state can stay in
ISOTP_WAIT_DATA with no rx timer running, and isotp_bind() then returns
-EAGAIN after the CAN device has been removed.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 8229b6a69ecd0..0293d590186c4 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -726,13 +730,13 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
>  		return 0;
>  	}
>  
> +	/* start rx timeout, isotp_send_fc() restarts it */
> +	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> +		      HRTIMER_MODE_REL_SOFT);
> +

[Severity: High]
Can isotp_rcv_cf() still leave so->rx.state at ISOTP_WAIT_DATA with no rx
timer running?

Earlier in isotp_rcv_cf() the timer is cancelled unconditionally, and two
length checks after that return without resetting rx.state or restarting
the timer:

net/can/isotp.c:isotp_rcv_cf() {
    ...
	hrtimer_cancel(&so->rxtimer);
    ...
	/* CFs are never longer than the FF */
	if (cf->len > so->rx.ll_dl)
		return 1;

	/* CFs have usually the LL_DL length */
	if (cf->len < so->rx.ll_dl) {
		/* this is only allowed for the last CF */
		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
			return 1;
	}
    ...
}

The first check is hit on a CANFD_MTU socket when an 8-byte FF is followed
by a CF longer than 8 bytes. The second check is hit on classic CAN by a CF
with DLC < 8 in the middle of a PDU. A remote CAN node can send either
frame.

The new hrtimer_start() comes after both checks, so neither path reaches
it. That means isotp_rx_timer_handler() cannot fire, and it is the only
asynchronous path from ISOTP_WAIT_DATA back to ISOTP_IDLE.

If the CAN device is then unregistered, the NETDEV_UNREGISTER branch of
isotp_notify() clears so->bound, so->dev and so->ifindex but leaves
so->rx.state alone. No further FF or SF arrives to reset the state, so
isotp_bind() keeps returning -EAGAIN until the socket is closed:

	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
	    READ_ONCE(so->rx.state) != ISOTP_IDLE) {
		err = -EAGAIN;
		goto out;
	}

This is the symptom the commit message says is fixed. The subject also
says the timeout is "always" started.

The next patch in the series, "can: isotp: reject socket options while a
transfer is active", adds the same rx.state != ISOTP_IDLE check to
isotp_setsockopt_locked(). With that patch, setsockopt() would also return
-EAGAIN permanently in this case. That patch's statement that receptions
always end by their timeouts at the latest also would not hold for these
paths. No later patch in the series appears to address this.

Would it make sense to reset so->rx.state to ISOTP_IDLE on these two early
returns, or to restart the timer there? Another option is to reset
so->rx.state in the NETDEV_UNREGISTER handler of isotp_notify(), which
would cover every such path at once.

>  	/* perform blocksize handling, if enabled */
> -	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
> -		/* start rx timeout watchdog */
> -		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> -			      HRTIMER_MODE_REL_SOFT);
> +	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs)
>  		return 0;
> -	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117-can-bcmlock-memcg-v6-0-6826a6227d36%40hartkopp.net
