Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFF47535D;
	Fri, 11 Sep 2026 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131845; cv=none; b=I3Hmkk9Zs7ilxnZcDxqFnNUpo9x8JhCxZ7eeFv092HfbXL/g3mwVUw1wTd6gjDHG2UDRafbmIIrDt3Cnj0aepjg/UkvGCm7yfdVDDH8PZobcOiJsMU3u1cEZy2GG4c43AY7iBh1y1+Wmksx9bMYyUn3YSxX/xoHuAap6qgQPqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131845; c=relaxed/simple;
	bh=crelH9CKz5xACPL/P0w+99JDuKyVYM00a9c1QE+DN+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgzVDixrG6ZgvFYa9uDpUlY/0/mPfpsVmu93+3/MJgsM4jyrOqSeJESYnEV1K4kRxrWcJu/xaNFjSDCTjPSvmJgVD+9rYQJfOB5GnGk2r+OLkaJ3ZYA21x/Eb6KKoa/de2e1tOZ/f5NRKylIcdUvWxM0N4lvFoAAU2UgsQum6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30EA1F000FF;
	Fri, 11 Sep 2026 13:03:59 +0000 (UTC)
Message-ID: <92ef814f-c207-44c1-9b7b-575980e29525@linux-m68k.org>
Date: Fri, 11 Sep 2026 23:03:56 +1000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for ColdFire
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, nico@fluxnic.net,
 linux-can@vger.kernel.org, linux-spi@vger.kernel.org, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Andrew Lunn <andrew@lunn.ch>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-2-gerg@linux-m68k.org>
 <20260910174210.0f8a4ad2@kernel.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20260910174210.0f8a4ad2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 11/9/26 10:42, Jakub Kicinski wrote:
> On Mon,  7 Sep 2026 23:37:09 +1000 Greg Ungerer wrote:
>> The FEC driver works today because the m68k architecture io.h has a
>> kludge in the definitions of the readl() and writel() functions for
>> ColdFire that allow big-endian access if the address of the register to
>> access is within the SoC's internal peripheral registers. This is being
>> fixed in the near future to define readl() and writel() correctly - with
>> no byte swapping. Thus the motivation for this fix here.
> 
> What is the motivation for this cleanup?

Sorry, maybe you were not in the CC list of the cover email. From that:

  This collection of patches is aimed at fixing the non-standard ColdFire
  set of readX()/writeX() IO access functions. Instead switching to using the
  asm-generic definitions in include/asm-generic/io.h. The difficulty comes
  in trying not to break any drivers with this change.

  The implementation of the readX()/writeX() family of IO access functions
  is non-standard on ColdFire platforms. They either return big-endian (that
  is native endian) data, or on platforms with PCI bus support check the
  supplied address and return either big or little endian data based on that
  check. This is non-standard, they are expected to always return
  little-endian byte ordered data. Unfortunately this behavior also means
  that ioreadX()/iowroteX() and their big-endian counter parts
  ioreadXbe()/iowriteXbe() are currently broken because they are implemented
  using the readX()/writeX() functions.

  Patches 1 and 2 in this series are specific net driver changes that can be
  applied independently of the final ColdFire readX()/writeX() change.


> Is someone still making
> new SKUs of Coldfire boards? Or (and please don't take this the wrong
> way) it was a long standing TODO that was tempting to feed to an LLM?

It is a long standing todo/fix, but there is nothing LLM anywhere here.
This was all manually coded and tested. This patch is 95% textual
substitution, so it wasn't exactly very difficult.


> IMO keeping the hacks in m68k is a better choice. FEC was used on more
> modern SoCs, definitely on PPC ones. So we'll be able to get rid of
> m68k before we can get rid of FEC. Sprinkling m68k workarounds in 
> the FEC driver is backwards.

These changes are not work arounds, they are made to make the FEC driver
explicitly aware of endianess of the underlying processor and FEC hardware
block. The code as it is now, that is carrying hacks inside readX and writeX
for m68k, is trying to hide that from the driver.

Regards
Greg



