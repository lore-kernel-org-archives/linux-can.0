Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795301002;
	b=FdJlUT3S11fqZr/4oVaaw2CmVvZJJfGUFPj2mIMolA2Yaz/mdPD1u7WjUY/+fPG3zG9I
	 D6rWq119eozssDgYCwgBqDj5Npw/NDTBHffYj7Nawx5FWavw/B5XvNA0D85w2evoscYiE
	 rCC8YXXKrGSvFnlnuWzSJP1BK40TXtxvk4bH+Wf4RuHMg585d8OHiMPQdbILIFkNKiB5E
	 xrRTeeOLIENz5UfOaNehbzW1uh/puhNjlex0b5K4eBKmDAfFY2FRNb0eXvdg9bROAL2bI
	 Ami7sJpaAivU3+m+8ti99ZCBIE/ClLYB2lk9pT7JLblyLj2MQ4Jv6Q3zz/3q8S6V/Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301002;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dmqTZBz98+aQHoIkKX3Bi+x48YWaXynzEN6Eook8DNE=;
	b=XHNsLw9S4VEZK7K0RWLSREw/fPF9dH6/4eljEEhHhzu7c9kN16ale2yMQBVWVpq0PiJr
	 UaJEjSgpelWww8bb+jAorQqnmPUZ+Mq78K4QBBZGD+U54MVG2UC7OtvJ0L4M/Of1s12wX
	 hdUBae7NRXpqoIbaqLj1rAvzffK53bjtDDcCogqQx7JiEpfZa9DNk/kNZMZ/ro5nq40gq
	 AsUZu6Qk1sytuvxkBM38jfbXX2XyBSSUyYCmRlixrM00yiKhmtVzlyOdVADV/+v1ijIjn
	 1A3kM3JSCbx/1WKsBoYwp7fMHrVL3m02/2fQr6HMIUm2CjDAc1J6ELaTHkhABdQNsBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eehXfdoH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09138606A320
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eehXfdoH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A205C1F000C6;
	Sat, 21 Nov 2026 22:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301001;
	bh=dmqTZBz98+aQHoIkKX3Bi+x48YWaXynzEN6Eook8DNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eehXfdoHOTgkTQ6HgF8I8KdGNUJyDE0LmP3l7TEGr7rXJ2TwRpbA5U7hvrrKIG+k0
	 3RagkY2k3My5oih4S5rWCt6LB+kwUwhmkg3VsGYAtwKyktb7YV6z1xTdA4+5odaynW
	 rc3ZmLUsLJ4eMYUN0DZ+FIeulq1Tw/THvXl5DxFfGdNqGWTEBZZIHIH7AJyEYQVZlo
	 Z/f86fY91CtfVBjVi0/6BNySduWSaIX/jpAoGVudDljYegupHVZdJgslMyDrfdAWob
	 IrCaj5bqTJ4ObSX16Gl5Ym1IakMqDtlMLthendyVnxQOJYY3WCCqB0CLAxbpNOY5JT
	 4IWrhvBo1B0mQ==
Message-ID: <sashiko-outbox-227464@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v9 05/13] can: gs_usb: fix hardware timestamp
 state for mixed channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-5-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
 <20261121-gs_usb-fixes-v9-5-db121d488945@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 22:43:21 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] can: gs_usb: unmatched opening brace in gs_can_open() breaks
  build
--

commit 5f884365b4de3f2bf3d74e69451cce317c14e008
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

can: gs_usb: fix hardware timestamp state for mixed channels

This commit moves hardware timestamp initialization to gs_usb_probe() when
any channel supports hardware timestamping, and starts or stops the
timecounter when the first channel opens or the last channel closes.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 470dd52d97dfe..30bcb734c5df8 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -990,9 +1030,19 @@ static int gs_can_open(struct net_device *netdev)
> =20
>  	can_rx_offload_enable(&dev->offload);
> =20
> +	/* rely on RTNL to serialize concurrent ifup/ifdown */
> +	ASSERT_RTNL();
> +
>  	if (!parent->active_channels) {
> -		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> -			gs_usb_timestamp_init(parent);
> +		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
> +			rc =3D gs_usb_timestamp_start(parent);
> +			if (rc) {
> +				if (rc =3D=3D -ENODEV) {
> +					netif_device_detach(netdev);
> +
> +				goto out_can_rx_offload_disable;
> +			}
> +		}

[Severity: High]
Does the unmatched opening brace on "if (rc =3D=3D -ENODEV) {" break the
build?  The stray brace is removed in the follow-up commit "can: gs_usb:
add support for context analysis", leaving this commit unbuildable for
bisection and stable backports.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-gs_usb-fix=
es-v9-0-db121d488945@pengutronix.de?part=3D5
