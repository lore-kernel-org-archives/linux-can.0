Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C4372EE2
	for <linux-can@vger.kernel.org>; Sat, 10 Oct 2026 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639841; cv=none; b=Xv+MgfdnHWul/HEuXNhPVcS3Y+K+Hc/gOoMe0Tog/qkpj3SXtd8/ENzcrmVDvjdti2Nw2xQ8Gpkwq7kLo1IZXqVdutmNhVgaETa4Ut7MxY/OgZbLoO/ngFDa1MXOKLbgqXRV6f9pz5IrcDboTBoG3vsTacxKprLvtDLaIzAcRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639841; c=relaxed/simple;
	bh=Sjpc1prBJTww9g86OkSf7n3QQ6XmztgEKvaOQgrHXwA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rqSHwosdvH/cO6km6juvYmHm48fF5Ke/tlg5FjhbWnzN6QLsoQ4Wv8vi46g0/55/cmCAFjwGVe0MJdHbRcI5vhCyN1nqO9HA9b7AlZEpj71Ja1uoY3qSt2YxBhWw5P37CtHsvo9z2JoUZkqzVbuy+Jp19kJBBVKOcu1rAsryB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNrR+A9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNrR+A9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604351F00893;
	Sat, 10 Oct 2026 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639840;
	bh=v7c5yVMeNhfwq8bgto1dfws3xB/b3gDkqYNIozRYjpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fNrR+A9a6ZVUtKTlqZVoDwR03UZ2btrhRQEq7R8eObVziA+5OMcCairjBAPe5U0jG
	 n0YS+Q6uC6ojQmzqv7x5AGLKxVsEWOmEWmdd+Ohwdva648cRecUZCISqRKwQZrodbR
	 THGPDsNFO9LClGFxXO4t9twwU+ihgl8Eag2NjQVpv7/eCOsNUqXUBtFVrcvq+zK9+s
	 lqLDAawzb10VnBhyhytoMhU8V4pvJwLmGRuaNNbxjcyWr4xNd+huHILfAvJ8zJ4l9E
	 2VPlb14gPJRwfGe7L9YRt9jC4czAdm9JjkRTd38cC60JSw06PU5+DUa/gcecEx2UGY
	 jYFy02fpx3cHQ==
Message-ID: <sashiko-outbox-166613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 23/37] can: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20261009134323.64064-24-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009134323.64064-24-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:43:59 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: m_can/bxcan: bus fault on shared IRQ during suspend
--

commit 67e577fb01461ec0237b4358b708fb235942190b
Author: Triet Hoang <triet.hoang.dev@gmail.com>

    can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
   =20
    Convert the deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS and
    pm_sleep_ptr().
   =20
    This lets us drop the __maybe_unused annotations from the suspend and
    resume callbacks, also reduces kernel size in case CONFIG_PM or
    CONFIG_PM_SLEEP is disabled.
   =20
    Link: https://patch.msgid.link/20260822074701.22856-1-triet.hoang.dev@g=
mail.com

> diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
> index 4bddd015775bc..622c5d73e33a8 100644
> --- a/drivers/net/can/bxcan.c
> +++ b/drivers/net/can/bxcan.c
> @@ -1042,20 +1042,19 @@ static void bxcan_remove(struct platform_device *=
pdev)
[ ... ]
> -static int __maybe_unused bxcan_suspend(struct device *dev)
> +static int bxcan_suspend(struct device *dev)
>  {
>  	struct net_device *ndev =3D dev_get_drvdata(dev);
>  	struct bxcan_priv *priv =3D netdev_priv(ndev);
> =20
>  	if (!netif_running(ndev))
>  		return 0;
> =20
>  	netif_stop_queue(ndev);
>  	netif_device_detach(ndev);
> =20
>  	bxcan_enter_sleep_mode(priv);
>  	priv->can.state =3D CAN_STATE_SLEEPING;
>  	clk_disable_unprepare(priv->clk);
        ^^^^

[Severity: High]
Is it possible for the shared IRQ to fire after the clocks are disabled her=
e?

If another device sharing the same IRQ line triggers an interrupt before the
suspend_noirq phase, or if the interrupt is configured as a wakeup source, =
the
kernel will invoke bxcan_rx_isr().

Since bxcan_rx_isr() reads MMIO registers (like rf0r =3D readl(&regs->rf0r))
unconditionally when called, could this cause a bus fault and system crash =
if
the clock is stopped?

>  	return 0;
>  }

> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_=
can_pci.c
> index d11a7c88fc32f..d31179312026b 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -169,17 +169,17 @@ static void m_can_pci_remove(struct pci_dev *pci)
[ ... ]
> -static __maybe_unused int m_can_pci_suspend(struct device *dev)
> +static int m_can_pci_suspend(struct device *dev)
>  {
>  	return m_can_class_suspend(dev);
        ^^^^

[Severity: High]
Does this suspend path have a similar regression with shared IRQs?

m_can_class_suspend() calls m_can_clk_stop() which disables the peripheral
clocks, but the shared IRQ is left registered. If the interrupt fires
subsequently, m_can_interrupt_handler() will execute.

While m_can_interrupt_handler() checks pm_runtime_suspended(), this evaluat=
es
to false during system suspend if the device was active prior to sleep. The
handler will then attempt an MMIO read via m_can_read(cdev, M_CAN_IR), which
could cause a bus fault on an unclocked peripheral.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134323.6406=
4-1-mkl@pengutronix.de?part=3D23
