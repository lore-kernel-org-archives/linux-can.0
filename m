Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643E346771
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420316; cv=none; b=SDkDaUMRR1RBriQP53aQc9c7llbdOgNvjKef0dC/5iQ2LD15R67gVlQ6hLxGWHsEPi5tGhZf1J754dYRRQimKOh0WEM0k+WNLonZblNdk2/0cYJPs752eFSrBfW1RdYlEFypvtvOwNHS2E+kDWx3ec0hZsBG78Ud1dxLe5ppSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420316; c=relaxed/simple;
	bh=lXDashfQtKoGvyrr9CCg8Gv2Fj/SNBl02KVVUa/936g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j2d55Jk0Yfy+9Xks5UzV/IKMeGXXLy+9I7PZRnPY6CeBLnTkQu8TEoPWhk4wi72n36E1Giyp50Y1xRKVK2beavXYpiZBPJjH544bFuMe/5Culi8xjGB3G7jdRW7ECnxFSEkaE7eqWF1iurtX/8dWbJ7zGXSSDIiyQtORuYWv26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYRdoud/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYRdoud/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80F01F000E9;
	Thu, 30 Jul 2026 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785420315;
	bh=u1Yl2akkxCDLxXFVNwlBpqel8c/e+pSyYCJzvekliTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FYRdoud/eJmgdybOjPAxLJ2bRmMQGbzJ9dSO4xhd0RyyDrnMfRVA6fuZLqLbKHpg1
	 yLdVYiKPveQj/4iUUgDkWG1oebHI2ifX/h3io75PuhTXyM5nR9fQ0Va/zI2qTA9Wjt
	 CZbC+dywBS6KSvWlG6DwI5dsfvN/R804CsBHz54guIPCbIsXSTRAt0w9P2JCeKM9hB
	 nlrbGv9Fa+gFD9rrLb5jAVfjvRqNbFDQSLGDeMly24Rn5yypUgpA7BG6Yo3j6Tntbp
	 8zGtbVoR7CQIihPzBOLgIWecCrpMQ7f/vVZ0dir+5JsQ8d4/rPNYYgfV5pNU4dgLro
	 u1coxKFCKLF2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <tencent_A7CBE824C48D68057C23BAF8E1355DD0BC0A@qq.com>
References: <20260730-master-v3-0-91cf030c337d@qq.com>
 <tencent_A7CBE824C48D68057C23BAF8E1355DD0BC0A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 14:05:14 +0000
Message-Id: <20260730140514.E80F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent MMIO accesses to RKCANFD_REG_MODE from softirq and hard=
irq contexts without locking defeat the Erratum 12 workaround.
- [High] Lockless update of `tx_head` lacks memory barriers, risking a NULL=
 pointer dereference when the RX IRQ handler reads `echo_skb`.
--

--- Patch [2]: [PATCH v3 2/3] can: rockchip_canfd: retry the outstanding TX=
 buffer ---
commit c91fe3adb2c3d0a63ee8904bebefd12fa1335d29
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: retry the outstanding TX buffer

This patch modifies rkcanfd_xmit_retry to use tx_tail instead of tx_head
to select the outstanding buffer for retransmission. This corrects an issue
introduced when the TX FIFO depth was increased to two.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index b1954b72560cf..2b5cd6aab31b6 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> @@ -57,8 +57,8 @@ static void rkcanfd_start_xmit_write_cmd(const struct r=
kcanfd_priv *priv,
> =20
>  void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
>  {
> -	const unsigned int tx_head =3D rkcanfd_get_tx_head(priv);
> -	const u32 reg_cmd =3D RKCANFD_REG_CMD_TX_REQ(tx_head);
> +	const unsigned int tx_tail =3D rkcanfd_get_tx_tail(priv);

[Severity: High]
This is a pre-existing issue, but does the lockless update of tx_head lack
memory barriers, risking a NULL pointer dereference when the RX IRQ handler
reads echo_skb?

In rkcanfd_start_xmit(), the CPU populates priv->can.echo_skb[tx_head]
locklessly via can_put_echo_skb() and then increments tx_head:

	err =3D can_put_echo_skb(skb, ndev, tx_head, frame_len);
	if (err) {
		ndev->stats.tx_dropped++;
		return NETDEV_TX_OK;
	}
	netdev_sent_queue(priv->ndev, frame_len);

	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);

Because there is no memory barrier separating these operations,
weakly-ordered architectures can reorder the store to tx_head to become
visible before the store to echo_skb.

A concurrent hardware interrupt on another CPU executing
rkcanfd_handle_rx_int_one() could read the updated tx_head and attempt to
read echo_skb[tx_tail] in rkcanfd_rxstx_filter():

	tx_tail =3D rkcanfd_get_tx_tail(priv);
	skb =3D priv->can.echo_skb[tx_tail];
	if (!skb) {
		netdev_err(priv->ndev,
			   "%s: echo_skb[%u]=3DNULL tx_head=3D0x%08x tx_tail=3D0x%08x\n",
			   __func__, tx_tail,
			   priv->tx_head, priv->tx_tail);
		return -ENOMSG;

Lacking a paired acquire barrier, it may read a NULL pointer.
This would terminate the RX FIFO processing loop prematurely,
leaving frames in the hardware FIFO. Should there be memory barriers ensuri=
ng
the echo_skb store completes before tx_head is incremented?

> +	const u32 reg_cmd =3D RKCANFD_REG_CMD_TX_REQ(tx_tail);
> =20
>  	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
rkcanfd_start_xmit_write_cmd() from both softirq and hardirq contexts
without locking defeat the Erratum 12 workaround?

The rkcanfd_start_xmit() function running in NET_TX_SOFTIRQ context calls
rkcanfd_start_xmit_write_cmd() to execute a non-atomic read-modify-write
sequence on RKCANFD_REG_MODE:

static void rkcanfd_start_xmit_write_cmd(...)
{
	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default |
			      RKCANFD_REG_MODE_SPACE_RX_MODE);

If a hardware interrupt occurs immediately after the softirq sets
RKCANFD_REG_MODE_SPACE_RX_MODE, the hardirq handler rkcanfd_irq() can run.
It can call rkcanfd_xmit_retry(), which also executes
rkcanfd_start_xmit_write_cmd(), restoring RKCANFD_REG_MODE to
priv->reg_mode_default on exit.

When the softirq resumes, it proceeds to write to RKCANFD_REG_CMD but
RKCANFD_REG_MODE is now back in its default state, meaning the required
Erratum 12 workaround is missing. Could this silent bypass cause incorrect
CAN bus behavior or TX stalls?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v3-=
0-91cf030c337d@qq.com?part=3D2
