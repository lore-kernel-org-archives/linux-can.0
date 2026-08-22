Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3631F98A
	for <linux-can@vger.kernel.org>; Sat, 22 Aug 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385826; cv=none; b=jYppcYFMiOLCj05ZUwUeGOsvef0g61c3c6xCV0nZ6Mw0ZURbTdH+DL8Z9tLThGQYCPgR0G+rUGvL4FsPbsuSxqW1LnJxg1xkXl/6GUpd1qH5K2xDzn7vPhhuEjQbS3p9cr7ljTPPKQEMZdCdEqrwLFzDSl0RF8F8HP/EXpIHYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385826; c=relaxed/simple;
	bh=wiFEkjhMacHgV4/zvW6O+kv1capTmI31zGvQDqKs7+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bQdIWOZjIknLFLOfGF1aPoVsL0R48TvYK+dQpgP/p+JrbOA7yjE5gbII5aKqC1bi0w77J/0CZ0ichdQLhFBf1og0uyiqmG/jv7qdxyxhUxx7NIkFwHe0aXl00LG2uhXYTuiplg6tK9l59gX+WgJvU1YGure09vfuxFVQ8apPYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlqNQMID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlqNQMID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E951F000E9;
	Sat, 22 Aug 2026 08:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787385825;
	bh=oaudmGYTRyWXBrBh4ZbFfTyqtszs/PAFxZkEO4Td2h4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MlqNQMIDEhwRu7AGwPpsXAFgiC9k9AaBv9VTdbeQUhkifxMu8SnRjG+MozTOFGaQw
	 SHMnA+Dk9GOpAGXf9Emohl5soTP36I2dZwS1S/8SD7SmU4YxJSAuPaK3phlWlB1Knw
	 JvcvhMBruAWVMlJ5q2xgTU8z0hmHmWE40b/s8FDMPp+ozPAKHFAe5Egg07StFqicLI
	 9n4Oi1zCW6vxmvdFy2556dAkD0caOFKTQTvfCT9VATCb2Ud/yD113tEWGRY1siliTZ
	 khgTlCzW/IZbqCDGCLnIoh+Kn/BVkmaBaUKbFXUEjTgP3R1GKMeIR3bIUqHDaVkNgi
	 tkg8MxZpi+iQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260822074701.22856-1-triet.hoang.dev@gmail.com>
References: <20260822074701.22856-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 08:03:44 +0000
Message-Id: <20260822080344.D0E951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing synchronous cancellation of the polling hrtimer during dev=
ice teardown leads to a use-after-free.
- [High] Workqueue is flushed after the device's power has been disabled, c=
ausing pending works to access unpowered hardware.
- [High] Missing IRQ synchronization in bxcan_suspend causes a system crash=
 when a shared interrupt fires.
- [High] Missing NAPI synchronization in m_can_class_suspend allows concurr=
ent access to unclocked registers.
- [High] Missing NAPI and IRQ synchronization in ctucan_suspend leads to us=
e-after-suspend register access.
--

--- Patch [1]: [PATCH] net: can: Convert to DEFINE_SIMPLE_DEV_PM_OPS() ---
commit a15538c2b4418f8d2120cca5fc551587851481fe
Author: Triet Hoang <triet.hoang.dev@gmail.com>

net: can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
   =20
Convert the deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the suspend
and resume callbacks, also reduces kernel size in case CONFIG_PM
or CONFIG_PM_SLEEP is disabled.

> diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
> index baf494d20bef4..b2a0ff8c033cc 100644
> --- a/drivers/net/can/bxcan.c
> +++ b/drivers/net/can/bxcan.c
[ ... ]
> -static int __maybe_unused bxcan_suspend(struct device *dev)
> +static int bxcan_suspend(struct device *dev)
>  {
>  	struct net_device *ndev =3D dev_get_drvdata(dev);
>  	struct bxcan_priv *priv =3D netdev_priv(ndev);

[Severity: High]
This is a pre-existing issue, but does this suspend logic correctly handle
shared interrupts?

In bxcan_suspend(), the device clock is turned off:

bxcan_suspend() {
	...
	bxcan_enter_sleep_mode(priv);
	priv->can.state =3D CAN_STATE_SLEEPING;
	clk_disable_unprepare(priv->clk);
	return 0;
}

If another device sharing the same IRQ line triggers an interrupt while the
clock is disabled, the kernel will execute bxcan_rx_isr() and unconditional=
ly
attempt to read regs->rf0r. Would reading from this unclocked peripheral
register cause a fatal bus fault?

[ ... ]
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ct=
ucanfd/ctucanfd_pci.c
> index 4b6db28f7b670..9c9c41c3058c0 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
[ ... ]
> -static SIMPLE_DEV_PM_OPS(ctucan_pci_pm_ops, ctucan_suspend, ctucan_resum=
e);
> +static DEFINE_SIMPLE_DEV_PM_OPS(ctucan_pci_pm_ops, ctucan_suspend, ctuca=
n_resume);

[Severity: High]
This isn't a bug introduced by this patch, but does ctucan_suspend() proper=
ly
disable hardware interrupts and NAPI?

It transitions the device state to CAN_STATE_SLEEPING, but leaves interrupts
and NAPI active before returning.

When the parent PCI bus transitions the device to a low-power state and MMIO
access is disabled, could a shared interrupt or scheduled NAPI handler read
from the powered-down MMIO space?

Reading from powered-down MMIO typically returns 0xFFFFFFFF, which might ca=
use
the ISR to assume all interrupts are active, scheduling NAPI again and
potentially entering an infinite polling loop.

[ ... ]
> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_=
can_pci.c
> index d11a7c88fc32f..d31179312026b 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -169,17 +169,17 @@ static void m_can_pci_remove(struct pci_dev *pci)
>  	pci_free_irq_vectors(pci);
>  }

[Severity: High]
This is a pre-existing issue, but could this lead to a use-after-free during
device teardown?

In m_can_pci_remove(), we call m_can_class_free_dev(), which frees the memo=
ry
backing the device:

m_can_pci_remove() {
	...
	m_can_class_unregister(mcan_class);
	m_can_class_free_dev(mcan_class->net);
	pci_free_irq_vectors(pci);
}

However, earlier in the unregister path (m_can_close() calling
m_can_disable_all_interrupts()), it uses hrtimer_try_to_cancel().

Because hrtimer_try_to_cancel() does not wait for the timer callback to fin=
ish
if it's currently executing on another CPU, if the timer is still running,
could the callback subsequently access the freed cdev->can.state?

> -static __maybe_unused int m_can_pci_suspend(struct device *dev)
> +static int m_can_pci_suspend(struct device *dev)
>  {
>  	return m_can_class_suspend(dev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can this suspend flow lead t=
o a
system crash due to a NAPI race?

m_can_class_suspend() disables device clocks via m_can_clk_stop() without
explicitly disabling NAPI:

m_can_class_suspend() {
	...
		} else {
			m_can_stop(ndev);
		}

		m_can_clk_stop(cdev);
		cdev->can.state =3D CAN_STATE_SLEEPING;
	}
	...
}

If an interrupt fires just before or during suspend, napi_schedule() can qu=
eue
the NAPI poll function (m_can_poll). Could this asynchronous softirq execute
after the clocks are turned off and read the M_CAN_IR register from the
unclocked peripheral, triggering a bus fault?

[ ... ]
> diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> index ae90e6716de5b..076a3efa1bfff 100644
> --- a/drivers/net/can/spi/hi311x.c
> +++ b/drivers/net/can/spi/hi311x.c
> @@ -972,7 +972,7 @@ static void hi3110_can_remove(struct spi_device *spi)
>  	free_candev(net);
>  }

[Severity: High]
This is a pre-existing issue, but does this workqueue teardown order cause
pending works to access unpowered hardware?

In hi3110_can_remove() (and similarly in mcp251x_can_remove()), the device
power regulators are disabled before calling destroy_workqueue(priv->wq):

hi3110_can_remove() {
	...
	hi3110_power_enable(priv->power, 0);

	destroy_workqueue(priv->wq);
	priv->wq =3D NULL;
	...
}

Since destroy_workqueue() synchronously flushes any pending work items, cou=
ld a
pending restart_work execute and attempt to communicate with the SPI device
while its power regulators are already turned off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822074701.2285=
6-1-triet.hoang.dev@gmail.com?part=3D1
