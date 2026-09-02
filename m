Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA1472796;
	Wed,  2 Sep 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347500; cv=none; b=oHUh3onqnXe7xqLFAuzlW52rhb1UI1L6ewsBUswSZK9ydXEduufUcXhsePC0wnB0sMLMVm8uvv6xoZIFvR7TaObGun1XZ9DRvfgZxk6IYvl8Np4KUq9Gl/ME3+6gq+yE779QRBudThttzPbfyO0yTZrWamWjY9vXi+CGHjsnYqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347500; c=relaxed/simple;
	bh=WSdzyMZuWcmtOLgej9ONorjM7VnDq3klj1YSChAasP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esnBt+Rrqcow2mTJ9AJ3NKTg53BR6LGrHndj0ZoO/SEa64YAePGVhpT3kSI0fxwR2Qx6PmFm8jYTfBIjPsyripmyPiFENMGarOnQnksxWEfm4njWyyb0vg0ytCnfBbEOc8+9UFW3lJ/ovd8df7aYybcyawFmumOXaIci/I4IXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=H0QaVw5Q; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="H0QaVw5Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=e13hcDNI+tjK7ZYito3EK+F+gJpiQQy7yUGftOidPTo=; b=H0QaVw5Qja/LxL3EoDTsZSAWu+
	DK9KFWSCKqQug6/BxhFEznFPH/fb8uU+FKbmdcmGIJI8l7KZxIVVAK9cnRtqjmT1StRVezLK4ows1
	ax/aQocKpxQzM0sEV5+ZW1RnbtyO4lylYn+Ot1lL1LQY/I4dktFtVXXuWMv/ScYt71xnXh+/+Wgyt
	NFxV2Wxct9H+/9xCIV/NoXgBsy3vRKRrSpitX1seuym0/ZoHxX3pLC/RpNUJgSnkOaTQFEwE2qtMl
	wFnO0cNlZeu84wAPHLH8uFgJSBSEKC9TghfFt8sA78yOqRwkC+svXiAi9OLpcoe6+w71YkDZOUcsz
	A6FYh+qQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cunhao Lu <1579567540@qq.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v6 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD compatible
Date: Wed,  2 Sep 2026 13:11:12 +0200
Message-ID: <178834747221.2268650.16431820094445507549.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_AE1A1199FC8C9ADC680C6458134A46B40309@qq.com>
References: <tencent_AE1A1199FC8C9ADC680C6458134A46B40309@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 30 Jul 2026 22:34:02 +0800, Cunhao Lu wrote:
> RK3588 integrates a Rockchip CAN-FD controller variant that is not
> fully compatible with RK3568v2. The RX FIFO count register field is
> encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.
> 
> Add a dedicated rockchip,rk3588-canfd compatible to describe this
> variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
> would describe a register layout that does not match the hardware.
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: rockchip: add CAN-FD nodes for RK3588
      commit: 685b81f8c717b0f7ec7219f35ead626758ef3aec
[4/4] arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou
      commit: 0fb792388d2d39e35b7b366f491f846a7ebd8630

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
