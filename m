Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C738D402;
	Mon, 31 Aug 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202285; cv=none; b=TozOQGSkMwrHAMWSPZ8b5yEK7sQ1UIjLiTSXIfPEzRtsVC8xBhhFoMVTgF3/uofwBb0AXWqvBGDp9RFDRsmNrhqGT3XTVLoF/CpfoNdzCZxtvYbRO+RK6ayxXYS0Kt8keMBjCd7DEqvDQZPX14zZQrQzsDSId8AR6fvOStu3V6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202285; c=relaxed/simple;
	bh=nOJzcAf+JwTqb9EpZGc6AUW4ADlBtYQYFFENrhrSzQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6wiGNoDgIfy4Np2yqCyeQAhMjny2ch+R65I7BDYZJ6m+KV7doc+bY73FgadhhVbStEWblhvwj+Cs7g1uhYH/AhkI4Vr9rPqtKcERelj6oFMEXKrK2WfG6fZ3k16pgF66L7Vpf1ChI0nhEizljSIrTUrG2Aa9URYeQFqxppDSmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOf+v/pZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOf+v/pZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165B21F000E9;
	Mon, 31 Aug 2026 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788202283;
	bh=SrIQmO2TqJQoSY8OIPAeq5rXYbmCOjzKNqsaH0Y3k7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nOf+v/pZSQOTzM/iyaXT8p37+ONPFponvLkLNgiT+VFDdrEJZflGnobUS89X9PsZB
	 xDxshAHz5dk/4e4eHpMISNfNMo3s8+oZp5WpA4Rmd4oOlJ7Zno1w6Zkx/5Vjg/uLY6
	 kn2jXRX2Z2sWGjzx87HPkjQnYBKqgwlU58QaiNJ2XTionBSgZB2Wa5KqX6pZxSHw3V
	 fb8L7yCsIKLs3Ewxm044B5SrJBeahWo2wVzkNhi2X4gPe8E25WTnJPWsA1uHL19HGf
	 0LO204EpjICNXtddHNVbeeMiOTiwmRMBVU9Gh/UTN9g3wwZBRZfJEfKr+XPF+A+qxb
	 h9sRUb32sASxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, Frank.Li@kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260831143449.12828-6-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
 <20260831143449.12828-6-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:51:22 +0000
Message-Id: <20260831185123.165B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Wakeup interrupt is not configured for the new dedicated ESR IRQ=
 during suspend.

Pre-existing issues:
- [Critical] Concurrent execution of separate IRQ handlers corrupts the loc=
kless rx-offload SKB queue.
--

commit 53e92dd64634f7bc681782eddd379791f6533960
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk

This commit introduces the FLEXCAN_QUIRK_IRQ_BERR quirk for platforms where=
 bus
errors and state changes share a dedicated IRQ line. It adds a combined IRQ
handler flexcan_irq_esr() and updates interrupt setup and teardown to manage
the new line.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f28ff0e95b74f..601d88bfcfeb2 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c

[ ... ]

> @@ -1303,6 +1303,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void =
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
> +
> +	return handled;
> +}

[Severity: Critical]
This is a pre-existing issue, but adding this separate IRQ handler highligh=
ts
a race condition. Can this new handler and the main mailbox IRQ handler
execute concurrently on different CPUs?

If dev->irq and priv->irq_err are dispatched to different CPUs simultaneous=
ly,
both handlers can call into the Rx offload functions in rx-offload.c. For
example:

CPU1 (in flexcan_irq_mb):
  can_rx_offload_irq_offload_timestamp()
    __skb_queue_add_sort(&offload->skb_irq_queue, ...)

CPU2 (in flexcan_irq_esr):
  handled |=3D flexcan_do_berr(dev);
    flexcan_irq_bus_err()
      can_rx_offload_queue_timestamp()
        __skb_queue_add_sort(&offload->skb_irq_queue, ...)

Since the Rx offload queue manipulation in __skb_queue_add_sort() is lockle=
ss,
could this concurrent execution corrupt the skb_irq_queue list and crash the
kernel? Similarly, both paths call can_rx_offload_irq_finish() which splices
the queue locklessly from the IRQ queue side without adequate mutual exclus=
ion
against other HardIRQs.

[ ... ]

> @@ -1905,6 +1922,13 @@ static int flexcan_open(struct net_device *dev)
>  			goto out_free_irq_boff;
>  	}
> =20
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_IRQ_BERR) {
> +		err =3D request_irq(priv->irq_err,
> +				  flexcan_irq_esr, IRQF_SHARED, dev->name, dev);
> +		if (err)
> +			goto out_free_irq_boff;
> +	}
> +

[Severity: Medium]
Since this quirk routes the wakeup event (WAK_INT) to this new dedicated ESR
IRQ line, should priv->irq_err be configured for wakeup during suspend?

Currently, flexcan_suspend() calls enable_irq_wake(dev->irq), but it does
not arm priv->irq_err. Will the system fail to wake up from sleep upon CAN
activity on platforms using this quirk because the interrupt controller isn=
't
armed for the correct line?

Should flexcan_suspend() and flexcan_resume() be updated to handle
priv->irq_err as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831143449.1282=
8-1-ciprianmarian.costea@oss.nxp.com?part=3D5
