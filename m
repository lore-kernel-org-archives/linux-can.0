Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850D26C383
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002034; cv=none; b=js1pHlNQGd5Qx1dS0eV7Ge9cl0RwaZpyZ5aW79aHMpbHMMBQ2iz6OYgGjT8bbu0SUzhpZGqBZnMTCS1Pi2KXU5ZA+/ka/6YMvhpOhMwve/G8pliCqKOTsjb3+E3SHpLw6YXDgO+iJz6/Si5dmgvTQsPSPoRzUC9ddtbJWtl52N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002034; c=relaxed/simple;
	bh=WV2SkEQ4VMzlopidLpTTX/8COLF91igRdzaI0QToov4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjRvXOTqih1UpOjlmIv1YgsPnhZNCSOlYeZOc16xr7a4Uu9wD9Yx9FOzrmBOjVyWSgUQTqO1YQ84RrZMfyMdIsJX4DGcxaBxjWJ3oqiduPRJ0w6/fmNHzQyuJckEFWN9LGxVaHxV51hZoGxv5dC7bJvtoGlE2teviN1kPOKJ1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pkiRdiEY; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pkiRdiEY"
Message-ID: <ee619a2d-a39d-4f48-ba18-07d4d9ef427e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755002030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WV2SkEQ4VMzlopidLpTTX/8COLF91igRdzaI0QToov4=;
	b=pkiRdiEYCqbf5ruhEHKIqqlCmZCi0D+5npJY5c+stw8l0p+KUwi0z5fpm9eb8seimKdFy/
	M3Mxdqm28WgZRYnTTASbCDfniSuJtKsi3W4NxZeJTWgUrQEQjW+xbbwXwQr0pA4WhkNBcN
	sDYUtJyQ/RJZG3jnIbhChvhw2Zn0C/Y=
Date: Tue, 12 Aug 2025 13:33:40 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] can: esd_usb: Fix possible calls to kfree() with NULL
To: =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org,
 socketcan@esd.eu
Cc: Simon Horman <horms@kernel.org>, Olivier Sobrie <olivier@sobrie.be>,
 Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
 <20250811210611.3233202-2-stefan.maetje@esd.eu>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250811210611.3233202-2-stefan.maetje@esd.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/08/2025 22:06, Stefan MÃ¤tje wrote:
> In esd_usb_start() kfree() is called with the msg variable even if the
> allocation of *msg failed.

But kfree() works fine with NULL pointers, have you seen any real issues
with this code?
