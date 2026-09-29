Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C183B14DE
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710419; cv=none; b=YgjJY4W75GdFF+mw2K0sdK9vEF4GNkONcTwtetbw/J48BzEcRzdob/avhXHxiGJ7+AWYLh0Zuhuc6e2QWkvDzBKq9I2hEFIMT6GZ3sRij686l4NJQHja4xjqUCW4t+/8uGVKWn+zq/8nxg9DH0IG9epHMuxRCvj94JhNFjbfXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710419; c=relaxed/simple;
	bh=6xYNNoAYWq9AhWFj/eSggkRWUqd4wpfM7S70PPUdUKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NfoKOQEYmezUHmzctelcxp1kkwtQ6+NrQMHf6xQhrQCcKP5ldKHmFasFkGM87r3+1au2FDjZppwdHsRcHT5k3MRJ0DYtONTqeuZDmMxjnovTz17IQOxzzluQPyn3Yq4lYzxu2IfhnJFzefJndQPr2pC7GnvFytjke/hGbQynaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfUW/+tM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfUW/+tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202441F000FF;
	Tue, 29 Sep 2026 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710416;
	bh=ekiswqZ9Hf8z6H3hYuB84HFq6PS3d4cEKME5JVMse1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfUW/+tMl/d5jAO39gei1L7gUR2mu2q1Vz1+Bxi7icohFPe6SNceMXtZx4UulO+23
	 3N5AJ1eiw2Ktl+gFHQwD9lEvIKWE2HZf4vQdmHNoFK+t9eMO8BIRW9QTgmJk91nkaf
	 1WjMSLDvmBkahseFh2F5OSFw/BeAS8Ne9FKQ13aTRiRWr9RrolUyyp8z4uKUdZ+kKY
	 w5gUqlZbjVDihD5VhyvQD5fywPQwliFHczyrgCrIJs3czezNqx+0r0gNgjFGcqcZnQ
	 xtGu8NKMqlH/z3NgYd4XRsU556u1+tVO8inhwmQtcFqu4YtmSrUKzRhhvxoXqPkyez
	 6Sw2O0inv63bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 08/22] can: cc770: platform_get_irq(): propagate the
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260928193312.553632-9-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-9-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:33:35 +0000
Message-Id: <20260929193336.202441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: cc770: missing IRQ returns -ENXIO instead of intended -ENOD=
EV
--

commit d39a1b15e30aece42be9b57846cef8999da6e194
Author: Quchaosheng <quchaosheng000406@163.com>

can: cc770: platform_get_irq(): propagate the error

cc770_platform_probe() turns every failure of platform_get_irq() into
-ENODEV, including -EPROBE_DEFER. Return the error unchanged so that a
deferred probe stays deferred, and keep -ENODEV for the case where no
interrupt is described at all.

Link: https://patch.msgid.link/20260914055611.495105-1-quchaosheng000406@16=
3.com

> diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc7=
70/cc770_platform.c
> index b6c4f02ffb97a..ac218acedb101 100644
> --- a/drivers/net/can/cc770/cc770_platform.c
> +++ b/drivers/net/can/cc770/cc770_platform.c
> @@ -156,8 +156,13 @@ static int cc770_platform_probe(struct platform_devi=
ce *pdev)
>  	int err, irq;
> =20
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem)
> +		return -ENODEV;
> +
>  	irq =3D platform_get_irq(pdev, 0);
> -	if (!mem || irq <=3D 0)
> +	if (irq < 0)
> +		return irq;
> +	if (!irq)
>  		return -ENODEV;

[Severity: Medium]
The commit message states the intent to "keep -ENODEV for the case where no
interrupt is described at all." Does this implementation achieve that?

When an interrupt is missing, platform_get_irq() returns -ENXIO. Since
-ENXIO is less than 0, the new check will return -ENXIO directly, bypassing
the intended -ENODEV return.

Additionally, is the check for !irq dead code? platform_get_irq() never
returns 0; if an underlying lookup returns 0, it triggers a WARN and
returns -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928193312.5536=
32-1-mkl@pengutronix.de?part=3D8
