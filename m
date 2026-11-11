Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399620;
	b=eGSYnBwx3yBtpn9Zjgk1CjQCOnDJpsAcJaYH0lZlSKkLtQ+pQGZhD/ZOG3JylfLJfRUD
	 zhh0RDESYVeypxjuugvFehjLRHpF+Zku/v3XDPTUOL5hjc9lh8oyNeIm80vSTKdwnpTAw
	 9+h6h82yfzzwLrXocBs2QTAVQvCwJ2Drmwq7O13I34OR2GFu+OMQFmW1k8+FSI98x94Fp
	 2S/le9QSwLagmuto+Ku0lfhGHU4u3VZka4anXj8CHXySPasBtBy03S1yhY5UQ3hAYtm/8
	 HeA7f8zpPhSIt8wIEWbTdMMnQFIwoduaXe23vpiDQi9PGcIRi+kaQCue7rtZlyiUZYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399620;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RTPnT3LdeumQQgNEh6wdlvvEooxZofAWChf4+Bqv2DI=;
	b=F/qd3knTpPDQugcRUI5neAEuJ/VKC/+/VgzyfdwVBykEOeFnbVACKI+n8JaKaRoyGoob
	 Ofzw9xasVeiYObJbFpoDMdUpTfmvQl20vbbmlbJJiZw95t21UYXbDip3/ODurJ42lL9Z+
	 Rh0Qhb+DTpF+GrxpBL1sDzKmm3pj/Xfgwcpr0f72tjwgotQ0yX8mSU4rDPTz39ieWnwri
	 coW49EKecMtk9XUZs7Hw8FTnEGrrNkVF/ULx6Bx4o/odGelkaBlwIjYsBerbzonttevbp
	 v13krJSd6wRHd3MnSfVOU/z2D8hFh54Q3g5VrOxtOKWBWXcivnV16hXA2vcooHlbMPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UndZJali;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E9D606A885;
	Wed, 11 Nov 2026 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UndZJali
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C64B1F00A0D;
	Wed, 11 Nov 2026 12:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399620;
	bh=RTPnT3LdeumQQgNEh6wdlvvEooxZofAWChf4+Bqv2DI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UndZJaliigWVcNdaYjSTMnik1DNcNBvNUusIpk8MoLxBbR62bkhm3/5JZYLj3gwey
	 owvsTmAAfxE0NPv3i5tlUQ6DCtRt8H2HeAlMB43tNGaOT29R/FNHDX2gt1di7CvaBC
	 dSt8r2O9pCe8Gg+pHyGa5OqM82DuAahuUBfF0IQOdncf/iEuEqvrpsQChnMin74xAa
	 IUr+/9TV9YxaaPG0JGm9WNQthAHzeHVdaea48E39pV5s0dHL2ANtl3Seymd8OUcxL+
	 W+FDPr3hx8wafdPfJc0HoDxqo9sZ92YmYfiLH7721nLu9mlouEqRtMstUnamW9Pydw
	 +plIRK1XklRhA==
Subject:
 Re: [PATCH net-next 05/12] can: rcar_canfd: Add support for Renesas RZ/G3S
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 claudiu.beznea.uj@bp.renesas.com, geert+renesas@glider.be
Date: Wed, 11 Nov 2026 12:20:19 +0000
Message-ID: <179439961902.2199510.3239778793056609646@kernel.org>
In-Reply-To: <20261110115112.3807247-6-mkl@pengutronix.de>
References: <20261110115112.3807247-6-mkl@pengutronix.de>
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

- [Low] Concern: r9a08g045_hw_info sets .fixed_canfd = 1, but
  rcar_canfd_probe() still reads "renesas,no-can-fd" (fdmode = false,…

--

can: rcar_canfd: Add support for Renesas RZ/G3S

This patch adds an r9a08g045_hw_info entry for the RZ/G3S CAN-FD
controller and binds it to the "renesas,r9a08g045-canfd" compatible. The
variant is gen4-like, with two channels, 16 AFL pages, an fcan clock
sourced from pclk, and the operating mode fixed to CAN FD.

Link: https://patch.msgid.link/20260902141544.565763-6-claudiu.beznea+renesas@tuxon.dev

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index ac5d5959d8e4c..74c3c3f20991f 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.fixed_canfd = 0,
>  };
>  
> +static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
> +	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
> +	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,

[ ... ]

> +	.ch_interface_mode = 1,
> +	.shared_can_regs = 1,
> +	.external_clk = 1,
> +	.fcan_pclk = 1,
> +	.fixed_canfd = 1,
> +};

[Severity: Low]
This isn't a bug as long as the DT follows the binding, but should
rcar_canfd_probe() ignore or reject "renesas,no-can-fd" and
"renesas,fd-only" when info->fixed_canfd is set?

This is the first hw_info with fixed_canfd = 1. Both properties are still
read without checking that flag:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
    ...
	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
		fdmode = false;			/* Classical CAN only mode */
    ...
	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
		gpriv->fd_only_mode = true; /* FD-Only mode for CAN-FD */
    ...
}

Meanwhile rcar_canfd_reset_controller() skips the CLOE/FDOE writes, so
the controller stays in CAN FD mode:

	/* Set the controller into appropriate mode */
	if (gpriv->info->fixed_canfd)
		continue;

With "renesas,no-can-fd", fdmode == false makes the rest of the driver
set up classical CAN while the controller is still in CAN FD mode:

  - 8 byte RFPLS/CFPLS in rcar_canfd_configure_rx() and
    rcar_canfd_configure_tx()
  - no RCANFD_GCFG_CMPOC in rcar_canfd_configure_controller()
  - no RCANFD_GCTR_CFMPOFIE in rcar_canfd_enable_global_interrupts()
  - only nominal bit timing in rcar_canfd_channel_probe()

FD frames on the bus would then be dropped silently instead of being
reported as errors.

With "renesas,fd-only", the probe message reports "fd-only" mode, but the
hardware cannot enter that mode.

The binding change for this compatible sets "renesas,no-can-fd: false"
and "renesas,fd-only: false". Only a DT that fails schema validation can
hit this, and the compatible is new, so no existing DTs carry these
properties.

As hardening, could probe force fdmode = true and clear fd_only_mode when
fixed_canfd is set, or fail probe instead?

> +
>  static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-2-mkl%40pengutronix.de
