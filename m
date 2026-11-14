Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661400;
	b=QMk69i9wvWhfdKo21+e/uGhc/YmDXRfzUe/5QUk/DTS7fOl8a5dB/TorQ1WW8OLCVf9b
	 0BN1ABADu/aITTSQtDi6HPPC6tMTtyqZnmeL0NWxhup6lQ5YQJjafsFOxvvJY6y3nVIa9
	 n3+kofp/bc0UmKo5KbDg7tm//U+D9OQ/Z0iomiG11vPUU6Gd2eS/OzLQojR1JUyj7OAbR
	 vZf4tR8Vl3kiVMsPwDgTp5OhLwolnqaRh46G2pT5UC3xWG+IiGF+n4hFEl3W7ObTvBOGY
	 6ZDRRLOIdvi1hc19ibc3ulDwOEBZzIpo/URF76dJnv6aaIspHCuzZaCUsJGmZig1DYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661400;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v2OYNbFfkGZlDpW1DfpQlKS7xAtxiV/7es1V5MAlhTI=;
	b=NJVOAZsjEIp1kDc8NNS7dRpPCwncKj7Ouos2vJqljyEARbjxiwK500zC7EwF6abIvF0T
	 C7HjwEZViWWX1J0aLWtmzLexbwVrRaXs5RtieAz5eE+K0f8FUbfxM+vpemeRnWAN5uS4L
	 qjkveloUrrnb23/dRnHt+5LnEYrtcQZcYWkA3F+Pt7m/gYZUkPWcL3KRkzxU9WjV3aXck
	 ifRxsODrtM07hc5eveYVZpRRT2ef8e78oWwhP90bpT8zM3HZ4ggkY+aussEQrHvYd4wAA
	 THafJxQAlZB1rf6vFwaBtoWzeZISsf772ELxAqAb+HR47g6Riiwf+OSPwsfrNUcGOEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iW6thp87;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC01606A32D
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iW6thp87
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15611F000C8;
	Sat, 14 Nov 2026 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661400;
	bh=v2OYNbFfkGZlDpW1DfpQlKS7xAtxiV/7es1V5MAlhTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iW6thp87JIsFoudGOUkLSZ7A5kdLKkv1a93eoSIoRv+LDqvql0g0P/UxuhQInqaaW
	 n3aOshpyi9j/wmG0GhJG4b5lLjac9eNLI6ODMCNotdBPsNcjf++xjY7g3oECAbAIfF
	 oWUBLjPi/Cggq/cHL2j5uLLSr5eAJ/qouI6/rpfsydu/n/eOrLUfEyZRlqMuUxNPlT
	 7lHktDD+6glCozI0zEfv7flvxtvwnpNt4Qv8xSkYiINu5QQzQuknhC7Ffu7eo+FoE5
	 fAoiKZDe+GwnREvyU8ZyCWSBkwx6gtfkf/Potex3Oc2WsA+kR4hX6XA87b0lhDfXPN
	 jw5U2z7IpSosA==
Message-ID: <sashiko-outbox-214519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can 2/4] can: flexcan: flexcan_probe(): fix probing for
 m68k/coldfire and reject devices without match data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, wsa+renesas@sang-engineering.com
In-Reply-To: <20261114-fix-device_get_match_data-v1-2-2d82025e9646@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-2-2d82025e9646@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:03:19 +0000
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
- [Medium] can: flexcan: PM runtime double put in flexcan_probe() [1]
--

commit 358ff5ffd9961920463407d0074c445e652d7609
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: flexcan: flexcan_probe(): fix probing for m68k/coldfire and reject dev=
ices without match data

This commit restores falling back to platform_get_device_id() in
flexcan_probe() for non-OF devices and returns -ENODEV when no match data
is found.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 86b40abe9e767..2bb9e4184eb57 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2148,6 +2148,11 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  		return PTR_ERR(regs);
> =20
>  	devtype_data =3D device_get_match_data(&pdev->dev);
> +	if (!devtype_data && platform_get_device_id(pdev))
> +		devtype_data =3D (struct flexcan_devtype_data *)
> +			platform_get_device_id(pdev)->driver_data;
> +	if (!devtype_data)
> +		return -ENODEV;
> =20
>  	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
>  	    !((devtype_data->quirks &

[Severity: Medium]
This problem wasn't introduced by this patch, but does flexcan_probe() drop
the PM runtime reference twice [1] when flexcan_setup_stop_mode()
fails?

flexcan_probe() acquires a reference with pm_runtime_get_noresume(), and
register_flexcandev() drops it with pm_runtime_put() before returning 0.  If
flexcan_setup_stop_mode() then fails, the error path falls through from
failed_setup_stop_mode to failed_register and calls pm_runtime_put_noidle()
a second time, underflowing the usage counter:

drivers/net/can/flexcan/flexcan-core.c:flexcan_probe() {
	...
	err =3D register_flexcandev(dev);
	if (err) {
		dev_err(&pdev->dev, "registering netdev failed\n");
		goto failed_register;
	}

	err =3D flexcan_setup_stop_mode(pdev);
	if (err < 0) {
		dev_err_probe(&pdev->dev, err, "setup stop mode failed\n");
		goto failed_setup_stop_mode;
	}
	...
 failed_setup_stop_mode:
	unregister_flexcandev(dev);
 failed_register:
	pm_runtime_put_noidle(&pdev->dev);
	pm_runtime_disable(&pdev->dev);
}

[1] https://sashiko.dev/#/bug/linux-34c83ee1-4b00-422c-b485-f3256591cdcf

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-fix-device=
_get_match_data-v1-0-2d82025e9646@pengutronix.de?part=3D2
