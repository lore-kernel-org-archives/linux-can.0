Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECAD306D2A
	for <linux-can@vger.kernel.org>; Wed,  2 Sep 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375176; cv=none; b=aIdEdg/+EcPLJLTn0lTSPLMGc+WNR7gG54Dz7UJTBeTZHLeAtbCPYlKW5R8JwjPGpOzQ/299/cP6S+DEW+nebOBw9VKCmngLHuYe8Bs2PN9w+QII3mCQpCgunFMQeb2dVPX6eGLFdrnRIvljKA3cqNFITeZEbkdVvQq2XjSVP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375176; c=relaxed/simple;
	bh=YiwagfLSP73YYInL95BMf0knu44fdjJ2fPjKuFjbG4A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PHfAGoggSp0pBklNxjynJGFU5RgvnpVyBlz3KPBDi3inxEr8eoJu60OvK6M8IxhCxNtYrTkrvLZfJAowkE9ctFFLc9jxHR5PcnAzVvrML/XP/a3ngyRsDpJXNTb7gygQv7jkBg7VqipuTalux+TudXzRxBh7HLBewJOAJ7cvRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbChT9AY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbChT9AY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877981F000E9;
	Wed,  2 Sep 2026 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788375174;
	bh=shCCnthOEoGh/8SXaXYmjy1gyth24VAUd86/AqMzWBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FbChT9AYgj2ZX9DwmHC4C1omJNxiy6G9MwRvq6P60+RkuXXs+11UN/myA1ilIHiyi
	 2rag/9daXHCeQWS96Rm8vnh148HrbkXNO1PrHv03gsp51Zp/DruAus94rDMIfW6H6o
	 i4j/ewlV3ct4XioyZdXEkqPsrQF+9o3nG1paghxz+V0R6q/qOkFypF5VxoOvr/PZx3
	 4UDJqE8vaL9TcRX7P2FlwSxTGV6Egr8112/wSi0nAczj5GlNG3TchVAI/IL6Wrk9ym
	 Yja+R9Bs+tq+ExZ4r7EKESKmH9CeOpM28E0CLIb+s2U+60GtQPLqzObnZimNf+gFOE
	 9KobZesiIytYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: remove CAN filters independent from namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260902182915.19486-1-socketcan@hartkopp.net>
References: <20260902182915.19486-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 18:52:54 +0000
Message-Id: <20260902185254.877981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Permanent struct net_device reference leak on error path in bcm_co=
nnect().
- [Medium] Cross-namespace data corruption in BCM ANYDEV receive operations.
- [Medium] Timer cancellation regression leading to leaked BCM TX timers.
- [Medium] Per-namespace CAN receive list statistics leak in isotp_release(=
).
--

commit 510b2a0288244edb9bcc3905c8c1576ae80db01f
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: remove CAN filters independent from namespace

This patch removes the namespace equality check in the netdev notifiers for
BCM, ISOTP and RAW sockets to ensure CAN filters are removed even when the
device's namespace changes. It also introduces tracked netdevice pointers
for BCM and converts isotp.c to use the device's namespace during
unregistration.

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8=
E@doyensec.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3d637a1e0ac1a..42851d37cc9ae 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1223,6 +1246,12 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  		op->sk =3D sk;
>  		sock_hold(sk);
>  		op->ifindex =3D ifindex;
> +		tx_dev =3D dev_get_by_index(sock_net(sk), ifindex);
> +		if (tx_dev) {
> +			op->tx_dev =3D tx_dev;
> +			netdev_hold(tx_dev, &op->tx_dev_tracker, GFP_KERNEL);
> +			dev_put(tx_dev);
> +		}
> =20
>  		/* initialize uninitialized (kzalloc) structure */
>  		hrtimer_setup(&op->timer, bcm_tx_timeout_handler, CLOCK_MONOTONIC,

[Severity: Medium]
If dev_get_by_index() returns NULL here because the interface does not exist
yet, op->tx_dev remains NULL but the timer is still armed below.

If the device is created later, bcm_can_tx() dynamically resolves it and
succeeds. However, if the device is then unregistered, bcm_notify() skips
cancelling the timer because it strictly checks op->tx_dev =3D=3D dev:

    list_for_each_entry(op, &bo->tx_ops, list)
        if (op->tx_dev =3D=3D dev) {
            hrtimer_cancel(&op->timer);
            ...
        }

Will this leave the hrtimer permanently leaked and firing indefinitely,
repeatedly failing device lookups?

[ ... ]
> @@ -1794,9 +1823,6 @@ static void bcm_notify(struct bcm_sock *bo, unsigne=
d long msg,
>  	struct bcm_op *op;
>  	int notify_enodev =3D 0;
> =20
> -	if (!net_eq(dev_net(dev), sock_net(sk)))
> -		return;
> -
>  	switch (msg) {
> =20
>  	case NETDEV_UNREGISTER:

[Severity: Medium]
Since this namespace check was removed, bcm_notify() now processes events
across all network namespaces.

For ANYDEV sockets, the code later in this function handles NETDEV_UNREGIST=
ER
like this:

    if (!op->ifindex) {
        spin_lock_bh(&op->bcm_rx_update_lock);
        if (op->if_detected =3D=3D dev->ifindex)
            op->if_detected =3D 0;
        spin_unlock_bh(&op->bcm_rx_update_lock);
    }

Because ifindexes are only unique per-namespace, deleting a CAN interface
in one namespace triggers this globally.

Can this cause an ifindex collision that spuriously clears the if_detected
state of an ANYDEV socket operating in a completely different namespace,
causing it to drop active frame assembly or mismanage timers?

[ ... ]
> @@ -2031,11 +2066,14 @@ static int bcm_connect(struct socket *sock, struc=
t sockaddr_unsized *uaddr, int
>  		}
> =20
>  		bo->ifindex =3D dev->ifindex;
> +		bo->dev =3D dev;
> +		netdev_hold(dev, &bo->dev_tracker, GFP_KERNEL);
>  		dev_put(dev);
> =20
>  	} else {
>  		/* no interface reference for ifindex =3D 0 ('any' CAN device) */
>  		bo->ifindex =3D 0;
> +		bo->dev =3D NULL;
>  	}

[Severity: High]
Does this error path leak the acquired net_device reference?

If the subsequent proc_create_net_single() allocation fails, the function
jumps to the fail label and returns without calling netdev_put():

    if (!bo->bcm_proc_read) {
        ret =3D -ENOMEM;
        goto fail;
    }

The cleanup also skips setting WRITE_ONCE(bo->bound, 1). When the socket
is later closed, bcm_release() skips the release because bo->bound is 0:

    if (bo->bound) {
        WRITE_ONCE(bo->bound, 0);
        bo->ifindex =3D 0;
        if (bo->dev) {
            netdev_put(bo->dev, &bo->dev_tracker);
            bo->dev =3D NULL;
        }
    }

Could this permanently leak the net_device and tracker, preventing the
interface from ever being cleanly unregistered?

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 155530aedce2e..0835a4758a72f 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1492,11 +1492,11 @@ static int isotp_release(struct socket *sock)
>  	 */
>  	if (so->bound && so->dev) {
>  		if (isotp_register_rxid(so))
> -			can_rx_unregister(net, so->dev, so->rxid,
> +			can_rx_unregister(dev_net(so->dev), so->dev, so->rxid,
>  					  SINGLE_MASK(so->rxid),
>  					  isotp_rcv, sk);
> =20
> -		can_rx_unregister(net, so->dev, so->txid,
> +		can_rx_unregister(dev_net(so->dev), so->dev, so->txid,
>  				  SINGLE_MASK(so->txid),
>  				  isotp_rcv_echo, sk);
>  		netdev_put(so->dev, &so->dev_tracker);

[Severity: Medium]
Does this leak the per-namespace receive list statistics in the socket's
original namespace?

If the device was moved to a different network namespace, this now passes
the new namespace (dev_net(so->dev)) to can_rx_unregister().

When can_rx_unregister() runs, it decrements the statistic in the
provided namespace:

    if (rcv_lists_stats->rcv_entries > 0)
        rcv_lists_stats->rcv_entries--;

Because can_rx_register() incremented the counter in the socket's original
namespace (sock_net(sk)), does decrementing it in the new namespace permane=
ntly
leak the count in the old one, while inappropriately decrementing the new o=
ne?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902182915.1948=
6-1-socketcan@hartkopp.net?part=3D1
