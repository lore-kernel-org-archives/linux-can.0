Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399621;
	b=bq8Q+hMx9DuNUYVvuoCeYPzZ8rKjUCXKE/CgGmyem+Oxyo1iti7LJ6L5XK2Iamq+5xIs
	 VfelWqgnfAU98KRKhEoBrXs9oorypHwsbUZgVJ9+385jODBPPZLZVY1KYe9IKHPMnjpxu
	 McD1Dwr6r3ABH8rvfcVlVLBSg2UOxaeBCNmA1C42kHpoDZjEWAJzdQ00duPn/TZko22P4
	 vomZRofwhLYiCpX5jQkOlYlHjHg5y+k3dGNUoDfuB7EBaYFmsEb6G3T14Or54Li7TTTUW
	 r2ZaKExhdud1LArPl8Sq/N7m4VUxRpBYMWzcn3DCpgruag7OGyicycjloJmlMznzuWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399621;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HoA6I/IKgUrWCu+g3COga0NNOn0zAPcwbBSjQYiFBJY=;
	b=3hbLPNkSMeouxsmcT+ww5euoz8dY2zcduNkv3NSTBYhWanC46w9z4P5gXvyxm8nr+rK7
	 j8B5+mbw6yROqcE/O3k0nwfBxhl3bwii7Hjm67ztzNRpRNeuBekmcvjRvp3UJoy9rxK+z
	 fa0G/1L2yJAj8AqDjwypNcZppu6Yc0LrTrl5BtYSdlAVG+YrIW6sd9ZwDplz2bZUttQpi
	 BvPZUyVbHH9nv6fwsGGwWGm3RKbW4ihXIbod1EwaZjDjMmOcsvwtLSMM8oTPbRYNCREvH
	 7hrADSQcGidvfsO3c9koPzC43RmZuD3pg8jCq2tmIj+uIw3wd8AEyrGwP13f6GUhPoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amDAD9P4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46807606A88D;
	Wed, 11 Nov 2026 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amDAD9P4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF21F00A08;
	Wed, 11 Nov 2026 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399621;
	bh=HoA6I/IKgUrWCu+g3COga0NNOn0zAPcwbBSjQYiFBJY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=amDAD9P4x1eePPGBqjUL/AqJGkxgQ5OxNSj6sOzoSzwOWfuFD4sSYfmAABmI0jvhz
	 njbIfCBVl9bFA4/u8NTCQu/13YZAFlEkjhejyO54WvlM+CbiOh2S2prsiaXeV3b9lH
	 sbY1+Jqpglny0aOaDhm8r7d3vCDELzHbX4Xkr8n2E+axOy+ksEZS/X8Gb+vCvLtot9
	 L5h5hyOG/gnxvu7fUJF5g4AyKSg6hg4ypSranV6rl0IXhWG7vpDI2K3KbV8YcfNF7E
	 Iql+jIr4tLRlLcg1DghUcPUonHTwdinOXN/EuTP01U6Z2KqetuWWLv31uFPgXt1ghO
	 HMYsp4eqd30GA==
Subject:
 Re: [PATCH net-next 06/12] can: rcar_canfd: Check can_clk request for errors
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 claudiu.beznea.uj@bp.renesas.com, geert+renesas@glider.be
Date: Wed, 11 Nov 2026 12:20:20 +0000
Message-ID: <179439962014.2199510.17188913183063652036@kernel.org>
In-Reply-To: <20261110115112.3807247-7-mkl@pengutronix.de>
References: <20261110115112.3807247-7-mkl@pengutronix.de>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch adds a dev_err_probe() call in rcar_canfd_probe()
  (drivers/net/can/rcar/rcar_canfd.c:2228) whose format string, "cannot…

--

can: rcar_canfd: Check can_clk request for errors

This commit switches the can_clk request in rcar_canfd_probe() from
devm_clk_get() to devm_clk_get_optional(). Errors such as -EPROBE_DEFER
are now passed back to the caller. Before this, the driver silently fell
back to the canfd or fck clock. The comment describing the fallback is
also updated.

Link: https://patch.msgid.link/20261019121356.2421761-2-claudiu.beznea@kernel.org

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 74c3c3f20991f..bb2d03b75142a 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2220,11 +2220,14 @@ static int rcar_canfd_probe(struct platform_device *pdev)

[ ... ]

> -	gpriv->can_clk = devm_clk_get(dev, "can_clk");
> -	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
> +	gpriv->can_clk = devm_clk_get_optional(dev, "can_clk");
> +	if (IS_ERR(gpriv->can_clk))
> +		return dev_err_probe(dev, PTR_ERR(gpriv->can_clk), "cannot get can_clk");

[Severity: Low]
This isn't a bug, but should this format string end with "\n"? All the
other dev_err_probe() calls in rcar_canfd_probe() have one ("cannot get
peripheral clock\n", "cannot get canfd clock\n", "cannot get ram
clock\n", and so on).

With -EPROBE_DEFER, the case this patch is about, __dev_probe_failed()
does not print the message. It stores it as-is through
device_set_deferred_probe_reason().

The stored string is then printed with no newline added. One place is
deferred_devs_show() in drivers/base/dd.c:

    seq_printf(s, "%s\t%s", dev_name(curr->device),
               curr->deferred_probe_reason ?: "\n");

The other is deferred_probe_timeout_work_func():

    dev_warn(p->device, "deferred probe pending: %s",
             p->deferred_probe_reason ?: "(reason unknown)\n");

So when can_clk defers, the next entry in
/sys/kernel/debug/devices_deferred would run onto the same line. The
deferred probe timeout warning would also have no line ending.

> +
> +	if (!gpriv->can_clk || (clk_get_rate(gpriv->can_clk) == 0)) {
>  		if (info->fcan_pclk) {
>  			fcan_freq = clk_get_rate(gpriv->clkp);
>  			gpriv->can_clk = NULL;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-2-mkl%40pengutronix.de
