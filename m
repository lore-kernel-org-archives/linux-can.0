Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082070;
	b=dSVmwtrjZr2eIXLHuzY7dgQ3XL0qctDvcJ+0wTqLOG6G2XdS75xznz7ISC0/eJcF0T7n
	 YdEtAaPI2wD7qlYEdpRgIoguEOcZiLueTRRi72PnRuHJTSmdp/LnxgM4erFr2ITOHgqLJ
	 IvprnmajKj27AkmcO5SqSjMV6SCAs3AGrRAcOAD+L+RLWb+V5/VS9A5QNjcMJtwzdWgnH
	 QNf3B8EB8mZqDq8Y4RO2poTSxW+wMFPhvjc4fOEzjocqxDbtGatw5lmuuKCls4ccFLybN
	 RhAxP2Vs77o1AUlMfYa8fcOo/nrShTZBj7WYG+rj9iYGJWpbYM7OmtVi4TENJ09B8Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082070;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ygnSbKp0E7LeTYU5wwx2Ori53L3wjeW4YGehUIRv/YQ=;
	b=X3rSpwG+i8d1z3KG/1BfMS6WzH9Wz/DQ1bYoCb67DTq5EbRhf++6eGXxWkS6X8YvEEaf
	 kHi/BZ3jujc4hqnGOB0ioXqbSvIsFCXEQc0dK4tI37wF931EdG1X0ujwQARpnFhH5a5vC
	 r3Sln29mg3RsG5R1DmPE0ga5DZ4eZAxhkxQbE/ekZkjs22tmWUkkFBPyDDVad+CGWeZxp
	 DlZSTZoWxU2io7ncWeKGhIWzHU7fxdY0/s59vuITQ6ty8SU5ld2Fzpx8827jnCHU7o/+j
	 kRzoDDjuSDOIWKcPVeRtJ6VXl7VJqzB/WQVKBc6K0pfsov3si8ESl1DCvAEQfvztJ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQo5pdMI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8A606A326;
	Thu, 19 Nov 2026 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQo5pdMI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900B91F000C7;
	Thu, 19 Nov 2026 09:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082070;
	bh=ygnSbKp0E7LeTYU5wwx2Ori53L3wjeW4YGehUIRv/YQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cQo5pdMIbXBKoH6WOuy2n2rh2e6aZh5Uy5KgF5sLBA06AUUMMLKPhEG9xCVdRYQb5
	 arRjJ+EGkX4iZUIh40C2Zv1zGB+mlc6IxoPyaiCZi/Hkz15kHW2ZLM4OANlT6iaE0A
	 Jr2Q8Erb1ywg++42hOZuuhHXGouto2BNmlQzItuU7jogBhWL14h3glpNr8VXC2lSCd
	 ny0+a1YQzevjl+3hbFx9jLGjZqicmgQrsywOdRyR4a7mKHu/cloDrEspIHTxIOylV+
	 3XADDzixuaTTvVaRmeFyGzPvcNshYpP/pOrxcgP10TRYz68P0oodJId7CVaBSX8dq7
	 PwItYhfQIgo1w==
Subject: Re: [PATCH net-next 06/12] can: sun4i_can: don't discard the IRQ
 lookup error in probe
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 dev.kurt@vandijck-laurijssen.be
Date: Thu, 19 Nov 2026 09:54:29 +0000
Message-ID: <179508206916.3136.11316421181176601828@kernel.org>
In-Reply-To: <20261118092955.1283165-7-mkl@pengutronix.de>
References: <20261118092955.1283165-7-mkl@pengutronix.de>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/can/sun4i_can.c, sun4ican_probe() takes a clock
  reference with of_clk_get(np, 0) at line 847 and never releases it on…
- [Medium] The patch fixes the IRQ path.
- [Low] The commit message does not match the code.

--

can: sun4i_can: don't discard the IRQ lookup error in probe

This patch makes sun4ican_probe() return the error from platform_get_irq()
as is, instead of replacing it with -ENODEV. The goal is to let
-EPROBE_DEFER from of_irq_get() reach the driver core, so the probe is
retried once the interrupt controller appears.

Link: https://patch.msgid.link/2a7cb6e4e1b494efd4da512abbf307c19d9d1467.1792118040.git.chaosheng.qu.linux@gmail.com

> sun4ican_probe() collapses every failure of platform_get_irq() into
> -ENODEV:
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0) {
>                 err = -ENODEV;
>                 goto exit_put_clk;
>         }
>
> The driver matches through an of_match_table, so of_irq_get() returns
> -EPROBE_DEFER while the interrupt controller has not been probed. The
> probe overwrites it and the driver core stops retrying, leaving the
> device unbound even though the interrupt controller appears later.

[Severity: Low]
Is the quoted pre-patch code accurate? In this tree, the IRQ error path in
sun4ican_probe() does goto exit. There is no exit_put_clk label, and there
is no clk_put() anywhere in drivers/net/can/sun4i_can.c:

exit_free:
	free_candev(dev);
exit:
	return err;

The quote makes it look like the clock is released on this path, but it
is not.

Can the deferral described here happen with the in-tree device trees?
sun4i-a10.dtsi, sun7i-a20.dtsi, sun8i-r40.dtsi and sunxi-d1s-t113.dtsi
route the CAN interrupt to sun4i-ic, the GIC or the D1 PLIC. All of these
register early through IRQCHIP_DECLARE, for example:

IRQCHIP_DECLARE(riscv, "allwinner,sun20i-d1-plic", plic_early_probe);

So the irq domain should already exist by the time this driver probes.

If this is meant as a bug fix, should it carry a Fixes: tag for
0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel
module"), which added the -ENODEV? If it is a robustness and consistency
cleanup instead, could the message say the issue has not been seen on real
hardware, as the sibling commit "can: cc770: don't discard the IRQ lookup
error in probe" does?

> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index af52285d5a4e0..80be48d0593db 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -853,7 +853,7 @@ static int sun4ican_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		err = -ENODEV;
> +		err = irq;
>  		goto exit;
>  	}

[Severity: Medium]
Does this error path leak the clock reference taken by of_clk_get()?

sun4ican_probe() does this just before the IRQ lookup:

	clk = of_clk_get(np, 0);

The goto exit path only returns err, and nothing in the driver calls
clk_put().

Before this patch, an IRQ failure turned into -ENODEV and the probe gave
up, so the reference leaked only once. Now -EPROBE_DEFER from of_irq_get()
is passed through:

of_irq_get()
    domain = irq_find_host(oirq.np);
    if (!domain) {
        rc = -EPROBE_DEFER;
        goto out;
    }

As a result, the device goes on the deferred probe list, and
sun4ican_probe() runs again each time deferred probing is triggered.

Each retry calls of_clk_get()->__of_clk_get()->clk_hw_create_clk(). That
allocates a new struct clk, takes kref_get(&core->ref), and links the
consumer into the clk_core. If the CCU is a module, it also pins the
provider module with try_module_get(). The retry then defers again at
platform_get_irq() and all of these references leak.

The in-tree DTs use early irqchips, but the binding allows any interrupt
parent. One example is interrupts-extended pointing at a GPIO irqchip that
probes late. Would this leak then repeat for as long as the interrupt
parent stays missing?

[Severity: Medium]
The clock lookup just above this hunk discards its error in the same way
the commit message describes for the IRQ lookup:

	clk = of_clk_get(np, 0);
	if (IS_ERR(clk)) {
		dev_err(&pdev->dev, "unable to request clock\n");
		err = -ENODEV;
		goto exit;
	}

The binding (allwinner,sun4i-a10-can.yaml) lists clocks as required.
of_clk_get_hw_from_clkspec() returns -EPROBE_DEFER when the provider has
not registered yet:

	struct clk_hw *hw = ERR_PTR(-EPROBE_DEFER);

The clock comes from a sunxi-ng CCU. Those drivers (ccu-sun4i-a10.c,
ccu-sun8i-r40.c, ccu-sun20i-d1.c) are tristate module_platform_driver
drivers, so they can register after the CAN probe. fw_devlink normally
orders this, but not with fw_devlink=off or fw_devlink=permissive.

If the CCU binds late, won't the probe still fail permanently with
-ENODEV before it ever reaches the IRQ lookup fixed here? The reset lookup
and the ioremap already return PTR_ERR(), so this is the only lookup left
that discards the error.

Since the clk leak above needs a respin anyway, could that version also
use err = PTR_ERR(clk), or switch to devm_clk_get()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118092955.1283165-2-mkl%40pengutronix.de
