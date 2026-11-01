Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793537493;
	b=yM7503NBK3Sml+1HxYYCapz8ubbxkQY4fEZaMh1damSMPjrXx6/P456c3DAn23LwJBP+
	 fQmajZ9JD8+w+2vb0EchBBoxLKKWtIs8SL0QWtXjOoe19+Mm0ZH4UgXfpMA5DjiKbD7Aa
	 7rn0r1AnSOFl2psToMGlhq7lUlUPv1MBv3qlsShViFcLB8weEuMQZmnQ8C9UKIwYteYhZ
	 wvNOa3AOLDSXcZEj1p+R7Oi3Aeb9ym+xgQnmWXSJf8ksHZNyCFOpQPLoS+bzwXgNn3ITs
	 P6JoAlaGDOEodggu3mIvJeWBDlNMXT7vl5PSRcHVyjDc5P7iPoyISMcltWKt5PZXLQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793537493;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/yH3sEyaKulpngVkZ8vP3Q7iirhuq9rycYyh4cMRasA=;
	b=BNPYUEjhJ0bBYewKIx+O7Owgz+tCqOosHMn8C4/p8bKKNse7z70zi/uSJMvtk5tYK4Z5
	 92BwneHkibYiSRFQuVG1w0atT/ApcdjyEvoX6YG6ePzslTHUmO3SDFOltth+Z9wUGT4Qm
	 JLgNmYTr20ZTKPj2t1ltZ6RZXvPIVppHjIfdaGy2qnSk9BA7jNaq1xruQtnCLkHHvIpxz
	 gK4sRAk3qjEg8x41Vj+RmSkJt39q3WY6Iy/V7TkeTU5ZVVZV5/gyFN1+XJigyt2JUXj0K
	 oOu7vVMO79qOV0PZwNzz8azoLl857q+71A1LT5lJiYk5O6KbD9p/mhHlExXl4o1BadQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBoDaGw6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC060606A324;
	Sun,  1 Nov 2026 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBoDaGw6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66611F000C1;
	Sun,  1 Nov 2026 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793537492;
	bh=/yH3sEyaKulpngVkZ8vP3Q7iirhuq9rycYyh4cMRasA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YBoDaGw6GW154m6un1pq1EgKNifOYMs5KH2nEoL+1MAqO65VAUuFHjB4B1Jm/wkcP
	 ognEGG1UiF5LavsOhP3uNR7FQgujIKkRWGiTgclICqoWFjlPm9/zCyGHXrAznjG38c
	 ELapRiYalHqqFnjT9uRvT+8zw5ctrwK/wIvmmA+aXAZbYU+hyoBjxhIaQHgWiV3Sm+
	 6E67IStYvv0vGLLXJI95yhXDKzwDEXAYDa1hfI1XV5PsVrvivnVrvX/WXEHLaqLvAz
	 WS9t/dMG6Sz4BezVxGR240nJZQCjhP5GMHfvD46Jn3E2owUBt/9t3D89f/ULm0VX9A
	 ULheU/DaoURlA==
Subject:
 Re: [PATCH v2 3/3] can: ifi_canfd: enable NAPI before starting the controller
From: netdev-bot+sashiko@kernel.org
To: patrzhan@amazon.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org,
 pisa@cmp.felk.cvut.cz, ondrej.ille@gmail.com, harini.t@amd.com,
 michal.simek@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sun, 01 Nov 2026 12:51:31 +0000
Message-ID: <179353749137.3127.3654469722382202292@kernel.org>
In-Reply-To: <20261030233330.3483988-4-patrzhan@amazon.com>
References: <20261030233330.3483988-4-patrzhan@amazon.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In ifi_canfd_open() (drivers/net/can/ifi_canfd/ifi_canfd.c),
  enabling NAPI before ifi_canfd_start() lets ifi_canfd_poll() run in…
- [Low] The new open sequence never puts IFI_CANFD_IRQMASK into a known
  masked state before napi_enable().
- [Low] The comment added in ifi_canfd_open() (lines 857-859) reads "Keep
  between the reset and ifi_canfd_start(): the ISR masks the interrupts…

--

can: ifi_canfd: enable NAPI before starting the controller

This splits the IP reset, configuration and interrupt status clear out of
ifi_canfd_start() into a new ifi_canfd_reset_config(). ifi_canfd_open()
now calls ifi_canfd_reset_config(), synchronize_irq() and napi_enable()
before ifi_canfd_start(). An early RX interrupt can then schedule the poll
instead of having the schedule dropped. The bus-off restart path in
ifi_canfd_set_mode() calls both halves in sequence.

> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
> index 0f83335e4d075..0ff766c7e786a 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -734,10 +734,9 @@ static void ifi_canfd_set_filters(struct net_device *ndev)
>  			     IFI_CANFD_FILTER_IDENT_IDE);
>  }
>  
> -static void ifi_canfd_start(struct net_device *ndev)
> +static void ifi_canfd_reset_config(struct net_device *ndev)
>  {

[ ... ]

> @@ -760,6 +759,12 @@ static void ifi_canfd_start(struct net_device *ndev)
>  	/* Clear all pending interrupts */
>  	writel((u32)(~IFI_CANFD_INTERRUPT_SET_IRQ),
>  	       priv->base + IFI_CANFD_INTERRUPT);
> +}

[Severity: Low]
The commit message says "The controller stays disabled until
ifi_canfd_start() unmasks the interrupts and enables it". However,
ifi_canfd_reset_config() never writes IFI_CANFD_IRQMASK. Does the driver
know the interrupt mask state in the window after napi_enable()?

On a re-open, the last IRQMASK write was in ifi_canfd_stop():

	/* Reset the IP */
	writel(IFI_CANFD_STCMD_HARDRESET, priv->base + IFI_CANFD_STCMD);

	/* Mask all interrupts */
	writel(~0, priv->base + IFI_CANFD_IRQMASK);

ifi_canfd_irq_enable() treats SET_ERR, SET_TS, SET_TX and SET_RX as group
write qualifiers. A source bit of 1 enables that source, and it masks by
writing only the SET_* bits. Under that encoding, ~0 would enable every
source, including ones that ifi_canfd_irq_enable(ndev, 1) never enables.

Suppose HARDRESET does not clear IRQMASK. On a dedicated IRQ line, an
rx-class status bit that latches after the final INTERRUPT clear here
would then raise the interrupt. With NAPI now enabled, the poll would run
alongside ifi_canfd_start().

The ~0 write predates this patch, and the v2 notes say it could not be
confirmed to mask. Enabling NAPI inside this window is what makes it
matter now.

Would calling ifi_canfd_irq_enable(ndev, 0) in ifi_canfd_reset_config(),
before the final INTERRUPT clear, put the mask into a known state? The ISR
already relies on that encoding to mask. ifi_canfd_stop() could also use
the same helper instead of ~0.

Neither change covers a shared-line invocation, because the ISR reads the
raw status regardless of the mask.

[ ... ]

> @@ -846,9 +852,14 @@ static int ifi_canfd_open(struct net_device *ndev)
>  		goto err_irq;
>  	}
>  
> +	ifi_canfd_reset_config(ndev);
> +	synchronize_irq(ndev->irq);
> +	/* Keep between the reset and ifi_canfd_start(): the ISR masks the
> +	 * interrupts and only the poll unmasks them.
> +	 */

[Severity: Low]
Is "only the poll unmasks them" accurate? ifi_canfd_start() is called
right after this and also unmasks, through ifi_canfd_irq_enable(ndev, 1).
The same happens from ifi_canfd_set_mode(CAN_MODE_START).

The comment also only explains why napi_enable() has to come before
ifi_canfd_start(). Could it also say why it has to come after
ifi_canfd_reset_config() and synchronize_irq()?

The IRQF_SHARED handler acts on the raw IFI_CANFD_INTERRUPT status, so
stale status could schedule a poll that races with the HARDRESET and FIFO
reset. synchronize_irq() makes sure the schedule from an in-flight
handler is still dropped.

As written, the comment gives no warning to a later change that moves
napi_enable() above the reset or drops synchronize_irq().

> +	napi_enable(&priv->napi);
>  	ifi_canfd_start(ndev);

[Severity: Medium]
With NAPI enabled here, can ifi_canfd_poll() now run at the same time as
the rest of ifi_canfd_start()?

synchronize_irq() only waits for handlers that are already running. The
handler is registered with IRQF_SHARED, so it can be invoked again after
that point, and it acts on the raw IFI_CANFD_INTERRUPT status:

ifi_canfd_isr() {
	...
	if (isr & rx_irq_mask) {
		ifi_canfd_irq_enable(ndev, 0);
		napi_schedule(&priv->napi);
	}
	...
}

On the open path this schedule used to be dropped, and now it succeeds.
The poll then overlaps these writes in ifi_canfd_start(), none of which
hold a lock:

	priv->can.state = CAN_STATE_ERROR_ACTIVE;

	ifi_canfd_irq_enable(ndev, 1);

	/* Unlock, reset and enable the error counter. */
	writel(IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC,
	       priv->base + IFI_CANFD_ERROR_CTR);
	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);

On the poll side, ifi_canfd_poll()->ifi_canfd_handle_state_errors()
compares the STCMD status bits of the still-disabled controller with the
stale priv->can.state, which is CAN_STATE_STOPPED. If BUSOFF reads as set,
ifi_canfd_handle_state_change() does:

		priv->can.state = CAN_STATE_BUS_OFF;
		ifi_canfd_irq_enable(ndev, 0);
		priv->can.can_stats.bus_off++;
		can_bus_off(ndev);

This turns the carrier off in the middle of open(). ifi_canfd_start() then
overwrites the state with CAN_STATE_ERROR_ACTIVE, so the driver state and
the carrier state disagree. In the milder case, a spurious ERROR_ACTIVE
error frame is sent and error_warning is incremented.

With CAN_CTRLMODE_BERR_REPORTING set, ifi_canfd_handle_lec_err() does:

	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
	writel(IFI_CANFD_INTERRUPT_ERROR_COUNTER,
	       priv->base + IFI_CANFD_INTERRUPT);
	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);

Could these interleave with the unlock/reset/enable sequence in
ifi_canfd_start() and leave the error counter in an inconsistent state?

The driver alone doesn't show whether the IP latches these status bits, or
reports BUSOFF in STCMD, while STCMD_ENABLE is clear. The v2 notes
acknowledge this overlap. The bus-off restart path in ifi_canfd_set_mode()
already has it, but it is new on the open path.

Would it work to move the priv->can.state assignment and the ERROR_CTR
unlock/reset/enable writes into ifi_canfd_reset_config(), before
napi_enable()? That would leave only the interrupt unmask and the STCMD
enable in ifi_canfd_start().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030233330.3483988-1-patrzhan%40amazon.com
