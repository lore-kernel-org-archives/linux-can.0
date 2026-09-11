Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC03148CF;
	Fri, 11 Sep 2026 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167891; cv=none; b=iSCCOnVM9FHV+UFWSfP4zdjNYogT/Rl22MOuIKxkNG4Id7/SKOUbrca/Uju36Ie7Fyxf++Ome3qZG0fceHFRQ+YtnhxPF4wvOH34E8XeXsABjRprS+Fc4jsHdr6nfcACmyj/XcZeEUK43zm8Tsdeh0sGHBjON+W57PVlL8mk7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167891; c=relaxed/simple;
	bh=xlWn8lsNQ74V6HS9v7MVPkrQMIN4eF0tWIk9IW2JCoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MY+jEcnb3K9pzF3GXfBDlzy/n707jOMu+CxoPrj8XCum7qa/ahGBxDCyzXtwJv317dm7Nb6hZBIMgmJjkVYDUpWJ3OmSdqrJhXM6RL8yRBspTCauMY4qE27l99b4fxXc1FJr5l3vgzqCoR44VqI9TSdCyQcN2jSlgUIGVnxrBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WshzVBKh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WshzVBKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AABF1F000FF;
	Fri, 11 Sep 2026 23:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789167889;
	bh=N1LY4rKYOr27Ilt9sZo1N4WbqCnS6yVf+HmCQgzzvz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WshzVBKh1zOG3iQqHN9bXk6iMn3UhPjWI2o9We2q85J1a0xxuvetInEqSv+oLVBif
	 oHixlX9hdnUTec+G9zk6kotK91VuauggK0rxfOR07BuXDSuVbPkPSgIKxAGEHnnOmt
	 Th5abxIcAARPoeXzkg1RZuTPeY7skMICjLiysDWUlk6TbZuVGou1nBri98K3vkOFma
	 +8WViZY9rRF0QyyYhVaVzRzVW1ce++rNpSS5X6VGBpU3jnuoYD43g/28KA7iJ0xah+
	 8qQDOEfeqF+wATGMEexc8UPt37RQWJ1KDqUcKNK9vRaS38zBePsIn/L4mZk0RSFzOq
	 tHA6h1BvCTugg==
Date: Fri, 11 Sep 2026 16:04:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, nico@fluxnic.net,
 linux-can@vger.kernel.org, linux-spi@vger.kernel.org, olteanv@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCHv3 1/3] net: fec: do not use readl()/writel() for
 ColdFire
Message-ID: <20260911160447.2873a40f@kernel.org>
In-Reply-To: <92ef814f-c207-44c1-9b7b-575980e29525@linux-m68k.org>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
	<20260907134037.1855408-2-gerg@linux-m68k.org>
	<20260910174210.0f8a4ad2@kernel.org>
	<92ef814f-c207-44c1-9b7b-575980e29525@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 23:03:56 +1000 Greg Ungerer wrote:
> On 11/9/26 10:42, Jakub Kicinski wrote:
> > On Mon,  7 Sep 2026 23:37:09 +1000 Greg Ungerer wrote:  
> >> The FEC driver works today because the m68k architecture io.h has a
> >> kludge in the definitions of the readl() and writel() functions for
> >> ColdFire that allow big-endian access if the address of the register to
> >> access is within the SoC's internal peripheral registers. This is being
> >> fixed in the near future to define readl() and writel() correctly - with
> >> no byte swapping. Thus the motivation for this fix here.  
> > 
> > What is the motivation for this cleanup?  
> 
> Sorry, maybe you were not in the CC list of the cover email. From that:
> 
>   This collection of patches is aimed at fixing the non-standard ColdFire
>   set of readX()/writeX() IO access functions. Instead switching to using the
>   asm-generic definitions in include/asm-generic/io.h. The difficulty comes
>   in trying not to break any drivers with this change.
> 
>   The implementation of the readX()/writeX() family of IO access functions
>   is non-standard on ColdFire platforms. They either return big-endian (that
>   is native endian) data, or on platforms with PCI bus support check the
>   supplied address and return either big or little endian data based on that
>   check. This is non-standard, they are expected to always return
>   little-endian byte ordered data. Unfortunately this behavior also means
>   that ioreadX()/iowroteX() and their big-endian counter parts
>   ioreadXbe()/iowriteXbe() are currently broken because they are implemented
>   using the readX()/writeX() functions.
> 
>   Patches 1 and 2 in this series are specific net driver changes that can be
>   applied independently of the final ColdFire readX()/writeX() change.

I read it, it doesn't really answer the question of priority.

> > Is someone still making
> > new SKUs of Coldfire boards? Or (and please don't take this the wrong
> > way) it was a long standing TODO that was tempting to feed to an LLM?  
> 
> It is a long standing todo/fix, but there is nothing LLM anywhere here.
> This was all manually coded and tested. This patch is 95% textual
> substitution, so it wasn't exactly very difficult.
> 
> > IMO keeping the hacks in m68k is a better choice. FEC was used on more
> > modern SoCs, definitely on PPC ones. So we'll be able to get rid of
> > m68k before we can get rid of FEC. Sprinkling m68k workarounds in 
> > the FEC driver is backwards.  
> 
> These changes are not work arounds, they are made to make the FEC driver
> explicitly aware of endianess of the underlying processor and FEC hardware
> block. The code as it is now, that is carrying hacks inside readX and writeX
> for m68k, is trying to hide that from the driver.

Whatever, let me not waste any more time on this. 
If Arnd thinks its worth it:

Acked-by: Jakub Kicinski <kuba@kernel.org>
