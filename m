Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977E3EC2E6;
	Tue, 18 Aug 2026 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078555; cv=none; b=jXrUhEDzXJ1jQL/waJSKKmbQSkJ3ATCVc3ljKBS294Je87mvKl+wWR43US+4nQWWn5Q056MDB1ejHWXuRwju/GEhNSjzk3BKOA653mb1waxn+H5PqqSm8qhrXIZIZl2Ude7klCF/rIFIs/1npl369GTPNj67UEWUa8gkGvQNAO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078555; c=relaxed/simple;
	bh=O5fwIS9pjZ7kl8UpzpKJ5vdTIp03psY2FpuylCb8toQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GY6X3AiKF3cyAQLXBzol6ACjBrk+OB21iGx8Aman/vlzdgKfq/OPQUeIvadVjH63PNsMAYt3HkQCar3N3/G6XOYsmd8MFhhGpsL3hKd+M1NHOs0EgRLA02WhSozhHNaIlr/KC2fCJiUR3AKz/q8RQO4lPhCXB+gwHWmb7UaEscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3mWQtKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3mWQtKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97C71F000E9;
	Tue, 18 Aug 2026 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078553;
	bh=/aAAw/5sL+lsgbgkh7rYODJs3bA5HDkXLNCV87tZH04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E3mWQtKFVLviNpNAyn8i5nBTAJ4iEyd/IExjYjERe9A2XrlQCG0vGDZ7+HmooYDlu
	 5OujAcOBrqry1JNdfwtBAd4Ze2jUASx4DXgwuXmp03vAZTu5WWZoCgRlgP6jBunUk+
	 80n8aUpb8AFirVuLyeCSFgFHlDgJrQyoqznNw7y5kmO+P8Tm/4FM5UlKUS/ifkVnS8
	 SBTWpSfqIPvqg7PiTz0owhi1fE/YS52xSkqK4xoMV9T749ouqG3BdcmfUt4lHE8ivG
	 Sca70vOlk3bEJmUO7MBgwYIVH/158xTZ3nX+YgjKdNC9SMfhvW2w3iuhopDwrov3RY
	 59jH6R41+3ufQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C6392704D;
	Tue, 18 Aug 2026 18:41:46 +0000 (UTC)
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
 <178707850515.2219101.2097137917698542123.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 18:41:45 +0000
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
    (no matching commit)
  - [net-next,02/11] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
    (no matching commit)
  - [net-next,03/11] can: rockchip: add RK3588 CAN support
    https://git.kernel.org/netdev/net-next/c/b7d51d9b14ee
  - [net-next,04/11] docs: ctucanfd: fix swapped colors in legend for TX buffer FSM of CTU CAN FD
    (no matching commit)
  - [net-next,05/11] can: vxcan: support per-netns device unregistration.
    (no matching commit)
  - [net-next,06/11] MAINTAINERS: Replace maintainer for Xilinx CAN driver
    (no matching commit)
  - [net-next,07/11] dt-bindings: net: can: Convert TI HECC to DT schema
    (no matching commit)
  - [net-next,08/11] dt-bindings: can: xilinx_can: Document phys property
    (no matching commit)
  - [net-next,09/11] can: m_can: Use of_property_present() for wakeup-source
    (no matching commit)
  - [net-next,10/11] drivers: gs_usb: gs_usb_probe(): fix typo in error message
    https://git.kernel.org/netdev/net-next/c/3392698d3c1d
  - [net-next,11/11] can: m_can: pci: Remove driver_data
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


