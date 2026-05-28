Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA93D1CAA;
	Thu, 28 May 2026 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966145; cv=none; b=JuQNjVFxQ7gYBdCO+/eLGjZFJu1x/TAX97X3KL9hwcQqr4uQeC7OLVF4QE84PNYVAO0XRJP0b2wkgjK4sruZE/dg+oCZY02M4aaeZDCT9+nQqDZ7/PlzeIJtI/yHlym7Ag+UerFe5ieMV3zFw/hFymYDhx0BzHUea2q++FJr2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966145; c=relaxed/simple;
	bh=OcrKigby6pKTGkKN6SbVrA2Nv859hY6uVKLZ1ka+nkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4wVsSVwU+XU80zBgiBiJ0/eOBRfb7s4icgDfK8Wv10rj1ISjsWZB1omB8ecL59dV3qLHk8k0vDAnynuA7ekYmq1+CoqnBSRcicd2zwC5iSUEZngQenvp7+/vofWPWgtwzQ0uNtFXM4dhhMPX8iHUHyiBqPuR3I9TU+EuPRgXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOSwxvdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOSwxvdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EA41F000E9;
	Thu, 28 May 2026 11:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779966144;
	bh=uupqXRIRO5CxiscEA7Wie2k89z+d4Z3FWBSh2AjHln4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YOSwxvdisMgnHZO7dRQ6lpIfWsVLBrJ+nILY+K4uUnrgBCnib1HD0yVVmAojTxu1X
	 /x0r/MbsAVM5J7HsHc/9sD+Pdp7+7MPAw9HfLTRmaC/QanzluBHlMYe078kjcJvGXU
	 Z/GlimgbJCPgTyP6wg56c/l3NSTSjQeN8GAzIi2HUojbXEhPTUJYzflX0HvwhfsY9e
	 HwmjULPI8169dPBz55ekoPeWcciBjb7IWldPK38btyaTV/17t4hOv8f6VSxrGA/CU4
	 Hi7zjI2W9FXmtfaynk/fdn9ZG1vyvt3eP4GhrKPsOTx4KR0NpKWmvXFCOnG4V9it4q
	 oUBm7c/RV3iow==
Message-ID: <86caae65-e768-494b-8a75-f79ffcd2f5e4@kernel.org>
Date: Thu, 28 May 2026 13:02:20 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
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
In-Reply-To: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/05/2026 at 11:45, Uwe Kleine-König (The Capable Hub) wrote:
> No function in the flexcan driver ever accesses the .driver_data member
> of its .id_table array as device_get_match_data() returns NULL for
> non-of platform devices. So drop that unused assignment.
> 
> While touching that array, drop the trailing comma after the terminator
> entry.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> I found this patch opportunity while working on a cleanup quest that has
> unifying platform_device_id arrays as first step.
> 
> Best regards
> Uwe
>  drivers/net/can/flexcan/flexcan-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index f5d22c61503f..1871def90fe3 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2077,10 +2077,9 @@ MODULE_DEVICE_TABLE(of, flexcan_of_match);
>  static const struct platform_device_id flexcan_id_table[] = {
>  	{
>  		.name = "flexcan-mcf5441x",
> -		.driver_data = (kernel_ulong_t)&fsl_mcf5441x_devtype_data,

But now, fsl_mcf5441x_devtype_data becomes unused, right? Should this
also be dropped?

>  	}, {
>  		/* sentinel */
> -	},
> +	}>  };
>  MODULE_DEVICE_TABLE(platform, flexcan_id_table);
>  
> 
> base-commit: e7d700e14934e68f86338c5610cf2ae76798b663


Yours sincerely,
Vincent Mailhol

