Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458258;
	b=s27QKuo5lY5+7okMZvIbsZxPVg5b6tCZjiRKPf/jxtx9UVlBRYebKZBYbvSHAmW7iTq7
	 m4q7jULbxRWwUnjWhzKHiHOBNo0fhDMvGFVx9R7x68oaYXmw5YU0D+oxA9l6oY/1oohKW
	 hxMRIJqvfh1vM5iiCC6p1YvrGbfVmkQ6I1pNm4bAIX38Dnr6cqi8rUVCWn8m57QqKR7rK
	 3Q2u/jQYRgH5+uT7kOnLI+ptZ/CaheuGJQm6oSCYEo2yUfdXOU4t5fsnePP9qIBQN/Rj1
	 uAHDYUr/rZxFKiMV/jIryHtwXqWlBgDUaToP9WqALtGKcaG9XX9WmZXtZyEzWv9lmKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458258;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=4x3znO0+A48yLudJ4NaQaLjUOCpPf07J9g6Oz+g4ayk=;
	b=1RP8rH9N91MKd3PVugLxHrTorvhy3TeF1GMoBGgPHpjjZr5ZgIW5A8A0zwBGU2YmfVcr
	 gjnqnSnFSkOLdXYeLc1RGw0h4fxN892/M8onuvARvkqTJq9/MUSeiRD7mQIMMlD43MZru
	 dKCYL8JyTccO6a/KA/mtsfqKkyYLOoOQI8b0yEMX42BwKD6oBcuaDdqkq3ho83gtVlgCf
	 +4ZpDqiWamuCTfYo/dxP5Kf2odkkXdKAKy9oSv2BJZ62TkucWPI67DzStAyXf3V1vTFOR
	 uHWjbSNbmUTf4yvVPzu7OsxxFQOaJoO0X0mLYIorvtqpWoPVWOjs7svdeUoLYqpsUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=ibbd0+gS;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B158606A321
	for <linux-can@vger.kernel.org>; Mon, 23 Nov 2026 18:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B158606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=ibbd0+gS
DKIM2-Signature:  i=1; m=1; t=1795458255;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:MHlEIKGxy07UtrfIbiO6SQsfNM9F
   T5uJrRs2VLOt1zT6+mxBKs7/htD/yi9sXRu0pFIHRD3GY80I40AIAnAu68UE59GocqCe/Gk7a3+
   aUDiN6noT3IWiBIhn/aFsA0RYj1OEVGfdNenDvbmxs/zGDrKBitfMMh9bf10oJwcYgVYAepo1zk
   1Ae6djZcOd67XgNHJ9YdotZC8pbBInvvgUiCNsjjrd/ncLQkBF5kEByreBiXX0H23OG3Ym30ard
   xUHELJysuqW1q079t9RYpswoMfsJ5NF4EepKPl48UapsFhqa/enX5rYelRpOnGZ7lnM0VRkFElG
   d6oy7ICrgYIMNA==;
Message-Instance:  m=1;
 h=sha256:
   OddLM3Kq790pctE/NEFmoOsRstIcsEExA6R7fzsme64=:
   njRanQqXRE1PrUxIiZNADiOE6dSecHnZaSU7TeORaHo=,
  sha512:
   nchFMIxkQdn2/piQclaX4+5BN/9x9FCUL9Wx7m4Pq2EiZM8jsYE34tjo5zn4l2xXH4sAr8Y5YbYWP9FlALOjJw==:
   OecmnPTkS8sT5WKhzMs1LHDGZxW7rnGW64zMwHOvCcN/dtUG49WejJYCB/Y/vuwQEj0x5nS3rZF0rpqFpz0eAQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1795458169; x=1796062969; i=wahrenst@gmx.net;
	bh=4x3znO0+A48yLudJ4NaQaLjUOCpPf07J9g6Oz+g4ayk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ibbd0+gSvnkmbd9vY+S+5pdBQcFgPZQPWM5V0fhs+YNSUVfjHnUers+LKMObT/LW
	 7N0FMaPHDvyWLiVNY+szOUa3wbCQIBaB46YtMTjUfqaKIM4vOpRpEYkExqGIwchFH
	 RxzOt+kt7/rk5HTpJkVeSgNFw8sWxabPtiratJXmiOhee3LmWM+dLnXKSzsmjhTkF
	 1w9N9tR7c7M6TQleO7KwX6KvMCTnaS8lSnZoBsvBpBFCj05k0SHxN0W5rYzfNgQ3v
	 60TpfCX1w+9vS8YktOUEBXxUJbwfM1tzZePNTDMLDj+rqujAW9ahERuxakYDZT3I9
	 dTvhKN3Y4QQnxyoHZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1yZGFa2UIp-0134CK; Mon, 23
 Nov 2026 19:22:49 +0100
Message-ID: <5e2563fb-bc32-45e0-88e9-71ddd1d8b1d2@gmx.net>
Date: Mon, 23 Nov 2026 19:22:47 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/6] ARM: mxs: add EVAchargeSE board support
To: Frank Li <Frank.Li@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Vincent Mailhol <mailhol@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vinod Koul <vkoul@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Manivannan Sadhasivam <mani@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261112130506.12823-1-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20261112130506.12823-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SxSBKz5/Qm7KbSFlbc+wsrq+Ahtg1xKh7TjubowVfmLUECkvdFf
 YOmIjWgj0nS9dqbPa7VT6Fngz8R0wj0SBWD9avPaYXIFSNk4dVNwYte5hf1EEOXUVkR2Pnh
 KXugFioMFBhjnQDwVuLzOacO7xf/IBt4Q8OmDh4tELBNp8WT6TeZgVPiApZrgrTgf5S4Yep
 Eb5kd5hxvJxYBGc7Z1shw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lZAX0ZXKaMc=;793Yt5dfmQAEusepIriBU2ay4ax
 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
 bbTJbjkT9NbAW7CEcxMUecQ=

Hi Frank,

Am 12.11.26 um 14:04 schrieb Stefan Wahren:
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
any remarks to this series? Vinod already applied Patch 2

Best regards
>
> Stefan Wahren (6):
>    dt-bindings: arm: fsl: support chargebyte EVAcharge SE
>    dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2562
>    dt-bindings: gpio: mxs: Allow gpio-line-names to be set
>    ARM: dts: imx28: add alternative pinmux for CAN1
>    ARM: dts: mxs: add EVAchargeSE board support
>    ARM: mxs_defconfig: Enable EVAcharge SE peripherals
>
>   .../devicetree/bindings/arm/fsl.yaml          |   1 +
>   .../devicetree/bindings/gpio/gpio-mxs.yaml    |   4 +
>   .../bindings/phy/ti,tcan104x-can.yaml         |   1 +
>   arch/arm/boot/dts/nxp/mxs/Makefile            |   1 +
>   .../boot/dts/nxp/mxs/imx28-evachargese.dts    | 295 ++++++++++++++++++
>   arch/arm/boot/dts/nxp/mxs/imx28.dtsi          |  11 +
>   arch/arm/configs/mxs_defconfig                |   2 +
>   7 files changed, 315 insertions(+)
>   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-evachargese.dts
>

