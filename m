Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF242049B;
	Fri, 14 Aug 2026 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698885; cv=none; b=STjxAMfKZLDCLfccsRN+ZkaMzyfANub/pH0p+BZZjoQaZpSFDg63wjZAgkbUDWqCOLcuuJzcBskCAjgSq/NnKiHAcS/w/53X7uZGbx6giZnrEKxl66ZVK6QEsPft64LgJ2oQApLU+2VMnLKhhnfajoHbGgJrvdTbkKf235ubeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698885; c=relaxed/simple;
	bh=bLxmo6w7wG8c11FaMhjlKWzVYP7EqZgqHvocwbItXeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MIVZs1a6mLuuhxKko+EtfHP4a0NhoVkoTgRzcT1rtnUS95cpsWtLh0kFPAYBV5xcIz9fU9izWf580ijX3laVXZU7rsg/pcehS+oOWj4Yx+ltYIIkqaS2+/nzpJKgJIeNKvMjCZvBmDX4LXPzNwdhrPCar0SCaAJbetk2KSjSwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoAsNzBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoAsNzBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990D91F000E9;
	Fri, 14 Aug 2026 09:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786698884;
	bh=WCYDDND33Gs+5oPob/MB66KTD80miateaiz1wxBupxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YoAsNzBcG14yQCEmhI3e7lGtb1Ocl8W1e7P2wDdHkXun7Sgyci+tPfODotlObDzDQ
	 oRbd7RQRL40cEVkDN+mykbeHz1rDzvcVdYkxAWzjepwkvmPrJfxUyj8COj0k4wegXh
	 GjqryQB7SE8zAWrlfghFp5zGHCpdS64/+H++vO5QPo2ECV4BVCRT28TsviKPReaNvQ
	 41zojx7lJjGyKP3HQ3EvcOVt+w2F2w4ktjzMf774WLWM9cr6+HXAScApm02tEaf4Nj
	 jlsBiFRsITNUOYa2SqIqe7zEwgI2uCRyD3ypewTIWoX+Y4WeEVFtvZmHGWz+JjDkLe
	 D3jqy8f4r1HsQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v6 2/6] can: flexcan: disable all IRQ lines in
 flexcan_chip_interrupts_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: devicetree@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, conor+dt@kernel.org, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, imx@lists.linux.dev, Frank.Li@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, robh@kernel.org
In-Reply-To: <20260814090324.647898-3-ciprianmarian.costea@oss.nxp.com>
References: <20260814090324.647898-1-ciprianmarian.costea@oss.nxp.com>
 <20260814090324.647898-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 09:14:43 +0000
Message-Id: <20260814091443.990D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Prematurely exposing the device to the network stack during resume=
, and delaying teardown during suspend, causes a race condition where ndo_s=
tart_xmit can interact with powered-down or partially initialized hardware.
- [Medium] PM runtime usage count underflow (double-put) in the probe error=
 path.
--

--- Patch [2]: [RESEND PATCH v6 2/6] can: flexcan: disable all IRQ lines in=
 flexcan_chip_interrupts_enable() ---
commit 51a052134a222a737e75062314cf44dff20da306
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()

flexcan_chip_interrupts_enable() disables only the primary IRQ line while
writing to the IMASK and CTRL registers.

On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (boff,
err, secondary-mb) remain active so their handlers can fire while
registers are inconsistent.

Disable all registered IRQ lines around the IMASK/CTRL writes. This
also fixes the resume path, which calls this function.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f73ff442d5304..7dde2e623defe 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1519,14 +1519,28 @@ static void flexcan_chip_interrupts_enable(const =
struct net_device *dev)
>  {
>  	const struct flexcan_priv *priv =3D netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 quirks =3D priv->devtype_data.quirks;
>  	u64 reg_imask;
> =20
>  	disable_irq(dev->irq);
> +	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +		disable_irq(priv->irq_boff);
> +		disable_irq(priv->irq_err);
> +	}
> +	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> +		disable_irq(priv->irq_secondary_mb);
> +
>  	priv->write(priv->reg_ctrl_default, &regs->ctrl);
>  	reg_imask =3D priv->rx_mask | priv->tx_mask;

[ ... ]

This isn't a bug introduced by this patch, but while reviewing flexcan-core=
.c
I noticed a PM runtime count underflow in the probe error path:

drivers/net/can/flexcan/flexcan-core.c:flexcan_probe() {
    ...
	err =3D register_flexcandev(dev);
	if (err) {
		dev_err(&pdev->dev, "registering netdev failed\n");
		goto failed_register;
	}

	err =3D flexcan_setup_stop_mode(pdev);
	if (err < 0) {
		dev_err_probe(&pdev->dev, err, "setup stop mode failed\n");
		goto failed_setup_stop_mode;
	}
    ...
 failed_setup_stop_mode:
	unregister_flexcandev(dev);
 failed_register:
	pm_runtime_put_noidle(&pdev->dev);
    ...
}

[Severity: Medium]
Since register_flexcandev() successfully drops the PM runtime reference via
pm_runtime_put() on success, doesn't jumping to failed_setup_stop_mode and
falling through to failed_register result in a double-put when
pm_runtime_put_noidle() is called?


This is also a pre-existing issue, but the suspend/resume handling appears
to have a race window with the network stack:

drivers/net/can/flexcan/flexcan-core.c:flexcan_resume() {
    ...
	if (netif_running(dev)) {
		netif_device_attach(dev);
		netif_start_queue(dev);
		if (device_may_wakeup(device)) {
			disable_irq_wake(dev->irq);
			err =3D flexcan_exit_stop_mode(priv);
    ...
}

[Severity: High]
Could this sequence prematurely expose the device to the network stack?
Calling netif_device_attach() and netif_start_queue() before hardware
initialization like flexcan_exit_stop_mode() or flexcan_chip_start()
completes could allow ndo_start_xmit to write to device registers while the
device is not powered.

Similarly in suspend:

drivers/net/can/flexcan/flexcan-core.c:flexcan_suspend() {
    ...
		} else {
			err =3D flexcan_chip_stop(dev);
			if (err)
				return err;
			flexcan_chip_interrupts_disable(dev);
			err =3D flexcan_transceiver_disable(priv);
			if (err)
				return err;
			err =3D pinctrl_pm_select_sleep_state(device);
			if (err)
				return err;
		}
		netif_stop_queue(dev);
		netif_device_detach(dev);
    ...
}

[Severity: High]
Does this tear down the hardware before stopping the queue? netif_stop_queu=
e()
and netif_device_detach() occur after the hardware is suspended via
flexcan_chip_stop(), creating a similar race window.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814090324.6478=
98-1-ciprianmarian.costea@oss.nxp.com?part=3D2
