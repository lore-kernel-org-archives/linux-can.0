Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719223955EC;
	Wed, 24 Jun 2026 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294829; cv=none; b=Oki60Ck5eQ7UpLMJ8VqkUY4tAfFT+x4dwdZEBIzBj2M1zpeSJ1qHatk1Otv+dxNsTA0HeegoKEbpW5ndj/DVevc2nPufwlFtATfroL5vEU5kg5p8XCteysBBY/oi1T/JL90Bb+9WCIRy2dr56F5yu71Yu8YncnnTBAoBaEWYSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294829; c=relaxed/simple;
	bh=C+WGFWNaIaf45gBRKxMcdv1jaLYDMF+6mUqNylPCqKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3Ue9mqqIXfG5x0ZEI1nmE5y04LTnnUpJZZH650YRgAzN6A9ijzBesrnZe96riGW6a+HJkiwVpaltnKh6Cxg6sjezsl4ldc2GMoAcUUmrZy2lsayK1oj+vPqXQASndNHUdkP7Yr2mhmw2RWytl7w91c3cYbULPx1DIlakrtfLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzsFuxhT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzsFuxhT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FA11F000E9;
	Wed, 24 Jun 2026 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782294828;
	bh=iNEBuHDtj3lw/hGAa3SXTCH0KqgqOiZ/1oH84U6cl3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FzsFuxhTNDoWI7G5HrhUua+dDvXmv8lRiO+gb/pKymxdOegQLr4wG4d6KxVWIvxBu
	 5F1WtFtCBm6Qgg0YS6eKrvsJwISsAu/tP4kv/6cJsX2wEbKk8aNvu9/yFUM81vcbdf
	 RuBtxaN++5alyp6neuwQTOC09Tc6hLbeSNDz87rbSiiKiDi9DK6ZeCO/GvotwwTPJQ
	 8c/6em1fy9i5LGlN8nmrqNALbBXc0/os7uyX+WMgk+lBQOMreFiryn8aG10tMRPu2R
	 tWplzI6wSuPAgUNFjbyx5luuggBY9RhkULcXrXCZYGM+WDs0441MOHOz9w0wYimMF4
	 b4Jx4bn0XucZg==
Message-ID: <76288461-98f7-4c72-9d97-3589d301cd9e@kernel.org>
Date: Wed, 24 Jun 2026 11:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: c_can: Use platform id data when OF data is absent
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/06/2026 at 07:49, Pengpeng Hou wrote:
> The platform driver keeps controller metadata in both the OF match table
> and the platform id table.  Probe reads the metadata with
> device_get_match_data(), which does not fall back to platform id-table
> driver_data.
> 
> When the device is matched through the platform id table, drvdata can
> therefore be NULL before it is dereferenced for msg_obj_num and the
> controller type.  Fall back to platform_get_device_id() when firmware
> match data is not available.

So, you are telling me that this patch fixes a NULL pointer
dereference? In that case, it needs to be backported. Please add a
Fixes: tag.

Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> index 19c86b94a40e..564c9e5b4c2c 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -263,9 +263,17 @@ static int c_can_plat_probe(struct platform_device *pdev)
>  	int irq;
>  	struct clk *clk;
>  	const struct c_can_driver_data *drvdata;
> +	const struct platform_device_id *id;
>  	struct device_node *np = pdev->dev.of_node;
>  
>  	drvdata = device_get_match_data(&pdev->dev);
> +	if (!drvdata) {
> +		id = platform_get_device_id(pdev);
> +		if (!id)
> +			return -ENODEV;
> +
> +		drvdata = (const struct c_can_driver_data *)id->driver_data;
> +	}

Reduce the visibility of id:

	if (!drvdata) {
		const struct platform_device_id *id;

		id = platform_get_device_id(pdev);
		if (!id)
			return -ENODEV;

		drvdata = (const struct c_can_driver_data *)id->driver_data;
	}

>  
>  	/* get the appropriate clk */
>  	clk = devm_clk_get(&pdev->dev, NULL);

With the Fixes: tag added and above nitpick addressed:

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol
