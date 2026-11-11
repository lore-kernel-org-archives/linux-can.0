Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363165;
	b=VKAJHyUg74libFE/G7lxSLRWzsugE7MJYW4q3c5uSO3KZz51taTX4M9Zk5fiJCMAfAuK
	 uUNWV2Car4ekwINkhGn3ByTTUyHQkMMrTU3ULulA0SKSglxEWt2MJskotIrnrS7qWWvvA
	 mrhTpCqeoNOgoJRZgbjmdZrb7gj2/fVk3Yzy7tqc5dmCIZQIPVqqNgcASgkp5bhAD5uAT
	 MD3aw22gGbvHy+a9BENwiUB2NLLr3HE/KHa3gQNC3bmXPVOUh/TvVGzDlYM4koppKUvW1
	 MTUVHoV0DYP2XNPTrQTrcR6mVO2ZdokI31wjQEnbbtLuylSuceC3XZ28JoZt2hUCqBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363165;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=DuqYtNneUEuH9evPuapHLCBL5pEX/5BkjSDOaIOKRgs=;
	b=mVVJCksXnJ/t2PeypLEqkY6W2Cug04EO1ZVecWCIPDvrw5GFlooTkTSAdEWyftVeELCN
	 IukppRhD7aXS4R/+J0Z50zQHnQ06IvRFkwobZK2NQci8RzYpayLuLjs1/Bb68CZhNr+gy
	 Mzs0eW5ABe0I4ua/MsAK4vvDvuPC/mZ79ypNqv/u77XicZziOlD/NOrPjzfZTRyN6St9W
	 1sglvZqeN3wucsI0oD86HsSJVZe9iNc+JDYhwYk6Ml0XI5nQ4a1Hi0bP7ha9aMH+pOYQU
	 KoYt3L43pMyrCGlGiH2G0xgIo97zLHAqJ9NyJvT6zkmPO0hViRafDxP+DAW+CNe5kVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=UWgDXJNq;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE189606A31C;
	Wed, 11 Nov 2026 02:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE189606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=UWgDXJNq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DuqYtNneUEuH9evPuapHLCBL5pEX/5BkjSDOaIOKRgs=; b=UWgDXJNqXBh/YLE2LI9GNZiocG
	c6UK7T6Q9IcIIj2LbSO7d6OKp/KBBFzGh3zomvFgO2F7bIGLlylRTiBMEqiIWmGLzWsa6XtM58Jce
	I90WnPA63oR6I7RURgkzBxntuZ7iNGXqdjZ24pNFh7J81WjQgG6gTUJOuWf1i3D+/nYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQxpH-00Fd71-03; Wed, 11 Nov 2026 03:12:39 +0100
Date: Wed, 11 Nov 2026 03:12:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 5/5] ARM: mxs: add EVAchargeSE board support
Message-ID: <61d1cb97-5c8e-45f1-8c01-1745e768e4e4@lunn.ch>
References: <20261106230746.21954-1-wahrenst@gmx.net>
 <20261106230746.21954-6-wahrenst@gmx.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106230746.21954-6-wahrenst@gmx.net>

 +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			clocks = <&clks 64>; /* enet_out */
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;

PHY interrupts are pretty much always level, not edge.

	Andrew
