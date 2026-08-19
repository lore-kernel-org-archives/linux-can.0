Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589C4052B3;
	Wed, 19 Aug 2026 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127197; cv=none; b=sdjfTZL6/T95jNmQpYn+fLdmlQm7Q5p/rwgHZocHYLeP7din8nFoqICY9vgxdQH9QWHKKISXD/25FspaaYGmTxgwQR8hLx6LQgm7yPzS1426edN6qM6YVKYdmcr6WUiqxWW/j6CmB4r+9BN/uwMaJc4ghtKxWQ/brG0yMib9hW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127197; c=relaxed/simple;
	bh=HARReklpCA9t5hln2IGU0gITbnp48khI/nqORu6nJv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQ4mb5jIjkqpou0usHoKYIpYZROGbqrCgTRJi2PyiaNeGZq5S1X1LO4yruEfXJ1U1VclBrUEfuLI33mGBW5V2iJNux5Xr2M5u6kGKOtv5YaDcKyWm525jEf16zRNQGDk0WZXHDpZ+0PjlZLWndCU/9dEtmvoZPuvcJF9941VHa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id ADB241046B5;
	Wed, 19 Aug 2026 08:13:06 +0000 (UTC)
Message-ID: <847d322c-fb14-406d-a5ef-d71699010e36@enpas.org>
Date: Wed, 19 Aug 2026 17:13:01 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] can: can327: Fix out-of-bounds write in
 can327_parse_frame()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Baul Lee <baul.lee@xbow.com>, mailhol@kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com
References: <20260818221818.49430-1-baul.lee@xbow.com>
 <c88e0f37-b9b2-4f92-a0c9-1ecee44d6d7c@enpas.org>
 <20260819-rigorous-ruddy-mammoth-abf127-mkl@pengutronix.de>
Content-Language: en-US
From: Max Staudt <max@enpas.org>
In-Reply-To: <20260819-rigorous-ruddy-mammoth-abf127-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/26 2:57 PM, Marc Kleine-Budde wrote:
> On 19.08.2026 07:28:44, Max Staudt wrote:
>> It seems like your patch sending tool didn't pick up the Cc: line in the
>> commit message :(
>>
>> Can you please re-send it just like v2, but also ensure that
>> stable@vger.kernel.org is on the email's CC list?
> 
> After I pick up the patch and send a PR, my tooling will automatically
> send it to stable (if on Cc).

Ah, even better. Thank you for clarifying!


Max

