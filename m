Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100556;
	b=YVg7VGQhGg4TgIYfZaICtJNLQThSMSbgB7Ee0a+ApiGxu1u6V02gQn88qOQEs8wvh5xU
	 4CqK3CEU0ev9GCQ/62VHC4WL4k4djsIaEwezhPXIHhnHJ9nsnC1GWbqP+C10s5pb74cpk
	 I2jqvEdk3RN1QOTtRIoItjdfwxTr+v5uDGs9EZ8Bl+/5k6xXKw0S9aybwV+Y75+9u8/5Y
	 FL3rSNUFbZk8VGmdBrPXKLX6V/VgHScKtDg31+YI+0WbkbZDzQt34+mN71RJFhkU8/vJf
	 5dKJKf+62FSL2+7sn6MzMhuCTG72MYji1S8mPGtBTpmCB5Vx0k99B8Agtw6o3kQU3qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100556;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4Wv6qrXdhtxLasnCngV8J1IpeiJT7lwvM37GgFLg69k=;
	b=yAcAaVte+6nQz+g1WLPwk7rbvBcVITAdNHnyst/JUILMuKn48R9hsU5KK45Wp+rNZK9c
	 ktQGDZXAZK2A+F21pvD+N7kDZKPowlQXuyYC2Kg1oNv3Sm6dq+rD3HiZwjS23wC1/vQUI
	 73W4QmXv/Yhof17ll7eZcU4qpXpFKx8CfiW9jhIBB7mgu69Ay420pE7j1m7GulZ9tHoE4
	 O0ryl6ftcAe/M3ZO2D+bOYEcUosoCsqU2qpF+Uu0iCaHfSl/IpY/7qwpnKhx9qlCknvUu
	 1W3UTW+c6kb74zgtRucjgDjjCfLoAK8DGaPwUpRs6LbmSMvgI4AXeYe/BUFG2j+rwvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYYpKYjX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA34606A31A
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYYpKYjX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCCD1F01825;
	Tue, 27 Oct 2026 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100556;
	bh=4Wv6qrXdhtxLasnCngV8J1IpeiJT7lwvM37GgFLg69k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYYpKYjX0bDSJkrv8AT5fZs4kEHeYFPQeSQUERFi7a+lHcLi2zJty18jfV2iXKp2a
	 9lMQgSRN8B7N2A9Jh1n1+oZBD1lrtzu3C3vskiXFdKhpCBB/Fw3IAYmU/PEnWXZRCv
	 g2SUPcFA3BONw9Zhs2KnFxAkfye8BPFka+DhxSCpuHJEffYe4xheZEnaCQSftZU1FK
	 y/10QjzzcADc+uSHf/oi4fM/UjuM6Ly0Cyxxw+cLiZ55eUZlC6cToHxwQ8PYytXe7N
	 6EX3SrrN0neRNgTTB5fFX/RSQIV37trgglScY66dXR7Gd/zD+FBGqtPsSWQQTiBSBD
	 M63uC5MO4p23g==
Message-ID: <sashiko-outbox-186443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/1] can: bcm: limit RX operation resource usage per
 socket
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <92fe9d7fe3a7daa2cc7de740b15ec7eaa0638b98.1793089479.git.zihanx@nebusec.ai>
References: <cover.1793089479.git.zihanx@nebusec.ai>
 <92fe9d7fe3a7daa2cc7de740b15ec7eaa0638b98.1793089479.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:29:15 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: bcm: bcm_rx_setup() returns 0 on frame array allocation fai=
lure
--

commit 3aff0eb4ba8d41c989dbd64aa48ab75c3eecec89
Author: Zihan Xi <zihanx@nebusec.ai>

can: bcm: limit RX operation resource usage per socket

This commit bounds the per-socket number and total memory allocation size of
CAN BCM RX operations, as well as the number of pending RCU receiver
callbacks. When a socket reaches either limit, creating a new RX operation
fails with -ENOBUFS.

Link: https://bugtracker.nebusec.ai/f/11134

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3d637a1e0ac1a..96d3f050dec54 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1425,26 +1518,22 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  		op->nframes =3D msg_head->nframes;
>  		op->cfsiz =3D CFSIZ(msg_head->flags);
>  		op->flags =3D msg_head->flags;
> +		op->rx_mem =3D rx_mem;
> =20
>  		if (msg_head->nframes > 1) {
>  			/* create array for CAN frames and copy the data */
>  			op->frames =3D kmalloc_array(msg_head->nframes,
>  						   op->cfsiz,
>  						   GFP_KERNEL);
> -			if (!op->frames) {
> -				kfree(op);
> -				return -ENOMEM;
> -			}
> +			if (!op->frames)
> +				goto free_op;
> =20
>  			/* create and init array for received CAN frames */
>  			op->last_frames =3D kcalloc(msg_head->nframes,
>  						  op->cfsiz,
>  						  GFP_KERNEL);
> -			if (!op->last_frames) {
> -				kfree(op->frames);
> -				kfree(op);
> -				return -ENOMEM;
> -			}
> +			if (!op->last_frames)
> +				goto free_op;

[Severity: Medium]
In net/can/bcm.c:bcm_rx_setup(), when creating a new RX operation with
msg_head->nframes > 1, err is initialized to 0 at the start of the function:

	int new_op =3D 0;
	int err =3D 0;

If kmalloc_array() for op->frames or kcalloc() for op->last_frames fails,
jumping to free_op without setting err =3D -ENOMEM executes:

free_op:
	if (op->frames !=3D &op->sframe)
		kfree(op->frames);
	if (op->last_frames !=3D &op->last_sframe)
		kfree(op->last_frames);
	kfree(op);
	bcm_rx_op_uncharge(bo, rx_mem);
	return err;

Doesn't this cause bcm_rx_setup() (and bcm_sendmsg()) to return 0 to
userspace instead of -ENOMEM when either frame array allocation fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793089479.gi=
t.zihanx@nebusec.ai?part=3D1
