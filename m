Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACC3242D4;
	Wed, 24 Jun 2026 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325327; cv=none; b=Or582a2mHJRHcNfdgQ/IdIf/NzVsICrzLy6XY8LXKKqz0QaXFoSAWqvCG+Q6P8oEGZ+9yX+wwufX0icpj/trHjZtXfG+qHBZd20ag3SPJ0lV4Fj+PQ/JzHpFALRcacINS7gpLDt2ynlIXpyPVpBHmjxIA/RCaeo/4em5N/DVR3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325327; c=relaxed/simple;
	bh=wdayrJRpYrkZ5HsYZt0DXqpN3IS5kur6okD4IL2e6KA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MSnfMLUY+yQAS65HLmS6fuOXS6gt3+f4l9paljAA6g0RMA7W0LcXq+BpEVowgH9aIymQT244JIya05+QcQ8DjubMVLgVbU9wO/6hMOPEFFfG9L/3dyAKw/HNlgDq/t1q3kW+ETqzzee1dveOl569CURGGrucqV4VTYaox3Gk7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehI/ywKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehI/ywKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127291F000E9;
	Wed, 24 Jun 2026 18:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325325;
	bh=hk8mTO54jlUiL8rS7zZDZMwBNKeg0NA390k5uA1+OoY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=ehI/ywKUxmFBwdT9Q+0f1flxhz46TiXmw+v0vZdF3/DgXnbhrqIH/YRWtgDLOnsEK
	 6oK2oT5atf0FDFm2LKfIUJzReqt17xfdT56nEPKio3zYCs61PlGPB1y/H/vChM8BJg
	 xvr5E472H3hbkH/2h9VWcZOuMIk2LjT8AgNvJUUhoezmJEmSKUPqUK8Jnsc6RFVROC
	 zaLeIUkk2CiLAa3zsbNbL3/i9AwTJIDvVvPyH0mhyckYI6uSeFv3YeOYGiJDp4kaq+
	 EsQgzFf3iPI6LI1ytOF1W3jRqUmWQHsWEThYjfvLck0w8mOI4VHP5OZaFFd7uJz4iI
	 55FIuSO/0O9xQ==
Message-ID: <12d20349-6e76-47a6-ab7d-e7429b50de35@kernel.org>
Date: Wed, 24 Jun 2026 20:22:03 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: c_can: Use platform id data when OF data is absent
From: Vincent Mailhol <mailhol@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
 <76288461-98f7-4c72-9d97-3589d301cd9e@kernel.org>
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
In-Reply-To: <76288461-98f7-4c72-9d97-3589d301cd9e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/06/2026 at 11:53, Vincent Mailhol wrote:
> On 24/06/2026 at 07:49, Pengpeng Hou wrote:
>> The platform driver keeps controller metadata in both the OF match table
>> and the platform id table.  Probe reads the metadata with
>> device_get_match_data(), which does not fall back to platform id-table
>> driver_data.
>>
>> When the device is matched through the platform id table, drvdata can
>> therefore be NULL before it is dereferenced for msg_obj_num and the
>> controller type.  Fall back to platform_get_device_id() when firmware
>> match data is not available.
> 
> So, you are telling me that this patch fixes a NULL pointer
> dereference? In that case, it needs to be backported. Please add a
> Fixes: tag.

Also, were you able to trigger that NULL pointer dereference?

> Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> 
>> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> ---
>>  drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
>> index 19c86b94a40e..564c9e5b4c2c 100644
>> --- a/drivers/net/can/c_can/c_can_platform.c
>> +++ b/drivers/net/can/c_can/c_can_platform.c
>> @@ -263,9 +263,17 @@ static int c_can_plat_probe(struct platform_device *pdev)
>>  	int irq;
>>  	struct clk *clk;
>>  	const struct c_can_driver_data *drvdata;
>> +	const struct platform_device_id *id;
>>  	struct device_node *np = pdev->dev.of_node;
>>  
>>  	drvdata = device_get_match_data(&pdev->dev);
>> +	if (!drvdata) {
>> +		id = platform_get_device_id(pdev);
>> +		if (!id)
>> +			return -ENODEV;
>> +
>> +		drvdata = (const struct c_can_driver_data *)id->driver_data;
>> +	}
> 
> Reduce the visibility of id:
> 
> 	if (!drvdata) {
> 		const struct platform_device_id *id;
> 
> 		id = platform_get_device_id(pdev);
> 		if (!id)
> 			return -ENODEV;
> 
> 		drvdata = (const struct c_can_driver_data *)id->driver_data;
> 	}
> 
>>  
>>  	/* get the appropriate clk */
>>  	clk = devm_clk_get(&pdev->dev, NULL);
> 
> With the Fixes: tag added and above nitpick addressed:
> 
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol

