Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A813909A5
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025637; cv=none; b=Ee6RMR4pa872qNcqVCWoL+o/aXX/gZZ/4fLAp23MukHqM3284vz2jVK/Y705imvHw8vtiYJUkrlMtJTgJu2VanO28jozDNlbuoyHbAUy2But8tBzc6IN7DeEJmS0c9uBcoVxBJ7VIcNo4HWTK4OTF+TOq8whcWRaELVK8xJNtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025637; c=relaxed/simple;
	bh=OBKl+RDJajCxqaLXJFiTOBtbx3Vhbz6logjkB6l1H48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZXCskVlNYk06U3+Z3KqsOf+ETFiJonlMJ3blDajKbI3ThyYYSp7RVshv1lyFCDJvcCS6tgIDAwJaiUx2p+lmW78KLRrwPylaHV0KJ3G3olFrRzYK6pRwaBxOkIAyzR/W6ZvTQSMKjVdGUblXjDBwwrWaaH3oukPQl9rEni5qagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf2CeJ2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf2CeJ2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC92A1F00A3A;
	Thu,  6 Aug 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025633;
	bh=nO2w6c0BHXTBMZBjWkljQzMouvNsWTq8PrUMp7QeE5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kf2CeJ2wvqo8DpHhjlq/zvcddJCDlKocOnLKQ2+XL/XhdegXdftlLX2CDMzG91xRd
	 +Xbls8lHWYERFCrw0CoSj/bbmWeGLl8eqBng/w+fPznvPdSJ8UQHrtCycO1D4PcPTm
	 UDywlC7VEBNLfSM54H5xOCU8+32c4L64HCL1PHMejxzNFKnNZ/H/AzR2QQNlcTzPtZ
	 QgPyYOFPzb6qFKyjFcRqtdUGcKHPZbJ4YLE5N1rfi/+Op/R6jvUnoUaFjgQkxOqSPC
	 4BYRKB8lI0mARxHe34OG8gy04EwOlpXt+Ed5+6ejwf17JNmYbJyIlLd8mb+mrMmiSH
	 zqjGclxA99ipg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: ctucanfd: ctucan_err_interrupt(): do not emit info
 messages on Arbitration Lost or CAN Bus Error IRQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260806-ctucanfd-silence-can-bus-error-messages-v1-1-70eff67debfd@pengutronix.de>
References: <20260806-ctucanfd-silence-can-bus-error-messages-v1-1-70eff67debfd@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 14:13:52 +0000
Message-Id: <20260806141352.BC92A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional evaluation of the global `net_ratelimit()` in a high=
-frequency (10kHz) interrupt handler exhausts the global network ratelimit =
token bucket and causes lock contention, effectively silencing rate-limited=
 messages across the entire networking subsystem. Furthermore, the generic =
`netdev_info` print at the top of the function still executes for these noi=
sy interrupts, meaning the patch fails to completely fix the log flooding i=
t aimed to resolve.
--

--- Patch [1]: [PATCH] can: ctucanfd: ctucan_err_interrupt(): do not emit i=
nfo messages on Arbitration Lost or CAN Bus Error IRQs ---
commit 5e775ed40c20c9c562c6441b9b627d0ada3f07fd
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: ctucanfd: ctucan_err_interrupt(): do not emit info messages on Arbitra=
tion Lost or CAN Bus Error IRQs

With CAN Bus Error reporting enabled, Arbitration Lost and Bus Error
interrupts can occur at a very high rate (~10kHz). To avoid flooding the
system, this commit stops emitting specific netdev_info messages for these
interrupts.

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/c=
tucanfd/ctucanfd_base.c
> index 07d4aa43c700a..9aec18681fc54 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -884,8 +884,6 @@ static void ctucan_err_interrupt(struct net_device *n=
dev, u32 isr)

[Severity: High]
This isn't a bug introduced by this patch, but does calling net_ratelimit()
unconditionally at the top of this function exhaust the global rate limit
token bucket?

Looking at ctucan_err_interrupt() earlier in this file:

	int dologerr =3D net_ratelimit();

	ctucan_get_rec_tec(priv, &bec);
	state =3D ctucan_read_fault_state(priv);
	err_capt_alc =3D ctucan_read32(priv, CTUCANFD_ERR_CAPT);

	if (dologerr)
		netdev_info(ndev, "%s: ISR =3D 0x%08x...

Since ALI and BEI interrupts can still occur at ~10kHz and trigger this
handler, won't this still drain the shared ratelimit budget and cause lock
contention on net_ratelimit_state.lock for the rest of the networking
subsystem?

Also, since the generic netdev_info log statement above is still executed
for these noisy interrupts, does this patch completely fix the log flooding
it aims to resolve?

> =20
>  	/* Check for Arbitration Lost interrupt */
>  	if (FIELD_GET(REG_INT_STAT_ALI, isr)) {
> -		if (dologerr)
> -			netdev_info(ndev, "arbitration lost\n");
>  		priv->can.can_stats.arbitration_lost++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-ctucanfd-s=
ilence-can-bus-error-messages-v1-1-70eff67debfd@pengutronix.de?part=3D1
