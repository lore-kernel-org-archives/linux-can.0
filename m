Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92073358B0
	for <linux-can@vger.kernel.org>; Thu, 20 Aug 2026 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236058; cv=none; b=fej2P8yytn4NNuJv9qMgz4styQVC1Qqa1giqrbnZeFPg6m3uYmzDWk3g4i0ra++MO41m7knYbzyZH5/pAa5/5PyaJ6jCN4S5wiBlIW/RKmSU7CSPG7P4gADS0n+NjOoN3hF1jnnSKBiBkxCLlMCNbxeQbAe9wofTA62B/0ciSUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236058; c=relaxed/simple;
	bh=vQA0r5yrcTneX0AORiBmIrZuk6hYJ+zgTzfFMcT4djE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSh8qnunhZLqAvrgY+q6XKQB+HADbj6uhZVThTgIeoun9MV0FQ+6KBn8AzUuXCm/17xVXWHKl9Ni5UMVLP1EQxM1MiW93LQP/jNsoZc7lhEGY5kjpCl7IBJzppUYbe7Hme9fTwAFVLBfrjjcAoTR8bAqRDLRO9krg8kIsyBFSz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=24FOXVKQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TAsyqIJA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="24FOXVKQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TAsyqIJA"
Date: Thu, 20 Aug 2026 16:27:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787236056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvfFiI0tLBTSTHL+Uqey1FuM01x9Oh+1UNKqdBw+wHM=;
	b=24FOXVKQihVu7PqE+aK3LAsy94xTJQClHqzyPjMQo9vQyj9Dbiq3oFauz2pcDgkzOxs+VF
	tY7dxgRB+hGg1Ehze7QZ5whWag6zr08T2MHenMzQbqadO9uAtBkBeCx9nbBtoD3mjMBUhb
	44e7wZCLqONKMnT+l5lszXA6yKdbCJ6xyhUWpuLZSujVW+ij7eLuvQtdarXzkgvQEWT39S
	jFi585/uzaABvKUOk1vA/DqUZ3MUR3Eg/YoI3b2w+XbhkKJ5SNbmSEGg+SNBA5pXOCCRcU
	oCFEtCNenaYRpXfAHKmPhTmxx0VLxsqHqA/WmesC0cM7+pO3rM6TocqMrAOVeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787236056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PvfFiI0tLBTSTHL+Uqey1FuM01x9Oh+1UNKqdBw+wHM=;
	b=TAsyqIJAscK+rgbMARUee9KwBP/K9/NR7dDHK2/enFQ2Xy6DwvLL/DYLA1SSLmnd7uexWB
	CfmmcVgaW7G8OXDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [can-next v2] can: proc: remove pointers from CAN specific proc
 output
Message-ID: <20260820142734.NuRnRMV9@linutronix.de>
References: <20260815103400.117175-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260815103400.117175-1-socketcan@hartkopp.net>

On 2026-08-15 12:34:00 [+0200], Oliver Hartkopp wrote:
> The proc content in /proc/net/can/ and /proc/net/can-bcm/ is intended to
> check the internal filter lists (af_can, can_raw) and the efficiency and
> functionality of can_bcm jobs. While it was ok to leak kernel internal
> addresses at time of writing the times have changed and multiple attempts
> have been taken to hash or remove such now sensible data.
> 
> This patch removes the disclosure of pointers and instead provides the
> function names and sock inode numbers when available. As there's no known
> tooling around the CAN specific proc output breaking the ABI with this
> rework creates no issue.
> 
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
