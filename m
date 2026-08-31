Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1594734CD;
	Mon, 31 Aug 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200850; cv=none; b=KD2gmVMIKA9/VLObOmgj/RlEyUKcPWeLi7P2jHfdTlcbLw2WiCyGt988BHrwYKplWU011ix4HIRakrA/35YOQaNrbQRdIsjazVOKO2R6GQwGWowF1NhrLaG5S8wWS5gt5SboZKCQlDKSm1QEzQ+v2ODHe06gB7Zdc1QeUMf8pBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200850; c=relaxed/simple;
	bh=jJT968OVL5uwBszC/U5WxLTyOFSTqeUy04S4GvGUEXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qbswPqyR7/NvwFHnJTC11mOujndLqf7sKIHK3IENy/XC8OwOnoE7HRWu92gfD7IRSRsZDPQogmVlgWzWZyKDtfRsYS5v7c5kE4jq5VFnWuTrypRr3ISHxdwffy6uNzUN6aVSz+ms8rzV4uPTEIqV/16tu0bO2thRb5Fbwop1UTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1hXhZD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1hXhZD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E85F1F000E9;
	Mon, 31 Aug 2026 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200848;
	bh=ceCHjZ0SYlMQspTcqp1Tk6IdKGfbhVTUG5oWOFZ8NBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c1hXhZD8CWoW2ChD+atZ+rI0yWLwVda/WF1XwcTSM5NwYRhDCiiQa+EPY6+5Hlhuw
	 HoR1dt9wb1eZgPm6Wn7BbPaRbqNad3mdIxl4hOEaAuAj0pKMCkoLtRWpt022LbGD3D
	 67YFO6/FKXzZ3bzsaYevu8UDPkwTv5nZsTFpUuuTOGYTROCnLC2WxbLDiro+0Xa9G6
	 ql02uIz8P3PPcuUzV4SZlFfyK5sEOYlIbfr7HorHelLLr7w5taMXtSiNY1iQGbdnHb
	 UJj9NP2+jxX/TFj/znVe78tgYaQvBh7QpOynFNnhLMwRKGyOJZbCAc1IuxRpI79x2q
	 FiTtluzNj/Wjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] can: flexcan: split rx/tx masks per mailbox IRQ
 line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: robh@kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, conor+dt@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, devicetree@vger.kernel.org, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260831143449.12828-4-ciprianmarian.costea@oss.nxp.com>
References: <20260831143449.12828-1-ciprianmarian.costea@oss.nxp.com>
 <20260831143449.12828-4-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:27:27 +0000
Message-Id: <20260831182728.0E85F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent execution of mailbox IRQ handlers causes `skb_irq_q=
ueue` list corruption.
--

commit 03c6b5c54e432135868db888c97ca8c2b9bc7225
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: split rx/tx masks per mailbox IRQ line

On S32G2 with two mailbox IRQ lines, handlers process the full rx_mask/tx_m=
ask
range. This patch introduces masks to split the range between the MB0 and M=
B1
IRQ lines.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 4eda54d2169e7..f28ff0e95b74f 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
[ ... ]
> @@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, void *d=
ev_id)
>  	struct net_device *dev =3D dev_id;
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	irqreturn_t handled;
> +	u64 mb_mask =3D ~0ULL;
> +
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> +		mb_mask =3D (irq =3D=3D priv->irq_secondary_mb) ?
> +			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
> +			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
> =20
> -	handled =3D flexcan_do_mb(dev);
> +	handled =3D flexcan_do_mb(dev, mb_mask);
> =20
>  	if (handled)
>  		can_rx_offload_irq_finish(&priv->offload);

[Severity: Critical]
This is a pre-existing issue, but does concurrent execution of mailbox IRQ
handlers cause skb_irq_queue list corruption?

On multi-IRQ platforms like S32G2, CAN packets arriving concurrently on both
mailbox ranges (MB 0-7 and MB 8-63) will trigger both mb-0 and mb-1
interrupts. If these are routed to different CPUs, flexcan_irq_mb() runs
concurrently on both CPUs.

Both contexts then invoke can_rx_offload_irq_offload_timestamp() (inside
flexcan_do_mb()) and can_rx_offload_irq_finish(), which modify the shared
lockless list offload->skb_irq_queue without synchronization:

drivers/net/can/dev/rx-offload.c:can_rx_offload_irq_offload_timestamp() {
    ...
    __skb_queue_add_sort(&offload->skb_irq_queue, skb,
                         can_rx_offload_compare);
    ...
}

drivers/net/can/dev/rx-offload.c:can_rx_offload_irq_finish() {
    ...
    skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue=
);
    ...
}

Can this lead to memory corruption (corrupted sk_buff_head list pointers)
and an immediate kernel panic in hardirq context when the list is accessed
or modified?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831143449.1282=
8-1-ciprianmarian.costea@oss.nxp.com?part=3D3
