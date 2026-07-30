Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71EC3F86E6
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407680; cv=none; b=S1Jq0VAIbZo3EUqRVWge/tnNDm9wUQfzIKlUgbrbbzXnXU2WbjtqsJcHDh8/jIbcCfr/SmXNpxSg2kEBKLFAlismX94KkqZiAqEEMfulS9JJ727cxvdfAu7ycX50vhTMRb94GYXIEp6Qszd3WH7Odm+et8Upe03ng4s3V9R9reE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407680; c=relaxed/simple;
	bh=XJe/gFnxx4J+2r/BnG4CVJTZ9NrL3wfHYKKHKx3IWQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NR30XPdk5IelONHhAvycUZq5xmYYXnGFFDLn17GJz/ali0vUllQfqQ+eoaROdvc84DZ/rUzUf/b6TZFI0/LiAO+Xas/qbr0ZUTgoodR4I6PUrjaeH6QJyLv+YKgEfkaKSNtgCRAtWkKvPDw/QhAOHxo+UOemtWWVIgqlOV0bcpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiYXiFWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiYXiFWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C321F000E9;
	Thu, 30 Jul 2026 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407678;
	bh=kUIfKAMkxeNRbUNkFQ5ikrODxag7SW93NH2wW2z5TEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LiYXiFWb0ttOZi7/5ABuFLMq9ml0MBGeuMXeG3Ob4EWUzbQIb8fRksnDgcQTflCWZ
	 4AgI+2gQJbm+vnUCFx6Vm8JJatHDVXIG4C6yMmYgGpbcbAXT2qEoDR/Sx1ttvlkWVL
	 OabUZn+8PTrnsvUEkz2L56jwftxtcHwZrjPXshgky9yr4HvwgYPyxjF/xvxnsF2qbw
	 p7GMKoIEWlYOALMkHfaOPjMuTpt9yN352e1hkVTCxEAAKtAXLVVMMkzrDCUq1swdrX
	 plwkGXFLScnozO6TqdauUC58paYkSf97iarFp3JUDj0H3z9lYDTt9flV165SUswYuO
	 NTBWRhph4x49g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] can: rockchip_canfd: retry the outstanding TX
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <tencent_9A8D6405DC23EAFB7D35E9D09CC93424F00A@qq.com>
References: <20260730-master-v2-0-572974052400@qq.com>
 <tencent_9A8D6405DC23EAFB7D35E9D09CC93424F00A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:34:38 +0000
Message-Id: <20260730103438.59C321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU race in `rkcanfd_tx_tail_is_eff()` causes spurious NULL poi=
nter errors in the kernel log and a Use-After-Free vulnerability.
--

--- Patch [2]: [PATCH v2 2/3] can: rockchip_canfd: retry the outstanding TX=
 buffer ---
commit 5e421e7397d8c64fe895d386c02cbed045a1e541
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
> index d2cbe25c46d6c..c4ecdc9411cc6 100644
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
> +	const u32 reg_cmd =3D RKCANFD_REG_CMD_TX_REQ(tx_tail);
> =20
>  	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
>  }

[Severity: High]
This is a pre-existing issue, but does the lockless access to tx_tail and
echo_skb in rkcanfd_tx_tail_is_eff() introduce a race condition?

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
}

The transmit path holds netif_tx_lock, which disables softirqs but leaves
hardirqs enabled.

If a hardware RX interrupt fires concurrently, it can process the loopback
frame, free the echo_skb (setting it to NULL), and increment tx_tail.

If the interrupt fires between reading tx_tail and accessing the array,
could this read NULL and spuriously flood the kernel log with netdev_err?

If the interrupt fires after the skb pointer is read but before skb->data
is accessed, could the SKB be freed before it is used, leading to a
use-after-free when evaluating cfd->can_id & CAN_EFF_FLAG?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v2-=
0-572974052400@qq.com?part=3D2
