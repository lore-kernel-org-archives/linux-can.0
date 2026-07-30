Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43193AF660
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392758; cv=none; b=LUIBVQXwzsfC9ja75d887XywYyQMU994G+Gpb9Z7hbeEoE4/UeuGxOD8BSpvW74LE/PIJ3H309YpfB1MB9EfRGDSNXmfaLJ++oHWhaEcELyb66fTt0SvUlkU8ZBxWysSHA0PyYIZx9xvl+aUuplc1ngdwXXHDFLtJVcED6RV2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392758; c=relaxed/simple;
	bh=52ehOqQTTcW2K3sJO7YbebhMqCwgQ6SjwmFxr4ITIyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=swU0Agobf8Ch0kMBBu/Es63BXzLT07f3RslV+PkqiUAPEbugNErw7zsquvH7lDjf4J5Jb9MTWb3lKobo7grKJHNpnaM6TvJ+fSwazGyZrcL63Eu5Klgg4G5RIAJQFJR9BTdk6B4iLgwF21Hsmb+QrJHEiZ1hFLsz7MWZ23T1p/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRaRX2gw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRaRX2gw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32E31F000E9;
	Thu, 30 Jul 2026 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785392756;
	bh=ITFMDokrhlt4AknnvFXpUWua2q1mjG/w4z/zcFLd2rU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CRaRX2gwrFIRkLM+4/LDa6KqRFTwNjm8QdWpIwiqLw//m80vmHLQhOg+yN02VDP77
	 q1e1PF4PKut8E3YuEq/u5GHTEKbCd4yGyoCz4vwIF6uYWZ7V1Q+734j7zDMg3ufaOm
	 nt4S2TQx9kSo8uPCk4hyRJkX5xhv236OdHXRX6PFFedhOENXHS7yHPrUA8OtpmJzeH
	 7UBfWp7Jb5HnSu2k3D87PkdUiiY7mNiAqDtJjItge3ugV0ixluF6b9xGiMGYBrPsGC
	 2R5iacD41gCWDhYtzuHZyDi3HNbY8Cy0EEKWe8czNXdy9KiTuHOXpI7zogqXANORB9
	 k8Ic65F/SZp2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] can: rockchip_canfd: prevent TX stall on echo skb
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <tencent_D2D30ECD988C5C82D18863401362835F7606@qq.com>
References: <20260730-master-v1-0-6945fdd4f0ff@qq.com>
 <tencent_D2D30ECD988C5C82D18863401362835F7606@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 06:25:55 +0000
Message-Id: <20260730062555.D32E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent access to `echo_skb` in `rkcanfd_tx_tail_is_eff()` with=
out locking leads to a Use-After-Free when the IRQ handler frees the SKB.
--

--- Patch [1]: [PATCH 1/3] can: rockchip_canfd: prevent TX stall on echo sk=
b failure ---
commit dae5727dde941410ecb97f7ed728561d5c939a22
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: prevent TX stall on echo skb failure

rkcanfd_start_xmit() advances tx_head and requests transmission even when
can_put_echo_skb() fails. This creates a pending TX entry without the echo
skb that the RXSTX completion path needs to match the self-received frame.
The entry cannot be completed, and the netdev TX queue can remain stopped
after the two-entry software FIFO fills.

Do not advance tx_head or request transmission if the echo skb cannot be
installed. Account the frame as dropped and report the error. The
-ENOMEM and -EBUSY paths have already consumed the skb; explicitly free
it on -EINVAL, where ownership remains with the caller.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index 12200dcfd3389..d2cbe25c46d6c 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> @@ -125,8 +125,18 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, =
struct net_device *ndev)
> =20
>  	frame_len =3D can_skb_get_frame_len(skb);
>  	err =3D can_put_echo_skb(skb, ndev, tx_head, frame_len);
> -	if (!err)
> -		netdev_sent_queue(priv->ndev, frame_len);
> +	if (err) {
> +		if (err =3D=3D -EINVAL)
> +			dev_kfree_skb_any(skb);
> +
> +		ndev->stats.tx_dropped++;
> +		if (net_ratelimit())
> +			netdev_err(ndev, "%s: failed to put echo skb: %pe\n",
> +				   __func__, ERR_PTR(err));
> +
> +		return NETDEV_TX_OK;
> +	}
> +	netdev_sent_queue(priv->ndev, frame_len);

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
related to echo_skb accesses in rkcanfd_tx_tail_is_eff() when called from
rkcanfd_start_xmit() via rkcanfd_get_effective_tx_free().

Does rkcanfd_tx_tail_is_eff() need locking to safely access echo_skb?

drivers/net/can/rockchip/rockchip_canfd-tx.c:rkcanfd_tx_tail_is_eff() {
    ...
	tx_tail =3D rkcanfd_get_tx_tail(priv);
	skb =3D priv->can.echo_skb[tx_tail];
	if (!skb) {
        ...
	}

	cfd =3D (struct canfd_frame *)skb->data;
    ...
}

If a concurrent TX completion interrupt on another CPU executes
rkcanfd_rxstx_filter() and rkcanfd_handle_tx_done_one(), wouldn't it
consume this same SKB and set echo_skb[tx_tail] to NULL?

If the SKB is then queued to the NAPI offload subsystem and immediately
processed and freed on the remote CPU, could the original thread continue
and dereference the now-freed SKB when accessing skb->data?

> =20
>  	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v1-=
0-6945fdd4f0ff@qq.com?part=3D1
