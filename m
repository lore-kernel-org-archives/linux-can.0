Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507643;
	b=jBsONFhuAOWOJYylPwYR30RTYOgTmlApziQYcRVk69w1asJgs0gkfzwgXqWQw+VhVM/W
	 spoTL2Skw0sSGVHNg1IufTw/IQNWUqlSdJ7bpuwTeBeYeQmBXMXpE9Nr4t1rzdSSYasLI
	 z8XN7P0MJYFbKwTWc+J49ZiDecSO6t3UYSBt4xzg5pSam9iHBWudd+UH1uBvJ3u/DC+4c
	 q9aKYnFHf75zS/bVFvCYYmrFzLfq72FnYPyorxPKzrT95TXlZ6WGTR7Dhcg71bo2tSCaK
	 70mkZiWpW/yFCqzEJswXKHXgKHKsZTSkSF4BrDdg2Wh5q9W13RlJnSAGBNZ7l8f7DjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507643;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z384hamH81nls7Cqgu8VnU3Tqn87ERoN8oONux7EIiI=;
	b=oR8JmbutaaTycEUqnFkOKbApRhoUo5SURfflTxr4Rt2M7oo9RmJeGiKqP96l8Y+7d/a4
	 EVw6KCQhxQo81CGlt6jXYXxdBvu0zsCSm6TVJ72yXd0cPohFq7H6AtrcUtSmHwSARUZcF
	 s04LsNuC762ukB/tcKjRzuGKFiMlCrl95qzrf1++HN9WHuIqhmXWNqzFR/WvYp2r7Z5Ew
	 +hKn26IyPuLPge2WL74xdnJr1BlOO6M2IqidTtxT1w4AQss83lPJR3bt4FmgoL9g0UW9F
	 PjiV3p6H85rEwyGKQHP3NNkwFtosm6WBr4qixtIYC5k2/CYueCy4Y01krwxiVCb5WwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUYbCeaG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38025606A31C;
	Thu, 12 Nov 2026 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUYbCeaG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975561F000C4;
	Thu, 12 Nov 2026 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794507642;
	bh=z384hamH81nls7Cqgu8VnU3Tqn87ERoN8oONux7EIiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HUYbCeaGof0BKc8LXkOBn5vjsaaSI+wfp0I8Vp3nsjkfd+OwNc0OA77PKjR/D5Tp5
	 K5LFjXnkQIkcOG4Deb8dgEkJHyX3TzyasypjcfTjijoiVfj95HmK8YQ2Il6BGeZYhi
	 NfvLteiCiciltqy9q7R/IUsHmt1jD0u/dpfDLAnb9AEf1t2Jq0H/BwYSIqtwMgb4i6
	 DP3V9rZCktkbNCR+1ItqxiSNuefjjKQb/bxz+TEPfb9ab/qzIQySVL3jWNpLPyQXbK
	 aIKfqOtIWWi3Q57c21ctsq47rqxmMu9oj2GsOdw6iuVFbkiykEE8GIFOp1UMWgCHx8
	 7arhkVEQze6HQ==
Date: Thu, 12 Nov 2026 10:20:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: claudiu beznea <claudiu.beznea@tuxon.dev>, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in
 the probe message
Message-ID: <20261112102041.0857478e@kernel.org>
In-Reply-To: <20261112-private-tangible-dragonfly-3de373-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
	<20261110115112.3807247-8-mkl@pengutronix.de>
	<20261111-wise-graceful-avocet-27fa57-mkl@pengutronix.de>
	<7c5f9cc9-8e3a-4f3d-b9a5-b5b0462833af@tuxon.dev>
	<20261112-private-tangible-dragonfly-3de373-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 14:44:43 +0100 Marc Kleine-Budde wrote:
> > RZ/G3E, RZ/V2H, RZ/V2N have input clocks named in the HW manual as pclk,
> > clk_ram and canfd. These are described in [1] page 3365, [2] page 3286, [3]
> > page 3160.
> >
> > All these have external_clk = 0, fcan_pclk = 0 and the patch here will print
> > "canfd clk" for them, as it is actually defined in HW, and as the previous
> > code did.
> >
> > It is true the commit message mentions it uses DT binding clock names. Maybe
> > that should be amended.
> >
> > With the current binding names and various usage of it across different SoCs
> > I'm not sure we can use binding names for all the cases.
> >
> > Please let me know how would you like me to proceed.  
> 
> I think it's fine. Let's see what the netdev people say :)

Fine by us if it's fine by you :) Thanks for chasing down 
the explanation!
