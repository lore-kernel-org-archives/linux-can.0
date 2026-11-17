Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924606;
	b=LVCuPFJN1oH3Ly6+TZzmv1/631leY0UldocLlsA8AlUBKK7t7A+3O4o4GY6L3bekvfsR
	 xUxGWcp4UmMFPkBSUz+eKrOBUbl3nDLTI++4X9fYZBkzvMShjVaqA/FJ8YWRLmPsVFN0I
	 s2CVtmYTRKOGnO0zFueCXe79PLhUcTeS0N/tN++H/Otf/AQQss2yY+kehQFDXt6095ejO
	 zzPE8TunDW45m3J6a1V1RwR7V7ytfOAr8WsRG7TSnX4jUgA52utijlmIbDFpy2c8+tRc6
	 cKzrlW5RcBFWf2fk3DzBDRpGsEXDDzmAa+x6qB/moGcSoazx+3EXGOtFrIh5hsYSdpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=F5meV2QUxN85asib0EvXq8wNQNxI3hiyY6zOUQ0uvmA=;
	b=NiVg2OONI+IFlNDo2beYI8+XiGfIuNO11FKcNpsgilY6nKb/bmFAmfoy+gQPCYxPnor3
	 2oIyMy9cX7i80GXyQ0KDeFNyoe6Kck09TUwkeZpcc90BTN1oCKwxxMjXLGCY7GLZVqot5
	 1gIn9dlpx7XmWwEBkajx841Se5/HVIQ26Vszt2B7oq0rS+8D/U7aesbWX+cq3Zi22YAJ4
	 eg/xETFV4TmvHHroA27/2N1MiVKygYuCPlkJ+adAdNWyTtgZ3HEfR22rU65mPU0lZkhlZ
	 f9COPQVYLdwQNR9oqkYFa+hFYigeJlQVUpGVilvQLN2nNcvh7EnsAmD7oca3f1jE23g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDX+A6uE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7645606A333;
	Tue, 17 Nov 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDX+A6uE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3011F000C9;
	Tue, 17 Nov 2026 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924605;
	bh=F5meV2QUxN85asib0EvXq8wNQNxI3hiyY6zOUQ0uvmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iDX+A6uEkn+A8RQZ2AhilY8u8OhUo/EO/XvGcRtdB/wESZVJyXVch7b+NLPIQP7Nv
	 y7A7s98AcicR395lMZgT5zIcAJ/RrB+tHDAa5JBMB35325fSun7jpPJp7l4JH45tkj
	 ZIf24AlJiwSn5s3G3xBrR8hS06lsr77AiZqy33k2PcAJYiot7i9qWlvP3cV94aZ/MA
	 J3CqhHYmN7/vD7c4pTHI88SaezQwEILZwhayJmI11mUGgpq+nFYDSmCF7VmAA55w1H
	 GT6vn+ulAJbICfh61jGv79iorlxzJTU418TOOSz+I+qK5dueiRn3Un/BqSH8KSbPta
	 IYE99BfW5oMow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4431392704C;
	Tue, 17 Nov 2026 14:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] MAINTAINERS: exclude CAN documentation from
 general
 networking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179492460428.610117.3153920075892405328.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 14:10:04 +0000
References: <20261113-exclude-can-docs-from-netdev-v2-1-8ae9dc553024@qq.com>
In-Reply-To: <20261113-exclude-can-docs-from-netdev-v2-1-8ae9dc553024@qq.com>
To: Cunhao Lu <1579567540@qq.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, mkl@pengutronix.de,
 mailhol@kernel.org, socketcan@hartkopp.net, robin@protonic.nl,
 o.rempel@pengutronix.de, kernel@pengutronix.de, max@enpas.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Nov 2026 10:33:06 +0800 you wrote:
> From: Cunhao Lu <1579567540@qq.com>
> 
> The SocketCAN, ISO-TP and J1939 documents and the CAN driver documentation
> directory match the broad Documentation/networking/ pattern in
> NETWORKING [GENERAL]. This makes get_maintainer.pl select netdev and the
> general networking maintainers for these CAN-specific documentation
> changes.
> 
> [...]

Here is the summary with links:
  - [net,v2] MAINTAINERS: exclude CAN documentation from general networking
    https://git.kernel.org/netdev/net/c/8868b79a430e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


