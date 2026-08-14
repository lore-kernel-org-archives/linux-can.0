Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9EE3446AD;
	Fri, 14 Aug 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699061; cv=none; b=NmVa/I1DbvZlJNWoD+/oTJlr9R7/3bS18D4GRWhLn9ygqLOe5o3Pp/hXt2W2HWqiUPIFpWR8UU9WFIsFjWNqlMgV7m1bXzQ+D1K0LWcz8TTY8I8DjLvSUrfPQjsgyLAAg9FuCWCwMQuNC0xoAxQL9MkrO7zkHT/cowoCkKd7blk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699061; c=relaxed/simple;
	bh=HYsIfYMksrHbnk4yrzCQP2nm5JZn2RFwx/dVBsdwbWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BQrfgsL3jhmn8NiMhmEH/QGTCi4F0gSI07w7sYVHRzoqsd17l6qWtuTLfmYtaBgv0Ptc7fwrdpnDMXMXPK2eg2rqEUsapZraZzaUIOy+0g4CHxEvMnYQGB2rtnrmF9teXWqU227fZrUv+r8yYuXYHHJStnaVY4xpQKwEU7/9WxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq1yBq94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq1yBq94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675C81F000E9;
	Fri, 14 Aug 2026 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786699060;
	bh=iwaSN8Ids8LBqxBuWuKfjw/bjSW/uj/KrVGQPUZ9EsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kq1yBq94yHWBWkl06ZcSuoOzY+7JTWx6AFPvgyO054l0iG7wzP3eTWTNYQsK9RInA
	 9OUjUrvRxx3HuqjZb8Z7V55guBPGwPa0uSLycvqEr3hxhjJelWy78FbUy/o3hQsH66
	 Qp5OxzmDOhe7wTh4io/W2ehpHG8iiWHJumO07XTzMr6bEXs6ntpDVP1qrQPYwXEwe+
	 i3nHFe/YTGDkdi5w0bEp9Qv9bNZISaDfBcF6qg/Oh42vkWzFWH8TYk2yYLzE5R6Fln
	 +iWshmiytUgkeQTSbxiNV9JCU5m3JctGcjPva2Syu8FebN1cc7Kt5mGiJlJQHpm3Y1
	 ltDcat/pM9/Qg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v6 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR
 quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: conor+dt@kernel.org, Frank.Li@kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, linux-can@vger.kernel.org
In-Reply-To: <20260814090324.647898-6-ciprianmarian.costea@oss.nxp.com>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
 <20260814090324.647898-6-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 09:17:35 +0000
Message-Id: <20260814091739.675C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent multi-IRQ execution corrupts `can_rx_offload` lockless =
SKB queues.
- [High] Wake-on-CAN is broken on multi-IRQ platforms because `enable_irq_w=
ake` is not called for the dedicated state/error IRQ line.
--

--- Patch [5]: [RESEND PATCH v6 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BE=
RR quirk ---
commit ec638df99febf4382988e54906857f08c9de34b2
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
   =20
This commit introduces the FLEXCAN_QUIRK_IRQ_BERR quirk for platforms with a
dedicated IRQ line for bus errors and state changes. It adds the
flexcan_irq_esr() handler for these events and updates interrupt enable and
disable paths to handle the new IRQ line. The change is required for NXP
S32N79 SoC support.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 8b70952f7f05d..e7e3fb41f55e7 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1300,6 +1300,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void =
*dev_id)
>  	return handled;
>  }
> =20
> +/* Combined bus error and state change IRQ handler */
> +static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	irqreturn_t handled;
> +
> +	handled =3D flexcan_do_state(dev);
> +	handled |=3D flexcan_do_berr(dev);
> +
> +	if (handled)
> +		can_rx_offload_irq_finish(&priv->offload);

[Severity: High]
This is a pre-existing issue, but does the concurrent execution of multiple
IRQ handlers corrupt the lockless SKB queues?

In an SMP system, if flexcan_irq_mb() (processing a mailbox message) and
flexcan_irq_esr() (processing a bus error) execute concurrently on different
CPUs, they will both push to the same lockless offload queue.

Since the can_rx_offload framework relies on the implicit synchronization
of a single IRQ line, executing these handlers on distinct IRQs could
cause simultaneous lockless modifications to offload->skb_irq_queue, leading
to linked list corruption.

> +
> +	return handled;
> +}

[ ... ]

> @@ -1902,6 +1919,13 @@ static int flexcan_open(struct net_device *dev)
>  			goto out_free_irq_boff;
>  	}
> =20
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
> +		err =3D request_irq(priv->irq_err,
> +				  flexcan_irq_esr, IRQF_SHARED, dev->name, dev);

[Severity: High]
This isn't a bug introduced by this patch, but does Wake-on-CAN fail to wake
the system on multi-IRQ platforms?

Looking at flexcan_suspend(), it only arms the primary mailbox IRQ for wake=
up:

drivers/net/can/flexcan/flexcan-core.c:flexcan_suspend() {
    ...
    if (device_may_wakeup(device)) {
        enable_irq_wake(dev->irq);
        err =3D flexcan_enter_stop_mode(priv);
    ...
}

However, wake events (FLEXCAN_ESR_WAK_INT) are processed by
flexcan_do_state(), which is routed through this dedicated state/error IRQ
line (priv->irq_err). Because enable_irq_wake() is not called on the
secondary IRQ lines, will the interrupt controller ignore the wakeup signal?

> +		if (err)
> +			goto out_free_irq_boff;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814090324.6478=
98-1-ciprianmarian.costea@oss.nxp.com?part=3D5
