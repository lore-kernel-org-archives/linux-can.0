Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD0491589;
	Sat, 10 Oct 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640976; cv=none; b=lvsBuxU87sD5MVLt0yoeMwfcIkfbZs6MwS1PlFiuaLmoaZzsUZDVzE+uEq2vpGC+j239yF+gV22vCT2C1Wj/aCBOci3ahrjiovy1/UDDpsFx1DUkg9aCjn5J+ekzGm05pslkWNjL58/nTSgkT0VAzpfVyb0J0gsq6Ofrqsu5xps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640976; c=relaxed/simple;
	bh=YlpiSc53nXbjuqMKgo9JNHtzC0sIkmpQ1y5f4UEoACo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNIwg5oCuQHoQaLF907Jbj1LHDpWfNcvOdiVybtG2uEf/7tjB9DD1hnuuSjihiOR6ME3dPd8xiicbek0zXpmDdUWUac1T8r8jbLUQUKA86lZ1bWvdqwwssNBNPwdzfyWxi/U9XKRuSSm6KvE6euKcQ5YAMOfetPdMLfZvYcbDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnV7Bw8o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnV7Bw8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F0F1F000FF;
	Sat, 10 Oct 2026 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640974;
	bh=tB+ZCdWKEnk2LOSvqb0rMSPCxPS0cwOesOru7QdkXYY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nnV7Bw8ojOZWp579Pv3BGJJ1s6qJmToDdpL91qtHU04tXWXmqpqAj+HI0Vllvxy6W
	 gWpv11/985lNEQHcboAVdWYrLak8dnO4dUmoDYvvfCVCg0BFzN/hvj6y+3vx0jnWEi
	 5BQl3u7L0pfEW25Byqy31yn1Wh1ODCeuG+KmnkhcjcDPtM/GgnFxvRg1Nf4nYRKduF
	 LCtBLSo0FfhRyIbLKdeuJ0cHE8oSC9bLgeqKEfzw0MF52V6Ff1pF/01x7EkrHJ+R9T
	 PXU20LyBcLaX9YIUUtCCc2HsmyCf5KjJV4RgpjTv5PXUH2Wj/J74OdMOp8id7Olg89
	 KsFHP0W86hAqA==
Subject: Re: [PATCH net-next 13/37] can: rcar_canfd: Do not set registers
 selecting the CAN mode
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:53 +0000
Message-ID: <179164097392.434549.8433276236723519282@kernel.org>
In-Reply-To: <20261009134323.64064-14-mkl@pengutronix.de>
References: <20261009134323.64064-14-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not match the code.

--

can: rcar_canfd: Do not set registers selecting the CAN mode

This patch adds a hardware feature flag to struct rcar_canfd_hw_info. On
RZ/G3S, which only supports CAN-FD mode, the flag makes
rcar_canfd_reset_controller() skip writing the CLOE and FDOE bits in the
channel CAN-FD configuration register. Every existing hw_info instance
now sets the new flag to 0 explicitly.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
Link: https://patch.msgid.link/20260902141544.565763-5-claudiu.beznea+renesas@tuxon.dev

> Add the mode_select_na flag in struct rcar_canfd_hw_info to cover RZ/G3S
> and avoid writing to unavailable bits.

[Severity: Low]
This isn't a bug, but the flag name in the commit message doesn't match
the code.

The patch adds this field to struct rcar_canfd_hw_info in
drivers/net/can/rcar/rcar_canfd.c:

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index f9173774387fa..ac5d5959d8e4c 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -445,6 +445,7 @@ struct rcar_canfd_hw_info {
>  	unsigned shared_can_regs:1;	/* Has shared classical can registers */
>  	unsigned external_clk:1;	/* Has external clock */
>  	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */
> +	unsigned fixed_canfd:1;		/* Has mode fixed to canfd. */
>  };

[ ... ]

> @@ -846,6 +852,9 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
>  		}
>  
>  		/* Set the controller into appropriate mode */
> +		if (gpriv->info->fixed_canfd)
> +			continue;
> +

Both the hw_info initializers and the check in
rcar_canfd_reset_controller() use fixed_canfd. The name mode_select_na
does not appear anywhere in drivers/net/can/, either at this commit or
later in the series. It looks like the flag was renamed during review
and the commit message was not updated.

Could the commit message be updated to say fixed_canfd?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
