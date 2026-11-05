Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869814;
	b=UlT3MoilpoVE2d7jQRvSoY0mQwY95+Hk3cFzN6C1lfL2tCHBkKTlG1gn022lFEocGvM5
	 v1myuM05h3epYyVByija4OCpuuXn+rf/ZNdIigtYdp8iNGgOsHCaQGJ8Dmuo12H6vcDFY
	 k9/RUT5cTtEeXSdvI+/xQB5yHMWYaPIhvg8xOrYcPEI3UbdmVgETHVa1xrcZv4ZeArWwh
	 P65/aaLTuvjHK+oGLrk8vujmkv6b7Gu8q/GF1jXCvFMviuMgrYZJXU6rhLIvI/tZ5qqnn
	 dzbb7++Zho8gztqACE1QldC1ydy+IpLJ5J24hmYlNUb8rbaeo32TxsjJPb0tTgl+lsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869814;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=XUtq8qWZBzsRZgFiEIjZ4AQV2UqPpDHNXpMykqYphTw=;
	b=zr9GE36IQAE6kPTsb9dRINpbZE+SjnKTm+ZQQ3v2J06+/Q591Jk7Ko22Y8c3JFwzozMj
	 U+b4obeVT3n0TIn3IlgqDJfVVJtRxpeCBl3eHnMGlT3SZqvScf/doNJbfLlbKfiZCRFZF
	 dfmSc6e+gt7MotlXWQngLLllWTynJVe+lnMTOyc7QICqOHM+Q5ej37G3lCobC1F22jJPa
	 lOfyEg+S2gGSxgg+SX1jb9odXipXob+sdfkEioScKgJ6+jZg3y/dvDzqnMblsBccEA9O9
	 b/YF5eUFPaiuWmzPkUrAhG86V4wUFesb9t1xVoufNBQGuYGT1Mgc+gH4paSFgv7HrLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEAsVhXr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F87606A31B;
	Thu,  5 Nov 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEAsVhXr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FFD1F000C1;
	Thu,  5 Nov 2026 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793869813;
	bh=XUtq8qWZBzsRZgFiEIjZ4AQV2UqPpDHNXpMykqYphTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WEAsVhXrZjMr9iXlAFtOIcVk7EYBYDA9ipugAjWvmoV3mvrpsWaTLuEslEVtd523P
	 7pA0EJo2pyIBfr+Pq4/Vka2aYAx+QSG3RCG2FKHVDwLLzQup7+stMHw0QLDQI4mIcG
	 GD17MDImSm7N5WgAm/BI4HHymoTgF19EAOqayDQov4kxTWLO/KN9nZjQjckLh3J6RN
	 xdwYTWp3Lh8K4Cu1JZ1+qbGG4uWiJvmMoQnmsy8hVfgM8HF2bwTuzugxPDVfvRhxOq
	 jmPG/7sX9vQs7J2k/R3/EV45LTWRQgf4T6NKd8wFABnBrYNNxKa3b82zf2KAWHm2/n
	 KjWbGvE6+VoOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D46A391AFA5;
	Thu,  5 Nov 2026 09:10:13 +0000 (UTC)
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
Subject: Re: [PATCH net 01/15] can: dev: can_dropped_invalid_skb: drop CAN XL
 frames on non-CAN XL devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179386981230.3522571.13202967143712215658.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 09:10:12 +0000
References: <20261103204305.3211144-2-mkl@pengutronix.de>
In-Reply-To: <20261103204305.3211144-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, mailhol@kernel.org,
 stable@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue,  3 Nov 2026 21:30:22 +0100 you wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
> 
> Sending a PF_PACKET bypasses the CAN framework logic and can directly
> reach a CAN driver's xmit() function. The PF_PACKET framework only
> checks that skb->len does not exceed the net_device MTU.
> 
> For a CAN device that is not CAN XL capable, anything above CANFD_MTU
> (72 bytes) is therefore dropped before it reaches the driver. However,
> CAN XL frames are variable length. can_is_canxl_skb() accepts lengths in
> the range CANXL_HDR_SIZE + CANXL_MIN_DLEN up to CANXL_MTU, i.e. 13 to
> 2060 bytes.
> 
> [...]

Here is the summary with links:
  - [net,01/15] can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices
    https://git.kernel.org/netdev/net/c/0fce44e29fce
  - [net,02/15] can: isotp: check the frame type, not just the length
    https://git.kernel.org/netdev/net/c/933bf0fcb325
  - [net,03/15] can: skb: make echo skb freeing safe in any IRQ context
    https://git.kernel.org/netdev/net/c/d74307196492
  - [net,04/15] can: skb: make CAN skb allocation failure paths IRQ-safe
    https://git.kernel.org/netdev/net/c/d4b616a38118
  - [net,05/15] can: dev: can_put_echo_skb(): free skb on invalid echo index
    https://git.kernel.org/netdev/net/c/b4ebcbbf66ba
  - [net,06/15] can: replace ARPHRD_CAN type checks with can_get_ml_priv()
    https://git.kernel.org/netdev/net/c/962947b69589
  - [net,07/15] can: isotp: check the return values of can_rx_register() in isotp_bind()
    https://git.kernel.org/netdev/net/c/874f5f14cf62
  - [net,08/15] can: protect the receive lists with a per-device lock
    https://git.kernel.org/netdev/net/c/0f3ad9ab40e3
  - [net,09/15] can: raw, isotp: copy socket options outside of lock_sock()
    https://git.kernel.org/netdev/net/c/43c973a0887d
  - [net,10/15] can: proc: reset pkg_stats atomics individually
    https://git.kernel.org/netdev/net/c/12297f855bbd
  - [net,11/15] can: proc: skip stats calculation after reset in can_stat_update()
    https://git.kernel.org/netdev/net/c/01b19ed9fa03
  - [net,12/15] can: proc: remove pointers from CAN specific proc output
    https://git.kernel.org/netdev/net/c/b98179a6e194
  - [net,13/15] can: dev: can_fill_info(): don't wake up controller if interface is down
    https://git.kernel.org/netdev/net/c/75332c410c81
  - [net,14/15] can: dev: can_tdc_fill_info(): don't read automatic TDCV if interface is down
    https://git.kernel.org/netdev/net/c/f5128a767261
  - [net,15/15] can: peak_usb: pcan_usb_fd_decode_buf(): accept short uCAN end-of-list records
    https://git.kernel.org/netdev/net/c/2d4c272e816a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


