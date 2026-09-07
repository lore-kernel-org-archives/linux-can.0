Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3544A64C7;
	Mon,  7 Sep 2026 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784385; cv=none; b=SD//JMPNlwiPgjD4A9pN/ilyyHdNCxitVRZOK6of0WfMJr69ut3n5NQAYr3hbSbbEGBptO2Mup2GQOKRrkR3pZ1l4qfbpHYmhDmlXqQH9ZIGWtmCJq3HPu0k1DGJUFm/AgB+RfCKms9x7LjnKuTxbSw2yPi+R2whxUsNkdSpvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784385; c=relaxed/simple;
	bh=778mZAkzDkmSQ/nnB01qv9KJ9eF/HBCrupCGXPJi5w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/zvfRdGQvrtTyW5aFBjvGlqL4SYHJ2at1up90a8w+4EBzmGbvIGJn1DqRjkgvuQidlw0nLaEKGOKgTShPWoVG1dOKXvra1Ic8AumhvkMinNZ59Z+wELhrfHjN2bIDZwJajZt1zouz+P3rrBGmzlrkAzwWVJDaZ5XSAdPeOV520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AAA1F00A3D;
	Mon,  7 Sep 2026 12:33:01 +0000 (UTC)
Message-ID: <1319f97a-1649-4f48-acd7-513897298639@tuxon.dev>
Date: Mon, 7 Sep 2026 15:32:59 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] can: rcar_canfd: Add support for Renesas RZ/G3S
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>,
 conor+dt@kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 devicetree@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
 wsa+renesas@sang-engineering.com
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-6-claudiu.beznea+renesas@tuxon.dev>
 <20260902143013.D70171F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260902143013.D70171F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/26 17:30, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Lack of validation for Classical CAN mode on CAN FD-only hardware.
> 
> Pre-existing issues:
> - [High] Dangling pointer in global array leads to double free when register_candev fails.
> --
> 
> commit 1c2240055c546ef67856ad4716f6c425dbce01c6
> Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> can: rcar_canfd: Add support for Renesas RZ/G3S
> 
> This commit adds support for the Renesas RZ/G3S CAN-FD controller.
> The RZ/G3S controller supports two channels, 16 AFL pages, and operates
> exclusively in CAN-FD mode.
> 
>> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
>> index bed7cde1aa01b..48e0573a73a44 100644
>> --- a/drivers/net/can/rcar/rcar_canfd.c
>> +++ b/drivers/net/can/rcar/rcar_canfd.c
> [ ... ]
>> @@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>>   	.fixed_canfd = 0,
>>   };
>>   
>> +static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
>> +	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
>> +	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
>> +	.tdc_const = &rcar_canfd_gen4_tdc_const,
>> +	.regs = &rcar_gen4_regs,
>> +	.sh = &rcar_gen4_shift_data,
>> +	.rnc_field_width = 16,
>> +	.max_aflpn = 15,
>> +	.max_cftml = 31,
>> +	.max_channels = 2,
>> +	.postdiv = 2,
>> +	.shared_global_irqs = 0,
>> +	.multi_channel_irqs = 1,
>> +	.ch_interface_mode = 1,
>> +	.shared_can_regs = 1,
>> +	.external_clk = 1,
>> +	.fcan_pclk = 1,
>> +	.fixed_canfd = 1,
> 
> [Severity: High]
> If the device tree specifies the "renesas,no-can-fd" property, could this
> lead to a silent mismatch between the software network stack configuration
> and the hardware state?

The DT schema was updated to forbid renesas,no-can-fd for RZ/G3S. AFAIK, we 
shouldn't validate the device tree in kernel. That's should be done by the 
dtbs_check.

> 
> In drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe(), if the property is
> present, the driver will set fdmode = false:
> 
> 	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
> 		fdmode = false;
> 
> However, when rcar_canfd_configure_controller() runs, it skips the
> controller mode update because fixed_canfd is true:
> 
> 	if (gpriv->info->fixed_canfd)
> 		continue;
> 
> This effectively leaves the hardware locked in CAN FD mode, while the rest of
> the driver initializes the software stack for Classical CAN. For example,
> rcar_canfd_channel_probe() initializes a max MTU of 16 bytes, and
> rcar_canfd_configure_rx() restricts the physical hardware Rx FIFO payload
> size to 8 bytes.
> 
> If the hardware receives a 64-byte CAN FD frame, will it attempt to write
> 64 bytes into an Rx FIFO configured for 8 bytes, causing a buffer overflow?
> 
>> +};
>> +
> [ ... ]
>> @@ -2383,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
>>   
>>   static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
>>   	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
>> +	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
> 
> [Severity: High]
> This is a pre-existing issue, but does probe failure on this newly added
> hardware expose a potential double-free?
> 
> In drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_probe(), the global
> array is populated before device registration:
> 
> 	gpriv->ch[priv->channel] = priv;
> 	...
> 	err = register_candev(ndev);
> 	if (err) {
> 		...
> 		goto fail_candev;
> 	}
> 
> If register_candev() fails, the error path calls free_candev(ndev), which
> also frees the embedded priv structure, but leaves the dangling pointer in
> gpriv->ch[priv->channel].
> 
> When the failure propagates back to rcar_canfd_probe(), the cleanup block
> iterates over all configured channels and calls rcar_canfd_channel_remove()
> for each, including the one that just failed:
> 
> drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_remove() {
> 	...
> 	unregister_candev(priv->ndev);
> 	...
> 	free_candev(priv->ndev);
> }
> 
> Could this lead to memory corruption when it attempts to unregister and free
> the already freed dangling pointer?
> 
>>   	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
>>   	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
>>   	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
> 

