Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E75304CC;
	Wed, 23 Sep 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169815; cv=none; b=hPBU20JMaNQ6PT+JufibF+xwHk/Ghk1QQ5WYP6Q2vqFVdyhrpfMb+CE7bDinQEfgkX6+vJXhQ69bTvCbL2uiWQ6f8e3O3V9udGWP8T47EY8jbRxYZvF3+RlqJOFqamUZmi/dkiB27rLuQz3FB4b9niA5U/N8TQtlcEG7eTP9alU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169815; c=relaxed/simple;
	bh=BDOzWHIc90fxbewwvw0Rru5lz8XcqrZT7fTWgRXM4q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE5FW2mvFvOrbZ8lzZVplCejmyWRbXiUiVXcLDWw9rqLJDSJQ8v4C5C6fBRXuSJAcpRrB4ORqiwzthJLc8996NUew0WrSj/ldtsmDwx8LXWgAGrKeTlpdzRsG1mW4s7XtctDXm/XTTW5qBzJHtTyPvOYtYBk2jmse1Bcd73ytgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IYrLApRq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IYrLApRq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EDnLi2pUMtS4xKymq2Gq5V18843JYuRVkIZ8gdUdVlU=; b=IYrLApRqgufL5H2QZLDcTZbkHg
	SH1wQ72o6gWBFq0DYRoigcScJUYmEhPbBFgVFE41jDMDvIGF1tDTm0VEGwwxVK53dddVrv0VdQwgj
	qjjMYNj67nAjJBy9bKdJ9wxkz8EkQ4v5f3kIp8l7jsp9vgh0u8JxazN8VGAfzFamZpyY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9Mwb-006oS1-F0; Wed, 23 Sep 2026 15:23:29 +0200
Date: Wed, 23 Sep 2026 15:23:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com,
	shenwei.wang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	nico@fluxnic.net, linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org, olteanv@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for ColdFire
Message-ID: <eb987eb9-f368-4d28-bdd0-c289c3039c3b@lunn.ch>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-2-gerg@linux-m68k.org>
 <42ad1525-fceb-43d6-aa03-d17e844a9ad9@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ad1525-fceb-43d6-aa03-d17e844a9ad9@linux-m68k.org>

On Wed, Sep 23, 2026 at 11:07:17PM +1000, Greg Ungerer wrote:
> Ping...

To: linux-m68k@lists.linux-m68k.org

ICMP redirect.

> > The FEC driver works today because the m68k architecture io.h has a
> > kludge in the definitions of the readl() and writel() functions for
> > ColdFire that allow big-endian access if the address of the register to
> > access is within the SoC's internal peripheral registers. This is being
> > fixed in the near future to define readl() and writel() correctly - with
> > no byte swapping. Thus the motivation for this fix here.
> > 
> > __raw_readl()/__raw_writel() access methods are used instead of the more
> > commonly used ioread32be()/iowrite32be() here because those are broken too,
> > because of the current readl()/writel() kludge. They are implemented in
> > asm-generic/io.h in terms of readl()/writel().
> > 
> > Note that even when readl() and writel() are fixed on ColdFire they will
> > not be the right thing to use within the FEC driver on ColdFire hardware.

So what is the end goal here? This patch. Then fix
readl()/writel(). Then fix ioread32be()/iowrite32be()? And then change
these macros to use ioread32be()/iowrite32be()?

Are we always going to be using fec_read()/fec_write()?

	Andrew
