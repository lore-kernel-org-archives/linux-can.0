Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDA2E6CB8;
	Tue, 18 Aug 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078283; cv=none; b=CvG5meo/VvLA6ZXP4CocuOKR3jIVVwkyLBOc/Fo2uP3x9rjr589z5aokr5BVcS+KYlUYuXuF9jYQUgAYDRNQSe0z1Q8K/p/fHKHUy6m9EDbStqYr2Jy49vs5aBz/fRIU7L9em90E8S3mkfNWP24KQ11AMDI381McwSN6lx2JLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078283; c=relaxed/simple;
	bh=t0tH5V6xyTwtZ5KYHf5n21g0lYj3M7UQIgaIDaeBEP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FRQ6eQ9G9nRGCEa2tOsIvLYv8jXs2edN8hK8fOeUohEfhdLNBVeLRl+OjdUd68iX8fYj4ppYh75TTP7UTnmxXjOZnjftre3OnbBO5SKZ5fAszlLz2RDswCGVtBQJMtUXvS3FWiDmbsVQOP1th+Rdf0R9sKU2/OkpTt4EzhZu5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrU78zqT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrU78zqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACE81F000E9;
	Tue, 18 Aug 2026 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078281;
	bh=X+tFDMCiIKvulMueyAE0+Uh+ICmd+Trypk9gjSTkOyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GrU78zqTPCXSsqXQjkrt5zcrbxxMm5I1f8AvbNVNcIhn/eLJWr4WMXjUQ4BnlH8rZ
	 5bYeFvI/Hs74ru4c5Qoq1+aTELCfKU8z6sbAHFX9GW9pp5Jo64ue9ZfI88hC2h9BsL
	 XXccmJVYnpantKfimTGqplJdodvZG94oUXj80wpImDTegnOt9NVeq+4VNzeNP+GXTl
	 ESWVungAD+sr6qeULRo+Af4OaO8dRe0WSsq+H144YiuzQxU8FCVyTP1D5PYlLIJ3Hf
	 ZP7n3fZp5JvEHcJQWSsZWdQetTs2u/SJ1Fvp7606YZlVrVAPtQsRDoOQlu88simUmD
	 Z8Yf0Z1ALTSgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93905392704D;
	Tue, 18 Aug 2026 18:37:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/11] can: tcan4x5x: put tcan into sleep when
 removing driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178707823318.2194892.10223198524007434761.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 18:37:13 +0000
References: <20260817233420.2068204-2-mkl@pengutronix.de>
In-Reply-To: <20260817233420.2068204-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, sean@geanix.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Tue, 18 Aug 2026 01:24:28 +0200 you wrote:
> From: Sean Nyekjaer <sean@geanix.com>
> 
> Put the tcan4x5x transceiver into sleep mode when the driver is
> removed, instead of leaving it in its current operating mode.
> This reduces power consumption(3mA@12V) once the driver is
> no longer bound to the device.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] can: tcan4x5x: put tcan into sleep when removing driver
    https://git.kernel.org/netdev/net-next/c/c7d2577bf135
  - [net-next,02/11] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
    https://git.kernel.org/netdev/net-next/c/1802936fa034
  - [net-next,03/11] can: rockchip: add RK3588 CAN support
    (no matching commit)
  - [net-next,04/11] docs: ctucanfd: fix swapped colors in legend for TX buffer FSM of CTU CAN FD
    https://git.kernel.org/netdev/net-next/c/a0d62de8adce
  - [net-next,05/11] can: vxcan: support per-netns device unregistration.
    https://git.kernel.org/netdev/net-next/c/703b31d21e52
  - [net-next,06/11] MAINTAINERS: Replace maintainer for Xilinx CAN driver
    https://git.kernel.org/netdev/net-next/c/572e27108be5
  - [net-next,07/11] dt-bindings: net: can: Convert TI HECC to DT schema
    (no matching commit)
  - [net-next,08/11] dt-bindings: can: xilinx_can: Document phys property
    https://git.kernel.org/netdev/net-next/c/d17e20a2dcaf
  - [net-next,09/11] can: m_can: Use of_property_present() for wakeup-source
    https://git.kernel.org/netdev/net-next/c/966506838a4a
  - [net-next,10/11] drivers: gs_usb: gs_usb_probe(): fix typo in error message
    (no matching commit)
  - [net-next,11/11] can: m_can: pci: Remove driver_data
    https://git.kernel.org/netdev/net-next/c/f6a48a7b10be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


