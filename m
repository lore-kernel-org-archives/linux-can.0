Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212712;
	b=U412S3QhWd+hgQZ9z9SOKlJ2urEl0OE+YWMumDhn/mNVqnqI8H8enIiYE9XBU6RunMAA
	 U1voLj2U4VOqtK5H1UvkF+axeNcWfoF5BNTp2USNGzVvm42N2v9Rl1+jE6crQhWuhFJfH
	 7qaYf3S39twXutwPOxyHyIz8UZoWcUjN217HnB9NCdShxLsYR+2kSzzIX4biucDLjb4et
	 uwigxrsIrC+P2HASlcL2MzySZOekqzrs0qtcg2VfLSa9pkEJG0HasiavwsxqNTxavSZ94
	 QbeeyzH5STrVTp6reBQiyV08xr1udIoxGsyD205sYIW3L/743Xk6YV+n1mZ996UkRVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=126On3iZK4KMKJJHocGj/sq0KmAG91RtgLz2wyKIiyI=;
	b=ZGzbpRh6FAOfYPt13IpkvjBYbKvlZOkgin3c5hGiWcuCr8fAQYHvWsSS/c8UZdfKHeuK
	 1HVhjb5apn2jB3IP/Td8iOGe3rbMtoIhApmp8dHM5jfnWP32wle//nDvQpyCREcYbA1Zi
	 uBOgwhYMXcu/3Vptna8HeWDhYm1J71SR1xrllXrxviUoDc2kRXbJjnt1AIe6Y1t0XmwT8
	 uRIm/Vxn500qv31gdE41x1BnYbfreuwVWUcB9IpxFv6FYZnwLCqtlNtHuQ26FSlyeZVw/
	 gJHXX5+Dx3k+oNly/H1gAxnvuzBqosiYpyi1rSWcwQwHgQjO+mgls0Qhis0MonsSrbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdrqhXSN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FA606A698
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdrqhXSN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019C11F000C0;
	Fri, 20 Nov 2026 22:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795212712;
	bh=126On3iZK4KMKJJHocGj/sq0KmAG91RtgLz2wyKIiyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LdrqhXSN0IOqo4mVPsnkDgipkAil0vmvGedkPNgfpUlMDf3DvsnenAEaBy+mX0ISz
	 N2wCz/pZ7guIcKeBmnWb/By+TxI17h79xWNla5y3b9sovcCDV/9xVzgIeK7WF8MnpW
	 dX1tPrOKdian677YZkhQHGNxKodOxcZibQcO/u35+6pS4Z9Ur2QMIWhi9Op0KUMZz0
	 +b3xoAbdZLKPJpP1IAQ3Ve4APNJ6aq29+dAPn/NI2tzNAERZ9mJx6DiktNUCGJWJ6i
	 Sy+7stdiY03FrFZzwXvkwzc0O+N/ZHybcamCPSQOKTVac6fYgdNm0gCq+UVzmY9kNP
	 /clk4hm1VhQtQ==
Message-ID: <sashiko-outbox-226231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 08/13] can: at91_can: don't discard the IRQ
 lookup error in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261119220936.155728-9-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
 <20261119220936.155728-9-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:11:51 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] can: at91_can: missing priv->transceiver assignment in
  at91_can_probe() [1]
--

commit fb6d34ef2c907ec33aacc966536e1987c18e5222
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

can: at91_can: don't discard the IRQ lookup error in probe

This commit splits the memory resource and interrupt lookups in
at91_can_probe() and propagates the error returned by platform_get_irq().

Link: https://patch.msgid.link/303815792800553c34842147941cab083823c212.179=
2118040.git.chaosheng.qu.linux@gmail.com

> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index 58da323f14d7c..3977de7616361 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -1069,12 +1069,17 @@ static int at91_can_probe(struct platform_device =
*pdev)
>  	}
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	irq =3D platform_get_irq(pdev, 0);
> -	if (!res || irq <=3D 0) {
> +	if (!res) {
>  		err =3D -ENODEV;
>  		goto exit_put;
>  	}
> =20
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		err =3D irq;
> +		goto exit_put;
> +	}
> +
>  	if (!request_mem_region(res->start,
>  				resource_size(res),
>  				pdev->name)) {

[Severity: High]
This problem wasn't introduced by this patch, but should at91_can_probe()
also assign transceiver to priv->transceiver [1]?

Later in at91_can_probe(), devm_phy_optional_get() stores the PHY in the
local transceiver variable and uses it to populate priv->can.bitrate_max,
but priv->transceiver is left NULL:

drivers/net/can/at91_can.c:at91_can_probe() {
    ...
	transceiver =3D devm_phy_optional_get(&pdev->dev, NULL);
    ...
	if (transceiver)
		priv->can.bitrate_max =3D transceiver->attrs.max_link_rate;
    ...
}

Because priv->transceiver is never set, phy_power_on() in at91_open() and
phy_power_off() in at91_close() are no-ops, leaving the CAN transceiver
unpowered when the interface is brought up on boards that manage it via
the PHY framework.

[1] https://sashiko.dev/#/bug/linux-940d736c-5531-4ec5-97e9-70c51890e25e

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119220936.1557=
28-1-mkl@pengutronix.de?part=3D8
