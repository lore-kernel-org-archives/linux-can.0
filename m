Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E232E6BC
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766159; cv=none; b=n7t8Sc2Fu4/j3SGqJUV/krbUywkYmkpS+O13o1nK5ZuD3kX6eXNpWna5uC9efNGlv5eWJlbhzP9UaxdUqkeMiwBDdqa/3CEFtpJGHafPcdmjfRHBpSpFn6/Phwn3WkLUXvY5bfizIYqNyG4ndCzIEQ1ehdzL9goPrq5ndck67tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766159; c=relaxed/simple;
	bh=VESB3s2RRWL/CGnYz+CKjgSH1ux8QiTLzbEx5vH5M1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ay2vfLamWkTaRFJ1MjgyFsYitzwV/7yw5hWB5wXxQK0oBP/QfJGV28ogsmAulTJKHc72YJUMG2iQ6g07LbD21aomeh91JQev0/4ji/d5bFwzxBZJ0tVLCvpLym5CKPs6BdweS4eB66NV5ZTBx/94tcelyV+Wm6HRyx+79JcbukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XacQYWyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XacQYWyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3661F000E9;
	Mon,  3 Aug 2026 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766157;
	bh=fFRdB7jvP4821yaz9SeWtD3KW2j01JmPAnBHNvKDWD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XacQYWyFsXQOGqf+nSxs7JYS9G4rYAGo962X+008y8RJxQZtDhpUWesgT/6lZc4or
	 MuyxaObSFxwTZkZovBPGiVCXK/ZSF5+clYB346DpQx87mKDK2t5crBUKhJv101GgLO
	 4Zy0j96XV5xF6LCHwUdrUK7m0AYdj8MnGm8MvKQ0zsEp1unJ5bdFV7BguXP01OrtLB
	 pPj/s5M1YZtf5/0QspHlJrQ1Ge5QwAjS+bX0LEoiSX93moU8zdqS44ohLlJ32Gr02w
	 zaB2yLH2vO/iN7xQ9DaeMlGpKddapjJ8Nc7XONaUVvgyzEgJ6H4IaMNwM8WvpTQA+7
	 wUi3hghgWUKPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] can: tcan4x5x: put tcan into sleep when removing
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Nyekjaer" <sean@geanix.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260803135011.230006-1-sean@geanix.com>
References: <20260803135011.230006-1-sean@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:09:16 +0000
Message-Id: <20260803140917.6A3661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The transceiver is not put into sleep mode if a regulator is con=
figured, defeating the power-saving goal for shared or always-on regulators.
--

--- Patch [1]: [PATCH v3] can: tcan4x5x: put tcan into sleep when removing =
driver ---
commit 153dfa0940acefa28cd89e367eedf818096ade5b
Author: Sean Nyekjaer <sean@geanix.com>

can: tcan4x5x: put tcan into sleep when removing driver

This commit attempts to put the tcan4x5x transceiver into sleep mode when
the driver is removed to reduce power consumption. It updates
tcan4x5x_power_enable to send the sleep command via SPI if the RST pin is
available and no regulator is present.

> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 31cc9d0abd453..a318f1874b351 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -211,10 +211,26 @@ static int tcan4x5x_write_fifo(struct m_can_classde=
v *cdev,
>  	return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_offse=
t, val, val_count);
>  }
> =20
> -static int tcan4x5x_power_enable(struct regulator *reg, int enable)
> +static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
>  {
> -	if (IS_ERR_OR_NULL(reg))
> +	struct regulator *reg =3D priv->power;
> +
> +	/*
> +	 * Check if the power regulator is configured. If it is, just power
> +	 * the device on/off. If not, put the device into sleep mode here if
> +	 * the RST pin is available, since a wake-up event, RST pin toggle,
> +	 * or power cycle are the only ways to exit sleep mode.
> +	 * Datasheet: TCAN4550, section "8.4.3 Sleep Mode"
> +	 * https://www.ti.com/lit/gpn/tcan4550
> +	 */
> +	if (IS_ERR_OR_NULL(reg)) {
> +		if (priv->reset_gpio && !enable)
> +			return regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
> +						  TCAN4X5X_MODE_SEL_MASK,
> +						  TCAN4X5X_MODE_SLEEP);
> +
>  		return 0;
> +	}

[Severity: Medium]
Will this miss the power savings if the regulator is shared or marked as
always-on?

Because the sleep command is nested inside the IS_ERR_OR_NULL(reg) check,
the device is not put into sleep mode if a regulator is configured. Instead,
the function continues to the else block and calls regulator_disable().

If the regulator is shared with other active devices or is marked always-on=
 in
the device tree, regulator_disable() will only decrement the reference count
without physically turning off the power. The transceiver will stay fully
powered in its active operating mode.

Should the driver issue the sleep command via SPI whenever priv->reset_gpio
is available, before disabling the regulator, to ensure power is saved rega=
rdless
of the physical regulator state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803135011.2300=
06-1-sean@geanix.com?part=3D1
