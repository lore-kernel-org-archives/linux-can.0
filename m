Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121494;
	b=PhnLSWjNIAQ+OVw1wO84hFQurgxzyX2q9x369cK95SsLqqXQN9jOPeF1ylt5iBvd6DoL
	 PkxmzepWTdgr6cB346v/qsujXRCX+1EBDbybT6ldfcTGe4GsTsitevtaCfi2cDnsEwkkx
	 uBc1JxC3pESbO1r/FejveQutTqHiNR+NUNmQrL5eGInYYsfNpZfjeFB00LuKccnjcfhW/
	 8igpkjSE2jmOIJYm6W/GyQO/JTlzCOviMb54xxyPHgY4Olj6QYABS+Gu5q4betFqkaIJA
	 2o/LpqNOO/9mhxqoPnAXa1faY6fEUm0cE+jjlK/DheA3SrxQhE2pcpebiE+igWAKnpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121494;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=2AhgxjpsSrdIp3v7Vm9/tI7GXfZBUU0A8emiVMRDe1Y=;
	b=z9tskEUgWzZRzYI6fXy4P+TFFTRwOLUI9Am09ZQUlPlqfDs2ElrwAkxNHKFcosDVNnzX
	 ojcCNQfTbpzdRpczBzqPVDyar6fYJWAiak7vcOp244QCl7GgkVqm4Y/5NlTFy0lPMxI2d
	 DceRfGMEIma4bjJTacjLn8r5TgKrnDBnmQ3OFddm21JT41ObDXjsldRBSixqlV3WUy6HS
	 OR0uQubPpHHObSS7LnUO0907/hYe5hycYgp+3bkUBDwCX+Rfh92H1TaA8+mC+wM2nCf8/
	 42eyCYyTYGYVNP1xNMIHpm61xcYIoQRSDBTXglAar3u2cy+mAwZ5Zd1Bix0INIrVzAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=cuBwKMs9;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339A606A31A;
	Tue, 27 Oct 2026 17:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7339A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=cuBwKMs9
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04D35108D58;
	Tue, 27 Oct 2026 18:18:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793121487;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2AhgxjpsSrdIp3v7Vm9/tI7GXfZBUU0A8emiVMRDe1Y=;
	b=cuBwKMs9MSlJwuxyuBzukuPRq4nyr+PD2+XAG+5Mrfpivg6CkaDvPJUaTlihGzEBVqPNPg
	vp/Oef/DMqwsmFyYU6aHqdiJZx1f0Nc1FfJiBZjWTCo0aWhl9ukoNcs7O0h/aWzlO4yU4Q
	SZwOhx58k3ejTwG9KwmU3rJ5rDgT3TD3pp3z0dLyVUieJv2gOL5b9BB7Qw5F8H4VK7MJGp
	LRbL52txxSsxbZXYQgORwx4VIeVgWDCy0cTZysihyBMZDL55k115D0G4kAFJagj4K2EMLz
	/llBrGMjsh5UBjbE50L8yvAm2mG7xRAnqp6GQh2dQjCol4QHB6msL4yN2cAP9g==
Message-ID: <d8c3ca76-3d93-4abc-8a78-d23e0f018975@nabladev.com>
Date: Tue, 27 Oct 2026 18:18:02 +0100
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
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6563
To: linux-arm-kernel@lists.infradead.org, Vinod Koul <vkoul@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Aswath Govindraju <a-govindraju@ti.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930214729.809649-1-marex@nabladev.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260930214729.809649-1-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/30/26 11:46 PM, Marek Vasut wrote:
> Microchip ATA6563 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042 and has a compatible programming
> model, therefore use ti,tcan1042 as fallback compatible.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Aswath Govindraju <a-govindraju@ti.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-can@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> V2: No change
> V3: No change
> V4: No change
> V5: Add RB from Krzysztof
> V6: No change
> ---
>   Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> index 0cf5fa21106b6..e97b1bc0a2e45 100644
> --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> @@ -18,6 +18,7 @@ properties:
>         - items:
>             - enum:
>                 - microchip,ata6561
> +              - microchip,ata6563
>                 - ti,tcan1051
>             - const: ti,tcan1042
>         - items:

+CC Vinod, is this patch OK with you ?

Thank you.
