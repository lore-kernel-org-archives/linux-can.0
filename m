Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BFE3DE430;
	Wed,  5 Aug 2026 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914719; cv=none; b=nEu5AaKIX08izI1Rr1iUF1VjejL7xQo3RUB33Jvg7N19BPcqGJ4PK165LLV2bt2dvuH+onuZyeKue3nB7z/GcxLfLnVjsmAv4DPpe6trJ7DWTwSgFWIoxT0HL9gekjt6iq/F9l3GDN8I3EXuoVuZIL9z5iKm0/dm8liSGcw97a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914719; c=relaxed/simple;
	bh=5EF6EV/tsqzKGbl4N2bJCPF2Wm6ztEK+sT4UWsUUBQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tm3Roq0jgabDG+IgflI3QN3o+iudFMcJ0UI4h3l/Sr3trqXNOV9nWyYTc5mREwSY6lubgcQD6266y6C6YGM7YEXTpCsISHIsPkfM5AT8XO/lEzbSl26S1R4xoNZOnGULHg5xCxrEGGzsRg39z78EVMrk1jinDOeGm/LNYRQ7jZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG2PZcJC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG2PZcJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964C41F000E9;
	Wed,  5 Aug 2026 07:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785914718;
	bh=Hu45KECkLQs+f+gz8d9sG9BTY9WBaw/7df1poFW/VAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YG2PZcJCZxJiUWiTyY8JjsLGRKZj5EOkaq9Ej83qTyf3bJpM1/yJZOHvhh4MT/LKL
	 TBoJSCPR7IAQF6X8rtS3+ibXFAb4k+OEa/YxJ09TjrJPJyK+1i0+f4KIdvin9wImmD
	 gG29h1dvnPKCiYN2o/Q8thxO2DIC1bquQXpKpFxVdj1NrDW8yzHtvkIf5HxifPcL+Q
	 lP0c6/2oGkiNXvHiG8Y267kCOe6ucLE/bunGHSKH1AHOGnNJAX7bnqbRbmc/6g2QRA
	 NwXdPNNXRwlgCR3HbIjHS95EDMUhSqJfMLaObcnekQxiMy532Hy14qfd9a8TdsRQnk
	 liXNtnDIJlw1A==
Message-ID: <6800934d-2da2-4eeb-8514-3978f4c7b307@kernel.org>
Date: Wed, 5 Aug 2026 09:25:15 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] can: automate IFF_ECHO flag for generic echo skbs
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
 <395d9b68-2527-47d6-a6a0-74569d27b734@hartkopp.net>
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
In-Reply-To: <395d9b68-2527-47d6-a6a0-74569d27b734@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/08/2026 at 08:29, Oliver Hartkopp wrote:
> On 04.08.26 21:55, Vincent Mailhol wrote:
>> Most CAN drivers allocate echo skb slots through alloc_candev() or
>> alloc_candev_mqs(), but still have to manually set IFF_ECHO to tell
>> PF_CAN that the driver handles local echo itself. This creates
>> boilerplate and makes it easy for drivers to forget one half of the
>> setup.
> 
> No one ever "forgot" this flag.
> 
>> A recent example is commit c77bfbdd6aac ("can: dummy_can:
>> dummy_can_init(): fix packet statistics"), where dummy_can was already
>> using the generic echo skb helpers but needed an explicit IFF_ECHO
>> assignment to make tx_bytes accounting work.
> 
> But you (ok us) :-D

Yes, this is the hidden motivation of this series. I did this mistake
and I was thinking if there were any way to prevent this from happening
again in the future.

But has a matter of fact, I am not the only one as the ucan driver also
omitted to set its IFF_ECHO (c.f. the note in Patch #3 message). And no
one noticed this one.

> To me this patch set does not really bring an improvement.
> You are now hiding the setting of this bit.
> 
> Today it is very transparent visible inside each drivers initialization
> section whether it supports IFF_ECHO or not. And e.g. vcan.c can also
> switch this feature with a module parameter.
> 
> I prefer this conscious setting in the driver setup. We should better
> add proper comments in drivers that do not set the flag, e.g. in slcan.c
> there's no hint that the af_can.c echo feature is used.

Then, what about setting IFF_ECHO for *all* drivers by default in
can_setup() and let the ones which have a special need to opt-out:

  dev->flags &= ~IFF_ECHO;

This way it remains transparent which one support IFF_ECHO or not. It is
also more important to highlight when things are done differently
(IFF_ECHO off) than when things go the normal case (IFF_ECHO on).

And this is more aligned with IFF_NOARP (c.f. you other message) in the
sense that both flags would now be set by default by the framework. It
looks odd to me that IFF_NOARP should be set by default by the framework
but not IFF_ECHO.


Yours sincerely,
Vincent Mailhol

