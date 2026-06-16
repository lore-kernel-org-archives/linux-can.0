Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C7388394;
	Tue, 16 Jun 2026 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640973; cv=none; b=Uiu9eKYKUWQ62cw4LVkByi5WiLhKPuQp1ltxI/50MIbOX4+eOt924R0QRY1P/ssBzdONHMU2GCmbs9C1RF2/K2H98YN3/yAfhvFN3GRx7wGsIJv/2sv/hCI/1z7whS4ADW+RbuQ/89+ohDfhsm/4+emvgKa1rcqz1lv/qASeEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640973; c=relaxed/simple;
	bh=MiyHaVoYM36jGVvr1HpDgeUEp3ZSjXc6ebH04dh1oh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0Ewga6N2ttfkkz7fRIPZvG8YbJA/dcGwoptvDaKj9V/fHkKfP8q09/jQEpZvzIgFFO3mZH+SEVMO0i20wKmwYY/MEDJ2W4aULBEBJYT91bLOlTRKWbd6V1MRoUuGIdECnSzUMCpVY+Y/owvEhTXbU1qfwbl9Z9uDvLxIkP+j7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1Cz+Jqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1Cz+Jqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F9D1F000E9;
	Tue, 16 Jun 2026 20:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781640971;
	bh=8+v9Dbv/3TyO6lr898JnUR3kpS6EIon21NDBuak9sZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a1Cz+Jquuyw72Ph2PjH9Gh6XvWf8EwDkHIM01kVAXsJaZ2haitq7hTT+X64ze/DjH
	 RM1YrqG8+Ed6Kf896cpoP2anpEXGaEgyVn9vm+sQx4RXRUA57vby596qtSBN3sqY/+
	 NCyBm1rcOV0xSzzuMNUYj0b60VYbo3moWCIKQ2tuAQZjiMI0bg041+6Y8CZUELMgE1
	 eLe68S+c9fEAns/yYAADTdJ7bR867g8g0QhDZVS2FSHUAJNuXJCWBBKMkSKkbN5mpz
	 bYja6riC+M2pLpg1V1qEHuUW2yrX2ndN/8IKQtu5LwhAsbm9LMpWueUdCF6Nck5IMk
	 J3kymvHKoa8vQ==
Message-ID: <153c3871-9759-4566-9424-56dc67a080fe@kernel.org>
Date: Tue, 16 Jun 2026 22:16:07 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: peak_usb: fix double free of transfer buffer on
 URB submit error
To: Maoyi Xie <maoyixie.tju@gmail.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, =?UTF-8?Q?St=C3=A9phane_Grosjean?=
 <stephane.grosjean@hms-networks.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <178163373110.2507866.216458825145756798@maoyixie.com>
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
In-Reply-To: <178163373110.2507866.216458825145756798@maoyixie.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2026 at 20:15, Maoyi Xie wrote:
> In peak_usb_start(), each RX URB transfer buffer is allocated with kmalloc()
> and the URB is flagged URB_FREE_BUFFER so that the final usb_free_urb() also
> frees the transfer buffer.
> 
> If usb_submit_urb() fails, the error path frees the buffer explicitly with
> kfree(buf) and then calls usb_free_urb(urb). Because URB_FREE_BUFFER is set,
> usb_free_urb() -> urb_destroy() frees the same buffer a second time, a double
> free of the transfer buffer.
> 
>   BUG: KASAN: double-free in usb_free_urb.part.0+0x91/0xb0
>   Free of addr ffff8881069ccb80 by task trigger.sh/285
> 
>   Call Trace:
>    kfree+0x113/0x3c0
>    usb_free_urb.part.0+0x91/0xb0
> 
> Drop the redundant kfree(buf); usb_free_urb() already releases the transfer
> buffer. This mirrors commit 03819abbeb11 ("net: usb: lan78xx: Fix double free
> issue with interrupt buffer allocation").
> 
> Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
> Closes: https://lore.kernel.org/linux-can/178159320216.2154888.16953451793788581739@maoyixie.com/T/#u
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol

