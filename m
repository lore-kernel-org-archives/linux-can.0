Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7036EAA4;
	Mon, 31 Aug 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200153; cv=none; b=XevFbR+UE/JfFsYQYxYtDOXtrFztu1evc1bWsOqZJbviasv/5ZfG5t+iOvN5f2s4geragYZ8ck4XZSFup9pCZehmQTqZJX+5h5ZiVSCY+O0Idcx33hY6Nfa29inhrZo/0Bz0k2zq6T5xdE3bnRQwTrabDH8Y8QEVux7TqidcJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200153; c=relaxed/simple;
	bh=x0ic9wz/HnvUvxOu+OPLIa+K+8GAZVse6P644E7VeGk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKBKPvk5Nys1EO87q0lfi7bfU1jGFSQIn1h1/ih0GVMLqjYI3AHuoR9FGMR7NieAL6cKf9gtKnoZM14nV/AJS4WOsHRJXDnfoiBsGYUIyS9TNX8+UGkcjbhcR1g+7y9RMcLRlGTeAtwJq5Mh3BjAjkVUxdwfQVgug3nQvN6jwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgZIFz6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgZIFz6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379521F000E9;
	Mon, 31 Aug 2026 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200151;
	bh=iluq10xN/efyo5GTacZ3JTHAVAYJvBqLtVPeLi/7/rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DgZIFz6QSXQ4wdu1gQLelTqlveOs5A7gxWCSqGwymYPmdTjZHxih10CfjOT6pc+Pf
	 lRlnEMyez92goE7m8dsNXkZUAw6y1w/GMxiptaoH6av2qGSWYlk69MpEHFpNfshRY+
	 oYCeevYn9AZ8XnbGjvzRxoA2/oF21XLLjMf6vJy3P3iZrLa+O6TnY9XS7R/b1hiMc3
	 xh9FxKUhuypV5E8PXwe7pmVuuVgIxJ93BQBKoebqAjw0dXXVMDKUIRYKXqxBzgB3v+
	 N7AI1/Vy5RS8TmJkOMi8WQGjjZTSjWi2vVKfQc2Ee3XBuqXma6MUh8dkjPdFl6KDqa
	 mIk0qWn06pvGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] can: flexcan: disable all IRQ lines in
 flexcan_chip_interrupts_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: Frank.Li@kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, conor+dt@kernel.org, imx@lists.linux.dev, robh@kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, devicetree@vger.kernel.org
In-Reply-To: <20260831143449.12828-3-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
 <20260831143449.12828-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:15:50 +0000
Message-Id: <20260831181551.379521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing synchronization in `flexcan_chip_interrupts_disable()` lea=
ds to a race with interrupt handlers, which can leave hardware interrupts e=
nabled after `free_irq()`.
--

commit 199c16c8ec6245fdb40faa9ca7c9456354adfb8c
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()

This commit disables all registered IRQ lines around IMASK/CTRL register
writes in flexcan_chip_interrupts_enable to prevent handlers from firing
while registers are inconsistent on multi-IRQ platforms.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 2e9df2d14b341..4eda54d2169e7 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
[ ... ]
> @@ -1522,14 +1522,28 @@ static void flexcan_chip_interrupts_enable(const =
struct net_device *dev)
>  {
[ ... ]
>  	priv->write(upper_32_bits(reg_imask), &regs->imask2);
>  	priv->write(lower_32_bits(reg_imask), &regs->imask1);
>  	enable_irq(dev->irq);
> +	if (quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> +		enable_irq(priv->irq_secondary_mb);
> +	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +		enable_irq(priv->irq_boff);
> +		enable_irq(priv->irq_err);
> +	}
>  }
> =20
>  static void flexcan_chip_interrupts_disable(const struct net_device *dev)

[Severity: High]
This is a pre-existing issue, but does flexcan_chip_interrupts_disable also
need this same fix pattern applied?

Currently, flexcan_chip_interrupts_disable modifies the ctrl register
without first masking the IRQ lines via disable_irq.

If flexcan_close calls flexcan_chip_interrupts_disable while the hardware
is still running, could a concurrent state-change interrupt on another CPU
invoke flexcan_do_state? That handler calls flexcan_error_irq_enable,
which might overwrite regs->ctrl and inadvertently re-enable hardware error
interrupts.

Since flexcan_close immediately proceeds to call free_irq while the
hardware might still be active due to this race, does this expose a time
window where an unhandled interrupt storm can trigger?

If an interrupt storm occurs without a registered handler, it could force
the kernel to permanently disable the IRQ line. On platforms where IRQs are
shared (requested by IRQF_SHARED in flexcan_open), this could break other
devices sharing the line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831143449.1282=
8-1-ciprianmarian.costea@oss.nxp.com?part=3D2
