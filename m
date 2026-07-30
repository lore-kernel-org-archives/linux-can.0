Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4444AB84
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427943; cv=none; b=P1ff1VyeWxYPyN8wrLXAiKohO0Sekl65lyx4E+wLcIDZRQZFxb2DBaTpTydFq9TNn4DBEFirtBoqp3A8yIONQYARPomRJoANEg9RjOIxpCSAA9PiTQMrff6gZICUS+jvjzXypVW6uu3Ub8JTZa9Wk3ZMg+/Ns3zb/lP95gHT56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427943; c=relaxed/simple;
	bh=yoesZhfEnFdrMt+rXHDXiCHVJatMauLn/plTqCYnOns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R4EtdGz3xzjHb5C8csO7ri/q6B3BOHkItjhhHLhyqHrUF9pkkIb9UWVtOunauRP9S65o5sU714c1SK5OcEeqWU8FYRvcV+fslrf+ikqgEK4T5Z6d30SHX+O4wMKX+YXwsyxceDkBUsSPtLivmw7NITGnROc9vG/Pr8vJsmeYL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MusRBn+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MusRBn+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CB11F00A3A;
	Thu, 30 Jul 2026 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785427941;
	bh=49bZ02BzD44qcnYJgV+SP4XkP6b+LYP9RQRGE0652co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MusRBn+vbEYZANq51LFD0RqKyFXsu66WKd2IHOurCm8cvuKCZZksF54oiXAH6Uola
	 ypKcnaIjrLcgUQPwpa6zALnzGZ9fB1eB6FIRHWA/d79WTRzefxflHvsegPAF1iG8Q+
	 ZmIfKoUkstRT5MJ5Now2EvoQvzN7DaOhS+KoBt6tDlzgcPRCemWB9o/qcLFkaWsncQ
	 t9ricS2xeuG3onG6LOLMyRrfkZgb+8pq9A4rkVE42stJ+hzw4guT80D/wKh/fmdnR/
	 tDGGe5Gs8lf3Fugdx5BQ7p/Mr90LQarYJCLqevbkSQn+eX+hZ0wfslP6Zvu4PuJ/5T
	 J3DKhE/TM80JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <tencent_BD7611A1FCC89A34685A64621292464E0209@qq.com>
References: <20260730-master-v4-0-07f7952f761d@qq.com>
 <tencent_BD7611A1FCC89A34685A64621292464E0209@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:12:20 +0000
Message-Id: <20260730161220.A4CB11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The hardware is not configured for strict FIFO transmission order,=
 which breaks the RXSTX (self-reception) completion logic and can permanent=
ly stall the TX queue.
- [High] Dereferencing the SKB in `rkcanfd_tx_tail_is_eff()` without protec=
tion leads to a Use-After-Free on SMP systems.
--

--- Patch [2]: [PATCH v4 2/3] can: rockchip_canfd: retry the outstanding TX=
 buffer ---
commit ef53444fe266d2fe80406b3bc81b10580a7299c4
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: retry the outstanding TX buffer

rkcanfd_xmit_retry() originally operated with a TX FIFO depth of one. At
that depth, the masked head and tail indices both select buffer 0, so using
tx_head happened to select the correct buffer.

After the FIFO depth was increased to two, tx_head instead identifies the
next free buffer when one frame is outstanding. The erratum 6 workaround
therefore requests transmission from the wrong buffer, leaving the
outstanding echo entry incomplete and the netdev TX queue stopped.

Use tx_tail to select the outstanding buffer for retransmission.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index b1954b72560cf..2b5cd6aab31b6 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the hardware configuration here brea=
k the TX completion logic?

drivers/net/can/rockchip/rockchip_canfd-core.c:rkcanfd_chip_start() {
...
	priv->reg_mode_default =3D reg |
		RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE |
		RKCANFD_REG_MODE_AUTO_RETX_MODE |
		RKCANFD_REG_MODE_COVER_MODE |
		RKCANFD_REG_MODE_RXSTX_MODE |
		RKCANFD_REG_MODE_WORK_MODE;
...
}

Without RKCANFD_REG_MODE_TXORDER_MODE to enforce strict FIFO order, could t=
he controller arbitrate pending TX buffers based on CAN ID priority instead=
?=20

If a higher-priority frame is queued after a lower-priority frame when TXFI=
FO_DEPTH > 1, the hardware would send the higher-priority frame first.=20

Since the self-reception handler (rkcanfd_rxstx_filter) assumes strict FIFO=
 order and compares the received echo against the oldest pending TX frame, =
would this out-of-order transmission fail the comparison? This seems like i=
t would leave tx_tail unadvanced and eventually stall the TX queue permanen=
tly.

[Severity: High]
This isn't a bug introduced by this patch, but can dereferencing the skb he=
re cause a use-after-free on SMP systems?

drivers/net/can/rockchip/rockchip_canfd-tx.c:rkcanfd_tx_tail_is_eff() {
...
	tx_tail =3D rkcanfd_get_tx_tail(priv);
	skb =3D priv->can.echo_skb[tx_tail];
	if (!skb) {
		netdev_err(priv->ndev,
			   "%s: echo_skb[%u]=3DNULL tx_head=3D0x%08x tx_tail=3D0x%08x\n",
			   __func__, tx_tail,
			   priv->tx_head, priv->tx_tail);

		return false;
	}

	cfd =3D (struct canfd_frame *)skb->data;

	return cfd->can_id & CAN_EFF_FLAG;
...
}

Since this is called from ndo_start_xmit without disabling hardware IRQs, a=
 TX completion interrupt could fire on another CPU immediately after the sk=
b pointer is fetched.=20

The hard IRQ handler would then set priv->can.echo_skb[tx_tail] to NULL and=
 queue the skb to NAPI, which could consume and free the skb on the remote =
CPU before the original CPU dereferences skb->data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v4-=
0-07f7952f761d@qq.com?part=3D2
