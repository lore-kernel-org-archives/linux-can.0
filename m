Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74931355C;
	Thu, 29 Jan 2026 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769650899; cv=none; b=DJQM5qq0bamJgFyw/wDIyrYedU1rx+STH/l420NwojitOZUV6b/JlDs8SAh9HjBOCkqnpX3UEEPzxVcdJN4Ve5YFK3oC8mm2ei1r7O1rYPy7/g4cDh6+3X3aw3lk80jLVFK9xWIzbERNs4hNF0ZrMJy3MhNYFh62DP5t/XcF7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769650899; c=relaxed/simple;
	bh=xDPqYiZQa7TzJ8mSUu1DL8UHnEMsE1fthjzDfHVLDyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuHr7ThiZDuw5FFmReiDgUwK4hurWDiIBKP9FL1QBJrjq5Ers25JMketqQvSstiNfYogWnOObYxV9cmSiV9pdwzxkrsUBrKoWExkzlUhtdEO5M29UZn3yISJV7Len6Uef2EHKWwUC8vLZRBsJDXR0DqvntsyFZpXcmGUVie+e+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGyD6dSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGyD6dSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B69CC4CEF1;
	Thu, 29 Jan 2026 01:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769650898;
	bh=xDPqYiZQa7TzJ8mSUu1DL8UHnEMsE1fthjzDfHVLDyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TGyD6dSgfJMlRuEck/YRbTZmCy35V0telRLezAySciRZ5rsNPqR35Up8zki6spQOw
	 IiS4pBSdiXieVP/hdt22dsaSfhcOCgOKfY2fJO8M1WVfOqElpWJc7u/0BoCSJA9yv/
	 Z+ZUu35lE4sen/mze4yJTKtssVd3WdgAQSacJOWUKVXf7N7eyB3Ypvb6MzjkiPwQlv
	 hx7aKfC21j9UnAr6gFY9zEBWsYJqLqU/Q6xqq92j5ZgbAhMLpIqLOEBK1yqmlIcgjj
	 N/aJFAJZtanTKpr90zPSy9P7tf8AYiyA0ZPvT37XNY4mAxiHi9Gkt+kM0eCkBwQCCS
	 K//SiJb5Cuk+Q==
Date: Wed, 28 Jan 2026 17:41:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: socketcan@hartkopp.net, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next v4 0/6] move CAN skb headroom content to skb
 extensions
Message-ID: <20260128174137.65929694@kernel.org>
In-Reply-To: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
References: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 23:43:39 +0100 Oliver Hartkopp via B4 Relay wrote:
> CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply contain
> CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data. Those
> CAN skbs do not have network/mac/transport headers nor other such
> references for encapsulated protocols like ethernet/IP protocols.
> 
> To store data for CAN specific use-cases all CAN bus related skbuffs are
> created with a 16 byte private skb headroom (struct can_skb_priv). Using
> the skb headroom and accessing skb->head for this private data led to
> several problems in the past likely due to "The struct can_skb_priv
> business is highly unconventional for the networking stack." [1]
> 
> This patch set aims to remove the unconventional skb headroom usage for CAN
> bus related skbuffs and use the common skb extensions instead.

If you're targeting netdev trees please comply with our community
guidelines:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pv-bot: 24h
