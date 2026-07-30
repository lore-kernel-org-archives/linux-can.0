Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E2A3D3486
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407403; cv=none; b=DCw1DCu4YUBmqUTNGmUYnzOVUjwuYrxPEa8nAG2YNgD337Q0lAU5PKix47IFghZA4oabX4ViItsvfF95x3LIkIVK5gsMHBBY6hE363iLDTBJnp6redoPgKj/mWulQoP18kZtfbTrdzPvk9wXDyfAYST1pfLAiZYnRrLDP8894DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407403; c=relaxed/simple;
	bh=uBDGqqK8DDeK2+vYhsKNRLpIv4O8adU9OisiyP2w9Ls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTAiy9aZiZOYWCMIATzzy0xZbnVTS2g5mXDCrUFZwixdEmJuetTCdEGIbnIl2bsy++M70utYqAYkxjs6zx6gY5xzFBzADm2w11CP0IAZQ6oJogW40VbbdVoSfXpnFMz5TKsZ0PzPB+wlqm9D7DTYRufqKQgBlx7Xy0V0FDIrFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvmJu9Y5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvmJu9Y5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55EC1F00A3A;
	Thu, 30 Jul 2026 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407401;
	bh=F3V3DS6jcjr8RwVcizQNAanOsdmz6BbTu2Ajr2vkNqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IvmJu9Y5qLRgSya6dlZTAkosFavo/Lmwkxv+JGLq18LI9jdwJbbTnJANv7TAYAA33
	 jgdBFR4jg3dBYRGacfRKxm3jsDp9HdlPkAo4tg27mzFAniW/8ax1KsczSN3owu+Ydj
	 3BegxoodGPeur0TC4cTU1awqcnJsTY2J2lvYEpvBUS6vepPJ2nrMuara1sM8xpK/DV
	 oCtI+iAbz5ith6EbNR2BmZ88CTsTMMQy0VRS7RX7kVEYiKy0IvHkno0VstPrZKhulN
	 YNhhIEwlmAK5bBJfELsKnCSHsvH6xSiPgXU8SD4cTFiOUx6gzm4ZidcRMuyF8eM6B8
	 F8pY9P2EIKz7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 17/20] can: c_can: c_can_chip_config(): keep
 controller in init mode until bittiming is configured
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260729102802.505168-18-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-18-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:30:00 +0000
Message-Id: <20260730103000.A55EC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] c_can_set_bittiming() inadvertently resets C_CAN_TEST_REG, breakin=
g loopback and listen-only modes.
--

--- Patch [17]: [PATCH net 17/20] can: c_can: c_can_chip_config(): keep con=
troller in init mode until bittiming is configured ---
commit 43c179b24ec630378edf5e7aee260bd073975b00
Author: Lucas Martins Alves <lucas.alves@lumal21.com.br>

can: c_can: c_can_chip_config(): keep controller in init mode until bittimi=
ng is configured

c_can_chip_config() was programming C_CAN_CTRL_REG without CONTROL_INIT,
which may allow the controller to become active before
c_can_set_bittiming() finishes.

Link: https://patch.msgid.link/20260714164839.771123-1-lucas.alves@lumal21.=
com.br

> diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c=
_can_main.c
> index 3702cac7fbf0f..b3b321d9ce68d 100644
> --- a/drivers/net/can/c_can/c_can_main.c
> +++ b/drivers/net/can/c_can/c_can_main.c
> @@ -597,20 +597,20 @@ static int c_can_chip_config(struct net_device *dev)
>  		return err;
> =20
>  	/* enable automatic retransmission */
> -	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR);
> +	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR | CONTROL_INIT);
> =20
>  	if ((priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) &&
>  	    (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)) {
>  		/* loopback + silent mode : useful for hot self-test */
> -		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
> +		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST | CONTROL_INIT);
>  		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK | TEST_SILENT);
>  	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
>  		/* loopback mode : useful for self-test function */
> -		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
> +		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST | CONTROL_INIT);
>  		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK);
>  	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
>  		/* silent mode : bus-monitoring mode */
> -		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
> +		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST | CONTROL_INIT);
>  		priv->write_reg(priv, C_CAN_TEST_REG, TEST_SILENT);
>  	}
> =20

[Severity: High]
This isn't a bug introduced by this patch, but doesn't the subsequent call =
to
c_can_set_bittiming() at the end of c_can_chip_config() unconditionally cle=
ar
the CONTROL_TEST bit?

c_can_set_bittiming() executes this:
	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_CCE | CONTROL_INIT);

Because this write does not include CONTROL_TEST, it gets cleared. Accordin=
g to
the Bosch C_CAN hardware manual, clearing the Test bit instantly resets the
Test Register to its default value (0x00).

Does this silently erase the loopback and listen-only modes configured here,
causing the controller to incorrectly operate in normal mode and potentially
cause active disruption on a live CAN bus?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D17
