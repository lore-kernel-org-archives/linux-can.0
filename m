Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E72931FF
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811735; cv=none; b=Nf50yMYY0M/SQjMLn7uQl5FJ6nMfyQ4J00K+5DiRZODuyBJEDIcXZD7tx2Dt74RlZFURTaBOzlwaGUEdctTniAiWO1hojYkdxtWMKEkqscrUtDr0zsSn+MFWbX0Qouhinawlt9fn5OS8Gstg8NtcvB2adWSA8eNFp2tqSp1a55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811735; c=relaxed/simple;
	bh=stUXlIB+qK2+o/GUxL38c9X1QQHiTeU/9jvWS9abksI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxJWQ+tFuAc1RoAbuVI8QKMqI245Q+X49bi+iGddx83mJLVBElbTjysgiwEBe82JUBFBUBxYyZlkumswgRpZgY84Fy+FGG6btfd5TvADTu/uLw0sxZ3SjWgWWpOyk3yRVA7N34W2pdSq4pAtTLCHkLTJnXYzASoEV0bTv3dWnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=og6b4WCa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=arD8yrgb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="og6b4WCa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="arD8yrgb"
Date: Thu, 27 Aug 2026 08:22:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787811729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXvhBLYEW7G+7dbbvanaCDrT0KOvkBWDV0pOyfqPV4A=;
	b=og6b4WCazxG7vYcogLuulLMmq/2ZBgBqS1930HWHxlQDU7CnRzHP3TMXEXdopBAIQf/7iJ
	QdIqCWdiXs4YlTxp2FA0DvopTMCxHxg5y+PKOS/Mgmx+1ldglJTyg1ryzac2SzEgFFH4vS
	CdVCjPEbYiDg/5jOvMfMXeeoTPqNrLAnOWfOSNqodL1R/y6IoMmjLIJyAhnVnKZ5TPWUe9
	uaApFrY+P/MVA95D54kuXzzMMS+XWmprYb5dxac6NZFyqcDQIy7hAPLEEasw0d6Tzj2mhU
	0hrOv5lX2kwIJNpwNCRa20qq+XjtL0bmM/sRmRNPoOdXGsUJHKTVaSvTq3PbUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787811729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXvhBLYEW7G+7dbbvanaCDrT0KOvkBWDV0pOyfqPV4A=;
	b=arD8yrgbvXIWJIwTPc6m9eE8eEVLYRrTlU7HpT/BnGzknzCHFgC6dZnV2QcB4fsz+kngoQ
	frkYVoMREwrG5wCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: convert unreliable ARPHRD_CAN type checks to robust
 can_get_ml_priv()
Message-ID: <20260827062208.HLewnUEH@linutronix.de>
References: <20260819160822.8256-1-socketcan@hartkopp.net>
 <c3fc21b4-db28-4323-b182-eeeb646e64da@hartkopp.net>
 <20260826-loutish-cinnamon-macaw-e340a9-mkl@pengutronix.de>
 <574090ae-dbe8-4b06-bb6e-7e0cdadeace9@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <574090ae-dbe8-4b06-bb6e-7e0cdadeace9@hartkopp.net>

On 2026-08-26 21:34:19 [+0200], Oliver Hartkopp wrote:
> Hi Sebastian,
Hi,

> On 26.08.26 13:43, Marc Kleine-Budde wrote:
> > On 25.08.2026 16:55:39, Oliver Hartkopp wrote:
> 
> > 
> > "net" or "net-next"?
> > 
> > > [can-next v2] can: proc: remove pointers from CAN specific proc output
> > > https://lore.kernel.org/linux-can/20260815103400.117175-1-socketcan@hartkopp.net/
> > 
> what's your plan with your other %ps and pointer hiding changes?
> 
> Are you going for 7.3 or -next ?

-next, https://lore.kernel.org/all/20260821152614.2202196-1-bigeasy@linutronix.de/

> Best regards,
> Oliver

Sebastian
