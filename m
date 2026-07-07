Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E337C109;
	Tue,  7 Jul 2026 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421627; cv=none; b=R3KWMIRhpZR1Qpc9tx3i59tVcOUulxrP4Iitr42WOIwkpIqECeqNyaYONEU0bbhKyWNFlqi1Wke0oBpQSluxnZ962o9qbMInFBhKQ83Sf1lF25/+MaQ73iIG7PnOgYvT8Gnype0/6DjL/wraLELSlV4sj6mo1P/bMzrbr+XHoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421627; c=relaxed/simple;
	bh=9J8UYNBGF/VxF6Ff0H7J/FxVFWIzrwVd2lppfmoEWaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tirnnOSQnScuy6QQ157uvZGeTZB/fkI4ova3ANfuXtchzk5eBltrW8tkiQiE6NgTUHmD6YM7zdbexviQQ5NXo2jQV0o7TPE49kBubwvjgfmuOVRopDpF1j5O3LhI+586k0xYPgqtgJW2cLXgqYP+Cjyb+HNzNOPJ/wEFPJn5wxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNQOUKBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNQOUKBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5DD1F000E9;
	Tue,  7 Jul 2026 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421625;
	bh=odUeIgLWqjof69zpVeV99PEY6uCX61l3cDe1zfwmvzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LNQOUKBq6EOR44opAtf39HGruMQEQzSYSDOBA53Ixkd5PFAvRU4ao02kRo9v0Q+x0
	 aWgLWI2GqpIYpDHhDT2HPPewt0yZ6Y++VTLAJbVlEXw02nTi+DZWskRxCxIjXTtiOb
	 hHN9WZMKW5o26RnkDciGv8L9FZdTI8Y4N5nNh8kZ7kpdLLLrWzuTTq4DrrzhjU+lbI
	 bxZW1EXKq8tp8/Q3eZbYeaOUvoJG9FxUc8MrbE4yqyajR/hQWg80RZ4FRY7Af4Tr+C
	 ixo38xN9t4A4sWFHP2b/2BqwU/FiAA3evgudO1LN3FYz5x7/Ot2XLm9elykHs3qD98
	 xOxsJBK3wUIrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] can: rcar_canfd: Do not set registers selecting the
 CAN mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: devicetree@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260707102418.1646159-6-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
 <20260707102418.1646159-6-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:53:44 +0000
Message-Id: <20260707105344.EA5DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch adds the `mode_select_na` flag to support the RZ/G3S S=
oC, but fails to provide the RZ/G3S hardware info structure with the flag s=
et, rendering the logic as dead code.
--

--- Patch [5]: [PATCH 5/8] can: rcar_canfd: Do not set registers selecting =
the CAN mode ---
commit c89aa117ce922f6dfb13d5f51bb4146e8af1be2c
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Do not set registers selecting the CAN mode

This patch adds the mode_select_na flag to struct rcar_canfd_hw_info to avo=
id
writing to unavailable CAN mode bits on the Renesas RZ/G3S SoC. The flag is
initialized to 0 for existing hardware structures, and a conditional check
is added in the controller reset path to skip mode selection if the flag is
set.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wana=
doo.fr

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 6ec2d7a031238..7f01afe60a4c2 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -445,6 +445,7 @@ struct rcar_canfd_hw_info {
>  	unsigned shared_can_regs:1;	/* Has shared classical can registers */
>  	unsigned external_clk:1;	/* Has external clock */
>  	unsigned fcan_pclk:1;		/* Has fcan sourced from pclk. */
> +	unsigned mode_select_na:1;	/* Has no bits for selecting the mode. */
>  };
> =20
>  /* Channel priv data */

[Severity: Medium]
Was the RZ/G3S hardware info structure missing from this patch series?

The commit message mentions adding this flag to cover the RZ/G3S SoC, but
all existing structures are updated to set this flag to 0, and no new
structure is added that sets it to 1.

[ ... ]

> @@ -846,6 +852,9 @@ static int rcar_canfd_reset_controller(struct rcar_ca=
nfd_global *gpriv)
>  		}
> =20
>  		/* Set the controller into appropriate mode */
> +		if (gpriv->info->mode_select_na)
> +			continue;
> +
>  		if (gpriv->info->ch_interface_mode) {
>  			/* Do not set CLOE and FDOE simultaneously */
>  			if (!gpriv->fdmode) {

[Severity: Medium]
Since mode_select_na is never set to 1 anywhere in the driver, doesn't this
conditional evaluate to false for all devices, resulting in dead code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707102418.1646=
159-1-claudiu.beznea+renesas@tuxon.dev?part=3D5
