Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7083BBFA5;
	Tue,  4 Aug 2026 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831731; cv=none; b=BXX1GxR0rvvor1ZoJLQMicQBYlIrsnksyG/vpj6OsHpjlyBRbfxY+/bPSkgXEeoYAUXhWCkG1jz31W4vXKX10zCvYeIPDeMpONSC8tlVtaEshScSFhbcQtEOXAaCwG0m6xauHzsYuvzie2adEGacug4Is9ilHbatSm8ZKCmf5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831731; c=relaxed/simple;
	bh=+CkWgQjsxoTX2+XgqYkbp284y8hZozLyYGa5JL/9Jg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8JFn5Nym1smYp6CYfHS4uNW3QaO4C87UIeKZvWT5aYpT378W5EB8vrlVOyBWOkCdk9XqGPK2+2VCnZLSMCWI4UcskwYNJjMLujOLRyWV91ya5PNHrs4t4b+ZKjrOu7OtoDlcHKEV54boLAqsI80nEy6qCk7hELqm7A4daBjFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ijTyWJG2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ijTyWJG2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DX7WKE6ZUQAMmQ1KtJTF0rbSJXIx9fEZBDRmpQHqr6Q=; b=ijTyWJG2QfSTQuuUodDQgGIVDz
	YwyEJ05aJg0aOoJArTWlFZU/R6R69N/5Lt4mQewrfwAuj7ndv87Qr+SK/llYbUDfu8T1p9MJGVqrB
	VKH+52xOP+0Shr190McefEEh26agYFdHp2BLOuEOWv1uCudWOvBPpZTQizFJiC64BcNyssknxZ5lg
	Sz/oJmN2IAnZGtpzyKfTqLMFKLC7W5Eo/b5THb2lu+ezwtZ9sXdLYQoUaLnA3YhDIFTOYiSQ6q2fB
	kRz7nIZ/UFcaM2HM3sUkUkmNk3D4Uq14WGWTxsReWcqGn7AV9RMuhpncPlterjcPvfywia6pJt47W
	Bn7rNrGw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wrAPS-00D0V6-1H;
	Tue, 04 Aug 2026 08:22:02 +0000
Date: Tue, 4 Aug 2026 01:21:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] can: isotp: convert to getsockopt_iter
Message-ID: <anGg-CeHzKdYvbqb@gmail.com>
References: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
 <20260507-getsock_two_can-v1-2-3c2ae9edfadc@debian.org>
 <14d3ad71-ade2-4d2b-8a67-b0fda3eef2b7@hartkopp.net>
 <aiAcRJ8TBjWhlKhQ@gmail.com>
 <f83e25e1-b9f5-4810-bbd6-fdb8d2a10c8e@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83e25e1-b9f5-4810-bbd6-fdb8d2a10c8e@hartkopp.net>
X-Debian-User: leitao

On Wed, Jun 03, 2026 at 02:50:51PM +0200, Oliver Hartkopp wrote:
> > > 
> > > Same pattern as in net/can/raw.c that had slipped in via net-next last time
> > > ;-)
> > > 
> > > Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > > 
> > > Thanks Breno!
> > 
> > Thanks for the review!
> > 
> > I haven't seen this on linux-next yet. Please let me know if there is any
> > update that is expected from my side.
> 
> This patch will likely go upstream via can-next.
> 
> Marc currently seems to be busy.

Hello, any chance that Marc is not busy anymore?

This is the last leaf nodes that is missing in this conversion now.

https://lore.kernel.org/all/20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org/

Thanks,
--breno
