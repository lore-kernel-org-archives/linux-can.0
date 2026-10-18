Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583E2D5436;
	Sun, 18 Oct 2026 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792286538; cv=none; b=Y0jWr+79j7UJESYEVHB/lgPyNY8LMA3o3oLvBV1Q81/zdKcjP1WqOdouzOWPrWJAvCeGBeyZODpgEc1A3F23YdB88LCSk7FNYqFfHg17Rq9QNe64Jkmk6hvRH3v4zzhB/0emigufE/hcLGYRW7xCsvnHg+LPcOQDfysYkzYy6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792286538; c=relaxed/simple;
	bh=XhexNEgETB4kXOMwMoUg24sDNbqfeADoCZGm0EPDurE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+Zv79iprM52+X8pvk23kxhB+Kb+D7UC/UE/0qFJDqkMUVQmUYsn/NnAoi8U7CbWUEs5cwJgMZl/yBiiThGTFi4NR5OpItVOABW/RIgP8QbFr9CpxA2XCs+CdGDZq94bnlr5hCRbMMWEGi5W+W3zGtSUInilaVugdpLR8lQDqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q//I5FQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q//I5FQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F74A1F000C5;
	Sun, 18 Oct 2026 01:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792286537;
	bh=M53PMwFpTB0OGisdlvnYwV3+CQAncQbW9tNlntg8hV8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q//I5FQZen1TJNIXlJq/IhrgBN+Y1tVmdhITXDKZKCaH0d6Gx+Wv0vc134kMnSZJd
	 wT3NwTqBI3Nw8KrRoByOyftpOMurUpRjAgZLfRezJ8NhcVODhggDL3OPi14fkGh+lP
	 sodJjqMIzhvZ8pk3E5Yee7MmsPhNiF5MwUYLGQpVl6D4i28URp5pPHWidXB8R3cJ2L
	 lZHrw7nv6H8YVcCpJN2txwBOi9Iv46ZkAkkwcnIV17pL895rtd2nM1XV1HhLLCR5Bk
	 rT4WOFHwUP8B/8I38IZNgN/l3z5SYqruZM/3QIuzQ7wfrhCYB4Dr51xwGHXzTTVGRF
	 dBcAMhxn6HbXQ==
Subject: Re: [PATCH v2 2/2] can: tcan4x5x: Add suspend error handling
From: netdev-bot+sashiko@kernel.org
To: msp@baylibre.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, sean@geanix.com, martin@geanix.com,
 k-willis@ti.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org
Date: Sun, 18 Oct 2026 01:22:16 +0000
Message-ID: <179228653606.3131.9842377725532740946@kernel.org>
In-Reply-To:
 <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-2-7efa2b172cce@baylibre.com>
References:
 <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-2-7efa2b172cce@baylibre.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The Fixes: tag points at the wrong commit.
- [Low] tcan4x5x_suspend() ignores the return value of
  enable_irq_wake(spi->irq).

--

can: tcan4x5x: Add suspend error handling

This patch adds an error path to tcan4x5x_suspend(). When
m_can_class_suspend() fails, the wake IRQ armed by enable_irq_wake() is
released with disable_irq_wake() before the error is returned.

> Fixes: b6b640c04446 ("can: tcan4x5x: support resuming from rx interrupt signal")

[Severity: Low]

Is this the right commit for the Fixes tag?

At b6b640c04446, m_can_class_suspend() ends with an unconditional
"return 0;". The new err_disable_irq path in tcan4x5x_suspend() could
never run against that version.

m_can_class_suspend() first became able to fail in ad1ddb3bfb0c ("can:
m_can: call deinit/init callback when going into suspend/resume"). That
commit added:

    ret = cdev->ops->deinit(cdev);

and changed the final statement to "return ret;". tcan4x5x is the only
m_can driver that sets .deinit (.deinit = tcan4x5x_deinit).

The previous patch in this series, "can: m_can: Fix suspend deinit()
error path", already uses Fixes: ad1ddb3bfb0c. With different tags,
stable tooling could pick this patch for trees that have b6b640c04446
but not ad1ddb3bfb0c. In those trees the new branch is dead code, and the
companion patch would not be picked.

Should this be Fixes: ad1ddb3bfb0c ("can: m_can: call deinit/init
callback when going into suspend/resume") instead?

Also, the commit message says "restore the previous state". Could it say
that the state being restored is only the enable_irq_wake() reference?

> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> index a5b8829aa5193..b69312413d627 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -575,11 +575,20 @@ static int __maybe_unused tcan4x5x_suspend(struct device *dev)
>  {
>  	struct m_can_classdev *cdev = dev_get_drvdata(dev);
>  	struct spi_device *spi = to_spi_device(dev);
> +	int ret;
>  
>  	if (cdev->pm_wake_source)
>  		enable_irq_wake(spi->irq);
>  
> -	return m_can_class_suspend(dev);
> +	ret = m_can_class_suspend(dev);
> +	if (ret)
> +		goto err_disable_irq;
> +	return 0;
> +
> +err_disable_irq:
> +	if (cdev->pm_wake_source)
> +		disable_irq_wake(spi->irq);
> +	return ret;

[Severity: Low]

Can this disable_irq_wake() be unbalanced against the enable_irq_wake()
above it?

The return value of enable_irq_wake(spi->irq) is ignored. Suppose the
parent irqchip has no irq_set_wake callback and does not set
IRQCHIP_SKIP_SET_WAKE. Then set_irq_wake_real() returns -ENXIO, and
irq_set_irq_wake() resets the depth:

kernel/irq/manage.c:irq_set_irq_wake() {
    ...
		if (desc->wake_depth++ == 0) {
			ret = set_irq_wake_real(irq, on);
			if (ret)
				desc->wake_depth = 0;
    ...
}

m_can_class_suspend() can then also fail, for example when an SPI access
in tcan4x5x_deinit() fails. In that case this error path calls
disable_irq_wake() with wake_depth == 0, which hits:

			if (desc->wake_depth == 0) {
				WARN(1, "Unbalanced IRQ %d wake disable\n", irq);

So the rollback drops a wake reference that was never taken.

Ignoring the enable failure has a second effect. Suspend carries on with
the chip in RX-wake mode even though the SoC IRQ line was never armed as
a wake source.

tcan4x5x_resume() already calls disable_irq_wake() unconditionally, so
the pattern is older than this patch. This patch copies it into the new
rollback path.

Would it work to record whether enable_irq_wake() succeeded, or to
return its error before calling m_can_class_suspend()? Then
disable_irq_wake() would only be called when the wake reference was
actually taken.

>  }
>  
>  static int __maybe_unused tcan4x5x_resume(struct device *dev)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce%40baylibre.com
