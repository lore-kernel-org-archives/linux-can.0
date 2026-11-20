Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795143011;
	b=ZQ0zWYsRoWYAbJbwIE7iOtQJsqV82UF/mJPbY0krBRjbOxIXW50tWiXiZMfmhvboAkni
	 8qtdW0dHLhMHzYJFRUfZgXiFQ8rWtT618ZQPotI3OGqOLs37zsKk2fH8FmTSMsXv0KLHR
	 t0rPNXEEm3NdAIGfU2renGfihmTQQG2nhxTyGeLykFjbFmbDgf7zy+ltj2hqapeCWqSyl
	 HFQD1lp6XVxNrpKl653OyWhSDB1ErfGzZ54oPApNCxgnW4M96ilx+yVLQkB1CJzdSmcAL
	 15+LwPs8AewY3CQn6c5FFfpxpOebEGoMS4HjzbytfLX2L3iVUl3x9KS1SGNWrrUa2ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795143011;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4fiwQiJyJaqU6VSlwfbmktP4bOp8bdtejSg+8GagrpI=;
	b=5WtBb5T+NBnOIR263b0IG2hcdXHdoF8scfeqxMt2qD3YOh8xGeROTWD8jDOX57pqTzE9
	 Xxjfg48ZUfXlzzFWT0+5gor0oOPY5pahy3gBGfvAIyO01jSjgIZC2LexRkhk7RPG5ktJv
	 38ox+6PCjdsNsfG1/7zoR5XkzmbEvBUxdDo0XzC8owswqvoiwMcjVADdMIEY63KlUcATU
	 H15+XYYdXBYW6GiInw381ub5H/k6LLbgSF2IUSAgpTPshvkJI5L97xHW5o7+eTYg4sSRZ
	 1mH5shb9d9bQ7iOLixtoM41SQs3S8jUVT57Y/4KUaC8Tv25iy/z8E+jl/jaF1tRzxZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxQW7xNY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B043606A320;
	Fri, 20 Nov 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cxQW7xNY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445971F000C4;
	Fri, 20 Nov 2026 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795143011;
	bh=4fiwQiJyJaqU6VSlwfbmktP4bOp8bdtejSg+8GagrpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cxQW7xNYwWG/bIr1aqEIOnJ2KhoREloZVn5mCGphd5cWAi5q7XQUCTwhzMPv6gnOp
	 JfCBGC2NJwq06z1oPa3TEKSBpHL1tCxqdsGhvQhdBcudULPGUUOAAdxB7fgESuP2Af
	 346Io+UzgxIVIjiHNCgsQO7ZA30OJIE/tUNnfGjm9wkAC0mNHPZkyyNl5XZVdabHh/
	 v3PM6EnywEKb4Xn51+c0aJ1WJ5piuf7CTF9rZSUppY9GX0Z45LD4IpgUGd/1L4tCC4
	 lBs/Sct4szLq1HJd8073/WMSPc+p7IMUadkxGsIwzdlXTXKCZSCBrNLglCrG/SygG9
	 YuFxTCXW9CEUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3993808209;
	Fri, 20 Nov 2026 02:50:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next 01/13] MAINTAINERS: add entry for PEAK-System CAN
 drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179514301003.3992568.7103079582894112358.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 02:50:10 +0000
References: <20261119220936.155728-2-mkl@pengutronix.de>
In-Reply-To: <20261119220936.155728-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, s.grosjean@peak-system.fr

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 19 Nov 2026 22:58:37 +0100 you wrote:
> From: Stéphane Grosjean <s.grosjean@peak-system.fr>
> 
> The PEAK-System CAN drivers (peak_canfd, peak_pci, peak_pcmcia and
> peak_usb) are only covered by the generic CAN NETWORK DRIVERS entry, so
> get_maintainer.pl doesn't Cc their author on patches and bug reports
> touching them.
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] MAINTAINERS: add entry for PEAK-System CAN drivers
    https://git.kernel.org/netdev/net-next/c/aeb9eb4b48ab
  - [net-next,02/13] can: raw: remove redundant NULL check before netdev_hold()
    https://git.kernel.org/netdev/net-next/c/850bccc21cfa
  - [net-next,03/13] can: dev: remove unused safe_candev_priv()
    https://git.kernel.org/netdev/net-next/c/b1a7bfc01b14
  - [net-next,04/13] can: convert to DEFINE_SIMPLE_DEV_PM_OPS()
    https://git.kernel.org/netdev/net-next/c/ac7e2763cd16
  - [net-next,05/13] can: sun4i_can: sun4ican_probe(): fix clk leak on unbound
    https://git.kernel.org/netdev/net-next/c/ec957a8257e1
  - [net-next,06/13] can: cc770: don't discard the IRQ lookup error in probe
    https://git.kernel.org/netdev/net-next/c/1c7234484e46
  - [net-next,07/13] can: sun4i_can: don't discard the IRQ lookup error in probe
    https://git.kernel.org/netdev/net-next/c/cedeef322d52
  - [net-next,08/13] can: at91_can: don't discard the IRQ lookup error in probe
    https://git.kernel.org/netdev/net-next/c/e54162551905
  - [net-next,09/13] can: janz-ican3: don't discard the IRQ lookup error in probe
    https://git.kernel.org/netdev/net-next/c/01c28a68d956
  - [net-next,10/13] can: ifi_canfd: don't discard the IRQ lookup error in probe
    https://git.kernel.org/netdev/net-next/c/82a860d46902
  - [net-next,11/13] can: remove Softing CANcard driver
    https://git.kernel.org/netdev/net-next/c/85cc67092bd4
  - [net-next,12/13] can: ucan: fix repeated word 'is' in comment
    https://git.kernel.org/netdev/net-next/c/b12de036b5d8
  - [net-next,13/13] can: xilinx_can: set CAN FD flags on received frames
    https://git.kernel.org/netdev/net-next/c/1d527d7ecfaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


