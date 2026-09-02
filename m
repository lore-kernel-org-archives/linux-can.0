Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0AE2D5412;
	Wed,  2 Sep 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359354; cv=none; b=gTBTLuzs3fAtCZapbfwKh5k1B8TjLEFMj7omCgwmhTlREDDR+cxp2QyperZpKgpTriy7YEsANr4BMZdMLayKEtz2xXJQn+yNWApOIyUZ7O4Fs4RNl+6ywGqsrHmGvjFfYWFhjHuBlMqWV13hJs40YjS5af4aR28oT6FvW6oZB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359354; c=relaxed/simple;
	bh=xuDP02Px1wtVQ8TR1pyIT0kW4Zo8spYwVrtWwoqVGr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LVkwvbAqgsb/2Ps6W7eMQqIzTI8hYEcQpUb6FuscHdMLkeCeQnDx1s5qAYSxYEGld7/WDiHp6Aexk/va2lgSyn6CXxsngYoqy72OQzU/yYvN3fjGU0kxzpZhiTCyWaVotesrUge0iHTf3vcCQ8qVrcBxCEfjSGdLr5F4kbTFOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyQOHqvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyQOHqvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F9A1F000E9;
	Wed,  2 Sep 2026 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359353;
	bh=/xu01tvCt2yl8YXKeQsYRoEBAE/HT8vfSXf2rBG16pI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TyQOHqvfOoy2kyvUIAyomJM1WqGuQnn45hF7yst0Fv2gt+isc0fqFJRf7gwbCe602
	 x9BdPeQYXlUC3aYW7kRJSlRxPoqCQ0GkuG/7DK8R4rn8LQvmtIyJZadwUEpW7ot2ay
	 GmMnd6E+MhFFw9SdfZTEDTjxTulpb2qmJF33G+FMvN/SNDNYFTuVGw6JmSsqRGNhA+
	 J92J3k3oRyj+hFASF9bxm5H2Yb5chVdOBGvQvFxFHSNwJ4xqr70jjfW5JOHIrYUK/a
	 Vhe1Ke65JL8TCa8yQtTaOQ/9DbrU16UyjdqOS2Tov/o20Y3bo/fbgaXF+rkpKTpmvC
	 nSl7DC6wcGY9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] can: rcar_canfd: Do not set registers selecting
 the CAN mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: conor+dt@kernel.org, robh@kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260902141544.565763-5-claudiu.beznea+renesas@tuxon.dev>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-5-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:29:12 +0000
Message-Id: <20260902142912.97F9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Software state diverges from fixed hardware capabilities due to un=
validated device tree overrides, causing silent data corruption and CAN pro=
tocol violations.

Pre-existing issues:
- [High] Race condition on write-0-to-clear status register causes lost TX =
completion interrupts and permanently frozen TX queues.
--

commit f5c5dd93cfcd4bdec86a8b0c4bc20cba21d7f4dc
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Do not set registers selecting the CAN mode

This commit adds a fixed_canfd flag to struct rcar_canfd_hw_info to handle
hardware like the Renesas RZ/G3S SoC that only supports CAN-FD mode. It ski=
ps
writing to unavailable CAN mode configuration bits during the reset control=
ler
sequence.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wana=
doo.fr

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 2e84dc5dfa34d..bed7cde1aa01b 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[ ... ]

> @@ -846,6 +852,9 @@ static int rcar_canfd_reset_controller(struct rcar_ca=
nfd_global *gpriv)
>  		}
> =20
>  		/* Set the controller into appropriate mode */
> +		if (gpriv->info->fixed_canfd)
> +			continue;
> +

[Severity: High]
Does bypassing the hardware mode setup here create a state mismatch if
the software interface is forced into Classical CAN mode?

If the device tree contains the "renesas,no-can-fd" property, the probe
function sets fdmode =3D false in rcar_canfd_probe():

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
    ...
	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
		fdmode =3D false;			/* Classical CAN only mode */
    ...
}

With this patch, if a device with fixed_canfd uses that DT override, the
hardware remains fixed in CAN-FD mode but the software expects Classical CA=
N.
Could this cause the driver to silently truncate 64-byte CAN-FD frames to
8 bytes while acknowledging CAN-FD frames on the bus?

>  		if (gpriv->info->ch_interface_mode) {
>  			/* Do not set CLOE and FDOE simultaneously */
>  			if (!gpriv->fdmode) {

[ ... ]

This isn't a bug introduced by this patch, but I also noticed a pre-existing
issue in the transmit completion path:

[Severity: High]
Can writing back the stale status mask unintentionally clear newly asserted
interrupt flags?

In rcar_canfd_tx_done():

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_tx_done() {
    ...
	/* Clear interrupt */
	rcar_canfd_write(priv->base, RCANFD_CFSTS(gpriv, ch, RCANFD_CFFIFO_IDX),
			 sts & ~RCANFD_CFSTS_CFTXIF);
    ...
}

If a new interrupt (like another TX completion or message lost flag) is
asserted by the hardware immediately after the status register is read but
before this write-back, writing the stale sts value with a bitwise AND to
a write-0-to-clear register will write '0' to the newly asserted flag.

Could this cause lost TX completion interrupts and permanently frozen
TX queues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902141544.5657=
63-1-claudiu.beznea+renesas@tuxon.dev?part=3D4
