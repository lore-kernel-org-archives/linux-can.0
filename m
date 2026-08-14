Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94F384232;
	Fri, 14 Aug 2026 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699110; cv=none; b=cT24AXRTOX/ntFvmT7tLA+YP89lEUrZgwmmk9+3X1JKEYxt3TNUHbXC+mJn9J98PMwiJou+UwilBXxddTKmlw/DeGx75IZuKrMGAe8qgtqvvEiHCQlGMwTT/jXYKEKcBiINCmzVYHNEEvyR0gilYVbYPS5pOOxozx686WbzD1J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699110; c=relaxed/simple;
	bh=7H4YUhqxWdKgj5VaJ6acrxrm78zbQuKyHIfmHr1xH8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z8DuvhzHNbg0zZojspmPTfCluNWtq6LuVbs54xe2C4Kp1wQqYZCngV+Xa+Dg7UX9gs1zB7zQtXqSH+FmAbvFTiRt2b8oPuoVsM0twUxWXdQIXh1qxXuz7qouc21XBiyfZXo2AScM1zKI3XQf9NR/ZndT+SoDcRpSumcTjxkOLWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSAOKFKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSAOKFKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B3B1F000E9;
	Fri, 14 Aug 2026 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786699109;
	bh=qJx7g9k5STMKaKQLffh1wIHeqcPN0FDfsmntz9/bEhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KSAOKFKNFv1cNsIvL8cAWNrpg98ANrtIJxHAwh/k2uvXEo2f1jOgxnKYuA3WCNR/9
	 R1CtO3J4ohZ5WOYln+GW96ymR3+F7gGbXzSwvimHoVEeNqSlbbNGSPK1HdylFtE+YZ
	 hjg+r1A7GAHqoNsVLBOMvEnVopblRxpJXyQtoztutxO+LRssqUAxWUhodcy6MhOJdF
	 yVCJcoMnDRfIPqp3y+Dt/eQtYRDJW2aaPd5OJUS7ytCYGEun14l6hv8ZA/st/O04l2
	 awC5xXMdcYISQkjlIff5qdh74+fWtIShJ60B3tQwJ1ApCOnYzl1VW8aY8iM68zpadZ
	 XUJQZN5DnEQ8g==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v6 3/6] can: flexcan: split rx/tx masks per
 mailbox IRQ line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: conor+dt@kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, Frank.Li@kernel.org, devicetree@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, robh@kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, imx@lists.linux.dev, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260814090324.647898-4-ciprianmarian.costea@oss.nxp.com>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
 <20260814090324.647898-4-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 09:18:28 +0000
Message-Id: <20260814091828.C9B3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent execution of split mailbox IRQ handlers corrupts th=
e lockless `skb_irq_queue`, leading to list corruption and kernel panics.
--

--- Patch [3]: [RESEND PATCH v6 3/6] can: flexcan: split rx/tx masks per ma=
ilbox IRQ line ---
commit c6ddbabd84c6f2c763ef4c2438243c9db72c6384
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: split rx/tx masks per mailbox IRQ line

This patch introduces FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK and
FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK to split the RX/TX masks between the two
mailbox IRQ lines on S32G2 platforms. It updates flexcan_do_mb() to accept
a mb_mask parameter so each IRQ handler only processes its corresponding
mailboxes.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 7dde2e623defe..8b70952f7f05d 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c

[ ... ]

> @@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, void *d=
ev_id)
>  	struct net_device *dev =3D dev_id;
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	irqreturn_t handled;
> +	u64 mb_mask =3D ~0ULL;
> +
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> +		mb_mask =3D (irq =3D=3D priv->irq_secondary_mb) ?
> +			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
> +			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
> =20
> -	handled =3D flexcan_do_mb(dev);
> +	handled =3D flexcan_do_mb(dev, mb_mask);

[Severity: Critical]
This is a pre-existing issue and was not introduced by this patch, but is
this safe from concurrent execution? If both primary and secondary MB IRQ
lines assert simultaneously on SMP systems, different CPUs could execute
flexcan_irq_mb() concurrently.

Both handlers would call flexcan_do_mb(), which eventually calls
can_rx_offload_irq_offload_timestamp(). That offload function modifies the
shared lockless queue without synchronization:

can_rx_offload_irq_offload_timestamp() {
    ...
    __skb_queue_add_sort(&offload->skb_irq_queue, skb,
                         can_rx_offload_compare);
    ...
}

Could this concurrent lockless mutation of the doubly-linked list result
in list corruption or kernel panics when traffic arrives simultaneously for
mailboxes in both the mb-0 and mb-1 ranges?

> =20
>  	if (handled)
>  		can_rx_offload_irq_finish(&priv->offload);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814090324.6478=
98-1-ciprianmarian.costea@oss.nxp.com?part=3D3
