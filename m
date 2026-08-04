Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434E340A46
	for <linux-can@vger.kernel.org>; Tue,  4 Aug 2026 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843474; cv=none; b=cWrj6tk4Vk9h0dffr7wyFLZROeZ9VNDaDEARSnroxBTojKqRnQgPomnkfxksob4ZO0N3opQE/7wF08HaJPqegDJCpv2J3itT5+iooHY9+xUebaWcj+TRb+CIsIeUPllMp22acuk+bwKywKfWLCZtho0FEbyVe10G70+p3LbRynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843474; c=relaxed/simple;
	bh=PMeWl5VWHHR4XgqrHtiz18IY1OEKAx1fQQxZnUpkE4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dcvupcRUO9vYda6RwS4dUf+jXCXtqCOwLL2ETEkbuwgSsKHVW7aQuVYZcbENGpJ6F8JvZK1J2lzLMPLPkl+TN48cgOBKrr0uA1Z6yk769UbOjhSsILQaZKxwPpVymIB/WPFykbHa0pKV3ZMVimBlpYgiiAsXNbSZWNnz2aITTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg2UGrAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg2UGrAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A291D1F000E9;
	Tue,  4 Aug 2026 11:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785843471;
	bh=tLU2B6m99jSSCjgYt1s42dMCBAoHD8ponyTsk21CU0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sg2UGrAg907aEzHwnl6JOwVvEIozU+H15I/FL2e7O4F4/ORnr3yjX6FZ8+Itx4sv4
	 9nJTabW4Qrn25ndsWGTj+orpYW13NaUfbVU/M15WJVAArYOx/TOuN6wRzstAbn4xIV
	 UldmWzvXK8ECFvHfpoMYvRi3tKShNLEbYONkImdkMfCh/hfhv/tmjTuDU80ymy0/zl
	 1BMpVDT8+coF5zj/0NkzK1yVXY2VwxD/BP90Hz/gzf1GiGaxIBQhrvbM5ScBmpFJxx
	 ZyxREJYIxPDOKb1io7ZTl941+0Xm3wiYH0QkttYtAstDS14nFyP6pQiTExFEaStH2Z
	 l6qxsGjJ7QPQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] can: tcan4x5x: put tcan into sleep when removing
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Nyekjaer" <sean@geanix.com>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260804113027.1626442-1-sean@geanix.com>
References: <20260804113027.1626442-1-sean@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 11:37:50 +0000
Message-Id: <20260804113750.A291D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Early return on SPI error in `tcan4x5x_power_enable(priv, 0)` by=
passes `regulator_disable()`, causing a regulator enable count leak.
--

--- Patch [1]: [PATCH v4] can: tcan4x5x: put tcan into sleep when removing =
driver ---
commit 277a5e1f34c213275f7c42975ff590a923bc1148
Author: Sean Nyekjaer <sean@geanix.com>

can: tcan4x5x: put tcan into sleep when removing driver

This commit modifies the driver to put the TCAN4x5x transceiver into sleep
mode upon removal. It issues a sleep command via SPI to reduce power
consumption when the driver unbinds. The sleep command is integrated into
tcan4x5x_power_enable().

> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 31cc9d0abd453..d8fd219a27cc5 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c

[ ... ]

> -static int tcan4x5x_power_enable(struct regulator *reg, int enable)
> +static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enable)
>  {
> +	struct regulator *reg =3D priv->power;
> +	int ret;
> +
> +	/*
> +	 * Put the device into sleep mode if the RST pin is available,
> +	 * since a wake-up event, RST pin toggle, or power cycle are the only
> +	 * ways to exit sleep mode.
> +	 * Redundant if the regulator is exclusive to this device, but that
> +	 * can't be determined here.
> +	 *
> +	 * Datasheet: TCAN4550, section "8.4.3 Sleep Mode"
> +	 * https://www.ti.com/lit/gpn/tcan4550
> +	 */
> +	if (priv->reset_gpio && !enable) {
> +		ret =3D regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
> +					 TCAN4X5X_MODE_SEL_MASK,
> +					 TCAN4X5X_MODE_SLEEP);
> +		if (ret)
> +			return ret;

[Severity: Medium]
If this regmap_update_bits() fails over SPI during the power-off sequence,
could this early return bypass the regulator_disable() call below?

It looks like this might leak the regulator enable count, which would
prevent the regulator from ever being disabled and defeat the power-saving
purpose of the patch.

> +	}
> +
>  	if (IS_ERR_OR_NULL(reg))
>  		return 0;
> =20
>  	if (enable)
>  		return regulator_enable(reg);
>  	else
>  		return regulator_disable(reg);
>  }

[ ... ]

> @@ -543,7 +564,7 @@ static void tcan4x5x_can_remove(struct spi_device *sp=
i)
> =20
>  	m_can_class_unregister(&priv->cdev);
> =20
> -	tcan4x5x_power_enable(priv->power, 0);
> +	tcan4x5x_power_enable(priv, 0);

[Severity: Medium]
Because tcan4x5x_can_remove() ignores the return value of
tcan4x5x_power_enable(), any error returned from the regmap_update_bits()
failure mentioned above would be silently dropped.=20

Would it be safer to ensure the regulator is still disabled even if the
SPI command fails, so the failure doesn't silently keep the power on?

> =20
>  	m_can_class_free_dev(priv->cdev.net);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804113027.1626=
442-1-sean@geanix.com?part=3D1
