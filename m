Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D461535FD2;
	Wed, 23 Sep 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172013; cv=none; b=cK7c07fr8QNhCw0/u9Pu8xYqpP18CHRF3sgLRNRrgUwpk10d9p61aHKb9ozG9yDi/G14/jGZBml3vJKle+jPTKcEZrAxMZW3m7JLqgY6u39VOenPTl3VFHf4LN2KGP+/Do7r7zRhgEVzYZ25OlrYmhFuONidXPADJeRH4kM2llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172013; c=relaxed/simple;
	bh=SIINyKArYOBU+m7LMycLWcJsLnMKO2zsO2JrQHKDiuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzJcVWu8GuRbMsMq4E95PB4iYTzxtILcjMFOtlEXf782KFJDLR0sInLfVxPDiA4L5zwgLJrQ3LNKiTAt4QDMuZ0Agtz6mFcpp6ijyp39I0m5BuLVN+mHS/Vrvub16PoBhqMmOYRI9rIsOkciZbJBFcGDKS0rrgVDavBrGYehrR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584F51F000FF;
	Wed, 23 Sep 2026 14:00:07 +0000 (UTC)
Message-ID: <46246a5b-3e95-4ecb-bc52-e374dc136514@linux-m68k.org>
Date: Thu, 24 Sep 2026 00:00:04 +1000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for ColdFire
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, nico@fluxnic.net,
 linux-can@vger.kernel.org, linux-spi@vger.kernel.org, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-2-gerg@linux-m68k.org>
 <42ad1525-fceb-43d6-aa03-d17e844a9ad9@linux-m68k.org>
 <eb987eb9-f368-4d28-bdd0-c289c3039c3b@lunn.ch>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <eb987eb9-f368-4d28-bdd0-c289c3039c3b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/9/26 23:23, Andrew Lunn wrote:
> On Wed, Sep 23, 2026 at 11:07:17PM +1000, Greg Ungerer wrote:
>> Ping...
> 
> To: linux-m68k@lists.linux-m68k.org
> 
> ICMP redirect.
> 
>>> The FEC driver works today because the m68k architecture io.h has a
>>> kludge in the definitions of the readl() and writel() functions for
>>> ColdFire that allow big-endian access if the address of the register to
>>> access is within the SoC's internal peripheral registers. This is being
>>> fixed in the near future to define readl() and writel() correctly - with
>>> no byte swapping. Thus the motivation for this fix here.
>>>
>>> __raw_readl()/__raw_writel() access methods are used instead of the more
>>> commonly used ioread32be()/iowrite32be() here because those are broken too,
>>> because of the current readl()/writel() kludge. They are implemented in
>>> asm-generic/io.h in terms of readl()/writel().
>>>
>>> Note that even when readl() and writel() are fixed on ColdFire they will
>>> not be the right thing to use within the FEC driver on ColdFire hardware.
> 
> So what is the end goal here? This patch. Then fix
> readl()/writel(). Then fix ioread32be()/iowrite32be()?

Yes, definitely. Patch 3 in this series completes the fixing of readl()/writel().
That also has the effect of fixing ioread32be()/iowrite32be().


> And then change
> these macros to use ioread32be()/iowrite32be()?

Happy to do that if that is want you want. Ultimately probably the cleanest.


> Are we always going to be using fec_read()/fec_write()?

The driver will always need to support big and little endian hardware, so I
am not sure how to avoid some abstraction like this.

Regards
Greg

