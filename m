Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C841D4EA
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495251; cv=none; b=aOhLT9MhIwroiPwocoUZ/gn1RCvn0UiO8VzcbqZntaCslkabjn6UOJ+bVbERbWlzGDTaChXo+M1oNx3MvzXsWMgb8mjXNKjrNHsxUGK9m8nYeQhrAvBh2jrZUg+piFsswbFCEoztErLTo3hcVJB8aEZhyHI1O2BFL3v+9TkHAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495251; c=relaxed/simple;
	bh=DIqn5ESwDxO6gVGYZZ/1P2KuY1m7HI825T5REOQUAMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bczR3ZMbqIk4H7Dy8hBm5CGf/DcVaqQ9t/x2VlB8nW+9BL6iWFcssPnMTwkW/KMDB1e9DKa9YciM51I/2ikUEA5dYAWJtKh8/ub9SZtQ1BszkvLGWRBlZIuhvPsAvWpZjAR6Cs8fh05zGFfF5ozC8uMQj7RTLVQHyoApwHtkJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT+SQokf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT+SQokf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A451F000E9;
	Fri, 31 Jul 2026 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785495243;
	bh=xaqxjYJIRjPKtGsUfl8eEcVNPJa3wJiic4eXmUWauY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aT+SQokfyn9zqebAPgN/zQynzKoiQSHT5ecna7DFhHnkqvEtRsgQpAA95Az2+UENj
	 ob+P2i7229dJa359tXJKfW9/VaL38F4UEwJesPaSSiL83qj1BwbwgcmhwCxnrQjNzt
	 dcbd+vCSm8WsDXaQYaw1IO8G2hx7KEYaXHahlbZOyE23QNHsDyvEYnt94v1kXborUg
	 A7Jco+/pX6DBs5dKwPSZeaKT3PqqQkq/nRsrYtQO8yvMRut1IcZaYV3vV7owsB2DNB
	 u0SG4b+C+gWY1Z7Qayrxwc1cRkzIDHQxR8UjDpm2KAQLhFLlKuYYSvObihJgx/+5YR
	 cCtdwzyGtoJdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] can: rockchip_canfd: prevent TX stall on echo
 skb failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <tencent_C82C09E7235101CC88A97E154D2534183208@qq.com>
References: <20260731-master-v5-0-5b27029dee20@qq.com>
 <tencent_C82C09E7235101CC88A97E154D2534183208@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 10:54:02 +0000
Message-Id: <20260731105402.B7A451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read and hardware register out-of-bounds write due t=
o CAN XL frame mishandling.
--

--- Patch [1]: [PATCH v5 1/3] can: rockchip_canfd: prevent TX stall on echo=
 skb failure ---
commit 8df8ef3a7e1e7414d8117605f2f14ed295ef9ad1
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: prevent TX stall on echo skb failure

This patch prevents a TX stall by installing the echo skb before loading
the hardware TX buffer. If installation fails, it drops the frame and leaves
the hardware FIFO and software TX state unchanged. It correctly relies on t=
he
echo skb as the source for hardware frame data after it is installed.

Link: https://lore.kernel.org/linux-can/tencent_944DADCC4B42C8484EC01DA2B15=
F42132906@qq.com

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index 12200dcfd3389..86fa8f2e1c8ba 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
[ ... ]
> @@ -114,7 +123,6 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, s=
truct net_device *ndev)
>  					    cfd->len);
>  	}
> =20
> -	tx_head =3D rkcanfd_get_tx_head(priv);
>  	reg_cmd =3D RKCANFD_REG_CMD_TX_REQ(tx_head);
> =20
>  	rkcanfd_write(priv, RKCANFD_REG_FD_TXFRAMEINFO, reg_frameinfo);
> @@ -123,10 +131,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, =
struct net_device *ndev)
>  		rkcanfd_write(priv, RKCANFD_REG_FD_TXDATA0 + i,
>  			      *(u32 *)(cfd->data + i));
> =20

[Severity: High]
This is a pre-existing issue, but does this code properly handle CAN XL fra=
mes?

If an ETH_P_CANXL frame is sent via AF_PACKET, can_dev_dropped_skb() curren=
tly
lacks a check to drop CAN XL frames for devices that don't support CAN XL.
When such a frame enters rkcanfd_start_xmit(), can_is_canfd_skb() returns
false, causing the driver to treat it as a Classic CAN frame.

The driver reads cfd->len from offset 4, which in a canxl_frame corresponds=
 to
the user-controlled flags field. Because valid CAN XL frames require CANXL_=
XLF
(0x80) to be set, cfd->len is evaluated as at least 128.

Could a minimally sized CAN XL frame trigger a loop of 32 iterations here,
leading to an out-of-bounds read from cfd->data and an out-of-bounds write
to device memory at RKCANFD_REG_FD_TXDATA0 + i?

> -	frame_len =3D can_skb_get_frame_len(skb);
> -	err =3D can_put_echo_skb(skb, ndev, tx_head, frame_len);
> -	if (!err)
> -		netdev_sent_queue(priv->ndev, frame_len);
> +	netdev_sent_queue(priv->ndev, frame_len);
> =20
>  	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-master-v5-=
0-5b27029dee20@qq.com?part=3D1
