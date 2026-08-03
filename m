Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BC383320
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753201; cv=none; b=nmTuWAgnZCXhcQtdAZzjSk8pi6IuWXClDeOhxzu/hgiKgekgBt2GeBAL8ZstBdxFrwMR+f5NjAMZ+GrLAORjB8B7grCmrb1WOEQkdz0vqSiacp2TMsNzmLO39nA46WfmE/aqm66wtKpJsLJNzHtp6KhsdIVPOg0NFlf9kIAyKcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753201; c=relaxed/simple;
	bh=+kteslCCygPRPIt+XkqZXHWzO4gTZ8OySH7ZnNopw2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lpG9ArkPYsGEtJXh+K+1brqDFIbbyYJfE0ATdx7/zowOO+zKVzgdOtP9I8t/WHyExkre90QLW33uwsfVqo908U/bHcVVDz1Can3hUomzI+q3kL+qfCe9fL4EQeZ/pG/UdpzYw162FH8uu5Uxki1J6dt80YS23rBrO7UZg61wET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr+3m0ez; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr+3m0ez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E155A1F000E9;
	Mon,  3 Aug 2026 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785753200;
	bh=Bkm/eaooYhBZo73RRENmD67kSoT2OSTjRBvyYthVTNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lr+3m0ezPuoo3MM6TyvbA6CCD0K3S+jiMDT1bniA+N9qZPlbG2fgTwXHHXV6JdJHG
	 DmCxsb9a7ej+VqiQKChQCUSppxDeNx8CgDs7wN2+Zr7G3NT3xyicXuRtyrxEdrE6O1
	 46oMwfk9wDzHFm8hnlhk3RPtso82NNuOUgikZEfwbrcifgDve47yKV77GVwCObl7nU
	 Q0qE3RMWSULVxvF1AdbHWKTBsrC1PHWde4Aridx2z/jHiPVaGKd9wJsfiZMCkS72wC
	 BMVRkGBcIbnO0qRB1TgIWtxt6dXLb5SeEQfqfagmSr3Ja30oa2eawQw7z6czMbqsC/
	 8WNShx6yJ2/Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Nyekjaer" <sean@geanix.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260803101927.17122-1-sean@geanix.com>
References: <20260803101927.17122-1-sean@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:33:19 +0000
Message-Id: <20260803103319.E155A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The function signature of `tcan4x5x_power_enable()` was changed to=
 accept a `struct tcan4x5x_priv *` instead of `struct regulator *`, but the=
 call site in `tcan4x5x_can_remove()` was not updated. This causes a severe=
 type mismatch leading to a wild pointer dereference.
- [Medium] The transceiver is not explicitly put into sleep mode via SPI du=
ring driver removal if it is powered by a regulator, undermining the patch'=
s intended power savings.

Pre-existing issues:
- [High] The polling hrtimer is not synchronously cancelled during device t=
eardown, allowing its callback to execute concurrently on freed memory.
--

--- Patch [1]: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing =
driver ---
commit b49d2b844c12ed05e9ff4437bc458dbace9b23e8
Author: Sean Nyekjaer <sean@geanix.com>

can: tcan4x5x: put tcan into sleep when removing driver

Put the tcan4x5x transceiver into sleep mode when the driver is
removed, instead of leaving it in its current operating mode.
This reduces power consumption(3mA@12V) once the driver is
no longer bound to the device.

> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 31cc9d0abd453..67902b8b0fab4 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -211,15 +211,21 @@ static int tcan4x5x_write_fifo(struct m_can_classde=
v *cdev,
>  	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offse=
t, val, val_count);
>  }
> =20
> -static int tcan4x5x_power_enable(struct regulator *reg, int enable)
> +static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
>  {

[Severity: High]
Did this signature change miss updating the call site in
tcan4x5x_can_remove()?

When the driver is unloaded, tcan4x5x_can_remove() still passes priv->power
which is a struct regulator pointer:

drivers/net/can/m_can/tcan4x5x-core.c:tcan4x5x_can_remove() {
	...
	tcan4x5x_power_enable(priv->power, 0);
	...
}

Could this cause a panic when tcan4x5x_power_enable() tries to dereference
the regulator pointer as a struct tcan4x5x_priv?

> -	if (IS_ERR_OR_NULL(reg))
> +	if (IS_ERR_OR_NULL(priv->power)) {
> +		if (priv->reset_gpio && !enable)
> +			return regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
> +						  TCAN4X5X_MODE_SEL_MASK,
> +						  TCAN4X5X_MODE_SLEEP);
> +
>  		return 0;
> +	}

[Severity: Medium]
If the device tree specifies a regulator for the transceiver, will this
skip putting the device into sleep mode?

Since the sleep configuration is gated inside the check for
IS_ERR_OR_NULL(priv->power), if a regulator is present, the function skips
this block and just disables the regulator.

If this regulator is shared with other components on the board, does it lea=
ve
the transceiver powered and in its previous state instead of entering sleep
mode?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
with the polling hrtimer during device teardown?

During device teardown, m_can_disable_all_interrupts() uses a non-blocking
cancel:

drivers/net/can/m_can/m_can.c:m_can_disable_all_interrupts() {
	...
	if (!cdev->net->irq) {
		netdev_dbg(cdev->net, "Stop hrtimer\n");
		hrtimer_try_to_cancel(&cdev->hrtimer);
	}
}

If the timer callback m_can_polling_timer() is concurrently running on anot=
her
CPU, hrtimer_try_to_cancel() will fail.

If the callback reads the state before it is updated to CAN_STATE_STOPPED,
will it reschedule itself and eventually execute on freed memory?

drivers/net/can/m_can/m_can.c:m_can_polling_timer() {
	...
	hrtimer_forward_now(timer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS));

	return HRTIMER_RESTART;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803101927.1712=
2-1-sean@geanix.com?part=3D1
