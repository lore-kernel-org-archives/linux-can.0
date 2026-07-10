Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDC3F8EB2
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676999; cv=none; b=JSs/jJdA/YPIK/HhA3Plo0huzoun9pGvBHdbQmQslWP676sChiWzWOlVeBG5izSDgfAbAryFMHqUfqTjOz9KCtdBEYJUL6QtkIIemu5uiChtockLl7SH4QG6royEAAoBL881A45jbie7OMpI4wlGzXvzHgi/eaQgYirLy8R//UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676999; c=relaxed/simple;
	bh=PQvhusqomgLA59bF9tbWhuxepmwU8Nx4zrYwgJDUaIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U3cnUJhJ8SEf1tI8ZNp7TZduxBkj9OPKSQo4a62S+KgHxji1sKmb31DRV2X0LFVKPIbvbnt1R6Jr15oNgxHmljwKForGdkphdbE4/WcZ+5CdTuuj+x7Md46CJAt51Hhh3uJ6BjwfBaRNErS5D7Am773vU3A6gizmZ2NI801OGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBLoZ5Sy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBLoZ5Sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A231F000E9;
	Fri, 10 Jul 2026 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676997;
	bh=yyumfNVpiSVghhSbTvoZEZjgfsx1r+cvhAS9cQTbtYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBLoZ5SyGlXZirIIzqOq1ISMny56K71IqTWb1P7+5FiBlOIzVfau9VmNavU6Cg8n6
	 WmWFJbZ6jfTKoSYYj/Tdr8opVaLXI53hDzvyaK2sa38RnrLfR+rAzLkmAga+eF8Slm
	 KuCgtcVJ03t7dkLNMOuENA83MlLQOIEACF+uxAsLqvdfVZ/7SQbVTWWQgKbeoBQdp5
	 adpd8UGTd0IayEpUF5vr6MJAko/zw3d0Ks3uh4mfRTZfoAYSdmBilOfWFVg5pITYpq
	 7ybMJ8SECBDFxBgpldutN7MT7FPho2OFHeyM5KOQKDc96Z1za6xmKZmQiZxMwC+bqz
	 B1mxKEi8A5e1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] can: isotp: use unconditional synchronize_rcu() in
 isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260710-isotp-fixes-v1-1-75a1d11d7df9@hartkopp.net>
References: <20260710-isotp-fixes-v1-0-75a1d11d7df9@hartkopp.net>
 <20260710-isotp-fixes-v1-1-75a1d11d7df9@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:49:56 +0000
Message-Id: <20260710094957.11A231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent lockless access to TX state variables leads to buffer c=
orruption and invalid frame transmission.
- [Medium] Concurrent socket release and netdevice unregister skips CAN fil=
ter unregistration, leading to a memory leak.
--

--- Patch [1]: [PATCH 1/2] can: isotp: use unconditional synchronize_rcu() =
in isotp_release() ---
commit fd9ce93db70bc0c54d097a98764dcfab2ecff812
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

This commit moves the synchronize_rcu() call in isotp_release() to run
unconditionally before timer cancellation. It ensures we always wait for any
in-flight isotp_rcv() callers to finish, preventing a use-after-free timer
callback race when NETDEV_UNREGISTER clears so->bound early.

Link: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);
> -				synchronize_rcu();
>  			}

[Severity: Medium]
This isn't a bug introduced by this patch, but earlier in isotp_release(),
there is a check for dev_get_by_index():

	if (so->bound) {
		if (so->ifindex) {
			struct net_device *dev;

			dev =3D dev_get_by_index(net, so->ifindex);
			if (dev) {
				if (isotp_register_rxid(so))
					can_rx_unregister(net, dev, so->rxid,
							  SINGLE_MASK(so->rxid),
							  isotp_rcv, sk);

If isotp_release() runs concurrently with a NETDEV_UNREGISTER event,
dev_get_by_index() can return NULL. When that happens, does this skip the
can_rx_unregister() calls and permanently leak the CAN filters?

>  		}
>  	}
> =20
> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();
> +
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);

[Severity: High]
This is a pre-existing issue, but could there be a lockless state corruption
involving the txtimer?

If isotp_tx_timer_handler() executes on CPU A, it sets
so->tx.state =3D ISOTP_IDLE and wakes up waiters:

	so->tx.state =3D ISOTP_IDLE;
	wake_up_interruptible(&so->wait);

Concurrently, if isotp_rcv_fc() executes on CPU B, it calls hrtimer_cancel(=
):

	hrtimer_cancel(&so->txtimer);

CPU B will spin waiting for the timer handler on CPU A to finish.

While CPU B spins, a blocked task in isotp_sendmsg() on CPU C can wake up,
see ISOTP_IDLE, and successfully execute the state exchange:

	while (cmpxchg(&so->tx.state, ISOTP_IDLE, ISOTP_SENDING) !=3D ISOTP_IDLE) {

CPU C will then begin writing into so->tx.buf.

When the timer handler on CPU A finishes, hrtimer_cancel() on CPU B returns.
isotp_rcv_fc() then unconditionally sets the state to ISOTP_SENDING and cal=
ls
isotp_send_cframe():

	case ISOTP_FC_CTS:
		so->tx.bs =3D 0;
		so->tx.state =3D ISOTP_SENDING;
		...
		isotp_send_cframe(so);

Does this lead to isotp_send_cframe() concurrently reading from so->tx.buf
while isotp_sendmsg() is still writing to it?

>  	hrtimer_cancel(&so->rxtimer);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v1-0-75a1d11d7df9@hartkopp.net?part=3D1
