Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E71F12F8;
	Tue, 29 Sep 2026 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644164; cv=none; b=WvDdxpY2QxAfKEO1U0QFB4Oig4UanxJfbA+WtnVsYCzrgnYJhRImtjTPq1LxVLndlKBzBcpzBTLzUFrczhkDnE5h5GJL8IXDD8XYJqVdLbQZD7FwIdgIm3F/LFjuf3B+r7j5RTU98YTOw6+9MIlJUcwjouwoha215AsGUB1EX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644164; c=relaxed/simple;
	bh=I0OmZNKyRkTsakc1BK2fZum/DdnBwj4dYllItNisJ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hh03bav9SkwRH7vjo+ZJKvIaCpziBN5zyTNhTbQIB/q9SSVKsC2xg1MfACkS2mivOYqgdctBPqfEJ7/GezV3vWmYqnvl0qXLyCMP/swFki25j8gu1+DYylxYJ3E/gXZJC6bCniCqiREJfsz3Pl8hAyZSS00P1Nj/I/KK8QaqLIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZklEqjrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZklEqjrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CF81F000FF;
	Tue, 29 Sep 2026 01:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644162;
	bh=wpxBY8dgiroer/Uu1UAO3GEdyrZypT/qC8j4Sb1sqvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZklEqjrfMRgDOG2+nZXnfGzYFqM1Hwv5Zd0J8M+X1Vo+sn2noqU3naEE6JOobtAhn
	 /sRllKe4hFxr0Yj/rdfydFttCQ1QWguxevsJcklWc56NkrQ1jVGmbnQwC7hqXV4ZzH
	 1ceNPSkYTeKA+H8WppnP0aY8+Q1Lvu4XkWuhq3PuwCMdm+IDzVi67CcJEiVF4TtuAe
	 K25hwd0wUoIBV65m6+h7n9rPmJVD4p1S0byLSQAlIrN/hlbZYUzh99wPmpkr7TNePe
	 71gIGmQ0D4MIl8V02ahGJunymWfitlKOXhb0XiGL8eIAwx62ypOxCqVuCOpRgWr5AY
	 ja4ZBPLq7QBXw==
Date: Mon, 28 Sep 2026 18:09:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/22] pull-request: can 2026-09-28
Message-ID: <20260928180921.4200d711@kernel.org>
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 20:45:07 +0200 Marc Kleine-Budde wrote:
> this is a pull request of 22 patches for net/main.

Oof, Linus just shouted at us for pulling too many LLM-driver fixes 
late in the release cycle. Could you whittle this down a little bit? 

At a glance the skb freeing from IRQ, and propagating impossible init
time failures (patch 8) can probably go? 9, 10, 13, 16 too?
Driver init error paths and remove races are things I commonly apply
to net-next these days, 'cause those patches usually come from LLM
jockeys and nobody cares in practice.

I pushed the Sashiko review to high prio, so pls wait for it to pass
judgment before you respin:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193312.553632-1-mkl%40pengutronix.de

Up to you what you keep and what you toss, FWIW, I mostly want to avoid
obvious egg-on-face conditions, which I think the driver init error
paths could bring about.
