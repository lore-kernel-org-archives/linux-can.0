Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBF483BEF;
	Thu,  6 Aug 2026 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033602; cv=none; b=f6mY3isBi1KmCuPZc/Oymrlsxv6SYB3h9unF6Q/BL/nFu1f3zwzCmlzsOXHeZejjnFowgQDM/tSGCkChUIfxWazfhb5g0w2WI3PMN0oIecDHNyuKEIRGnlv95RVC/OKN3Hzz4AwerHpROfTi0udd7vBWRSjHwPjd+xBhYsNA1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033602; c=relaxed/simple;
	bh=T0VPQvTvxTwSb7LVPQVSD8L/B+RvfcK9IIREKofM3LA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NP19vMBdMiidu2Z3hGkiaUcsWgMAGRuR+QJan/xQQsWH7EIdptTt35YHFeqIqzjxzYkbuSDcK/dNr3cmOaHPENusoz1y6wRg50BS2Ym2RTeAnbwLVgLLQhZVw6eIFa13pQMieeOoH+2xjkdqPoPxv+9NczLEU+BqHxFszfsN3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3NwEX/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3NwEX/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049671F00A3D;
	Thu,  6 Aug 2026 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786033600;
	bh=XllXt40MUZTpJoHsg0rQ8AaWK9M0xp6NH1sMMydFWzY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=l3NwEX/z5skYEOOPYlbVrKK/LpoDHH26KZvyAzb+p0dwEpi2yA4MOzDaeePfICbpz
	 2o+0GqyrFuK3bGQ2xUpuhS0qbz69MNtN+ETiaumch3AEp1MCCraAVcFRIKRfr8eI05
	 1NlZxgNGX3JuOIRmRZWiP8JXT9GpXqz/y5pRNXFWYKZpD45OOWknZ/c7ominD3VDzr
	 KNrTgADqCkgRW+Z42vUNBy8ZFhar3DjydPyM/idNnkHxV/3HDAqY7b6qLsCHILywAi
	 OsIAumKY4cwrSXt1/ksHedWBwwxCJc4/i29zo78kxSukK4TeeDgfzOdoIMDPPtzruX
	 KqOWNB/67eyiw==
From: Vinod Koul <vkoul@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, haibo.chen@oss.nxp.com
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 Haibo Chen <haibo.chen@nxp.com>, qijian.guo@nxp.com
In-Reply-To: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
References: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
Subject: Re: (subset) [PATCH 0/3] arm64: dts: imx95-15x15-frdm: support CAN
 transceivers sharing a silent GPIO
Message-Id: <178603359460.674490.14449067344629912709.b4-ty@kernel.org>
Date: Thu, 06 Aug 2026 21:56:34 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 30 Jul 2026 12:33:25 +0800, haibo.chen@oss.nxp.com wrote:
> On the i.MX95 15x15 FRDM board the two CAN transceivers (attached to
> flexcan2 and flexcan5) share a single "silent" control pin, which is
> routed through the on-board PCAL6524 GPIO expander. Both transceiver PHY
> nodes therefore reference the same GPIO line for their silent-gpios
> property.
> 
> This series makes that sharing work correctly and puts the transceivers
> into the proper default state:
> 
> [...]

Applied, thanks!

[1/3] phy: phy-can-transceiver: default silent GPIO to high during probe
      commit: c3b0bb15ef001703b00d79bc4928e7421e24280d

Best regards,
-- 
~Vinod


