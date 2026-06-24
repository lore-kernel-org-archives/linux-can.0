Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DB384235
	for <linux-can@vger.kernel.org>; Wed, 24 Jun 2026 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280939; cv=none; b=GjQpdWTtq0PuiOIbM4UpWATOW70cV7Q5XiCJQGPl54PFuHjuXoEYn746myyaYGPQ2Zi6AUNmfsLUHGf43YERm2P0DXlTyaDG15ImOm2c2a16O7JxWOmKbjlYpLgkiqvTm1PEbEufshg2AE9JaFSjOKy+Kckp8t+h1ota5tmftnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280939; c=relaxed/simple;
	bh=I9SviO8ZF0iKrg9Msa+xs5O7rsXezDHZUbausoqqpFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N0Bp+wSUKGioNcNbWSqgEli+g7eeukJ2TXJ2nA08vDeTs7/06ykIfdvPt0Be2DvUR5EpqWNZv0li/HZYWjZnA6S23HDtFjok6Dv+OkLfCM86tANPrvfELR+ifPuU4raWLKMwv14JHSjFu1iiOkeS9Pfqcf1Z3KdO0xCDJKRw/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzTMKRLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzTMKRLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EBD1F000E9;
	Wed, 24 Jun 2026 06:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782280938;
	bh=7nCx1o7jRPe4/qD2fnnOxXqEKnnRT0Yn3ejRWPLSoaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZzTMKRLfD8vlls3g0lBDxQmrIVSnuDm4kP+QINb8KCD42tbQcSd8P8f2HmwdpORH4
	 0njTUFo0BfuYARniW4kRxbnVcGUMAyiEIaNCdKh/+ifHbr8D36cJDeYan2Z87pEnpT
	 hQgyll7/eD5wmyHRFJLecFC81m0LNo/aXteSpHwLZWGdfnjoyTahZ79zyCAZ/lNtf+
	 HMlGSBpFqAaDhaWzo6AV0wGXRgrPUPKKXqDxmkwgWmN6PiLM97i1yk/294fQOTxAyb
	 CmAWSamfJ+cWxJts4SFEkgb66eE2FQNSCEI5P+63Pyoq1Tl6Be889xvlcLhmakhZWe
	 vbC8/ZY0Y13xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: rockchip_canfd: Propagate reset failures on start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260624055026.24789-1-pengpeng@iscas.ac.cn>
References: <20260624055026.24789-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 06:02:17 +0000
Message-Id: <20260624060217.D5EBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unsafe reset error handling introduces bus faults and incomplete t=
eardown.

Pre-existing issues:
- [High] Missing can_rx_offload_disable() in rkcanfd_open() error path caus=
es BUG_ON panic.
- [High] Asynchronous pm_runtime_put() races with pm_runtime_disable() duri=
ng device removal.
- [High] Calling non-atomic reset control APIs from the hardirq handler cau=
ses a panic.
--

commit a6e0fcd15347d005fd23e1237e5a026a9096879a
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

can: rockchip_canfd: Propagate reset failures on start

The Rockchip CAN-FD driver requires a reset controller, but
rkcanfd_chip_set_reset_mode() ignores reset assert/deassert failures.
This patch returns reset errors from the reset/start helpers and propagates
them before enabling RX offload, requesting the IRQ, or starting the netdev
queue.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> index 29de0c01e4edc..89bc402b76e85 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
[ ... ]
> @@ -102,13 +102,23 @@ static const struct can_bittiming_const rkcanfd_dat=
a_bittiming_const =3D {
>  	.brp_inc =3D 2,	/* value from data sheet x2 */
>  };
> =20
> -static void rkcanfd_chip_set_reset_mode(const struct rkcanfd_priv *priv)
> +static int rkcanfd_chip_set_reset_mode(const struct rkcanfd_priv *priv)
>  {
> -	reset_control_assert(priv->reset);
> +	int err;
> +
> +	err =3D reset_control_assert(priv->reset);
> +	if (err)
> +		return err;

[Severity: High]
This is a pre-existing issue, but does calling reset_control_assert() from
this context cause a scheduling while atomic panic?

If a state error occurs on the bus, the hardirq handler rkcanfd_irq()
calls rkcanfd_handle_state_error_int() which initiates a stop:

rkcanfd_handle_state_error_int()
    rkcanfd_chip_stop()
        __rkcanfd_chip_stop()
            rkcanfd_chip_set_reset_mode()
                reset_control_assert()

Since this reset control uses a mutex internally, can this sleep in interru=
pt
context?

[Severity: High]
If reset_control_assert() fails, we return early. Does this skip the
fallback software reset and leave the controller active on the CAN bus?

Previously, this function would fall back to software reset:
    rkcanfd_write(priv, RKCANFD_REG_MODE, 0x0);

With the early return, the controller might still be active while the driver
considers it stopped.

>  	udelay(2);
> -	reset_control_deassert(priv->reset);
> +
> +	err =3D reset_control_deassert(priv->reset);
> +	if (err)
> +		return err;
> =20
>  	rkcanfd_write(priv, RKCANFD_REG_MODE, 0x0);
> +
> +	return 0;
>  }
[ ... ]
> @@ -309,13 +322,16 @@ static void rkcanfd_chip_start(struct rkcanfd_priv =
*priv)
> =20
>  	netdev_dbg(priv->ndev, "%s: reg_mode=3D0x%08x\n", __func__,
>  		   rkcanfd_read(priv, RKCANFD_REG_MODE));
> +
> +	return 0;
>  }
> =20
>  static void __rkcanfd_chip_stop(struct rkcanfd_priv *priv, const enum ca=
n_state state)
>  {
>  	priv->can.state =3D state;
> =20
> -	rkcanfd_chip_set_reset_mode(priv);
> +	if (rkcanfd_chip_set_reset_mode(priv))
> +		netdev_err(priv->ndev, "Failed to reset CAN-FD controller\n");
>  	rkcanfd_chip_interrupts_disable(priv);

[Severity: High]
If reset_control_deassert() fails in rkcanfd_chip_set_reset_mode(), the
controller is left actively held in reset.

Will calling rkcanfd_chip_interrupts_disable() immediately after cause a
synchronous external abort (bus fault)?

Accessing MMIO of a peripheral currently held in reset on Rockchip SoCs
typically causes a kernel panic.

>  }
[ ... ]
> @@ -719,7 +739,10 @@ static int rkcanfd_open(struct net_device *ndev)
>  	if (err)
>  		goto out_close_candev;
> =20
> -	rkcanfd_chip_start(priv);
> +	err =3D rkcanfd_chip_start(priv);
> +	if (err)
> +		goto out_runtime_put;
> +
>  	can_rx_offload_enable(&priv->offload);
> =20
>  	err =3D request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, pr=
iv);
> @@ -734,6 +757,7 @@ static int rkcanfd_open(struct net_device *ndev)
> =20
>  out_rkcanfd_chip_stop:
>  	rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);

[Severity: High]
This isn't a bug introduced by this patch, but if request_irq() fails,
does this error path miss calling can_rx_offload_disable()?

A subsequent attempt to open the interface will call can_rx_offload_enable()
again, which calls napi_enable() on an already-enabled NAPI context.

Could this trigger a BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state)) in
net/core/dev.c?

> +out_runtime_put:
>  	pm_runtime_put(ndev->dev.parent);

[Severity: High]
This is a pre-existing issue, but does using the asynchronous
pm_runtime_put() here and in rkcanfd_stop() race with pm_runtime_disable()
during device removal?

When the device is unregistered, rkcanfd_unregister() calls
unregister_candev() which stops the interface, queueing an asynchronous
suspend via pm_runtime_put().

Immediately after, rkcanfd_unregister() calls pm_runtime_disable() which
cancels the pending async idle/suspend work.

Could this leave the hardware permanently powered on? Would using
pm_runtime_put_sync() ensure the suspend completes?

>  out_close_candev:
>  	close_candev(ndev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624055026.2478=
9-1-pengpeng@iscas.ac.cn?part=3D1
