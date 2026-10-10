Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ECE49553A;
	Sat, 10 Oct 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640989; cv=none; b=e3okeylc2kHyeSM/V41+iom3p/UEynpUZEtMO/uytmZLwS4sPPNHkc6fxWwk+32/nFRBxFjKp8v+wCJIPjMZnyx9/lUfjbYoRXTy0DE5K8ACTe5V9j4kYsw1YVNN0IyNET1VzYHi2HVtUfCFhpiRBpSI8Wtd41O2KPGXxZH9q+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640989; c=relaxed/simple;
	bh=/i0zZ1+ZKNtJNc2vuQektu7Q1aE22c1b2utELNoLUYE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEeSfVcRsCB0lPBBUOYfQS12sDmnVTm2DudifUHXwvMBasIuGhgKUF7ogpIBViALqhuRoHiEVzwDKRF/Y/50igODcgKkEvCNev/x3GKmcgaA6pjN/Fh9yewnz1X1R1Ixw00hZlWiiWTBr6OIhdU515tR0wGQ41AHXP5BfOzn6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LahTTr/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LahTTr/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DAB1F000FF;
	Sat, 10 Oct 2026 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640988;
	bh=haMw7OVO9a0gWHueNvHYagqRiFVRicnLdUua2mx0zfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LahTTr/NngUt09pm3sy6tu96eSs1/oFGAGJ06VirDnVVfEosLLbtyEZkdQGs3YBLa
	 LrxqF0lhsNHCuo6pCLBHpQA5AD39GMjyaMKiM37WM0Ec+wZPaL3Lk8i38UCGLq3Ugc
	 acrQy+bC6U4CzeqaOjsg8+LRRHLfjvq2TMHASzm+JRPy7f+EUmQBin4KfNjy7e7swc
	 puma6h4bwYPfRZIJgyfEGNG/58C+OUkWtOe9F5MMyUlWglWUHQGtLongY7laGDTKMv
	 WGl5hjZqpLMAlaH0kgWmZ6HBGtIRY3jjmtxAMTW5UGxErgXAnZgQRpwjCyum3v/IKU
	 FszS69PNkC0uA==
Subject:
 Re: [PATCH net-next 35/37] can: sun4i_can: sun4ican_probe(): fix clk leak
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:03:07 +0000
Message-ID: <179164098741.434549.8861826105737099024@kernel.org>
In-Reply-To: <20261009134323.64064-36-mkl@pengutronix.de>
References: <20261009134323.64064-36-mkl@pengutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the of_clk_get() clock reference still
  leaks when the device is removed.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  sun4ican_probe() replaces the real error codes from of_clk_get() and…

--

can: sun4i_can: sun4ican_probe(): fix clk leak

This commit adds an exit_put_clk label to sun4ican_probe(). The clock
reference taken with of_clk_get() is now released with clk_put() when
platform_get_irq(), devm_platform_ioremap_resource(), alloc_candev() or
register_candev() fails.

Link: https://patch.msgid.link/20260917104514.2147347-1-vulab@iscas.ac.cn

> diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
> index af52285d5a4e0..311526107ed81 100644
> --- a/drivers/net/can/sun4i_can.c
> +++ b/drivers/net/can/sun4i_can.c
> @@ -854,13 +854,13 @@ static int sun4ican_probe(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		err = -ENODEV;
> -		goto exit;
> +		goto exit_put_clk;
>  	}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but
this block is being touched anyway. Does replacing the return value of
platform_get_irq() with -ENODEV break probe deferral?

platform_get_irq() can return -EPROBE_DEFER. For example, of_irq_get()
returns it when irq_find_host() cannot find the interrupt controller
domain yet.

The of_clk_get() error path a few lines above does the same thing:

	clk = of_clk_get(np, 0);
	if (IS_ERR(clk)) {
		dev_err(&pdev->dev, "unable to request clock\n");
		err = -ENODEV;
		goto exit;
	}

of_clk_get() returns -EPROBE_DEFER when the clock provider has not
registered yet.

The driver core only retries a probe that returns -EPROBE_DEFER. If the
clock provider or interrupt controller registers after this driver
probes, would the CAN interface ever bind? Would it be better to return
PTR_ERR(clk) and irq instead?

[ ... ]

> @@ -908,6 +908,8 @@ static int sun4ican_probe(struct platform_device *pdev)
>  
>  exit_free:
>  	free_candev(dev);
> +exit_put_clk:
> +	clk_put(clk);
>  exit:
>  	return err;
>  }

[Severity: High]
This covers the probe error paths. Does the clock reference from
of_clk_get() still leak when the device is removed?

On a successful probe the reference is stored in priv->clk:

	priv->clk = clk;

sun4ican_remove() never drops it:

static void sun4ican_remove(struct platform_device *pdev)
{
	struct net_device *dev = platform_get_drvdata(pdev);

	unregister_netdev(dev);
	free_candev(dev);
}

free_candev() calls free_netdev(), which frees the private area that
holds priv->clk. After that, nothing is left to release the reference.
The clk_put() added here is the only one in the file.

So each successful probe followed by a module unload or sysfs unbind
would still leak the struct clk. It would also leave the clk_core
refcount and the clock provider's module reference held for good.

Would switching to devm_clk_get(&pdev->dev, NULL) be simpler? It would
handle both the probe error paths and the remove path, and the
exit_put_clk label would no longer be needed.

If the manual clk_put() is kept, sun4ican_remove() would need to read
priv->clk before calling free_candev(), because priv lives inside the
netdev allocation.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
