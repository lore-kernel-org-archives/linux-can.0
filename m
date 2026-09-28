Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7824C6521;
	Mon, 28 Sep 2026 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604770; cv=none; b=I4Zc8yBCq6yrSMZbxDYlW+ElEW0GXfvfyIIWKPEEzOo0HXBQ5KjBRAtRWOS8NF2BLghfR4G6u2XWgwFn3uVhGi20joSiLSWTD8QUHZPh3OjBOWvYTL7fgbCTNF6ImpIbBGjHAiCNM55cUCyM+/EBiuFG4C5gCHHL9efayw/NB9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604770; c=relaxed/simple;
	bh=I1OkBqVPr+9G+RJLMxC5TQVtfMBI/TY4oZRVasYidvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCU9zv84U44EyTBJaRFTFsIxNOK+plYo/JfCNLve/Fxf1Gn6wMgIn3ei2REXWGmeGXotjmgzDx6AinX6q+YPxxdDesU7YlszrUvWKBNszpd51/+c+EzLOc2rplkT0xPHNypFwOQwzsM+d7tYKmuSBrSmQhMRVBwoBM3jQ+FQUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KCXg6xm1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KCXg6xm1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UwA7q79XkQQsz+Uy3hKsQ1FetQP83ctPZqJR3PIPVmw=; b=KCXg6xm1ncflYpI4MfnUO7xLUn
	ciO6Y10Gasp9xt1yg2IR1zhm0Lw5Gcy5bSV/rbrr4/4W5kHmI+8HIxpqTGhLjVnCFIaduffj33eYf
	W274KyRBodj33H3IPLyy9Rx861poUxDhk5Yxf2G9gEpDj7w68P/ngw/hEvaQgqczu9u4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBC5y-007j7G-10; Mon, 28 Sep 2026 16:12:42 +0200
Date: Mon, 28 Sep 2026 16:12:42 +0200
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
Message-ID: <06910e8b-5717-41cd-b18a-d1c4f92fb8dc@lunn.ch>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-2-gerg@linux-m68k.org>
 <42ad1525-fceb-43d6-aa03-d17e844a9ad9@linux-m68k.org>
 <eb987eb9-f368-4d28-bdd0-c289c3039c3b@lunn.ch>
 <46246a5b-3e95-4ecb-bc52-e374dc136514@linux-m68k.org>
 <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
 <b9a686cf-0d28-4feb-b971-f1bf2264964f@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a686cf-0d28-4feb-b971-f1bf2264964f@linux-m68k.org>

On Mon, Sep 28, 2026 at 10:59:52PM +1000, Greg Ungerer wrote:
> 
> On 24/9/26 00:15, Andrew Lunn wrote:
> >> The driver will always need to support big and little endian hardware, so I
> >> am not sure how to avoid some abstraction like this.
> > 
> > I was wondering if there is a linux standard set of macros which is
> > supposed to handle this big/little difference, the macro knows the
> > architecture and does the correct thing?
> 
> There is regmap, but that is way more than just access macros.
> At least one driver shared across big and little endian architectures
> does use that - the freescale dspi driver (drivers/spi/spi-fsl-dspi.c).
> There is probably others.
> 
> If the issue is more to do with code churn then a simpler approach here
> might be to just essentially keep the same work around but move it locally
> into fec.h. Something like the patch below.
> 
> This could be cleaned up to use ioread32be()/iowrite32be() after the final
> readl()/writel() changes have been applied.

The changes are fine, i just did not know all the background and
wanted to make sure we were not missing something. Thanks for the
explanations.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
