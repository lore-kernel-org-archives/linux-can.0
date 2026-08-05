Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461143230B
	for <linux-can@vger.kernel.org>; Wed,  5 Aug 2026 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929014; cv=none; b=pZ6bBGewfJFxjO7gPVE+wrBsBwKxm2+EEc3LjHiHlN8y/yIlYsFyjKGbals8GT1u5Q43JXlFxiX/4HXcL5x8tEf5AYx4d7p3sBWfTBeoXDqseb8uSByadxr4RaQVdCHr1njixecmIMjF8CH1B7nsbgNOWunq+v1FDEygr0ttqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929014; c=relaxed/simple;
	bh=c1/7jHz2smWogQqamWsnuflZV+N5+NpoZKs2ipjT4Gk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ntOxQ3qTe5VM1PKx+YoDu3slIaVIAoInwPz3qzvGdsliFH5Q+DGbwHWFt5yVM/POGQu8upUr531fI25oUvDXGcyP5d36VkYZZVQZNuZBkn9yRugNbafFrvKfKctu98UIqKIlwH0KVr+Csbef1xr2Zc98HEx2HZxG3pGH89zgBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/FjTV28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/FjTV28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14951F000E9;
	Wed,  5 Aug 2026 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929012;
	bh=AD9NPxM3sJ8RiJxT9HF+z/tbjV3T4TUcGlxQZakComE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/FjTV28K6bjHko5+RW0PbHeoc76MJpMsz50h61EcA85uK9SkJ3rE9vhWIWKinK75
	 j+IUx4qShaOaz2EVRUMtTCogH5vNVFTmVV3/viBRbHYshERbcbiDveL8DPcky44LZq
	 MFAQqL6/TxbBvtcL2QRtPj+08TXGvOowdCU6KeTeCsod4/62sz6qf64oK+SyJwdSMv
	 4SzwM6624Oi1PYTJY8KnFI6BBFuUnXYOifVV5IOMHRjqbOynUog7WtmeL7BC20XhXJ
	 EI1Twdn2bF3qCWdpQcVnq24rTX+QKbTp1oZ8Q1wp3cyz0uPpWupWtEgbqLsq5azZcs
	 2MvxQhwDgAnFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] can: tcan4x5x: put tcan into sleep when removing
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Nyekjaer" <sean@geanix.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260805110708.3220251-1-sean@geanix.com>
References: <20260805110708.3220251-1-sean@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 11:23:31 +0000
Message-Id: <20260805112331.C14951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Polling timer Use-After-Free during device shutdown when configure=
d without an IRQ.
--

--- Patch [1]: [PATCH v5] can: tcan4x5x: put tcan into sleep when removing =
driver ---
commit 2a7917c5ce38fcbd43e02a99be03a839492ce7ee
Author: Sean Nyekjaer <sean@geanix.com>

can: tcan4x5x: put tcan into sleep when removing driver

This commit puts the tcan4x5x transceiver into sleep mode when the driver is
removed instead of leaving it in its operating mode. This reduces power
consumption once the driver is no longer bound to the device.

> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_ca=
n/tcan4x5x-core.c
> index 31cc9d0abd453..bdb266be6dd37 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
[ ... ]
> @@ -543,7 +565,7 @@ static void tcan4x5x_can_remove(struct spi_device *sp=
i)
> =20
>  	m_can_class_unregister(&priv->cdev);
> =20
> -	tcan4x5x_power_enable(priv->power, 0);
> +	tcan4x5x_power_enable(priv, 0);
> =20
>  	m_can_class_free_dev(priv->cdev.net);

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a
use-after-free of the m_can_classdev structure when the device is operating
in polling mode (without an IRQ)?

When the interface is shut down prior to driver removal, m_can_close()
eventually calls m_can_disable_all_interrupts() which attempts to stop the
polling timer:

drivers/net/can/m_can/m_can.c:m_can_disable_all_interrupts() {
    ...
    if (!cdev->net->irq) {
        ...
        hrtimer_try_to_cancel(&cdev->hrtimer);
    }
    ...
}

Because hrtimer_try_to_cancel() does not block to wait for a concurrently
executing timer callback (m_can_polling_timer()) to complete, it returns -1
and allows the driver teardown sequence to proceed immediately.

If the driver unbinds and tcan4x5x_can_remove() calls m_can_class_free_dev()
while the timer callback is still executing on another CPU, won't the timer
callback access freed memory when it interacts with fields like
cdev->can.state?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805110708.3220=
251-1-sean@geanix.com?part=3D1
