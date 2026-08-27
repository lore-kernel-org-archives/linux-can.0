Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55F3F1053;
	Thu, 27 Aug 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859851; cv=none; b=KnNR6N8wB1xn6HGSphdr0bOaMxM3CPIeMFXiMGLbWl6D0d+NVq/uhTHbM+KrKZYZugvN8hmnDpowLnl4IBfT0oGhNMWUDI5cIIDnRgKOMHcpYTtGaTdT37JlTqEP5J3aUoSM1fSmZOmaa2LvMkddSk1v3Gz0sGcSNWgh+W6ORWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859851; c=relaxed/simple;
	bh=L4wNEHcY4aozfnc66ZnzRVtjh/XKdkgAn95LY0H5wFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+/+UoePDg8CeGoy8l73wWTUkA4WAk2sbLMjAlitc+MMhl0CMrzduMMnH5L9znThEEQrKokQsIcloqHun1nmoZ9JCpLoW7PU6EQdCYEg5NytexPM1IeggZz/fRbTqOiTKnxLlDMAitDoyS4Knk2e3GViKM5e+p6Z2dsVnorJWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBji4+ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBji4+ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578121F00A3A;
	Thu, 27 Aug 2026 19:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859849;
	bh=XzW/WWM0ZHd9+/8mNzs5NYwdbZjrG+OVeS9mFKyQJ/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBji4+baIVLGHnVhzVdo0WsoIuMGfaPDN5F59V/f1MxhjPXTeGYygBGiNeDyfwf+B
	 8egj+3Ufl9Io5bbEeGLnP1c2Kpp1Hd7PNrnelHOlnTTYFHcBgZzT2j+PnY8XUPb318
	 vZdi+NUxOHTkGnUtx75tdN8sfsFDMQFCQpHarE3SFrabElecJIYCSvCZGNhNko/Nsc
	 JifpXTTfWB8W7obE68NiR0bXdBh+r/spsBdCNJeMYHjd30L17JNVfvth27M40Il4+v
	 htbmBz98JTqpPqvxLl3pd0OqKrQZg6ToBecqL47akpzK6ED4op4Oh0OKJgeNy8m+OF
	 YFs39mJT882jg==
From: Jakub Kicinski <kuba@kernel.org>
To: mkl@pengutronix.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	blbllhy@gmail.com,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net 06/14] can: rockchip_canfd: retry the outstanding TX buffer
Date: Thu, 27 Aug 2026 12:44:08 -0700
Message-ID: <20260827194408.4023732-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826121036.2706424-7-mkl@pengutronix.de>
References: <20260826121036.2706424-7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
can: rockchip_canfd: retry the outstanding TX buffer

This changes rkcanfd_xmit_retry() to use rkcanfd_get_tx_tail() instead of
rkcanfd_get_tx_head() when building the TX_REQ command, so that the
erratum 6 workaround re-requests the buffer that is actually outstanding
now that the TX FIFO depth is two.

Link: https://patch.msgid.link/tencent_2CCE005FC440BF8026599A6999EC04BE1107@qq.com

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> index 86fa8f2e1c8ba..fc338ea865feb 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> @@ -57,8 +57,8 @@ static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
>  
>  void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
>  {
> -	const unsigned int tx_head = rkcanfd_get_tx_head(priv);
> -	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
> +	const unsigned int tx_tail = rkcanfd_get_tx_tail(priv);
> +	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_tail);
>  
>  	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
>  }

[Severity: Medium]

This isn't a bug introduced by this patch, but with rkcanfd_xmit_retry()
now aiming at the tx_tail buffer, is the buffer it re-requests the same
one that rkcanfd_start_xmit() may be arming at that moment?

rkcanfd_xmit_retry() is reached from the hard-IRQ handler, since
rkcanfd_open() registers it non-threaded:

	err = request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, priv);

and rkcanfd_irq()->rkcanfd_handle_rx_int()->rkcanfd_rxstx_filter() calls
rkcanfd_xmit_retry() for the erratum 6 case. At this commit there is no
lock covering priv->tx_head, priv->tx_tail or the register writes.

Two interleavings look possible.

First, rkcanfd_start_xmit_write_cmd() is not atomic:

	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default |
			      RKCANFD_REG_MODE_SPACE_RX_MODE);

	rkcanfd_write(priv, RKCANFD_REG_CMD, reg_cmd);

	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default);

If the interrupt path runs this sequence while the transmit path is
between its own MODE and CMD writes, the restore of reg_mode_default
lands before the other context's CMD write. Does that silently drop the
erratum 12 workaround for that frame? rk3568v2 carries both
RKCANFD_QUIRK_RK3568_ERRATUM_6 and RKCANFD_QUIRK_RK3568_ERRATUM_12.

Second, rkcanfd_start_xmit() publishes the new head before issuing the
command:

	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);

	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);

If the interrupt path completes the previous frame (advancing tx_tail)
in that window, rkcanfd_xmit_retry() now selects the buffer whose CMD
write has not been issued yet. Can that produce a second TX request for
the same buffer, a duplicated frame on the wire, and a desynchronized
echo ring, with rkcanfd_tx_tail_is_eff() then hitting the

	"%s: echo_skb[%u]=NULL tx_head=0x%08x tx_tail=0x%08x\n"

path?

For what it is worth, this appears to be addressed later in the same
series by the change that adds "spinlock_t tx_lock; /* protects tx_head,
tx_tail and echo_skb */" to struct rkcanfd_priv, wraps the
rkcanfd_start_xmit() echo/register/command sequence in
spin_lock_irqsave()/spin_unlock_irqrestore(), takes the same lock in
rkcanfd_rxstx_filter() and adds lockdep_assert_held(&priv->tx_lock) to
rkcanfd_xmit_retry(). Given that ordering, would it be worth noting the
dependency in this patch so that a standalone stable backport of this
change does not land without the locking?
