Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6430DEB2
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420098; cv=none; b=u9S2qdSxNs5TpwtTCz3Zey+giZubobAYKCaOXlOXYDwb4ZP6y0n8wvwiZ4BWCOczvzp78g0WF+V8kGKGAoF8zGCjtmSon7VkaoiZAUXJRpgUJomFoyf55W75qJOA7rcC+LkZ7+89OxHYZDAuz1/z6Bk9zFERFegPwewmhWl1qRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420098; c=relaxed/simple;
	bh=v3XlpYetJq1qEYfbmKVQ6cK6Uc/h71GbkmPB5BSfnHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VGAcNg4xDb4TQrj5XDu1kkykbucvUQz7k8vqzZTUwSPqJ3bcUDhrgcAhQmVaCegovlWxV3EoMzr1ajlPFjggU+6PDUKMPnT0U2bKSA5DddqX/HwHTdJvg1PjHLCq194YM6GkgDGwmP9n+X45HQsDe7QzBYSBPbAb8VV81QBV1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k62I2yF7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k62I2yF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DF21F000E9;
	Thu, 30 Jul 2026 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785420097;
	bh=SaXpD09ejzzTV9qLqNP+ZO8IHtrHJf1CW1IH0+wX6ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k62I2yF7jond+j9JgHucu3uPJHMBx73O3qtSWnFM3ypJuXJH1Y+msGXJ0kqllD/hl
	 dQEwYndcb2oot1gUFJiF+LWPiygo2rvQTFJ/gM0nJ86vMEJeBmF2j1PpzwHphYIiDR
	 qH0rpQPUqqX9lvVtUbxkD3QqB07kmy50VSx+MK2WvT5h5spSzgMiXvkoIIwnGT9BAa
	 TYnikSY4orFsHjWRB8DOAfPPJU+MAZV3LPwsjYgWCSNr4zOmz0a4wX6EIPQU5w25GG
	 srCFHX5zifSBmvVcMGznvwCe7hkClTZQANcEu5JrrsBP8srzq1p2pcN3vbv1F4si3n
	 lXt+u/+uzM9nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] can: rockchip_canfd: prevent TX stall on echo
 skb failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <tencent_1BD50002C4093F92A6181A5D99D004949107@qq.com>
References: <20260730-master-v3-0-91cf030c337d@qq.com>
 <tencent_1BD50002C4093F92A6181A5D99D004949107@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 14:01:36 +0000
Message-Id: <20260730140136.C3DF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect Transmit Retry Target Index causes hardware to retry the=
 wrong buffer, leading to a permanent TX stall.
- [High] Missing memory barriers in the lockless ring buffer logic between =
the TX path and RX IRQ handler allow concurrent CPUs to read a NULL `echo_s=
kb`, stalling the TX queue.
--

--- Patch [1]: [PATCH v3 1/3] can: rockchip_canfd: prevent TX stall on echo=
 skb failure ---
commit 39312269693a856e9d3d6b063ae673598025f7df
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: prevent TX stall on echo skb failure

rkcanfd_start_xmit() advances tx_head and requests transmission even when
can_put_echo_skb() fails. This patch halts tx_head advancement and
transmission request if the echo skb cannot be installed, dropping the frame
instead. It also makes can_put_echo_skb() consume the skb on its -EINVAL
error path.

Fixes: b6661d73290c ("can: rockchip_canfd: add TX PATH")
Cc: stable@vger.kernel.org

> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 95fcdc1026f80..44ebeba998370 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
[ ... ]
> @@ -54,6 +54,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_de=
vice *dev,
>  	if (idx >=3D priv->echo_skb_max) {
>  		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of b=
ounds (%u/max %u)\n",
>  			   __func__, idx, priv->echo_skb_max);
> +		kfree_skb(skb);
>  		return -EINVAL;
>  	}
> =20
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
This isn't a bug introduced by this patch, but missing memory barriers in t=
he
lockless ring buffer logic between the TX path and RX IRQ handler might all=
ow
concurrent CPUs to read a NULL echo_skb.

When CPU 0 calls rkcanfd_start_xmit(), it sets echo_skb[idx] =3D skb inside
can_put_echo_skb() and then advances tx_head. Without an smp_wmb() or
smp_store_release() here, could an ARM CPU reorder the tx_head store to
become globally visible before the echo_skb store?

If CPU 1 processes an RX interrupt, reads the updated tx_head, and proceeds
into rkcanfd_rxstx_filter():

drivers/net/can/rockchip/rockchip_canfd-rx.c:rkcanfd_rxstx_filter() {
    ...
    tx_tail =3D rkcanfd_get_tx_tail(priv);
    skb =3D priv->can.echo_skb[tx_tail];
    if (!skb) { ... }
    ...
}

Without an smp_rmb() or smp_load_acquire(), would CPU 1 observe a NULL
pointer, triggering an error and causing the TX frame to never be completed,
permanently stopping the netdev queue?

I also noticed a separate pre-existing issue in the transmit retry path.

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the hardware
might retry the wrong buffer during an erratum recovery, leading to a
permanent TX stall.

Looking at rkcanfd_xmit_retry() in
drivers/net/can/rockchip/rockchip_canfd-tx.c:

const unsigned int tx_head =3D rkcanfd_get_tx_head(priv);
const u32 reg_cmd =3D RKCANFD_REG_CMD_TX_REQ(tx_head);

Does this function incorrectly use tx_head (the next free, unpopulated buff=
er
index) instead of tx_tail (the index of the failed frame that actually needs
retrying)?

Since rkcanfd_start_xmit() has already advanced tx_head, would the driver
request transmission for an empty buffer, leaving the correct buffer
unacknowledged and the TX queue permanently stalled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v3-=
0-91cf030c337d@qq.com?part=3D1
