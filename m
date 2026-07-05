Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5236B067;
	Sun,  5 Jul 2026 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240733; cv=none; b=rvNpzO6HnyaaZ9xTElqbKq4Jodlfqg/SC91ZvIU0jZ3dKffkyAzvGqStF0M7ICjtDEDJzoqa8Ezy+gYLYmGi7cD/RbyHJGaLUhQVw89iWNIz2d5S0f2DiawC24nUVf9NVemDOWKLq4QTph2b33Ugl3cT/e2xd7rM60UCe64gKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240733; c=relaxed/simple;
	bh=Q+zfgMcm4SVsyiy4uT/+08jtj5rfxbz96xbbLZLpkLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=B3l1ZTtm7C4S+5P3oUb0GQ/Wr/C6rvtMQJMRtX892CVzxJhNCIDCTwLMz3Xvq9Ct6Kmhp89o0e0gjCE7hNpXwneVJkTBioMUJJjY00avhy61Ah32pqnDgguJVEjBTsI4CNEl8oSdQFZCxtCTvAQQoHqkVzKGRQ2EqiDwJk33b3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6hNaQPK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6hNaQPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C871F000E9;
	Sun,  5 Jul 2026 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783240732;
	bh=FkSd1B31HKg3M4d5j8m08YYQcnh0GBy2eK3T0r6Vync=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=j6hNaQPKR5nRMVDOxMGnuNG9LuG5K/r7qeSS6l2ngu9S7tmsm20asOhdMXsvZf4c/
	 pP23/zEBLX2UBdAGSxfn1R00Vc0r+wKNCJcvGKXNE4Uv74fq6tNjApKcSGVRSUMQiD
	 21Zhtl3rOUhcmA5vQugEF2aLuzfqKh3eqbTUiohyjwAr+O7w5RzWs0bCaYr+zgCVYq
	 rptABZQjJUf/m0k4ktSD779YYNmZwmPD7lk9ADvcaF591Yl4Vqv3kFddngtkimBiyU
	 7LD9evlysrhEPWJXLsjZflD7C2Z3w8H7V9CP9bsuE9FhnoPGJbtd+wzxlLZUxUENM8
	 se93vkP90VG1A==
Message-ID: <1c56d19c-e781-4df3-8f9e-1cfe7849c95f@kernel.org>
Date: Sun, 5 Jul 2026 10:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: usb: etas_es58x: Fix RX buffer leak on URB resubmit
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>
References: <20260704165717.248880-1-lgs201920130244@gmail.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260704165717.248880-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2026 at 18:57, Guangshuo Li wrote:
> es58x_read_bulk_callback() resubmits the RX URB after processing a
> received packet. If the resubmit succeeds, the URB remains anchored and
> will be handled by the normal RX path or by teardown.
> 
> However, if usb_submit_urb() fails, the callback unanchors the URB and
> then returns directly. This skips the existing free_urb path, so the
> coherent transfer buffer allocated with usb_alloc_coherent() is not
> released.
> 
> Reuse the existing free_urb path after a resubmit failure so that the RX
> coherent buffer is freed before leaving the callback.
> 
> Fixes: 5eaad4f76826 ("can: usb: etas_es58x: correctly anchor the urb in the read bulk callback")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index b259f6109808..da12a35dd2f9 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -1476,7 +1476,7 @@ static void es58x_read_bulk_callback(struct urb *urb)
>  		dev_err_ratelimited(dev,
>  				    "Failed resubmitting read bulk urb: %pe\n",
>  				    ERR_PTR(ret));
> -	return;
> +	goto free_urb;

Just delete the return statement. No need for the goto as the label is
just below.

With above comment addressed:

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

>   free_urb:
>  	usb_free_coherent(urb->dev, urb->transfer_buffer_length,


Yours sincerely,
Vincent Mailhol

