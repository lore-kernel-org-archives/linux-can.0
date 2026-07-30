Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16F3191BD;
	Thu, 30 Jul 2026 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417676; cv=none; b=NhMlKWpu2Jb4ulcl/FBA1lcqP2FI1CMF05whCH2jaNKHaIJAUaQrb9KQMAynhu1ulHoCEijky6EueL9CZDAcoUi1ETQ3zZlV97mi9zttk80/dMQdtVq4K4SaPcHb01+VwLZWGzee45MbxDfLQowHbN7IcxGBcdY1xaOMX2yaRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417676; c=relaxed/simple;
	bh=YYbmrVVcPaa/sGUTEyq1hJ2qoMEWjwJZ5gKDgc1vd68=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NGBoYI5moKdDx9FvauT/6FSq16P7YexVPrjcCmHETOtxYGAURJLgSC2C+/3OIXoRSs6DIbh+2wyJO+nxcZiNqYf83lAx8tc6H3K7Fy6Fway/WhBfRSTGApMprcsGNBcuNjjYrOJ7iKmwgQXdK6vZWzIf21AD+wMDIPvm2i6Ubx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOsq7j9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOsq7j9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405B11F000E9;
	Thu, 30 Jul 2026 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785417675;
	bh=+c5b3QFnVdIL6lkKBYaqUPnPQ+WB/hciUXwvJ4sUKD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mOsq7j9iqhpssRh97tIVDEULg0+7+6Y212Ju76fnP1I3NQ3Ltsz2KP/FUwgEFvM47
	 L0fCNqUQF9x7+LAS60KVX80pF7CxbOXUy6uM9FVjz7rsPqhbB5aJqcZobmT8vHKl/u
	 wnC9nSyyjRhgw9JGjanyq7NEiuaJdQaBmmP6U8g9jKxQGy80F+bXhYaiswevkk21Vc
	 5x1qts4GLTUZM0KtLvHsq3VqU449jVaErol0W3z9WAoPb0WWRIWEYXjOZHxZMHjvAQ
	 lEtl+qPDESgP3346vLzxyeJGLO4c66X/z6IT1cXo3YK0exORENyQM4argVb9rIXvSv
	 H6Drxw69ZUGlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987F38119D1;
	Thu, 30 Jul 2026 13:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/20] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178541763890.3566031.18223366649826424515.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 13:20:38 +0000
References: <20260729102802.505168-2-mkl@pengutronix.de>
In-Reply-To: <20260729102802.505168-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 penguin-kernel@I-love.SAKURA.ne.jp, o.rempel@pengutronix.de,
 stable@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed, 29 Jul 2026 12:12:41 +0200 you wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> syzbot is still reporting
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> problem. A debug printk() patch in linux-next-20260508 identified that
> there is dev_hold()/dev_put() imbalance in j1939_priv management.
> 
> [...]

Here is the summary with links:
  - [net,01/20] can: j1939: use netdevice_tracker for j1939_{priv,session,ecu} tracking
    https://git.kernel.org/netdev/net/c/d2fb981384b3
  - [net,02/20] can: j1939: transport: j1939_session_fresh_new(): initialize receive buffer
    https://git.kernel.org/netdev/net/c/eb96c5890792
  - [net,03/20] can: isotp: fix timer drain order, wakeup handling and tx_gen ordering
    https://git.kernel.org/netdev/net/c/050f010f920d
  - [net,04/20] can: isotp: check register_netdevice_notifier() error in module init
    https://git.kernel.org/netdev/net/c/ef09a13c5afa
  - [net,05/20] can: ctucanfd: unmap BAR0 using base address
    https://git.kernel.org/netdev/net/c/a6873910f983
  - [net,06/20] can: ctucanfd: mark error-active controller status valid
    https://git.kernel.org/netdev/net/c/4e735cbe3aff
  - [net,07/20] can: ctucanfd: handle bus error interrupts
    https://git.kernel.org/netdev/net/c/e74bae899529
  - [net,08/20] can: ctucanfd: use self-test mode for PRESUME_ACK
    https://git.kernel.org/netdev/net/c/c31a435933f1
  - [net,09/20] can: ctucanfd: add missing MODULE_DEVICE_TABLE()
    https://git.kernel.org/netdev/net/c/d937bdb244a7
  - [net,10/20] can: peak_usb: add bounds check for USB channel index
    https://git.kernel.org/netdev/net/c/39132f166ca8
  - [net,11/20] can: peak_usb: peak_usb_start(): fix double free of transfer buffer on URB submit error
    https://git.kernel.org/netdev/net/c/9b3d5a6d952c
  - [net,12/20] can: peak_usb: validate uCAN receive record lengths
    https://git.kernel.org/netdev/net/c/93fcab2c6968
  - [net,13/20] can: kvaser_usb: kvaser_usb_hydra_get_busparams(): fix memory leak in kvaser_usb_hydra_get_busparams()
    https://git.kernel.org/netdev/net/c/941eaf9a6d3b
  - [net,14/20] can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
    https://git.kernel.org/netdev/net/c/0293dd153f9d
  - [net,15/20] can: rcar_canfd: change the initializing flow for clocks and resets
    https://git.kernel.org/netdev/net/c/bef9004c5b91
  - [net,16/20] can: softing: fw_parse(): validate firmware record spans
    https://git.kernel.org/netdev/net/c/856d6cb04e54
  - [net,17/20] can: c_can: c_can_chip_config(): keep controller in init mode until bittiming is configured
    https://git.kernel.org/netdev/net/c/26504844613f
  - [net,18/20] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure
    https://git.kernel.org/netdev/net/c/68c5724ecd15
  - [net,19/20] can: etas_es58x: es58x_read_bulk_callback(): fix RX buffer leak on URB resubmit failure
    https://git.kernel.org/netdev/net/c/7a0cf2b2497c
  - [net,20/20] can: ems_usb: validate CPC message lengths
    https://git.kernel.org/netdev/net/c/02925f51377f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


