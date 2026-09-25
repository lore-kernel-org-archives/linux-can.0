Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D41402B8C
	for <linux-can@vger.kernel.org>; Fri, 25 Sep 2026 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342959; cv=none; b=KIjDKbdWhoYEfI802t9Ri+uHH6Ws+Et1LBBRzn65vSF4Nsu1bDd1k9lVjjJumwnbBajpJTHg3CV5+OXzYZhhnan8hIaAoxdAxHUdBgh2oGbsp1JE7GzItNmHQLnuGgeSph9LGKuXviKy+EYlTC1zdK0ZLMoHAxYrTqmpBevgQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342959; c=relaxed/simple;
	bh=3q2q24QxjZeTA6pbub4YQAn0g0+xBTZb19biv/S+mpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gz0sb4Cj3CuxLYWk3X9oha2xKMlhmRCtRoxGYdT6mxk1j5uje43PP9983b67oPWAsR+hyUw+EGLZVs7jGDmRcp6PD1s4+TN/UFI2lwyFN6eJN/ni4VGxQQAPt851oY/+4JVgeJKlYlQd5v9MuuloqvNoB6+o+qhKrN3Hic8yWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULJWWjpE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULJWWjpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3CF1F000FF;
	Fri, 25 Sep 2026 13:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790342957;
	bh=Lr+J8bbimuny3r/eB6EaUPoh8EX6SfNY28RfWp26TYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULJWWjpEBpxbWtUgQTM1+guYpGkZL+FSM1Qu99icWf1ttQyEH/FBQkuk4x5IMa37M
	 LGSKHmtkpyuziVTUrq9IBNRRXiwIv2Q3oBjKlK49u7ieBRy8Bp0dxQ/DPKHz0CTqqj
	 yhuJzJkGKPHGY5Hm5ZI4D8buHvamr/RRTWq13nWMD1hhMgJWbTECGIDYB8PQvTF+br
	 9dGq/f1Vol+Bc1fm824ec+g/ZsiOqhU21ZZwErfTzV1NJbG0bXx5JueRgvgEae44YA
	 uV25x1yuD0/+nIPJIrvxwCg9MEiZ5xU7ZWVUTLxtjco8zVB2UkwZadKhjgDU1f56U/
	 Qt0+hED3wIQ7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] can: peak_usb: Add PCAN-USB bus errors reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260925-peak_usb-v3-1-e7bfccacf795@peak-system.fr>
References: <20260925-peak_usb-v3-1-e7bfccacf795@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 13:29:16 +0000
Message-Id: <20260925132917.3B3CF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: missing CAN_ERR_CNT flag in bus error frame
--

commit d66a7ddeb9e61cb6f2f338731231a0a8c41a3d91
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: Add PCAN-USB bus errors reporting

This patch implements missing CAN bus error reporting for PCAN-USB devices.
It parses the hardware ECC, RX, and TX counters to construct standard CAN
error frames.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 8fd058c328564..c59166a29648d 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
[ ... ]
> @@ -550,23 +560,94 @@ static int pcan_usb_decode_error(struct pcan_usb_ms=
g_context *mc, u8 n,
[ ... ]
> +			/* allocate an skb to store the error frame */
> +			skb =3D alloc_can_err_skb(mc->netdev, &cf);
> +			if (!skb)
> +				return -ENOMEM;
> +
> +			cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +			cf->data[2] |=3D can_err_tx;
> +
> +			/* set error type according to 1st data byte (ECC) */
[ ... ]
> +			/* set error location */
> +			cf->data[3] =3D ecc & PCAN_SJA1000_ECC_SEG;
> +
> +			cf->data[6] =3D pdev->bec.txerr;
> +			cf->data[7] =3D pdev->bec.rxerr;

[Severity: Medium]
Is this missing the CAN_ERR_CNT flag in cf->can_id?

Userspace tools like candump rely on the CAN_ERR_CNT flag in the CAN ID to
know if data[6] and data[7] contain valid error counters. Because the flag
is not set here in pcan_usb_handle_bus_evt(), will these tools silently
ignore the newly provided TX and RX error counters?

> +
> +			if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
> +				struct skb_shared_hwtstamps *hwts =3D
> +					skb_hwtstamps(skb);
> +
> +				peak_usb_get_ts_time(&mc->pdev->time_ref,
> +						     mc->ts16, &hwts->hwtstamp);
> +			}
> +
> +			netif_rx(skb);
> +		}
>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-peak_usb-v=
3-1-e7bfccacf795@peak-system.fr?part=3D1
