Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EE3A4F4B
	for <linux-can@vger.kernel.org>; Tue, 30 Jun 2026 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823232; cv=none; b=ClWU46JRZqeRe/UsxeAiBxIOtRHKZCIR8swEctTCiCaYUS2bKiUYUPGd/lwj+SPWkcwIqn7T9yy08wF0eduiE1/3Fh45TFlnsz7x+e5CyqnyZX55fEHj1f+YWFATsgs2wZwr9e+RT+aSEVntwuQ6YIoeMVYczoZJJsqj43TNr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823232; c=relaxed/simple;
	bh=yqv2wEnNz5XPyZDa5khdy8g3kJQG/M4DCFzkY61Xw2s=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZoNnttyUwEsOgVjrsW9/msWyD29U8+loLD8nEWqkkj5/ZfKzc+ZyS+UgeCsr0Go2AsnOjsiECNY3FTB7jDc6XDNuKIwjJ96i7cCHtrSUwpZ24aoYUWWeSaw2rHwesTdXupocWO2KQnSJJtMUgo0/XvaZtIgn/eN0K9ciw8rErOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi/a4Tl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi/a4Tl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11D11F000E9;
	Tue, 30 Jun 2026 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823231;
	bh=v+ylQS7T1PbxJbxcVCtCmB+Zu07GYw80PbAHrMGukNQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hi/a4Tl8t8mGGqn3T7VFYq3PYxy9QhWxY1gIaKKtiMAx+4XS9Cq8zzJGe9JptgW0U
	 IRlMMacT7LfBCmI61zHRt2IP3N/IK3mqP1KJQZ6zGEqNZAa3dHHXf7txfE9FaLkEVq
	 q0+Z+U0GRKB9FPVK2xilis6qbF6flNKDx2kXRjFOB1YWsk/uMAPLwLRqRe3Y2Pi4do
	 VftaxmxVxRVF+ha+9YChYGr/NdMhPnRstGAn/v60WXccPU3L/aZ5irak97/Ue0JTsy
	 zgamnEQgYhAyFk9pQG0S16bc9w5MoF5VW3+A8hZzE7MLXsdYSULvMPo6AsLCoo+0Xd
	 1VSIasFCxPFCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] phy: phy-can-transceiver: Add suspend operation for
 tcan1043
Reply-To: sashiko-reviews@lists.linux.dev
Cc: olteanv@gmail.com, vkoul@kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-phy@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20260630-phy-can-transceiver-suspend-resume-support-v1-1-6842c2d697e4@bootlin.com>
References: <20260630-phy-can-transceiver-suspend-resume-support-v1-1-6842c2d697e4@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:30 +0000
Message-Id: <20260630124030.F11D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `.resume` callback in PM operations leaves the CAN PHY per=
manently in Sleep mode after system resume.
- [Medium] Missing delay when transitioning through Normal mode may result =
in the transition being ignored by the transceiver hardware.
--

commit 2d2e1a772ce8aac2faea27b0135abc2a7ed70072
Author: Thomas Richard (TI) <thomas.richard@bootlin.com>

phy: phy-can-transceiver: Add suspend operation for tcan1043

This commit adds a suspend operation for the tcan1043 PHY, switching it
to Sleep mode during system suspend. It transitions the PHY through Normal
mode to clear the WAKERQ flag before entering Go-to-Sleep and finally
Sleep mode.

> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-tran=
sceiver.c
> index 75dc49e75ca0e..2bca1a173fcc3 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
[ ... ]
> @@ -76,12 +80,28 @@ static const struct phy_ops can_transceiver_phy_ops =
=3D {
>  	.owner		=3D THIS_MODULE,
>  };
> =20
> +static int tcan1043_suspend(struct can_transceiver_phy *phy)
> +{
> +	/* Switch to Normal mode, it clears WAKERQ */
> +	gpiod_set_value_cansleep(phy->standby_gpio, 0);
> +	gpiod_set_value_cansleep(phy->enable_gpio, 1);
> +
> +	/* Switch to Go-to-Sleep mode */
> +	gpiod_set_value_cansleep(phy->standby_gpio, 1);

[Severity: Medium]
Will this back-to-back GPIO toggle execute too quickly on platforms with fa=
st
memory-mapped GPIOs?

Without an intermediate delay, the sub-microsecond state change might not
give the transceiver's internal state machine enough time to register the
Normal mode transition. Can this cause the transceiver to ignore the
transition, fail to clear the WAKERQ flag, and thus fail to enter Sleep
mode?

> +
> +	/* Wait transition to Sleep mode */
> +	fsleep(5);
> +
> +	return 0;
> +}
[ ... ]
> @@ -115,6 +135,26 @@ static struct phy *can_transceiver_phy_xlate(struct =
device *dev,
>  	return priv->can_transceiver_phy[idx].generic_phy;
>  }
> =20
> +static int can_transceiver_phy_suspend(struct device *dev)
> +{
> +	struct can_transceiver_priv *priv =3D dev_get_drvdata(dev);
> +	const struct can_transceiver_data *data =3D priv->data;
> +	int ret, i;
> +
> +	for (i =3D 0; i < priv->num_ch; i++) {
> +		if (data->suspend) {
> +			ret =3D data->suspend(&priv->can_transceiver_phy[i]);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(can_transceiver_phy_pm_ops,
> +				can_transceiver_phy_suspend, NULL);

[Severity: High]
Does leaving the resume callback as NULL permanently leave the CAN PHY in
Sleep mode after a system resume?

Since the parent CAN MAC driver typically relies on the PHY framework for
power management and may not manually wake the PHY during its own resume
flow, could this prevent the CAN interface from becoming responsive again
until it is manually brought down and back up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-phy-can-tr=
ansceiver-suspend-resume-support-v1-1-6842c2d697e4@bootlin.com?part=3D1
