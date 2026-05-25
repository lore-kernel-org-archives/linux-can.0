Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D7537B03B;
	Mon, 25 May 2026 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713046; cv=none; b=szPm/gl567zhD8ls9SmBhHdHQHz+4Dx+NXMruEiYtvNYjGx2vUuPO+Aeua761m5jyeQq47EtAtmnsIy0DObxCK2ep77SLPmnVdZLycdUbctNjmG5o9edUZY0VhcoP1hZpp8O62VwkEs7JThiYnVxlk7rr+Kbp/OR9OH+zR7gFg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713046; c=relaxed/simple;
	bh=cVF0waMwS3j1OcWPn1UjNwzfhQws2HnXJqrGu0Udv4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXkQEVnElPcAQGUESC+T1UrhZCR6GcWKlOQcr8+SuyzJFqxo6ZUpOwCWhnQAVgNMRQ2KmlwcU/c7gFQxZmIGMSXKSVQ/HgkGhz+m1G491uccyyLoBxllZPx0sZ7bRF9CDpGmTeyZ2lQ1Xp+pqA1oqhMXjWRNTj2bl+L9esk384E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxIgjsRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxIgjsRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0586B1F000E9;
	Mon, 25 May 2026 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779713045;
	bh=9+6hwY9Ko8DaVpOdEIWBuBE09SQLOV358E27fri7a+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YxIgjsRF8AHxoZ3VTfSweF7kZhR691Wj+ui9ZUQ4iT9Ni4ojI4e5l2pVwNshxdfDS
	 oRWNl8ERIRRRjIZQEuLIBmT7KsZbd+6XTPCidDZG6MHFVWfsDRdkFOVh0lVFgnG6av
	 8H4vV7eKfIMY42g3iVPyWjdt/Gwhn+XBF2ZBNuaRqXsQjvl3KC1EBoaY5webUEyR5T
	 DbtyLLfAPHR01ClMk/vDz1dL/AhCbMxihLgMNhun4+Qwta67potFwp7a3P0uXPhPbH
	 2k5Yjcb768ZFmjtZvYwiqCQtd+4tU/LN2aGvKQoq24zhnsBZTm35Bbe1HmAdCrv+/+
	 /JvDm/mSgBz9w==
Message-ID: <3e72919d-564a-4171-85f7-82ffddbc5b5b@kernel.org>
Date: Mon, 25 May 2026 14:44:01 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] can: peak_usb: Add bounds check for USB channel index
To: James Gao <jamesgao5@outlook.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, s.grosjean@peak-system.fr,
 linux-kernel@vger.kernel.org
References: <TYCPR01MB856782BAA657447E5EDDDC1FF0062@TYCPR01MB8567.jpnprd01.prod.outlook.com>
 <TYWPR01MB8559DBAAAA6A7F410400329CF0012@TYWPR01MB8559.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TYWPR01MB8559DBAAAA6A7F410400329CF0012@TYWPR01MB8559.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/2026 at 07:40, James Gao wrote:
> The channel control index ctrl_idx is derived from rx->len which comes
> directly from a device USB payload. The mask 0x0f allows values 0-15,
> but the array size of usb_if->dev[] is only 2. Values 2-15 cause heap
> out-of-bounds read, eventually causing kernel panic in the IRQ context.
> 
> Add bounds checking for ctrl_idx before the array access in both
> pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error().
> 
> Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
> Signed-off-by: James Gao <jamesgao5@outlook.com>

Thanks,

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol

