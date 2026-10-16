Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A6302767
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145114; cv=none; b=iBEW+RaKa+/lzM8vty+k5TbWkHg5Wo67/QxCjhCRJO+ANr2lA3MOhz8BRhS+Cqfb3C44wPpZAPu1mb5LeC/OfrfG08zDOH0IwLsoOJU3bF0/blvduCSWVKfK4IWPNwkHt6DV/V26mSLte7YYneUZ7GPqlmARnUhM/b4j5rAP5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145114; c=relaxed/simple;
	bh=UKK8Tu+iEyCCLUJfuroyYqUQFXt9gboiZ5dyi3IDo0k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ImExoBENHNnwSywtBxx02kQjRSo19FZ0IUx/VP7iJfrggGcJe2WX1L3B3F3OT4tnVtOHHad/iuj1Voq+cj8gP2uDd049IzJE1JGH8epZ/Hql8+znAnWwz23flMyC9wgNeqJeLOeXS9vcIdPj4ipbZYOmwmhaSDmOJSWdylHN9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVdve5Jw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVdve5Jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583941F000C5;
	Fri, 16 Oct 2026 10:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145112;
	bh=3PNTe9H7bmV9i6UJsb8NussElv+zuZcDd8oG/GSpan0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jVdve5Jwy+kJUYiQiLLDaIsqoud9E2+pXcrT38SZ+bwEvYcmff2UXqzZnGgY9DeCc
	 yOquovGql/WFhqS1bmNQVSRTu5h1tIZYWfmvekPZW6KsoOnhjIYC+/e5Ubg0+cOZ2t
	 FJ8ZbWl6pauZV8OhcqK+dh48+W79NoN6aftw7mX2aMvzCUtuKqlyVvhghRUPVrzWAw
	 2HRXobP/9Z3XS+yFoq/HOjF+9shqwbQ6rxWMWlqNMGu0e69yaRnzWoBnPhy0WS9Vp2
	 VFNgOBBaygbIc1udoDHYbNAZ97aOpJGiIK1IbRz9U51s4L7OKnl6FudThtNN5j5SEz
	 iN4OcPZ4RKgjw==
Message-ID: <sashiko-outbox-174121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] can: tcan4x5x: Add suspend error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Schneider-Pargmann" <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-2-7efa2b172cce@baylibre.com>
References: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com>
 <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-2-7efa2b172cce@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:05:11 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] irq: unbalanced IRQ wake disable on suspend error path
--

commit 35cb9abaa9dd12aabf550562b5fe36f26129d629
Author: Markus Schneider-Pargmann <msp@baylibre.com>

can: tcan4x5x: Add suspend error handling

This commit adds error handling to tcan4x5x_suspend() by checking the
return value of m_can_class_suspend(). If the suspend fails, it restores
the IRQ wake state before returning the error.

> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index a5b8829aa5193..b69312413d627 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -575,11 +575,20 @@ static int __maybe_unused tcan4x5x_suspend(struct d=
evice *dev)
>  {
>  	struct m_can_classdev *cdev =3D dev_get_drvdata(dev);
>  	struct spi_device *spi =3D to_spi_device(dev);
> +	int ret;
> =20
>  	if (cdev->pm_wake_source)
>  		enable_irq_wake(spi->irq);
> =20
> -	return m_can_class_suspend(dev);
> +	ret =3D m_can_class_suspend(dev);
> +	if (ret)
> +		goto err_disable_irq;
> +	return 0;
> +
> +err_disable_irq:
> +	if (cdev->pm_wake_source)
> +		disable_irq_wake(spi->irq);

[Severity: Low]
Will this trigger an unbalanced IRQ wake disable warning if
enable_irq_wake() fails?

The original code calls enable_irq_wake() but ignores its return value.
If the underlying IRQ controller does not support wake settings (e.g.
returning -ENXIO), wake_depth is not incremented.

If m_can_class_suspend() subsequently fails, the new error path calls
disable_irq_wake() unconditionally.  If enable_irq_wake() had previously
failed, wouldn't this underflow wake_depth and trigger a WARN from the IRQ
core?

Could we check the return value of enable_irq_wake() and only call
disable_irq_wake() if it actually succeeded?

> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-v7-3-topic=
-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com?part=3D2
