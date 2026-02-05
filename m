Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D82C3ACA72;
	Thu,  5 Feb 2026 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289827; cv=none; b=RGLi5mCwK4qtlYXlPRTvGLBRCXtI+xGMkXngha1G4Lx4XRsyFojD1BBx8Xtawvxwso0Uy2STwjUBNxZ3F3X9kZmEVEBBuNI4MPwMrhffJ4jTi4YCzuBiKY0uog0K2DAE8KFZV+6OPnG5CzRQcwTg89/p+TFm2WXd1n6wtxrSjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289827; c=relaxed/simple;
	bh=9N6OLcjFLijwEHSq6VmHGslxJx06zjs534/5sp/VNHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MpYo4wsWPp6xbvWe/MjdBj78LWY8EqSCq4HGpae2/oWzC7ActjAGjVLtotlxC9hWsZpshM7UKMOloPdGIWMUkT8vYgxxYskT6YFEyYGRevxvefgNMHZZ0QWve11FmntuZvqUoLus5yPJb/IDkseiG5K1WcGYs8wdAvuE3xC5OhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW6pTi1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW6pTi1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E70C4CEF7;
	Thu,  5 Feb 2026 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770289826;
	bh=9N6OLcjFLijwEHSq6VmHGslxJx06zjs534/5sp/VNHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BW6pTi1yibviPUiENX2NZKKrlZsAMIhX4RBE9xGU48VeDsi3V4cAnfEqcq2L9/HXj
	 QCDyXxJQu1bhEUL2tJppcHprZEsSYLpPmRlndbym+75AX0Ylxp3Iy+askJ2gRp/d/6
	 PqnvYsB6Un36Wrex5VRXrLXsTrAtVVJneMiGG1Spi6sQzS0Gzx90TpAoWfLD7sk5cp
	 6T/3Urnby3K8dDFYtILCB+0fJAY8aWnWCK0iv38SqSfO0Zjyz6m9ys/qutbmjVrn6+
	 HG4o+MH9HOVV8RF5iu5l96aBpVyewT2pMmXrTdSrRmReHZ6L9s+/T1YD/NH7nhxNbC
	 OWSvLb9JsvZ8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23913808200;
	Thu,  5 Feb 2026 11:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/6] move CAN skb headroom content to skb
 extensions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177028982443.276579.4263605959311895217.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 11:10:24 +0000
References: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
In-Reply-To: <20260201-can_skb_ext-v8-0-3635d790fe8b@hartkopp.net>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robin@protonic.nl,
 o.rempel@pengutronix.de, kernel@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, lkp@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 01 Feb 2026 15:33:15 +0100 you wrote:
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
> [...]

Here is the summary with links:
  - [net-next,v8,1/6] can: use skb hash instead of private variable in headroom
    https://git.kernel.org/netdev/net-next/c/d4fb6514ff8e
  - [net-next,v8,2/6] can: add CAN skb extension infrastructure
    https://git.kernel.org/netdev/net-next/c/96ea3a1e2d31
  - [net-next,v8,3/6] can: move ifindex to CAN skb extensions
    (no matching commit)
  - [net-next,v8,4/6] can: move frame_len to CAN skb extensions
    https://git.kernel.org/netdev/net-next/c/d2d9179751e6
  - [net-next,v8,5/6] can: remove private CAN skb headroom infrastructure
    https://git.kernel.org/netdev/net-next/c/9f10374bb024
  - [net-next,v8,6/6] can: gw: use can_gw_hops instead of sk_buff::csum_start
    https://git.kernel.org/netdev/net-next/c/3ffecc14ec7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


