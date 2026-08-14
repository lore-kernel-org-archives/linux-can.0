Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56E356770;
	Fri, 14 Aug 2026 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699232; cv=none; b=MWtqz3JtMoGs9REJL77sAXQhTSjpu9ordCxxQ1qvTTA1f4LKIztDop4v9YcWpI1jC2GsMmJILm30YDpH3tKZDmqHznD0eyCw/R5lFyEwulnpbX6W1FsOFkvCgIQZRBOIyRYCO0N4mkWRByOGnl5UZsXR/6OQf6KpYV044n4cAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699232; c=relaxed/simple;
	bh=vTzoFK6spLrza3SQdkn3dlPSpUTmPius0uMwro2rkTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WBMrjJVEaXOYDJfKw/ePg+6dVWtjVGEjv34hVHBHFEIyyIdSIvit7+kW4dU/ZXaTZxRJzfMZTDNoqfurR5QsaoWnH+gNtkSkug9kO1SsF8dN0/VcVL0JCkrQzn/Vs0FTXtVp042Fe4wXVQqvLDXO99/0+sFzeLOKfW1SxlsOp/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYzxWvNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYzxWvNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BA51F000E9;
	Fri, 14 Aug 2026 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786699231;
	bh=LdFQrpkbrPrJWAVU/s+iyDwuA+i85QuNZOUH4St6I+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYzxWvNyvOwxbjqiCtoL8aQ/1z/pmvAh23NH925C/ayDR0062l4jBNWQ9zY9Kl3uy
	 yW3w5+r0vlfeqwtVKyP1nreftqvx01wG0RR2jsK37Ik0g4p/UWIvKhLsR+jJA8bXcI
	 9+yH6fvLT7kNWqch9Stk+Vr/6o0KxEPErJGT07ksa665i6I/OKtVveYJvU1WgIZ6jF
	 KL/A8hBtoDMwGSSRQDbQTsqGHVwzQ/FeYps/xNhyvzombxwWFVtQi6gqqAqynedICQ
	 XhC/Grxm51tkTd0vqXdCRjLi4bI0RbjCuN8pnsu4waKG0Y4wUaal8l2hErBiRlYFEF
	 wowOjce3VJFZw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers
 for multi-IRQ platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: imx@lists.linux.dev, "Oliver Hartkopp" <socketcan@hartkopp.net>, robh@kernel.org, Frank.Li@kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260814090324.647898-2-ciprianmarian.costea@oss.nxp.com>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
 <20260814090324.647898-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 09:20:27 +0000
Message-Id: <20260814092027.86BA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The split IRQ handlers break the FLEXCAN_QUIRK_BROKEN_PERR_STATE w=
orkaround on multi-IRQ platforms.

Pre-existing issues:
- [Critical] Concurrent execution of split IRQ handlers locklessly corrupts=
 the shared `skb_irq_queue`.
- [High] The patch fails to fix duplicate frame processing for platforms wi=
th multiple mailbox IRQs.
--

--- Patch [1]: [RESEND PATCH v6 1/6] can: flexcan: use dedicated IRQ handle=
rs for multi-IRQ platforms ---
commit 4696683063946bcc95216f931b7fa509b55610f8
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Date:   Fri Aug 14 09:03:18 2026 +0000

    can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms

This commit splits the monolithic flexcan IRQ handler into dedicated
handlers for mailbox, bus error, and state change events. This is intended
to prevent duplicate frame processing on multi-IRQ platforms where distinct
IRQ lines can dispatch concurrently.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503fa..f73ff442d5304 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
[ ... ]
> @@ -1131,25 +1129,57 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>  		netif_wake_queue(dev);
>  	}
> =20
> +	return handled;
> +}
> +
> +/* Process bus error events */
> +static irqreturn_t flexcan_do_berr(struct net_device *dev)
> +{
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	irqreturn_t handled =3D IRQ_NONE;
> +	u32 reg_esr;
> +
>  	reg_esr =3D priv->read(&regs->esr);
> =20
> -	/* ACK all bus error, state change and wake IRQ sources */
> -	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
> +	/* ACK bus error interrupt source */
> +	if (reg_esr & FLEXCAN_ESR_ERR_INT) {
>  		handled =3D IRQ_HANDLED;
> -		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &re=
gs->esr);
> +		priv->write(FLEXCAN_ESR_ERR_INT, &regs->esr);
>  	}
> =20
> -	/* state change interrupt or broken error state quirk fix is enabled */
> -	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> -	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
> -					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
> -		flexcan_irq_state(dev, reg_esr);
> -
>  	/* bus error IRQ - handle if bus error reporting is activated */
>  	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
>  	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>  		flexcan_irq_bus_err(dev, reg_esr);
> =20
> +	return handled;
> +}

[Severity: High]
Does this break the FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround?

Before this patch, the monolithic flexcan_irq() checked this quirk and call=
ed
flexcan_irq_state() on any interrupt.

The FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround relies on enabling the bus e=
rror
interrupt to catch state changes on platforms where the state interrupt is
broken.

Now that the bus error interrupt is routed exclusively to flexcan_do_berr(),
which never invokes flexcan_irq_state(), won't state transitions (like bus
warning or bus-off) be silently ignored on affected platforms?

[ ... ]
> +/* Mailbox IRQ handler for multi-IRQ platforms */
> +static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	irqreturn_t handled;
> +
> +	handled =3D flexcan_do_mb(dev);

[Severity: High]
This is a pre-existing issue, but does this still allow duplicate frame
processing?

If a platform has a secondary mailbox IRQ (FLEXCAN_QUIRK_SECONDARY_MB_IRQ),
flexcan_open() registers flexcan_irq_mb() for the secondary IRQ, and the
primary IRQ registers either flexcan_irq() or flexcan_irq_mb().

Because these can run concurrently on different CPUs, and flexcan_do_mb()
unconditionally processes all active mailboxes globally, won't both threads
still race and process the same frames?

> +
> +	if (handled)
> +		can_rx_offload_irq_finish(&priv->offload);

[Severity: Critical]
This is a pre-existing issue, but does splitting the IRQ handlers make
skb_irq_queue vulnerable to lockless corruption?

When flexcan_irq_mb(), flexcan_irq_boff(), and flexcan_irq_berr() run
concurrently on different CPUs, they can independently call the can_rx_offl=
oad
API (like can_rx_offload_irq_offload_timestamp() and
can_rx_offload_queue_timestamp()).

These functions insert SKBs into offload->skb_irq_queue using the lockless
__skb_queue_add_sort().

Additionally, they concurrently call can_rx_offload_irq_finish(), which
splices the list locklessly:

drivers/net/can/dev/rx-offload.c:can_rx_offload_irq_finish() {
    ...
    spin_lock_irqsave(&offload->skb_queue.lock, flags);
    skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue=
);
    spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
    ...
}

Will this concurrent lockless access corrupt the skb->next / skb->prev poin=
ters
leading to a kernel panic?

> +
> +	return handled;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814090324.6478=
98-1-ciprianmarian.costea@oss.nxp.com?part=3D1
