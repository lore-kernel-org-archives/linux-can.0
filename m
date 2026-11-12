Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493411;
	b=xIzO/zTLVjK17z3lhCYnhB8Mg3ibAG37HJJ+QgRubip3Zvdm4R3DS35l85q5TziW0MQh
	 0a0e2tkt/pguPe7qmV5qld/moHScHRiHC0OhYWAd/Y642eEdH3p28pr3y/d777Yyzkwd7
	 C77S6bH0Jo0GAOqUIUGQK0MzEa6lCPRdvdA7LuMv0o50Eh1tSY2R9Iwgiv55U3bV3HYGo
	 YxJbBI/7N2wu/DPSi4sz7KLmIr3LM5VAYweWfO3tEwAu5Te7mpgz/rrIcPBv4u9DvF2Xm
	 6U/BqxUnGUG8/hvFUx2QedVtVxqf87aFOmosYQr0X99AoUKOj7zDvai3NP/6ed1Ueaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493411;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=9gXiTKwhd0i3FmOeF109/if7WExvzUv7qcneIWltTw4=;
	b=p07NXsYUSKZnIEKD2t2y1xoiCtVhszIQx12l9uF6yfs2Q5l9ZnX8zBo+G6x7LdOCzQHE
	 eCgLwpbUb+kF69s5j/ikwe5ASgtzirTYJvXNAbmJOwaenoEaqPy0pM/0voAjOTART3jPb
	 /USCxkd+HgieMhET4PB7g9MOgQ90TImLJhtx1fSI7CIGS9nROSoSeZwQ9eCEMcx9iec0G
	 TAkqOxlrQ2qNhAY3nFQIiSf5BcKFTUfhcRi/MY5sGHh3y/SlD2SppzZJ8gEcyYL2WbkZG
	 RlnBRWgVuTJRRdHS53aNQbrPRW6egl+0d5BqNTQF7cCnalSRP/qRIERJknXNQveINXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GkM8K1QJ;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298BF606A33D;
	Thu, 12 Nov 2026 14:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 298BF606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=GkM8K1QJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9gXiTKwhd0i3FmOeF109/if7WExvzUv7qcneIWltTw4=; b=GkM8K1QJwEYb9aj1af7OXzpN/G
	g5/5QCVE6DP0q/LKaEPIJTuDFHiIOj6a6I/AgVt9J9E21WMfjotLjCaUmL7RtVSuSIDQag+Wgil14
	NsMKr+8wvC+9gpqaUbXyB7NMVW9yQ02S67CO+kHdejDpBBDi6aj7c/JAMTSDGHkBra2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRVhr-00G2ck-B3; Thu, 12 Nov 2026 15:23:15 +0100
Date: Thu, 12 Nov 2026 15:23:15 +0100
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
Subject: Re: [PATCH V2 5/6] ARM: dts: mxs: add EVAchargeSE board support
Message-ID: <bf6040aa-9cb0-4566-a2cb-f3edf39bf4c8@lunn.ch>
References: <20261112130506.12823-1-wahrenst@gmx.net>
 <20261112130506.12823-6-wahrenst@gmx.net>
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
In-Reply-To: <20261112130506.12823-6-wahrenst@gmx.net>

> +&mac0 {
> +	clocks = <&clks 57>, <&clks 57>, <&clks 64>;
> +	clock-names = "ipg", "ahb", "enet_out";
> +	phy-handle = <&ethphy>;
> +	phy-mode = "rmii";
> +	phy-supply = <&reg_3p3v>;
> +	pinctrl-0 = <&mac0_pins_a &mac0_phy_reset_pin>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy: ethernet-phy@0 {
> +			compatible = "ethernet-phy-id0007.c0f0","ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +			max-speed = <100>;
> +			pinctrl-0 = <&mac0_phy_int_pin>;
> +			pinctrl-names = "default";
> +			reset-assert-us = <500>;
> +			reset-deassert-us = <500>;
> +			reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
> +			smsc,disable-energy-detect;
> +		};
> +	};
> +};

For these nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
