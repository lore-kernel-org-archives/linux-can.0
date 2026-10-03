Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774EE377A89;
	Sat,  3 Oct 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020222; cv=none; b=mC6vyebFO+I5tBfgBtPJmLrOju0wOIeDhXdago9Vl8SYOpnQ26ml6QVT8ibANwLBNo/VKA5ra06eyvPpz7cPBQH++03xWeq7dn/z6EOVVgEVUgq3lUf9HbNMII9NemLRCLslZiHJgFgBSNTrDfMpBpbFrvQh/jM2IhWpBzl/M/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020222; c=relaxed/simple;
	bh=QhxxCJv+arrds0ItGOOvsuX4qjcWl0kj2P0vHSPmv/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T1Yj0/5V5ttEbqWAA43TxTCmR/t5YLmfYve7Csc4ulKMJrb0T5y3GOiOeY8gjwCvTXM2XLehLCpshoTtBL8VHlEg2bnfs144+TmMLxY2ePWYtNrC5jo0ntm5KwXBR4izLAL0HAozGAKlShRWCkvsACD+6xxuQZRarY6k/jopYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUZj4lw2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUZj4lw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F5D1F0089D;
	Sat,  3 Oct 2026 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791020216;
	bh=57cvkcIoJzzm7zcSu2Zd4zEuzNCdr1C6KzAfCkfcuXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HUZj4lw2Ddt9xyc1006mO1rFn8o6OEoIBPQXj2wx07MkK4xtLDJQcLy02RkRAjME9
	 TTht8/TrGtK532GbkDqwXM3HlAuBBM1obmNWGR4ELJJx3CtWcj/peYIJQG+6iDMkES
	 XbKiLlV+Xw1gtxYRbmYCikNooCMye5W3ztclMNxD28Jd3UHMnLR+T5RkkxyfGKEc/u
	 3oTq4nNrgDZPuFq/zZWSCOSMaw7S2eK6kKr9Zwg7Orm4pnm4/K1YgJyWuXdkCEx2zX
	 UuAgArCjOQfxOQvRPdgH9g5jD7C45TdIcXdWsGGFedhJ03+Tb5aNk0WRFopNmV1zBB
	 pCdA6jxBveHmg==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aswath Govindraju <a-govindraju@ti.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Christoph Stoidner <c.stoidner@phytec.de>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260907150420.18787-1-wahrenst@gmx.net>
References: <20260907150420.18787-1-wahrenst@gmx.net>
Subject: Re: (subset) [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte
 Charge Control Y
Message-Id: <179102021250.199361.12700555463820856458.b4-ty@kernel.org>
Date: Sat, 03 Oct 2026 11:36:52 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 07 Sep 2026 17:04:16 +0200, Stefan Wahren wrote:
> This series adds support for the chargebyte Charge Control Y, which is
> an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
> Charging System) charging stations.
> 
> sashiko reported in the first version of the series [1] that X_nRST_LAN
> is available via GPIO line names, but there is no reset mechanismn in the
> device tree. This finding is valid. Since the reset line feature isn't
> implemented for LAN8651 driver yet, I like to proceed with the current
> version. The LAN8651 handles reset via SPI commands and in rare cases
> we still have the possibility to control the reset from userspace.
> Btw the pin has a pull resistor in hardware, so it's not floating.
> 
> [...]

Applied, thanks!

[3/4] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542
      commit: a1aebc3846c37ca54977a79ef3af2f667a224891

Best regards,
-- 
~Vinod


