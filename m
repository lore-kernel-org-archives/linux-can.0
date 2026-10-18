Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6428640B;
	Sun, 18 Oct 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792286537; cv=none; b=awg/ojmrxiB8TD+jfeBLBbATXasJ6ncfWb/jeBN9FvmNcETCn0HL9d4f9yLiguii8YOUxwD15hXonWuy36D+5gkJB9ZDgWphVpefT5pyikTQcklyrZxlOtqZq0N6q0Uf0xecFCY/hhrnrGdwbFgabRKeWg+zv7C3H9GomfiXBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792286537; c=relaxed/simple;
	bh=PwV19XQ4L+OsrR7+HRk7ELF800kgOKCoUeUucoGVBu8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+nVt0jkbglywPUbLOoCiY2N9i6ZMSfGs29KeKPwOkVBAouIWLwA59yxMvUuNSKU9NEYcyiJ+vGNXGaDgKBlLoUEINVWzMT0Qr//BDjX6cpV53dR6dPR5V8AeGiulyzxBzCnaHMjJXaHvENGHaWVPF0k4JDg/LtnWknWmqSQYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aN1zOBsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN1zOBsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EEE1F000C4;
	Sun, 18 Oct 2026 01:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792286535;
	bh=AiFrVKHpqADre5cPbWmBmIMVC/7CpWC740YrgCEvAu4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aN1zOBsITJ0tnLxM4FmRevh4PdnnqXmkL20a08IfhfzhF7IcivZ0RHC2PuJQONgeg
	 vHDVe+ZaIPOQ6JKBeri/85vNjnKKcuOEKYd4LV+vBNFU2iEa/x64LhO23Ie97CQm01
	 qKefcKPBRT/GLsb2fnNRcKz6kqETlWaZz2hv2rBx88PCiWwS6IJsVrp8Ttt1X+AYJb
	 NWX8g8nrcAKQ1nY5qEgUECDJbJ1LthpES0Q6um+UXYy/Hm6W3UbiO5rmyBxG/RiDte
	 NMgZZybQwOC6INT3P3CThaz0n5yt9OlMZoXoOt/cttfXxnS3dbscY2dxRtDzGr6PP+
	 ZxmWib1rMyjRA==
Subject: Re: [PATCH v2 1/2] can: m_can: Fix suspend deinit() error path
From: netdev-bot+sashiko@kernel.org
To: msp@baylibre.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, sean@geanix.com, martin@geanix.com,
 k-willis@ti.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org
Date: Sun, 18 Oct 2026 01:22:14 +0000
Message-ID: <179228653488.3131.4873060589631781242@kernel.org>
In-Reply-To:
 <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-1-7efa2b172cce@baylibre.com>
References:
 <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-1-7efa2b172cce@baylibre.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new err_pm_wake_source restore path in
  m_can_class_suspend() (drivers/net/can/m_can/m_can.c:2638-2645) has no…
- [Medium] The new error path in m_can_class_suspend() restores M_CAN_IE
  and the coalescing hrtimer, reattaches the netdev and restarts the TX…

Pre-existing issues:
- [Low] Unbalanced enable_irq_wake() when suspend fails.

--

can: m_can: Fix suspend deinit() error path

This patch handles a failure of the deinit() callback in
m_can_class_suspend() when the device is a wake source. On failure it
writes the cached interrupt enable mask back to M_CAN_IE and restarts the
coalescing hrtimer if coalescing was active. It then reattaches the netdev
and restarts the TX queue.

> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 16f80607e150e..02a95a769a784 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2612,8 +2612,14 @@ int m_can_class_suspend(struct device *dev)
>  			hrtimer_cancel(&cdev->hrtimer);
>  			m_can_write(cdev, M_CAN_IE, IR_RF0N);
>  
> -			if (cdev->ops->deinit)
> +			if (cdev->ops->deinit) {
>  				ret = cdev->ops->deinit(cdev);
> +				if (ret) {
> +					netdev_err(cdev->net, "failed to deinit device while suspending %pe\n",
> +						   ERR_PTR(ret));
> +					goto err_pm_wake_source;
> +				}
> +			}
>  		} else {
>  			m_can_stop(ndev);
>  		}

[ ... ]

> +	return 0;
> +
> +err_pm_wake_source:
> +	if (netif_running(ndev)) {
> +		if (cdev->pm_wake_source) {
> +			bool coalescing_active = (cdev->active_interrupts & (IR_RF0N | IR_TEFN))
> +						 != (IR_RF0N | IR_TEFN);
> +			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
> +			if (coalescing_active)
> +				hrtimer_start(&cdev->hrtimer,
> +					      cdev->irq_timer_wait,
> +					      HRTIMER_MODE_REL);

[Severity: Medium]
Can this restore race with the threaded IRQ handler?

The forward path leaves M_CAN_IE set to IR_RF0N, and the IRQ is still live
during ->suspend. In that state m_can_coalescing_update() does a lockless
read-modify-write of the same cache, the same register and the same
hrtimer:

m_can_coalescing_update() {
	u32 new_interrupts = cdev->active_interrupts;
	...
	if (!enable_rx_timer && !hrtimer_active(&cdev->hrtimer))
		new_interrupts |= IR_RF0N;
	if (!enable_tx_timer && !hrtimer_active(&cdev->hrtimer))
		new_interrupts |= IR_TEFN;

	m_can_interrupt_enable(cdev, new_interrupts);
	...
}

With the tcan4x5x SPI regmap, one possible interleaving is:

suspend error path                  IRQ thread
reads active_interrupts (A_old,
  RF0N/TEFN cleared)
m_can_write(IE, A_old) waits on
  the regmap lock
                                    m_can_coalescing_update()
                                      timer was cancelled, so
                                      RF0N/TEFN are ORed in (A_new)
                                      writes IE = A_new
                                      active_interrupts = A_new
m_can_write(IE, A_old) completes

After this, the hardware masks RF0N or TEFN, but the cache says they are
enabled. m_can_interrupt_enable() then short-circuits:

	if (cdev->active_interrupts == interrupts)
		return;

So later updates that compute A_new, including the one woken by the
restarted hrtimer through m_can_coalescing_timer(), never rewrite IE.

Could RX FIFO or TX event interrupts stay masked after the netdev is
reattached here, until something else changes the cached mask?

> +		}
> +		netif_device_attach(ndev);
> +		netif_start_queue(ndev);

[Severity: Medium]
Does this rollback leave the TCAN4x5x in standby mode?

tcan4x5x_deinit() is a single read-modify-write on the SPI regmap:

	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
				  TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_STANDBY);

Suppose the read succeeds and the write reports an error after the frame
has already been clocked out to the chip. The device may then have latched
STANDBY even though deinit() returned an error.

The error path restores IE, the hrtimer and the netdev state, but it never
sets TCAN4X5X_MODE_NORMAL again the way tcan4x5x_init() does:

	ret = regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
				 TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_NORMAL);

In that case the interface would look operational, but frames would sit in
the TX FIFO until the next ifdown/ifup or suspend/resume.

This depends on whether a failed SPI write can still reach the device. If
the read fails, no write is issued and the mode is unchanged.

> +	}
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(m_can_class_suspend);

[Severity: Low]
This isn't a bug introduced by this patch, but returning an error here
still leaves the wake IRQ armed on tcan4x5x. tcan4x5x_suspend() does:

	if (cdev->pm_wake_source)
		enable_irq_wake(spi->irq);

	return m_can_class_suspend(dev);

If m_can_class_suspend() fails, the PM core does not call
tcan4x5x_resume() for this device. That is the only place that calls
disable_irq_wake(), so each failed suspend leaks one wake reference on
spi->irq.

The same imbalance existed before this patch, because the deinit() error
was already returned without this cleanup.

The next patch in this series, "can: tcan4x5x: Add suspend error
handling", adds an err_disable_irq label to tcan4x5x_suspend() that calls
disable_irq_wake() when m_can_class_suspend() fails, which looks like it
fixes this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce%40baylibre.com
