Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [37.187.220.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9641B4F09
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.220.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145068; cv=none; b=gJnitWFq2yX2UTm4QUBLLgaqAugPx65f4CNrENPGFsSJAunQDXxo3MVoYSPCxi0jCgJq4kwIXSwUmcOzY5w5hkOER12btxEB6SNeiZNU+RAqN3XQl+17gnuOtkFj2fE0/AvMtRgiC8d3Hy+gI+mOZxpScL+PxFlUJDvkf6uimgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145068; c=relaxed/simple;
	bh=JzdYK4/mVWh47gUoZJQrG7duf5rpyPL52yROrUvZBRg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZl7gNDSYh1yUaLbsobDgEoNJ0iOhvjuE2aQKj3PYdiT40CMFWqF5RXBqEE62UHELJeBciZXZKhZz0MnUuMLII/++GOPfbz51Q/pkYHJms6LcrZdlTWny8ODdv+W2E/LgNVJ13GQ9Gh32rPGtjMB2aOpTIZMntdt8k1Zv9iNQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=N8x23Uox; arc=none smtp.client-ip=37.187.220.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="N8x23Uox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1792145043; x=1792404243;
	bh=JzdYK4/mVWh47gUoZJQrG7duf5rpyPL52yROrUvZBRg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N8x23UoxZIoCcBfVj/ZiOIh1HrnsYTstaigoX1LEYZzgt+cTSkr8TvI7kpGzCcoWd
	 TRiegJcJZ5AuX/p/l4SC76yBbX87fCu8Gm3zIdYP7lTOd+UBNZZ3oamnVyGYV3SXK4
	 5Xt6CUZLR5Y425nhfJGEN5nR8ENCO+UU4KQ6h3Fgizm+r1NNTIq2lFbBsQIkhmDuHS
	 H5Z5ldWPWLSV+3Iq44mhDyT/sVhSLcrUbQi9HquIndCOOQc5wS0XBGudlYHSs4jrXR
	 JozAYyyOow0VbkmsnaM+y9gJZJCvfBSjWhVEM4fVLkHFZqOh27wEIAiGAA2i37VNGB
	 z6BLEPzDNMZZQ==
Date: Fri, 16 Oct 2026 10:04:00 +0000
To: Markus Schneider-Pargmann <msp@baylibre.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Sean Nyekjaer <sean@geanix.com>
From: =?utf-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>
Cc: Kendall Willis <k-willis@ti.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] can: tcan4x5x: Add suspend error handling
Message-ID: <9aba5682e371f5969d3ddca1c6a763485bc25285.camel@geanix.com>
In-Reply-To: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-2-7efa2b172cce@baylibre.com>
References: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com> <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-2-7efa2b172cce@baylibre.com>
Feedback-ID: 134068524:user:proton
X-Pm-Message-ID: 4007cfee36bc45d272916d42b64204fb7d67e81f
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Fri, 2026-10-16 at 11:57 +0200, Markus Schneider-Pargmann wrote:
> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c
> b/drivers/net/can/m_can/tcan4x5x-core.c
> index a5b8829aa519..b69312413d62 100644
> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> @@ -575,11 +575,20 @@ static int __maybe_unused
> tcan4x5x_suspend(struct device *dev)
> =C2=A0{
> =C2=A0=09struct m_can_classdev *cdev =3D dev_get_drvdata(dev);
> =C2=A0=09struct spi_device *spi =3D to_spi_device(dev);
> +=09int ret;
>=20
> =C2=A0=09if (cdev->pm_wake_source)
> =C2=A0=09=09enable_irq_wake(spi->irq);
>=20
> -=09return m_can_class_suspend(dev);
> +=09ret =3D m_can_class_suspend(dev);
> +=09if (ret)
> +=09=09goto err_disable_irq;
> +=09return 0;
> +
> +err_disable_irq:
> +=09if (cdev->pm_wake_source)
> +=09=09disable_irq_wake(spi->irq);
> +=09return ret;

Wouldn't this be better written in the shorter form:

=09ret =3D m_can_class_suspend(dev);
=09if (ret && dev->pm_wake_source)
=09=09disable_irq_wake(spi->irq);

=09return ret;

?

// Martin

