Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D723C1085;
	Fri, 17 Jul 2026 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281865; cv=none; b=FkQCsNhTsVdu/WUI4fT0dyg2kYCZzNKfqgkA7/eqBQlnTY/QCpS5tVXboW6vcGXUsMOLIczh8pdpLMPeqOOgvuaX+4ZJalVH0HZErEXZupvviwVOJxpap0fFKariYi5/esiZkb5L0S0iNd5epz5qw6WS4aERZSyAtM/phWkjDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281865; c=relaxed/simple;
	bh=6/88PhGG+2jdFq4MqduXDg1GGg8fEzpsIGfKmfMg7Ps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cuOu/Ec/s5+g1jjiwrjuq9GdD4rKqdEb42VR00/i7ICnIrbJH6yFEU4TxVXPcAl+cMMWoHXcjHU+Vy/7eCQZgrcNzqnMznTE8JRQ1ZYHtOzXubdd9abV4J5K0u0Z4qMnTCn9yHw9JqxMx1M3OlFUTtmtOJjGmlz9OTwe28KON8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu+V26gC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu+V26gC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1B61F000E9;
	Fri, 17 Jul 2026 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784281863;
	bh=+f2BqKfaIAk31XZR2BGdOMxiuQ/Xg0fIHytL6fBxbPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hu+V26gC/Zg53aHMOqeiEBg8OEGdmiLfRt8i0OmD7lFQ4FpDcj2chhS3AsaRhO44K
	 6T/AYyTZaHt2u7HcUhqy2RgRNl9KeyL+uGaZFGsEiTqlQMPURk0yIs5y7hKpJG6jVC
	 JpI3pJq6PoBrmZXYrjg2StWXp9Htrg+ObZBjlWcYcHQwLBapMk/i1ulwLGxrrmrK7I
	 HIRAoKF2nyg8WSo8Em4aWqaWxOlS4nFMU+t4djgYz6hjx2H/4cj6y07PCTo6n+Eby2
	 FzpfA/Flj01qnkS994l0mhMCwmnROCI0PUX8ywHXoRLZsp/TTGgE4GV+lvuQy+9NC1
	 j04Wa8FCmgOPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C0380CECD;
	Fri, 17 Jul 2026 09:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/19] can: vxcan: Kconfig: fix description stating no
 local echo provided
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428183589.1639384.13582691603275670664.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 09:50:35 +0000
References: <20260716155528.809908-2-mkl@pengutronix.de>
In-Reply-To: <20260716155528.809908-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, alexander.hoelzl@gmx.net,
 socketcan@hartkopp.net

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 16 Jul 2026 17:47:26 +0200 you wrote:
> From: Alexander Hölzl <alexander.hoelzl@gmx.net>
> 
> The Kconfig description of the vxcan kernel module erroneously states the
> the vxcan interface does not provide a local echo of sent can frames.
> However this behavior changed in commit 259bdba27e32 ("vxcan: enable local
> echo for sent CAN frames") and vxcan interfaces now provide a local echo.
> 
> [...]

Here is the summary with links:
  - [net,01/19] can: vxcan: Kconfig: fix description stating no local echo provided
    https://git.kernel.org/netdev/net/c/79adf48fb091
  - [net,02/19] can: esd_usb: kill anchored URBs before freeing netdevs
    https://git.kernel.org/netdev/net/c/c43122fef328
  - [net,03/19] can: raw: add locking for raw flags bitfield
    https://git.kernel.org/netdev/net/c/1e5185c09058
  - [net,04/19] can: j1939: fix lockless local-destination check
    https://git.kernel.org/netdev/net/c/e4e8af62adab
  - [net,05/19] can: peak: Modification of references to email accounts being deleted
    https://git.kernel.org/netdev/net/c/d83762005c13
  - [net,06/19] can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF
    https://git.kernel.org/netdev/net/c/68973f9db761
  - [net,07/19] can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
    https://git.kernel.org/netdev/net/c/d9b091d9d22f
  - [net,08/19] can: bcm: add locking when updating filter and timer values
    https://git.kernel.org/netdev/net/c/749179c2e25b
  - [net,09/19] can: bcm: fix CAN frame rx/tx statistics
    https://git.kernel.org/netdev/net/c/e6c24ba95fc3
  - [net,10/19] can: bcm: add missing rcu list annotations and operations
    https://git.kernel.org/netdev/net/c/7b2c3eabc4da
  - [net,11/19] can: bcm: extend bcm_tx_lock usage for data and timer updates
    https://git.kernel.org/netdev/net/c/12ce799f7ab1
  - [net,12/19] can: bcm: validate frame length in bcm_rx_setup() for RTR replies
    https://git.kernel.org/netdev/net/c/62ec41f36464
  - [net,13/19] can: bcm: add missing device refcount for CAN filter removal
    https://git.kernel.org/netdev/net/c/d59948293ea3
  - [net,14/19] can: bcm: fix stale rx/tx ops after device removal
    https://git.kernel.org/netdev/net/c/3b762c0d9503
  - [net,15/19] can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
    https://git.kernel.org/netdev/net/c/58fd6cbc8541
  - [net,16/19] can: bcm: track a single source interface for ANYDEV timeout/throttle ops
    https://git.kernel.org/netdev/net/c/2f5976f54a04
  - [net,17/19] can: isotp: use unconditional synchronize_rcu() in isotp_release()
    https://git.kernel.org/netdev/net/c/9b1a02e0d980
  - [net,18/19] can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
    https://git.kernel.org/netdev/net/c/20bab8b88baa
  - [net,19/19] can: isotp: serialize TX state transitions under so->rx_lock
    https://git.kernel.org/netdev/net/c/cf070fe33bfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


