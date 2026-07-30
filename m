Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C6449B24
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428221; cv=none; b=uliZHKEq5WFlKFQr78bZCOpX7sp/6JCLWBjhgMfaM/n1IFN+paplhkJ40WluS4q9RqL6lUDm7Fam8CMqFwrKP42l/sZU72VxcLph9dQgfz/J+fHrT6h5JNfrqLPwQQooDLjm23BHbGi/Bsp5QWqGwHOV+6USSFuVPSYUCZakkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428221; c=relaxed/simple;
	bh=yU+F7j/xXbq3ELLaHoVePWj58cpGAU1tMvCs1ttY2+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UnyXIuTzlA9X9ZETkF1VAU3abes6rhXT/1RuZfkt7GS1g4swHEoBYsbjoVP8h4iNeSUbsocJO1EBrGpimDaYJZQ1Unan4gisjvA8IMPP8BlFyArZs+yNwGrBhl4hodQ2s2bgkjCi5hzEi8tG1/D3ApU/LwdMVjTwqd6yGMTScPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy8uLpIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy8uLpIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2131F00A3A;
	Thu, 30 Jul 2026 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785428215;
	bh=fypdSgpVDwAUJjPqDVppNq0Y3ZoM3cr28G0wxoJ3y5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uy8uLpIFRMabjCA9FIKQgKy4dVIPAp3GinWCrA7cUocwclGzzuwDSJ5Ma4LcabaaX
	 7JEu3SEWfp2zRFfdS+xtLjUU4n80e9GE9jDCLbTcIFdFXDERIhFwb5s2YCOiBOOLa7
	 ec0rA3fLs5tvktq3R7VIcFwcIJiLBNBmLlXg7TUPZwq1Q/v9tbJwhccJNJMG4slpEz
	 lWZXbaAtZheQqss4VQXaLG8BhE2FVMOP3HZdd09NARhYWVTLTdqggC3gJmSElzwvJs
	 4ew22tcp66dDBqH82cn0gO7cLAyz1UCTPt3DaLGUnHrFQehAhdkNRhDdYKd8hD2ALz
	 l9+YktBFoyqiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] can: rockchip_canfd: serialize TX state and
 command writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <tencent_9BBC002BC4013FA9A6559A771980048B9107@qq.com>
References: <20260730-master-v4-0-07f7952f761d@qq.com>
 <tencent_9BBC002BC4013FA9A6559A771980048B9107@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:16:54 +0000
Message-Id: <20260730161655.5C2131F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware FIFO and software state desynchronization when can_put_ec=
ho_skb fails.
--

--- Patch [3]: [PATCH v4 3/3] can: rockchip_canfd: serialize TX state and c=
ommand writes ---
commit ab677d838393ae26a8c9bbe2590b03c3dd72671f
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: serialize TX state and command writes

This commit adds a tx_lock to serialize TX state and command writes in the=
=20
Rockchip CAN FD driver. It addresses races between the transmit and complet=
ion=20
paths, as well as an erratum 12 workaround bypass.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/c=
an/rockchip/rockchip_canfd-tx.c
> index 2b5cd6aab31b6..c311b6990bc9e 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c

[ ... ]

> @@ -124,8 +138,11 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, =
struct net_device *ndev)
>  			      *(u32 *)(cfd->data + i));
> =20
>  	frame_len =3D can_skb_get_frame_len(skb);
> +	spin_lock_irqsave(&priv->tx_lock, flags);
>  	err =3D can_put_echo_skb(skb, ndev, tx_head, frame_len);
>  	if (err) {
> +		spin_unlock_irqrestore(&priv->tx_lock, flags);
> +
>  		ndev->stats.tx_dropped++;
>  		return NETDEV_TX_OK;
>  	}

[Severity: High]
Does this error path leave the software and hardware out of sync?

If can_put_echo_skb() fails, the driver returns early from rkcanfd_start_xm=
it().

However, the frame data has already been written to the memory-mapped FIFO
input port just before this code block. Because the error path skips
advancing tx_head and issuing the TX command, it consumes a hardware buffer
slot and causes the software and hardware pointers to become permanently
out of sync.

On the next transmission, a new frame is pushed to the hardware, but the
un-advanced tx_head command is issued, which transmits the previously dropp=
ed
frame instead.

Should the driver only write to the hardware registers after
can_put_echo_skb() succeeds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-master-v4-=
0-07f7952f761d@qq.com?part=3D3
