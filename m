Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508219;
	b=rZKqkbUChLjuM45JSzXNiLb8LKC4/7joQjmQRrEa+ZMglSVJUlqE8/wPMOIj86eUA/Lu
	 11dcE2y+KrGjdemDZHG/ZLV7lnJ0lroDGoEx41Qzia4AFVR9ggyRAEtveC4yN6HFhbDTx
	 JSM+0IuagBrhy59vgJgvqrK6mn2Cuc8mtIXUR3XHw0V31/ZF8RIE4lv/TObAf4igUY9+g
	 uBX71lLzrHBF5kFzissWvF8urXghAqmzQsM3tL+0HINuTzswSuEkD3smVzeGVDc3+6CGd
	 yQZRieEivuKNIGrYN45MmUv/TJ1ByM8tsvnFJh8aStiqaflc/hnR4q8FZ6n7oiPRq8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508219;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ORLmmfxjRklPpWfdUmUL1iGPXPkke+HZp4Umvsgz+hE=;
	b=j+zOQUYh9C9ficydkt9Rj4AIUiVoOf/h42r4mT0dTCNvp8uGlkW7mMR3p6OzofxECWct
	 4ziTRWg9pWHaMX/Ex6Fl5auDS+Zv830RA4myybPsFM4JDInfalHFcyK2Ol1NYxbz79VsB
	 AHbJFVWFa8AHZwM8qh0OTHrxhfgaPT5L/CS0rS2jQdhTHLzyfCkHiWfP8TXFZtcQyGIbr
	 ZjbN2zf6lverO+yK0Y8orK3enhbT1uVwRrfAbMpwTxRxxUJ+F5CM0wwtSZhk3PF7IZ0s6
	 G9MafAtRt3SbyI7UY0XDuvd9BoBXGq4ASyJudyvol3biAy6WjVzIVXqcItn+e+Cl0dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObgJpWE9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36A960A2628;
	Thu, 12 Nov 2026 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObgJpWE9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825861F000C6;
	Thu, 12 Nov 2026 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508218;
	bh=ORLmmfxjRklPpWfdUmUL1iGPXPkke+HZp4Umvsgz+hE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ObgJpWE9U5vyIRpRoDYZKVwtuiJcdQO0N0o1f149QpiQgxRlRSMaJ9FxmRYbpQuBJ
	 OjgNdKNf6NXrwKBT3+uTEXX7niNyeBykXwuQQRxOiJtoNlpCujXQ96oG/X67jL0xvp
	 4VeZ3LG90BYe9V2/8epxAybC1AAlOkx/32q96FwQ7CO/FL4TEZeq3pRyd+2dRhitdm
	 qMyTNNvCmkMAQ/TIp6bm8B6nJD8OIusN7GR+2LrmTAk3N5dDBKmynz5kUiyrgCTl5x
	 av6BIaL2SCm47Sc/tB2+VlYs3DYIRjd2NKZ74OGpiQt51+dVO0G8OpeMg21e/rGTfH
	 sl/2/Kreaobgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773FA380AAFF;
	Thu, 12 Nov 2026 18:30:18 +0000 (UTC)
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
Subject: Re: [PATCH net-next 01/12] dt-bindings: can: renesas,rcar-canfd:
 Document
 RZ/G3S SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450821702.579048.3144753075880171787.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:30:17 +0000
References: <20261110115112.3807247-2-mkl@pengutronix.de>
In-Reply-To: <20261110115112.3807247-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 claudiu.beznea.uj@bp.renesas.com, robh@kernel.org, geert+renesas@glider.be

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 10 Nov 2026 12:41:24 +0100 you wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The CAN FD controller found on the Renesas RZ/G3S SoC is largely compatible
> with the variant present on the RZ/G3E SoC. The main differences are:
> - the RZ/G3S provides only two CAN FD channels
> - the RZ/G3S supports only CAN FD operation; the Channel n CAN FD
>   Configuration Register does not implement the bits used to select
>   classical CAN-only mode (bit 30) or CAN FD-only mode (bit 28);
>   consequently, bit 31 (CAN FD Frame Distinction Enable) of the same
>   register is also not implemented
> - some bits in several registers (mainly reserved or status bits) are
>   read-write on the RZ/G3S but read-only on the RZ/G3E; their behavior is
>   otherwise identical: the bits read back as 0 on both SoCs and software
>   is allowed to write only 0 to them on the RZ/G3S
> - the RZ/G3S provides 256 acceptance filters, compared to 768 on the
>   RZ/G3E
> - the RZ/G3S can use PCLK clock as the CAN FD clock source through an
>   internal clock divider, while also supporting an external CAN FD clock
>   source
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
    https://git.kernel.org/netdev/net-next/c/7aa321a595e2
  - [net-next,02/12] can: rcar_canfd: Fix typos in macro names
    https://git.kernel.org/netdev/net-next/c/79d4ac8cc434
  - [net-next,03/12] can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
    https://git.kernel.org/netdev/net-next/c/b40631d86a8d
  - [net-next,04/12] can: rcar_canfd: Do not set registers selecting the CAN mode
    https://git.kernel.org/netdev/net-next/c/a2af960288df
  - [net-next,05/12] can: rcar_canfd: Add support for Renesas RZ/G3S
    https://git.kernel.org/netdev/net-next/c/32e8a013243c
  - [net-next,06/12] can: rcar_canfd: Check can_clk request for errors
    https://git.kernel.org/netdev/net-next/c/0deb654e2b6b
  - [net-next,07/12] can: rcar_canfd: Use DT clock names in the probe message
    https://git.kernel.org/netdev/net-next/c/6a6c71a03d5a
  - [net-next,08/12] dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level
    https://git.kernel.org/netdev/net-next/c/3696939f7cb5
  - [net-next,09/12] dt-bindings: can: renesas,rcar-canfd: Simplify renesas,no-can-fd description
    https://git.kernel.org/netdev/net-next/c/aecb16f09db9
  - [net-next,10/12] can: rcar_canfd: Document that RZ/G3S has no Classical CAN mode
    https://git.kernel.org/netdev/net-next/c/7a5305fb26cd
  - [net-next,11/12] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
    https://git.kernel.org/netdev/net-next/c/0e890f327d8d
  - [net-next,12/12] can: rcar_canfd: Add support for Renesas RZ/G3L
    https://git.kernel.org/netdev/net-next/c/aa56fb023365

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


