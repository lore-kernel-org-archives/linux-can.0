Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B307378838;
	Wed, 23 Sep 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172953; cv=none; b=NPQ9ihmnb9c3Juf/pHBZtYvj7E25PM/PsRAfzrQoz33mw5Mp8kuJlvLHPbXFUWXMqPLBg/QKYDwG1EsQ2XGZc8gAcJDmQrxjUCreyjvMPrT7fIIR8354XekFb+ufZI2zSYZjm7ljXVnfOks0QLTJAvN85oiDdwe2DhE4wW0DEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172953; c=relaxed/simple;
	bh=gLKxiXaYuzXzRH3NzpPWYDvSfcLvfUIzm83C2oCYFzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAJpqsA9Onyi78OxVpZJNUMMSaT8SDYdCpsGFR5xuQKvRbEchouxRbGO3ydrrXpWkA9KR8Yxyp/kFv1CTrZXdGQ2/jkbG4bVFeZguVe2wZcv4o9ipEKCb8+Gutf7G1EJ4bdqxdRON326tOdBALIpc201vzNxPSifFln+5LQyNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Eirx7ZkB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Eirx7ZkB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kh1BmU+b8bRZ/hX23dXwEg+RXJfNapV72jSBmuL3mNs=; b=Eirx7ZkBmpWEbnEkL9kj5cyFJP
	tyiDa/gYdEre/pfo+5s+kW4rM+yNk4dyrUpwQPFmwgLhbZfdhd3jN+0W6fXCphigcWRg6rax1srEz
	WM8pLmcYupWLDv0LGPMy+KZV8F/C0YZvNxpjw8qOpmorJikbGPU7Thx9JiZo3/4PLiBs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9NlC-006p29-Qx; Wed, 23 Sep 2026 16:15:46 +0200
Date: Wed, 23 Sep 2026 16:15:46 +0200
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
Message-ID: <fe8a632a-80a8-45da-ba64-31158af7c987@lunn.ch>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-2-gerg@linux-m68k.org>
 <42ad1525-fceb-43d6-aa03-d17e844a9ad9@linux-m68k.org>
 <eb987eb9-f368-4d28-bdd0-c289c3039c3b@lunn.ch>
 <46246a5b-3e95-4ecb-bc52-e374dc136514@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46246a5b-3e95-4ecb-bc52-e374dc136514@linux-m68k.org>

> The driver will always need to support big and little endian hardware, so I
> am not sure how to avoid some abstraction like this.

I was wondering if there is a linux standard set of macros which is
supposed to handle this big/little difference, the macro knows the
architecture and does the correct thing?

	Andrew
