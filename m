Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934F361DBF
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947102; cv=none; b=eDfPWReB/TCL1fKL3trzUbW2ntOf7DOWAqAiH1AGa6syMNI24hV4kLvYgMuDWAOgdeAqHQAi8oEmWpYFCZ1vzrsH9/8bDFCq/Iy7YvcAGlMa16OHvhrjQIzu/39CXdFXgWJZGdAXISkEx4HmrWr54e5BikKJzQ5sDC/Lapjne6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947102; c=relaxed/simple;
	bh=EPN2obsg9YkxxojCfG7XMQzs07sDcRQVXs1EzixRqzE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YVOB6689nf0IKAH/M6kf1E//VA6a37f2qyr7lrs0Jrt7cP7o62Wz2mJl7kMPSqEmugoIR9K+FnAoIt+RMpOzwBA/FUp0fAB6fovGcnhKbv41rGaC49FH2czS+DD19cIJib1VMy+k8EH8uHtuUQFzl1bTuNxwy5CtaQvRfagFmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndflMsPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndflMsPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59B81F000FF;
	Wed, 14 Oct 2026 03:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791947101;
	bh=0UBazoMuXYGD7F8KymIaavL137cKvMPMfEel5YhdK1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ndflMsPUT4TzKZLC1fWLYpVKvBn5vHkFdPupHgJMTpg87H3NXH80geCBLjpd//rnE
	 98gr0ZEmNXiEasdJ0Nzbl1JsPJCJ1IrdL3OSZ+k4F3uKNNY8Fi9ULDp8sE9Th4hnfc
	 lqhn3s9DoDFBrd/2kxKRpz3r+ZzQq/ZM63uYjTMiL0w0I8/g838Pz4nT6/DJ4zbLOV
	 fYXEvvYF5vDQ2gDxyWa7Q2ECipXd/uMBrreurLwvGbRqVWsIfWD0RqmdMmzzBwnxhO
	 VejFNEqVCSEjcmL3xHGkiqUqY1OuSztkLYW00oxbn6Fiwg+LinMO//mKHaSo1mGh5k
	 c/IaPxnW3jXWg==
Message-ID: <sashiko-outbox-170754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/3] can: rockchip_canfd: cancel bus-off restart
 before closing the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cunhao Lu" <1579567540@qq.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <tencent_B15E13184DA04C4382F48848C006A2B51F06@qq.com>
References: <20261014-rockchip-canfd-restart-close-v2-0-c8fbdfad1803@qq.com>
 <tencent_B15E13184DA04C4382F48848C006A2B51F06@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 03:05:00 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: rockchip_canfd: disable_irq() called on shared IRQ
--

commit 580402c6870b4c8a3e1db89526b629150785fd7a
Author: Cunhao Lu <1579567540@qq.com>

can: rockchip_canfd: cancel bus-off restart before closing the device

This commit cancels restart_work during the close path before closing the d=
evice
to prevent a running restart from re-enabling the controller. It also uses
disable_irq() during the restart callback to prevent the IRQ handler from
running while the hardware is being reinitialized.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net=
/can/rockchip/rockchip_canfd-core.c
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -356,8 +356,10 @@ static int rkcanfd_set_mode(struct net_device *ndev,
> =20
>  	switch (mode) {
>  	case CAN_MODE_START:
> +		disable_irq(ndev->irq);

[Severity: Medium]
Is it safe to call disable_irq() here on a shared interrupt line?

In rkcanfd_open(), the IRQ is explicitly registered as shared:

    err =3D request_irq(ndev->irq, rkcanfd_irq, IRQF_SHARED, ndev->name, pr=
iv);

Masking a shared IRQ line globally delays or drops interrupts for all other
devices sharing that line.

Could this driver instead use a software flag paired with synchronize_irq()
or spinlocks to exclude the handler, rather than disabling the physical lin=
e?

>  		rkcanfd_chip_start(priv);
>  		rkcanfd_chip_interrupts_enable(priv);
> +		enable_irq(ndev->irq);
>  		netif_wake_queue(ndev);
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_196A2433801=
631CD2FA42998465E26316105@qq.com?part=3D3
