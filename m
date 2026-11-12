Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492266;
	b=nAcYzA1vAEKt8X9xHOztyqT0dpgya8u+WiJYatLvqhqpHd3WXHCMFsY1ovC+Bs9axcYB
	 hFY41INFkUuwfleFAW3f4GkJtUmZ413FxkzgKp1mjXQ88uwzFxIhz45Up77fXTeR3J2ck
	 o5TeOf6RLWA0HNTv1/bcpncAtVeMbk3SGinUDdX561ecnsbqkSfpAK0T+cDwm72OQAWTS
	 oJRlpAOmj9LFZOOya8tVhW9RRVHtYGQv4/DNnpZFA4smSp2iWn0i8dnSls5jmnntCi+gY
	 XiEw+B6FAxe9cCE9hoaaaO7RkuGavVjnGl+gPmdZXpfRhYPw5gBhOe5ecQlbqK78iZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492266;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=o4e6DKn8it+1Rse/95SmihcJknRsQkvOnDfeAvHPjno=;
	b=oeJQIVkaNLmsrhe8g5cl7tYJOgB26vjxA6jNSu3OjlXuw9ReP6irgWch+wFXg11FlOym
	 0z5R9SXagZKG9Q5b6LhkukUSYSiIbNuwSLbwzggWUVeEnjJtgc+Dc+MEw9QPdbCzyYNWa
	 Co5gRNpOW5Qc9kDinrlib5PFvWqpk/zpeGpQ98kHye0zMI6CaaBcc5o2fgI8y6Rx605Ka
	 qEVtg55Zm5PDIN9ADKSj6jGSR2Llb5cQlUHVxL0zBBptUoVtyThqZk1R6QiMr3yZXKQ89
	 bxABfryKWgrTq5xXHF6Py8jtpP8omdtos9Ep8K9gZQJE7dpY8UPcqoZTuZCI52cUWUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SC7wFltQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFCB60A3838;
	Thu, 12 Nov 2026 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SC7wFltQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEFF1F00A05;
	Thu, 12 Nov 2026 14:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492266;
	bh=o4e6DKn8it+1Rse/95SmihcJknRsQkvOnDfeAvHPjno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SC7wFltQpC0qBvf+HrMVnoSiX9K/cUcaMV+YboznfByvgaonrFSS3vntGSYRB/tae
	 bdo4I+j5s1PugdHuoTkacVr60PsW5iNQxMKss2YHFRsBz4d5uS4d2/8TViTRO2LySj
	 CdQsKYyR+cuC7LOly4VolHyFn9PWLHcDQquWPDbXpgy5iytHTeA41eOmXL3BVua1zu
	 oL1LuPCC+9hFMobz+GT0dyigZiMka2J22dh/k+QG1rZoxYkVt9jzx+tMsTfUqu+K1n
	 W/FThAXAuhZfwfV0VKLshZ2lI1QYRh12sIv4kdEhHLopuqeAipri3PDbii2mp8hWxq
	 Zn2eL6n05G3Uw==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Stefan Wahren <wahrenst@gmx.net>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Vincent Mailhol <mailhol@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Manivannan Sadhasivam <mani@kernel.org>, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20261112130506.12823-1-wahrenst@gmx.net>
References: <20261112130506.12823-1-wahrenst@gmx.net>
Subject: Re: (subset) [PATCH V2 0/6] ARM: mxs: add EVAchargeSE board
 support
Message-Id: <179449225983.539829.932909223688582860.b4-ty@kernel.org>
Date: Thu, 12 Nov 2026 19:34:19 +0530
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 12 Nov 2026 14:04:59 +0100, Stefan Wahren wrote:
> This series adds support for the chargebyte EVAcharge SE, which is a
> ISO 15118 compliant controller for electric vehicle & charging stations.
> 
> Changes in V2:
> - add Krzysztof's Acked-by to Patches 1-3
> - align writing of EVAcharge SE (reported by sashiko)
> - add "dts:" to subject of Patch 5 (reported by Andrew)
> - add PHY ID of LAN8720Ai (reported by sashiko)
> - move enet_out clock to MAC node as in imx28-btt3.dtsi
> - adjust IRQ type of PHY (reported by Andrew)
> - add new patch to enable EVAcharge SE peripherals in mxs_defconfig
> 
> [...]

Applied, thanks!

[2/6] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2562
      commit: 06f194589afdf29e85176b358ecd5a38aa467a95

Best regards,
-- 
~Vinod


