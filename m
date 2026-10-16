Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60E3451AA
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 01:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115643; cv=none; b=rm+rVSURdExu+nCfpfI4LDS6EFnyXI+J5h84IsUrC6rxqGVczdoQ7MXNY6MJ0KSe2vM0OYlzfsB0FVWWbMZVaxytMh77L6GpPbDaLiVBEoVf3iDEhnwOJ041bFEjE0eG8+WzCszDAxlW2bV74PqZg/zwwRx+EfC+M1u+ySzxwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115643; c=relaxed/simple;
	bh=yD6SI5O9Wxt9CpYvk9IiXHO/0/9qFlSxMkplRoYMUgo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Lt2VXlxwuSPS+6VMOY4TYOQyHTBMaYs9JRjEsGjvTyEAMQYtloCxM9UI4hrZ1qJcYSlr8sNJfMFah0OODjCNBwJgT04zAmE5kgvWw/tUceWN18S0ByMHF7QgjTh8BsmWvFUGGRk//xRJqmHTMg+8yAP9uIBBO/XSAEY9twZYf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqlVb3WF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqlVb3WF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050951F000C5;
	Fri, 16 Oct 2026 01:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792115642;
	bh=STRngD0JKMArd+iUvh90/dqgmfQtmzBEed/6N/01CoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oqlVb3WF0toFhudfYxbKg3QddxNGu5oh9jqFj4w8VpJ4ZleTIdACpKn0j67LWEruK
	 ou2XEnauByg0iZsy4DuVk6qKt3IDla/ZOdoqwMWxa+qvJ/VIeWibsxE7IT8ykxiDUB
	 pvTJ2/UzSVCchHr3+w1ph8RtMDeS5HRABYYEEencs917vUUM9jmHx0I4yXntgW4oxY
	 EEPM4wKadBaupv9imBdGYwr/F3AnPa+dWdA7tMmeokhvfSXiBW2/KRp0bCklEcpmff
	 uOaiqjAYmXQmFIynzCDQIQSXnh08oh5OHJdzv4U9JDlcoUXhIs2rS83VmFQyzDtZDZ
	 /YKQ8MRL+B8QA==
Message-ID: <sashiko-outbox-173571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 17/37] can: rcar_canfd: Add support for Renesas
 RZ/G3S
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015015336.816543-18-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
 <20261015015336.816543-18-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 01:54:01 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: rcar_canfd: uninitialized DCFG register on fixed_canfd hardwa=
re if no-can-fd is specified
--

commit ef6619c0671e4d4b6f4522cdff322e81009d1151
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Add support for Renesas RZ/G3S

The Renesas RZ/G3S CAN-FD controller is largely compatible with the variant
found on the Renesas RZ/G3E. The main differences are:
- the RZ/G3S provides 16 AFL pages
- the RZ/G3S supports only two channels
- the RZ/G3S supports only CAN-FD operation and does not implement the bits
  used to select between classical CAN-only and CAN FD-only modes.
- the RZ/G3S includes an internal divider that allows the peripheral clock
  to be used as the CAN FD clock source.

Link: https://patch.msgid.link/20260902141544.565763-6-claudiu.beznea+renes=
as@tuxon.dev

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index ac5d5959d8e4c..74c3c3f20991f 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info=
 =3D {
>  	.fixed_canfd =3D 0,
>  };
> =20
> +static const struct rcar_canfd_hw_info r9a08g045_hw_info =3D {
> +	.nom_bittiming =3D &rcar_canfd_gen4_nom_bittiming_const,
> +	.data_bittiming =3D &rcar_canfd_gen4_data_bittiming_const,
> +	.tdc_const =3D &rcar_canfd_gen4_tdc_const,
> +	.regs =3D &rcar_gen4_regs,
> +	.sh =3D &rcar_gen4_shift_data,
> +	.rnc_field_width =3D 16,
> +	.max_aflpn =3D 15,
> +	.max_cftml =3D 31,
> +	.max_channels =3D 2,
> +	.postdiv =3D 2,
> +	.shared_global_irqs =3D 0,
> +	.multi_channel_irqs =3D 1,
> +	.ch_interface_mode =3D 1,
> +	.shared_can_regs =3D 1,
> +	.external_clk =3D 1,
> +	.fcan_pclk =3D 1,
> +	.fixed_canfd =3D 1,

[Severity: High]
This problem wasn't introduced by this patch, but setting fixed_canfd here
could lead to incomplete hardware initialization if a user specifies
"renesas,no-can-fd" in the device tree.

In rcar_canfd_probe(), the driver unconditionally disables fdmode if the DT
property is present, without verifying if the hardware actually supports
classical CAN mode:

	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
		fdmode =3D false;			/* Classical CAN only mode */

Since fdmode is false, CAN_CTRLMODE_FD is missing from the interface, which
causes rcar_canfd_set_bittiming() to return early without programming the
DCFG register:

	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
		return;

	/* Data bit timing settings */
	brp =3D dbt->brp - 1;
...
	cfg =3D rcar_canfd_compute_data_bit_rate_cfg(gpriv->info, tseg1, tseg2, sj=
w, brp);
	writel(cfg, &gpriv->fcbase[ch].dcfg);

Meanwhile, rcar_canfd_reset_controller() bypasses the FDOE/CLOE register
toggle because fixed_canfd is true:

		/* Set the controller into appropriate mode */
		if (gpriv->info->fixed_canfd)
			continue;

		if (gpriv->info->ch_interface_mode) {
			/* Do not set CLOE and FDOE simultaneously */
			if (!gpriv->fdmode) {

Could this leave the fixed CAN FD hardware with uninitialized data phase
timing while remaining as an active CAN FD node, potentially corrupting the
shared CAN bus with active error frames? Should rcar_canfd_probe() ignore
or reject the "renesas,no-can-fd" property when fixed_canfd is true?

> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015015336.8165=
43-1-mkl@pengutronix.de?part=3D17
