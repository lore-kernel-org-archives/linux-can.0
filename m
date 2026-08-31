Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F13D9DD6;
	Mon, 31 Aug 2026 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199294; cv=none; b=YOk31j9Q9bP87V57PnVIGl4HabXTNVWmBPrYcTi2hOvEje8g7tNALeDA1ZAVNLsSzcSE0dFPtqIaPE7VoTF1jGqbHUtMwZoEcwRhdGxi3V2TGHUBvYIW9DHXCjIJBoXehEjC+RxZGvZsgSooCJ08a7SYei+6zr87JWcuPuQMTeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199294; c=relaxed/simple;
	bh=GDJPhp1ce/3T7KhNfmDDHsX+QplicWRSy8Msbo0K25c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YDqnP7T3pIO45rLhoVEEHnaKh3rNQAnIxplL10/PNfQgNIFl7Q/lL2/DMd6VmsFnwbqYCuc3R6QcWsiajafEmzcu3zp/qW7sjPUOhkiHnWDJycebx+Tjn32GI46up3EId6hZHdTt7wjomwXlDVFWgdHtltNPBd2wWr6mUiovtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY6JNhlq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY6JNhlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55E61F00ACA;
	Mon, 31 Aug 2026 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199292;
	bh=H8Hdvy1jenVkD3hJGZB64SIGqV7u7k8upgn0caLEL4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TY6JNhlq6Jg5tddvsKXfiuBwomx3uZu7gpxBwBfoIUQ53J0CuNnK6nv1SMvN2F64X
	 KHpMuprfDbGCTkWkZskfmzEi8plfMmQyMjZ1FsHeYSlPo9CqoU4aix+jLADr4SIJsd
	 v3ig8T3pNXkB7kZZg5hf61yAnnqcZRSkKNHrv5zdNbIgKAM7syxtRG37i2WCzJ5EP4
	 ZcNQncZ9S5c5BvkOQIP9x5UHORLkm3LdGdqW955259wTuqA7MEkQ3bkIzPP7abAXvU
	 Z6pRY6FrRgwpjua7wE67dzicvAs7HjaWYTguqf02BcH3HKBLkUZGdZcEV6EF5hf5Gk
	 ibfrPsOFbc+Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, imx@lists.linux.dev, Frank.Li@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260831143449.12828-2-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
 <20260831143449.12828-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:01:31 +0000
Message-Id: <20260831180131.B55E61F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The split IRQ handlers fail to resolve multi-IRQ concurrency for d=
evice state processing, leading to lockless list corruption.
--

commit f3f261bafd25e44254ad99cda953074bc68ed987
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms

This commit splits the monolithic flexcan_irq handler into dedicated=20
functions for mailbox, device state, and bus error processing. The split
handlers are then registered to specific multi-IRQ lines depending on the=20
platform quirks.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503fa..2e9df2d14b341 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
[ ... ]
> +/* Process device state change events */
> +static irqreturn_t flexcan_do_state(struct net_device *dev)
> +{
[ ... ]
> +	/* state change interrupt or broken error state quirk fix is enabled */
> +	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
> +	    (priv->devtype_data.quirks &
> +	    (FLEXCAN_QUIRK_BROKEN_WERR_STATE | FLEXCAN_QUIRK_BROKEN_PERR_STATE)=
))
> +		flexcan_irq_state(dev, reg_esr);

[Severity: High]
This is a pre-existing issue, but does calling flexcan_irq_state()
concurrently corrupt the lockless SKB queue?

If the boff and err handlers execute flexcan_do_state() concurrently,
they will both allocate error SKBs and insert them into
offload->skb_irq_queue using the lockless __skb_queue_add_sort().

Can this concurrent insertion corrupt the list pointers (skb->next and
skb->prev), potentially causing infinite loops or use-after-free
conditions?

[ ... ]
> +/* Bus error IRQ handler for multi-IRQ platforms */
> +static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	irqreturn_t handled;
> +
> +	handled =3D flexcan_do_berr(dev);
> +
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_BROKEN_PERR_STATE)
> +		handled |=3D flexcan_do_state(dev);

[Severity: High]
This isn't a bug introduced by this patch, but could this multi-IRQ
setup lead to concurrent device state mutations?

On platforms like s32g2 and mcf5441x with FLEXCAN_QUIRK_NR_IRQ_3 and
FLEXCAN_QUIRK_BROKEN_PERR_STATE, a hardware bus error or state change
can trigger both the boff and berr interrupts on distinct IRQ lines.

Since flexcan_irq_berr() and flexcan_irq_boff() execute on different
CPUs, couldn't they both call flexcan_do_state(dev) at the same time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831143449.1282=
8-1-ciprianmarian.costea@oss.nxp.com?part=3D1
