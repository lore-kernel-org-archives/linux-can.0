Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BD3D3486
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407392; cv=none; b=swMx7XDDkpg06difFfPXgBL9FSJ1uXvN6Ek/Yt+TY+MrmRrO34o9kd1AvYA+aMatKW+gcnwSNAX7/whvmqm7CRHZZZyV8k6TeHGdhdYXHUVVxdHJIEA6D9+RnsbWKQsqL05bPZ5zLmRQEmCx6eivY7p8WK0eEoCMGmMncPJzDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407392; c=relaxed/simple;
	bh=oJD9KExo0vI18HUOoJ6FdHzzolFYlQnJ0CEqxN5xALs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BfZYLQQb+GM4hz6SwbrQGpqB9LsA0+hy929IF7UDxKH087v0MQ9OEynkZDUBjUZ7T4K12/pp23hXUkxUC3DUtUV344+TlUpa6nAiZzYR61RrKdIX1wWMKsdlHnkG3bLDuap87UGlgC+xJWVTvVNbNaCoOeCjjNOAlrxWd7vhtLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4DRKNWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4DRKNWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E651F00A3A;
	Thu, 30 Jul 2026 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407390;
	bh=lExBIylm4ywzqUrihnOc+UGmy7LSVGLPvuWxWUC51e0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y4DRKNWwO9boBUUjd2eyUO2dblLvxnqCsuQDDfUJ7Y1JI4lCe7tydKt6UkklpLywT
	 IjuTzsfPdEgJy1t/mO65ha2zUOR7pGCvBQVG/p0lsICFCKhL3CMLgSB/CR96amT0DD
	 uQDF6IhrP4ca2S7hpq29wMwNbizPlY5YRTE0wh83ojRSxO2XV4+tBPPYThOUOMTTsP
	 LCKpTmaRNLuzfHjBfPufCALjgB8LqYLKbMol2mUAH0D4pTvf9QN9cqlWnhRJ26naJE
	 uw5+4edcJAAxlDRrEmp8qRkNuUUuT4By/fLOggkhfQpZ0zezzPIw8CX0ICmCV/7wCM
	 UeQpNq+hLKcwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 07/20] can: ctucanfd: handle bus error interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260729102802.505168-8-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-8-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:49 +0000
Message-Id: <20260730102950.38E651F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on hardware-provided word count can lead =
to a severe heap buffer overflow.
- [High] Missing rate-limiting on bus error log messages causes a kernel lo=
g flood and system lockup.
--

--- Patch [7]: [PATCH net 07/20] can: ctucanfd: handle bus error interrupts=
 ---
commit d64540d1abcd187254c2c60ea1d9abba7c60b2be
Author: Avi Weiss <thnkslprpt@gmail.com>

can: ctucanfd: handle bus error interrupts

Include REG_INT_STAT_BEI in the top-level error interrupt condition. BEI is
enabled when CAN_CTRLMODE_BERR_REPORTING is requested and
ctucan_err_interrupt() already handles it. Without checking and clearing
BEI, bus error interrupts are not handled or acknowledged.

Link: https://patch.msgid.link/20260723074403.131575-1-thnkslprpt@gmail.com

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/c=
tucanfd/ctucanfd_base.c
> index 8f8b1c097ec6d..10ebcc13ea656 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -1136,8 +1136,12 @@ static irqreturn_t ctucan_interrupt(int irq, void =
*dev_id)
>  		/* Error interrupts */
>  		if (FIELD_GET(REG_INT_STAT_EWLI, isr) ||
>  		    FIELD_GET(REG_INT_STAT_FCSI, isr) ||
> -		    FIELD_GET(REG_INT_STAT_ALI, isr)) {
> -			icr =3D isr & (REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_A=
LI);
> +		    FIELD_GET(REG_INT_STAT_ALI, isr) ||
> +		    FIELD_GET(REG_INT_STAT_BEI, isr)) {
> +			icr =3D isr & (REG_INT_STAT_EWLI |
> +				     REG_INT_STAT_FCSI |
> +				     REG_INT_STAT_ALI |
> +				     REG_INT_STAT_BEI);
> =20
>  			ctucan_netdev_dbg(ndev, "some ERR interrupt: clearing 0x%08x\n", icr);
>  			ctucan_write32(priv, CTUCANFD_INT_STAT, icr);

[Severity: High]
This isn't a bug introduced by this patch, but this patch explicitly unmasks
and clears the BEI interrupt in the top-level handler. Does this prevent the
driver from hitting the previous stuck-interrupt failsafe and inadvertently
unleash an infinite log storm whenever BERR reporting is enabled?

Looking at ctucan_err_interrupt(), the unconditional bus error logging
bypasses the dologerr rate-limit check:

drivers/net/can/ctucanfd/ctucanfd_base.c:ctucan_err_interrupt() {
    ...
    if (FIELD_GET(REG_INT_STAT_BEI, isr)) {
        netdev_info(ndev, "bus error\n");
    ...
}

If the CAN bus is faulty or experiencing heavy interference, will the
controller continuously generate Bus Error Interrupts and overwhelm the
printk subsystem causing a CPU lockup?


[Severity: Critical]
This is a pre-existing issue in the same file, but could the lack of bounds
checking on the hardware-provided word count lead to a severe heap buffer
overflow?

In ctucan_read_rx_frame(), the driver derives the word count directly from
hardware:

drivers/net/can/ctucanfd/ctucanfd_base.c:ctucan_read_rx_frame() {
    ...
    wc =3D FIELD_GET(REG_FRAME_FORMAT_W_RWCNT, ffw) - 3;
    ...
}

If a buggy or malicious hardware controller provides an unexpected word
count, could this integer calculation underflow or result in a large value
that exceeds the maximum 64-byte payload limit?

Later in the same function, the driver copies data into the cf->data
buffer using the unchecked len variable:

drivers/net/can/ctucanfd/ctucanfd_base.c:ctucan_read_rx_frame() {
    ...
    for (i =3D 0; i < len; i +=3D 4) {
        u32 data =3D ctucan_read32(priv, CTUCANFD_RX_DATA);
        *(__le32 *)(cf->data + i) =3D cpu_to_le32(data);
    }
    ...
}

Would this blindly write out of bounds into the heap-allocated SKB buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D7
