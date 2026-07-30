Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BB240627F
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407218; cv=none; b=gKttYwDH8FGtFX+QXi4+Hm9HV2qOMogs4qnNf2y2AWYQGT4sl9x+wRmWjXnPQffu0i9OyqlYUGSp3o28Zg5ozlb5VUzZfYk9oa13qNLFMgUQlnPjuEopXU8u4zL2IzWiFkIuWYl2T2SLvVwXEsG12LM8HhLbw4CfGkyZc+5TgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407218; c=relaxed/simple;
	bh=Cwb6D8SUTSLSzwc7w+0W7Jr8weWX7mSKiU53W8gb/4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gxIMAiBpLywLiKPtOEUik/shbojA+HKnpIbDRivwYlbTziEzPgHpHuKkpfAsN5MWDvpT6ErUtpqxAmm8WBMWj873XnGya+JRxFL0nZIJNm2TX2JzuJEXXKmuN0e4JArm1aReKGsxUFWN5Z4wcveoa6Fj6qFjGup8Iabh8uC2bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at8LEMSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at8LEMSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F61F000E9;
	Thu, 30 Jul 2026 10:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407217;
	bh=8c5YoYvCjCf5Bp08EL/Ud4aYrimcnhB+NVyf6znvpCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=at8LEMSJ0nN2owldggPuGzu1ysVJA+9SkM5Av2ucnxFe1sVurVpKeAHtbV5kP2yoK
	 eCibiU1uCRVJHlbLpVGTFRAnZrHap3pBNJgzHxdBdTZo+expnaOgtTLBL6ytTkWywb
	 +j7ZLg45pB2G2jtsmZRNfIT1Bi0/SOEA8+zHW4KEa+SJw0zQDGULDoqmnRpF7GGLrz
	 l6haHzUyvWQu0fD7CuaAqjKAQL0tJxOpKU77zJ0uvbVtu50Vopq+tRjaQ/Z2Mt/OND
	 UznSi5lVQXSusHgcHHFj4uYMiZg0sbV8UXdPvWAolP5X3ACWYUJQRIRWhHNr3CzmBe
	 Gm15DVh6qyD2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] can: rockchip_canfd: prevent TX stall on echo
 skb failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <tencent_5E44473FC626379A34998A84DF11E6000807@qq.com>
References: <20260730-master-v2-0-572974052400@qq.com>
 <tencent_5E44473FC626379A34998A84DF11E6000807@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:26:56 +0000
Message-Id: <20260730102656.B68F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `rkcanfd_xmit_retry()` function retransmits the wrong hardware=
 buffer due to using `tx_head` instead of `tx_tail`.
--

--- Patch [1]: [PATCH v2 1/3] can: rockchip_canfd: prevent TX stall on echo=
 skb failure ---
commit f51df37d6dddee0c506b68b904fa428c63fce520
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: prevent TX stall on echo skb failure

This commit prevents a TX stall when can_put_echo_skb() fails by not
advancing tx_head or requesting transmission. It ensures the skb is
properly freed on -EINVAL and accounts the frame as dropped.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index 12200dcfd3389..d2cbe25c46d6c 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a pre-existing issue in rkcanfd_xmit_retry().

When a hardware erratum occurs and rkcanfd_rxstx_filter() detects a
mangled self-received frame, it calls rkcanfd_xmit_retry() to retransmit
it. The failed frame is located at the software queue's tail. Does this
code request the correct buffer for retransmission?

drivers/net/can/rockchip/rockchip_canfd-tx.c:rkcanfd_xmit_retry() {
	...
	const unsigned int tx_head =3D rkcanfd_get_tx_head(priv);
	const u32 reg_cmd =3D RKCANFD_REG_CMD_TX_REQ(tx_head);

	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
	...
}

Because rkcanfd_start_xmit() already incremented tx_head, it points to the
next available, uninitialized slot. Will this instruct the hardware to
transmit an empty or uninitialized buffer onto the CAN bus instead of
recovering the valid frame at tx_tail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v2-=
0-572974052400@qq.com?part=3D1
