Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D83ADB92
	for <linux-can@vger.kernel.org>; Sun, 18 Oct 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335067; cv=none; b=oLhv5k29ckSz+490+Vyw2OH2AW+M7wFVUSjpq7Ou22moBT14wcochA6cEP/IUIxm53HQlncq4aTZeBQNPCy8S/A8o5RjTfsMnnPOn2zalIGOaxkwUq6H4oLHdrUHoWWKmocW1AER7AdPIMB/q/lEC+k59UYY560qEFI4kIUJ1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335067; c=relaxed/simple;
	bh=p+rwPGpD1it2jolrAKhsR3E6UuXfQUWwF0aOZVL1MYg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=k0CWbeQrQBmKlhFTdl8qUFyN6zJCXJqQBJTQl0pxb3dP3FRP47SeIqlQQTdlNDCbXqLLfRBmJry2dULWWTic9ZFXe8skk8zesbTpr8AOPBKzFsgGe9Og/sIGwr3qwZYJ5QShQTa0QGmqJHvJ5wLFvY+hKzL2vuQrL/ZL5dugMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz2k0l6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz2k0l6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630B71F000C4;
	Sun, 18 Oct 2026 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792335065;
	bh=dkXpLZIHYZVrRM0XJKdFwnOBoRWe3Vrw4CjEJ3EWvyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oz2k0l6CSZBefz8hke8zjghcZGAhJtMhP1HSTBWtRLUDayGPxzxCwz8LmQPySEfLH
	 acUi9YU0QPCQkSWoYcxdFf4czcSWyuYUVczaqkvSD+5U+VTl4bhgmPN7PjPR7PDQeg
	 9bER/JhqgBi+aCHrpz2RksNAc+0wugA95zPfjkhoM8GGr+ne3nQ4M+x42jpLwb3OXG
	 MNbGFr3lrnE59HXEXA1h8kdu8gQFYNR+euhvDGMCa6HGMBLPjCRboHBltmLphRq+Su
	 RRKhCDNWMmQurg1yo7Klg5xRCvv+lui+YnV+CixEPQ3b/1k15Kta7YVByDgvIuhj12
	 3OioYxSG+RRmQ==
Message-ID: <sashiko-outbox-176216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 3/6] can: rockchip_canfd: cancel bus-off restart
 before closing the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261017-rockchip-canfd-restart-close-v6-3-ed605feb4b6e@qq.com>
References: <20261017-rockchip-canfd-restart-close-v6-0-ed605feb4b6e@qq.com>
 <20261017-rockchip-canfd-restart-close-v6-3-ed605feb4b6e@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:51:04 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: rockchip_canfd: ad-hoc flag synchronization in rkcanfd_set_=
mode()
--

commit 84108d981e4356f8149159f043033d7bbecd5e53
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: cancel bus-off restart before closing the device

This commit cancels bus-off restart work at the beginning of ndo_stop(),
synchronizes interrupt and timestamp handling across controller restart in
rkcanfd_set_mode(), and disables RX offload on request_irq() failure in
rkcanfd_open().

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 37c1c22c40c9f..4b3db07242395 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
[ ... ]
> @@ -356,7 +357,18 @@ static int rkcanfd_set_mode(struct net_device *ndev,
> =20
>  	switch (mode) {
>  	case CAN_MODE_START:
> +		rkcanfd_chip_interrupts_disable(priv);
> +		/* Flush the interrupt mask write before suspending the handler. */
> +		rkcanfd_read(priv, RKCANFD_REG_INT_MASK);
> +		/* Keep shared IRQs from accessing the device during restart. */
> +		WRITE_ONCE(priv->irq_suspended, true);
> +		/* Wait for handlers that already passed the suspended check. */
> +		synchronize_irq(ndev->irq);
> +		rkcanfd_timestamp_stop_sync(priv);
> +
>  		rkcanfd_chip_start(priv);
> +		/* Publish the initialized state before resuming IRQ handling. */
> +		smp_store_release(&priv->irq_suspended, false);
>  		rkcanfd_chip_interrupts_enable(priv);
>  		netif_wake_queue(ndev);
>  		break;
> @@ -666,6 +678,10 @@ static irqreturn_t rkcanfd_irq(int irq, void *dev_id)
>  	struct rkcanfd_priv *priv =3D dev_id;
>  	u32 reg_int_unmasked, reg_int;
> =20
> +	/* Pairs with the release after restart has initialized the device. */
> +	if (smp_load_acquire(&priv->irq_suspended))
> +		return IRQ_NONE;
> +
>  	reg_int_unmasked =3D rkcanfd_read(priv, RKCANFD_REG_INT);
>  	reg_int =3D reg_int_unmasked & ~priv->reg_int_mask_default;

[Severity: Medium]
Does using priv->irq_suspended as a boolean gate flag between
rkcanfd_set_mode() and rkcanfd_irq() leave a race window during controller
restart and shared IRQ handling?

Setting priv->irq_suspended on entry to rkcanfd_set_mode() and clearing it =
on
exit acts as an ad-hoc lock that is invisible to lockdep and does not
serialize against other concurrent readers or writers of shared state (such=
 as
rkcanfd_get_berr_counter()).

In addition, rkcanfd_chip_start() already puts the controller into
RKCANFD_REG_MODE_WORK_MODE and sets priv->can.state =3D CAN_STATE_ERROR_ACT=
IVE
before rkcanfd_set_mode() clears priv->irq_suspended:

can_restart()
  rkcanfd_set_mode(ndev, CAN_MODE_START)
    rkcanfd_chip_start(priv)
      rkcanfd_chip_set_work_mode(priv);
      priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
    smp_store_release(&priv->irq_suspended, false);
    rkcanfd_chip_interrupts_enable(priv);
    netif_wake_queue(ndev);

Because rkcanfd_irq() reads the raw unmasked interrupt status from
RKCANFD_REG_INT and masks it in software with ~priv->reg_int_mask_default
rather than consulting RKCANFD_REG_INT_MASK, a shared IRQ firing on the
IRQF_SHARED line after smp_store_release(&priv->irq_suspended, false) (or an
interrupt firing right as rkcanfd_chip_interrupts_enable() unmasks hardware
interrupts) can enter rkcanfd_irq() and handle a new bus-off condition befo=
re
rkcanfd_set_mode() finishes:

rkcanfd_irq()
  rkcanfd_handle_state_error_int()
    rkcanfd_chip_stop(priv, CAN_STATE_BUS_OFF)
    can_bus_off(ndev)

When rkcanfd_set_mode() then executes rkcanfd_chip_interrupts_enable(priv) =
and
netif_wake_queue(ndev), wouldn't it unmask interrupts on the stopped
controller and wake the transmit queue while priv->can.state is
CAN_STATE_BUS_OFF?

Similarly, because rkcanfd_irq() only checks priv->irq_suspended (which is
only set during rkcanfd_set_mode()) and masks RKCANFD_REG_INT with
~priv->reg_int_mask_default, shared IRQs arriving during rkcanfd_open()
between request_irq() and rkcanfd_chip_interrupts_enable(), or while in
CAN_STATE_BUS_OFF after rkcanfd_chip_stop() masks RKCANFD_REG_INT_MASK, can
still evaluate pending bits in RKCANFD_REG_INT. Would a proper spinlock (or
honoring the active mask state under a lock) avoid this race?

[ ... ]

> diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/=
rockchip/rockchip_canfd.h
> index 95bea9bfd8a2f..e1debab54534e 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd.h
> +++ b/drivers/net/can/rockchip/rockchip_canfd.h
> @@ -480,6 +480,7 @@ struct rkcanfd_priv {
> =20
>  	u32 reg_mode_default;
>  	u32 reg_int_mask_default;
> +	bool irq_suspended;
>  	struct rkcanfd_devtype_data devtype_data;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017-rockchip-c=
anfd-restart-close-v6-0-ed605feb4b6e@qq.com?part=3D3
