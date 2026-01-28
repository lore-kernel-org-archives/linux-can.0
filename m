Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04F17D6;
	Wed, 28 Jan 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617551; cv=none; b=tqKD6iLC5nfsa44iveSNwrGGcvDXon4aRStVK+RzerXlYl4GKFP+A0aXWzFpv7r4udKnYxTcZSMhAKyH0QFf8RgkXsj2MftKkclmDoQ2DzoGS6wt4dMQ9gQPgrepyp1DnZmbaKIt1ImSOWqDmCEqeGrLdyubgWdlc+zsak+RwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617551; c=relaxed/simple;
	bh=31X9JFSHzmvgdIey95VPsmriefKTQ9kT3QGAlb5Keks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOjMHDH/viKRZtLAh3j9jtz2MkyNjodkAytQiXNDhsF9OASbkotDLv1vEyZWWUpTD7I7MN0aMha6wepFNQ2EgNP24x6pG/TgWG1VW0e2w03bkF9d42dnNDQYIZ+0dSMl1XKZuHjHsNj1K8o0w5bKA3cV1PjaU1VuCbuLKd1Ziiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4802F60625; Wed, 28 Jan 2026 17:25:47 +0100 (CET)
Date: Wed, 28 Jan 2026 17:25:48 +0100
From: Florian Westphal <fw@strlen.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <aXo4jP9M0EQPOaeI@strlen.de>
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <aXn0iLuRqdOdcIBN@strlen.de>
 <4909066f-cf9c-49ac-b02f-d2e16908bbd9@hartkopp.net>
 <aXoMqaA7b2CqJZNA@strlen.de>
 <e2033d96-e900-4013-a18a-c2e0ffa269d3@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2033d96-e900-4013-a18a-c2e0ffa269d3@hartkopp.net>

Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Ok. But then I don't see any real pressure to do the extension right 
> now. There doesn't seem so much changes adding new skb extensions users. 
>   And we still have a free slot even if all users would have been 
> enabled (which is not the case due to the mutually exclusive options).

Yes.

> The good thing is that skb extensions are very efficient. Which leads to 
> the bad thing that we only can detect the problems at build time with
> 
> BUILD_BUG_ON(SKB_EXT_NUM > 8);
> BUILD_BUG_ON(skb_ext_total_length() > 255);
> 
> For (SKB_EXT_NUM > 8) the upgrade of active_extensions to u16 should 
> simply make it. Probably with some #ifdef magic only.
> 
> But thinking about BUILD_BUG_ON(skb_ext_total_length() > 255):
> 
> Shouldn't this be SKB_EXT_CHUNKSIZEOF(struct skb_ext) + sum of the skb 
> ext user data which can be up to 255 *  SKB_EXT_ALIGN_VALUE (= 2040) ???

Why?  Its not about the size in bytes, its there to make sure
ext->offset[] (u8) won't overflow for any of the extensions.

Maybe a comment would help.
