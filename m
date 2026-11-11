Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397893;
	b=N6hll7DLtm52EmCyReZEAZvvMbzEdUMiUiLvz5b7+FfEe79gMkDwu03yS0jPh1RixpAK
	 SoIXvzXDSy1j1C2qh+W3fki0BsOhxJkb29SZs6xKjSvcHCc3OGUH6cM9NplgmDMbMS7SI
	 NUcbvmhFovZLVzocTzzlFocqrh6on9/MIhlGTNX3HYrf1jeBWIwQbp1AN4dhJYPZonn0k
	 CdRLnDAV1LGp6o8o05QIDDeltI5DCeqCY5eU5SPyj4Z/1sIQJyK0Gesk29rHb8wKAtv61
	 O/wQuyjiDcdoBphuSZ7eSeg6bXpEljqQ0D2x6jWEEmt4pHLuO7dLg+Tmkoo1WW2mXSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Biux/PNw7hAz9MqU8Erm8O1ZlPHcIePrBL3IzyJn59M=;
	b=dN0xSdU83QdxNaxwWoA+DiWCgz2rnodUzraZTP4fAOhmGol389fwOc9aAs9qb10gtsQT
	 JE8TJcpk5jvot7IrlryhraUGu/UHnA0bvGBAkXlTNODYZiJJ1ezZNVwcmnE3eD2OgL6TJ
	 vR54aWmWEgtUDPoTMAnzL+9JwNqjRGhgw7sBehKBO9RMBa5mh4/YhPaFy8GXS6w4F4/2U
	 e/nRhWiwI6s2I/yiOCxMnx54z5QqsVRZiVdpDUWIZTVHq/6ga2TDJcBoPfnJLBjiUU+LO
	 SOoK+wWSKSh/PF4hMY67gCE2e7wPUND717xnYXVeY97D915LJbYJvK88Bb3Dl1leYfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MB6WxYbk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375EC606A326
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MB6WxYbk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6A11F00A06;
	Wed, 11 Nov 2026 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794397893;
	bh=Biux/PNw7hAz9MqU8Erm8O1ZlPHcIePrBL3IzyJn59M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MB6WxYbkCJjSvBSkgwZTpst8oLvwuZeyYBTRFj5vjf3WP8GzxjlEElW4b9jW6163e
	 1OF9vBu1FIWS6DrO3bI6l76z49r8fJZxqGPQeyfTtQ7WUNVpCAjE+rg0GfZZ22FFc8
	 T23PCoWwpPQC3p7zgyGjhMGEKliaz5xmXsVI9nnjdnOwRKUMI91lp/e+tsFj3g2KAH
	 qqGrKiFcxS1xpCO1EWodVPIybH4CjgUtFC2oaSQ75lf69HZMTagRmzQPTOyEGlnJ0N
	 k3uhLObLaZo3uIEzvqwDP/PDZVdznmderhdtO9G0lEigth35BrjJqGcashfSpQ0O7q
	 CaUxI3lhY25Zg==
Message-ID: <sashiko-outbox-208904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 02/12] can: rcar_canfd: Fix typos in macro
 names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261110115112.3807247-3-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-3-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:51:32 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] can: rcar_canfd: missing hardware reset on rcar_canfd_start()
  timeout [1]
--

commit 683df0154ce2ae541ee019a38062ac1a2b103eac
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Fix typos in macro names

This commit renames the RCANFD_CCTR_CHDMC_* channel mode macros to
RCANFD_CCTR_CHMDC_* to match the hardware register documentation.

Link: https://patch.msgid.link/20260902141544.565763-3-claudiu.beznea+renes=
as@tuxon.dev

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index fcc37b73ed436..b7c4fe3477ac5 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[ ... ]

> @@ -1504,7 +1504,7 @@ static int rcar_canfd_start(struct net_device *ndev)
> =20
>  	/* Set channel to Operational mode */
>  	rcar_canfd_update_bit(priv->base, RCANFD_CCTR(ch),
> -			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHDMC_COPM);
> +			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHMDC_COPM);
> =20
>  	/* Verify channel mode change */
>  	err =3D readl_poll_timeout((priv->base + RCANFD_CSTS(ch)), sts,

[Severity: Medium]
This problem wasn't introduced by this patch, but does the error path in
rcar_canfd_start() [1] leave RCANFD_CCTR_CHMDC_COPM pending in
hardware if readl_poll_timeout() times out?

Neither the fail_mode_change path in rcar_canfd_start() nor the out_close
unwind path in rcar_canfd_open() transitions the channel back to
RCANFD_CCTR_CHMDC_CRESET:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_start() {
	...
	err =3D readl_poll_timeout((priv->base + RCANFD_CSTS(ch)), sts,
				 (sts & RCANFD_CSTS_COMSTS), 2, 500000);
	if (err) {
		netdev_err(ndev, "channel %u communication state failed\n", ch);
		goto fail_mode_change;
	}
	...
fail_mode_change:
	rcar_canfd_disable_channel_interrupts(priv);
	return err;
}

On a later open attempt, rcar_canfd_set_bittiming() runs while the channel
is no longer in reset mode, so the hardware ignores the bit-timing
configuration writes.

[1] https://sashiko.dev/#/bug/linux-f4b05dc8-33ba-4ce4-8f99-3c391b0fc79a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110115112.3807=
247-1-mkl@pengutronix.de?part=3D2
