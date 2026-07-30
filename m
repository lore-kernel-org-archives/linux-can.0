Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9E449B34
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427890; cv=none; b=o6MFfOJNl2kyNUn35UkJ0Z+9AGV2gww1/iDbTgnTjrv31RSfrboz+/phWc4bKJwXfMwouCbqI+p1bmLn32PwUSF0DUFdOubZCtnM2wPDp8OG8FuCAFZmUjrnWCVUCZud78YgE8dXYASNHpI0Wuk+Jhchxj9ethFD5MYgU31jA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427890; c=relaxed/simple;
	bh=p9BIyfDkwcuGQiv22NLtuS+UHi7dvNLP96CN5vJU9w0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ogyFiNkfbnzTXRdx0Rr2u9TZXq5eU71323HWcS7vO8zeWmNKW5Y3TFoKDkOXoTiDtabuu4TtgxaFkkVBu87aW5vGWD5vuyzn3ow0B6zZnO24HEnJdHJ/QV5VAvqEJMm8L+KRq4avqwfQYKSXrcMpWz/26Jw4brkzdEtqyWUMK9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+WVQ+zY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+WVQ+zY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27CE1F00A3A;
	Thu, 30 Jul 2026 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785427889;
	bh=BIBvOxhedKeLVtZf58RRg2dncxZsmUqnfTe6TCoy5Fc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+WVQ+zYyBHwyLImPjvz9qRHp++ofgB/PqiJzgnmHVC/zkBRg6wtGzn3i4WhvuQqU
	 WC9hPHYjUMdZ66Jo7QQYH2d0N3ex1hmF/qqTCaSzlNeC3USGtgdffWatd49x4mzqYK
	 Akmf72CIvcWLwLBCPPqs6K1E72H67Zj3a6JcbXaneSZOvqTOucpznnUX3GubmU7e+f
	 I83lxmS6gD3jEkYBua+zbuuZZgvv4dkdyNoYl6pN6GS7gJ7gNkad1f5HWhnwl+eaqf
	 SCtqvVICkgUFi3Z/1YbQSDKttf7NgUkWz32U5E2AlluVyE0DR1UnWrMWiCI24l39K2
	 71YpGAz34C+FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] can: rockchip_canfd: prevent TX stall on echo
 skb failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <tencent_BFFE7E8E4D7E349F32F509B7233D01FB8808@qq.com>
References: <20260730-master-v4-0-07f7952f761d@qq.com>
 <tencent_BFFE7E8E4D7E349F32F509B7233D01FB8808@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:11:28 +0000
Message-Id: <20260730161128.D27CE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] rkcanfd_xmit_retry retransmits the wrong hardware buffer (tx_head =
instead of tx_tail), causing incorrect transmissions and eventually stallin=
g the TX queue.
--

--- Patch [1]: [PATCH v4 1/3] can: rockchip_canfd: prevent TX stall on echo=
 skb failure ---
commit 10806e8e98cd5083f34122a8793d28a8a961b0e4
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: prevent TX stall on echo skb failure

rkcanfd_start_xmit() advances tx_head and requests transmission even when
can_put_echo_skb() fails. This creates a pending TX entry without the echo
skb that the RXSTX completion path needs to match the self-received frame.
The entry cannot be completed, and the netdev TX queue can remain stopped
after the two-entry software FIFO fills.

Link: https://lore.kernel.org/linux-can/tencent_944DADCC4B42C8484EC01DA2B15=
F42132906@qq.com

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index 12200dcfd3389..b1954b72560cf 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c

[ ... ]

> @@ -125,8 +125,11 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, =
struct net_device *ndev)
> =20
>  	frame_len =3D can_skb_get_frame_len(skb);
>  	err =3D can_put_echo_skb(skb, ndev, tx_head, frame_len);
> -	if (!err)
> -		netdev_sent_queue(priv->ndev, frame_len);
> +	if (err) {
> +		ndev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}
> +	netdev_sent_queue(priv->ndev, frame_len);
> =20
>  	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in this same
file regarding TX stalls during retransmission.

In rkcanfd_xmit_retry(), the hardware retransmit command is issued using
tx_head instead of tx_tail:

void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
{
	const unsigned int tx_head =3D rkcanfd_get_tx_head(priv);
	const u32 reg_cmd =3D RKCANFD_REG_CMD_TX_REQ(tx_head);

	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
}

Does this retransmit the wrong hardware buffer (the next available software
slot) instead of the actual corrupted frame at tx_tail?

It looks like this would leave the failed slot unacknowledged and tx_tail
permanently unadvanced, which could eventually stall the TX queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v4-=
0-07f7952f761d@qq.com?part=3D1
