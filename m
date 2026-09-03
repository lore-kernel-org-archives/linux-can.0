Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD284B04AF;
	Thu,  3 Sep 2026 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443200; cv=none; b=WESlmfPmHiDUHIqneYsZJojRIgEKpEZb+fkdA8PVEDLRNqpuncvz5kVRvsMC0M1HotEFK0lczlors7chrwr2TlCcjnEvU2TppbEmkQfAblqxKAGM8qCKsW0r0N7wdxouzyE0iofARhRnjxMoQMDje5wyDrl8Fp6W6fhkXeV3yUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443200; c=relaxed/simple;
	bh=AKNFgz6y7bWysJZnMRPGzfk1IbXVY+OIBudNGcWmTOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy0ADXgm8z8ZPWm3MVBeuBHskvZic4QwoVUJm/hsW6w8y7kpqVIf5jwoZa4AbJQhIMUHia8uyxvrmGv8kbYpVdj6oM9jVmYtuJsOWKAdgtAqIRifepfUHjSlOz5a9THWEhUSxFlEocHfzoJUf4YD/twOmvTHRZJuXwfKSe+qmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB6xkOVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB6xkOVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3781F000E9;
	Thu,  3 Sep 2026 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443193;
	bh=1GaOqHUkNtj8r8eALTg+KisHKtjO2dUNcb3JPPBYfYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YB6xkOVt9oDB5SoTCXGTwsADZjPK8YHbjUkq3uunoCbjHNVj07gp6JsEQtuYnQ5k9
	 LJxrKBUneNlGhgloYUHq2mgXtyYZusxpL57Iaoo7NwjOiZv6G1uABQGFZqrG0fCsQ/
	 cFbX9LnJKYNA35+vApsZiEsB0s44jnB2dl877XYBVg/VBL41pxCf0WypQZjZacWe/y
	 dTEmI3stvPyEcCtOXfDEaFFz52E4pIOS5ui6GirrT/7PKBiIi3XDDjf3Xt7QI9Sjli
	 quWI61akQNx6sjJPRaMbr43SId7MrOPxZnqyW2rrWZIFN5IXrt+qobwsAMqVAjku42
	 wZtPlSHQ8EJHQ==
Date: Thu, 3 Sep 2026 15:46:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com, vishalm@ti.com, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] can: m_can: add ti,am62-m_can compatible with
 out-of-band wakeup support
Message-ID: <20260903-crystal-wrasse-of-trust-a9dbc3@quoll>
References: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
 <20260902-temp-v4-2-3896f7d16ce8@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902-temp-v4-2-3896f7d16ce8@ti.com>

On Wed, Sep 02, 2026 at 04:03:28PM -0500, Kendall Willis wrote:
> +struct m_can_pdata {
> +	bool out_band_wakeup;
> +};
> +
>  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int sizeof_priv);
>  void m_can_class_free_dev(struct net_device *net);
>  int m_can_class_register(struct m_can_classdev *cdev);
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
> index 56da411878af0185ff9cc512e325137428a68255..ae2d89b65fe8da65b1ca73cbf80cd8ee8483e2e8 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -218,8 +218,13 @@ static const struct dev_pm_ops m_can_pmops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
>  };
>  
> +static const struct m_can_pdata m_can_plat_am62 = {
> +	.out_band_wakeup = true,
> +};
> +
>  static const struct of_device_id m_can_of_table[] = {
>  	{ .compatible = "bosch,m_can", .data = NULL },
> +	{ .compatible = "ti,am62-m_can", .data = &m_can_plat_am62 },

How exactly having out of band wakeup makes this device INCOMPATIBLE
with Bosch (in terms of DT compatibility)?

Best regards,
Krzysztof

