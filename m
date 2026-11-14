Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663215;
	b=keWRQb4KlaV/YZ2DKIXc5svxi5BhTwIQYgOrWcew5F/vOVPSgE9jFXRqDwN5T78y9aMQ
	 XrECWeAoVrfo1G9yRTf/Vdcm3uol/qMvmE39VprA1nNhCGVwhflvGSV1nff8u0PCjLlMA
	 +eXjLZY5XNvpS0eqx42nwrS4ckkPNwmOE437tBsmRPBryacd301VZSHr2u2ljSeS+mKe5
	 w6x1dCcGX4soGR4r66PplF1PjueZ5/IQpmlI4ywtORMNN9jDNHjVhaDQLbgcs2CnIPX4s
	 Imm0ht4BWI6GHQ3PkA+9RZ0hxvOLvfBcqOtClQuZ6pwo5YlXY9wfMESTFxrOMYuEd7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ws5m1MosyzfQ6sKWkZw2a2uQnouRVxLt0ERf0lcFKRA=;
	b=4eQ2OXXSAwus6ElLYTOgWDYkoNYJYamdxTp4lVT1XFILU6zk7IbFHBG0PoOCbIukoynR
	 YBOJsWNesi8SGGNPerLQcjejg6ZlXH5DoUGoiAIHh/p5UDkbruGfIwMZ9dTszoGZWdqd4
	 KeiTmMtAO31UZyrZRxAp1hd+qqUf+Ve1rm7KVRX2V+vkfE0R78+j7GhqTQ7a5B9JdlwCp
	 MWorTdtET33YWBcB768WtjAePG3gGfsCFaCCajDourwKnE245m+NTNODel0Cy+wB9fK8Z
	 vspnTztkiH8sD7weIWhfvOpCJuT8LQHfHy2FtkuE9MeX3M/F1P0LkAt0/ll6yclMO7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2afsMiJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2774606A887
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2afsMiJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBF01F000C4;
	Sat, 14 Nov 2026 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663215;
	bh=Ws5m1MosyzfQ6sKWkZw2a2uQnouRVxLt0ERf0lcFKRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2afsMiJFhEnxkO0i55o3fG67+kusvSB5fLpU3lNYk27N5KRRckIZQcKONWoiibaB
	 tkTG0jULLWm+lv9nM9EPdlql4j/RrpmlqdHncsiM5SzwRfYQu9Lq5i9bBoafm8BiRv
	 1Mt3J9spNEyn1Sl6ELWHMNTRLPm/TBaDOlKmX122MrS+kgQZd9j7MKQZnn+yfKWA17
	 L+NN4fiK1oGs06TX9mLthd8E5fnjQ+k5VnW0qNFfCaM9gjfDoUC3gxioc7GfEi/b3H
	 P3cleUKMCgFTqQuGvTcxtsqOGH2eFjUpuFqOwKQwetPkHM9a/laZmPnQo5r9E0i3rh
	 VFRBhx9oQR1ag==
Message-ID: <sashiko-outbox-214574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can 1/4] can: c_can: c_can_plat_probe(): reject devices
 without match data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, wsa+renesas@sang-engineering.com
In-Reply-To: <20261114-fix-device_get_match_data-v1-1-2d82025e9646@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-1-2d82025e9646@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:33:34 +0000
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
- [Medium] can: c_can: c_can_plat_probe() rejects c_can_id_table matches
  with -ENODEV
--

commit e910ae3e03adb41c30f60d29d9b4c11824109fe5
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: c_can: c_can_plat_probe(): reject devices without match data

This commit rejects devices in c_can_plat_probe() when
device_get_match_data() returns NULL.

> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_c=
an/c_can_platform.c
> index 75607b1afd2e9..b6012cd713cee 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -266,6 +266,8 @@ static int c_can_plat_probe(struct platform_device *p=
dev)
>  	struct device_node *np =3D pdev->dev.of_node;
> =20
>  	drvdata =3D device_get_match_data(&pdev->dev);
> +	if (!drvdata)
> +		return -ENODEV;

[Severity: Medium]
Does this reject non-fwnode platform devices matched via c_can_id_table?

device_get_match_data() only queries dev_fwnode(dev) and never inspects
struct platform_driver.id_table.  Because c_can_plat_driver registers
.id_table =3D c_can_id_table with .driver_data pointers, devices matched
through c_can_id_table get NULL from device_get_match_data() and fail
probe with -ENODEV unless platform_get_device_id(pdev) is checked as a
fallback (as done prior to 5e6c3454b405 ("net: can: Use
device_get_match_data()")).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-fix-device=
_get_match_data-v1-0-2d82025e9646@pengutronix.de?part=3D1
