Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420238F658;
	Mon,  7 Sep 2026 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770732; cv=none; b=X+4j11a3fVNxCIbRkfBNZgT5M7cTrTQIhD9UQPHBPan5Q9NUJSpVRSHYLrTR/rBBP1lFb1JzJro6ifJxCRM1DS1x+ScuE5SSonjH2oIZDGkh+0qWdcnyN1mHqj9vI0UsWh5R+f0eyFatWvAPAsI1lKn4egLe+ad/F3SZv0Z16lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770732; c=relaxed/simple;
	bh=FaAXurq/IRPqM0O19vHRQM1h7v5KPl9QTFVZmdPBcQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgv8fLzT7oEnCTGdIbEj1uXQH8AlYydlQw7A0TisH0g+CX9kg+exF9RFITl9A7cGq/TJX9ELwzyMcaY0hF8Vm7OmOK8hkEkw4yTSEeWHmVFxfJMD5EemrbqMDQpq0H1APBs7W3L4enwa7IKVZBgrYQpkMbIomp1trcZvlVvwn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWB61ri4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWB61ri4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9101A1F00A3A;
	Mon,  7 Sep 2026 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788770730;
	bh=9CfMRY6C+btqHlTiWd8OIUdZwnsYHsyWiOk41SLPto4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aWB61ri4ehlda/B8fFIjk1Hhvy6YOBKytcCVKJtzdcYF9KZU4wgPy0FohmFQhXbB9
	 AF7/YNHVNx9cJ2R4EutlG1zfQ0rg7OfCP1X4AxDpKDiGrjTtqB1COXbbZLG65dAc1D
	 tKFf2QisYr4UEpp0n7n+HFb3PVTepaBorQG/duRx25C+9hySII7MpiIHtwdlX9Fa03
	 d9Km+UGTfesTFLTRefDFUkAZaokSTVlRPrEsRFff1ry8RkfVgjnP3W2eiSnhxu4r7G
	 /dsZ/FZH9lkmC2+OQ/NDsGhz0BF+5Yvk4lI6E9v+NGG1N7Mqlz1d5NjexbZ+b20K0t
	 ZI7X635dRgYgg==
Date: Mon, 7 Sep 2026 10:45:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Frank Li <Frank.Li@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Aswath Govindraju <a-govindraju@ti.com>, 
	Christoph Stoidner <c.stoidner@phytec.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, sashiko-bot@kernel.org
Subject: Re: [PATCH V4 1/4] dt-bindings: phy: ti,tcan104x-can: Fix property
 constrains
Message-ID: <20260907-debonair-whispering-mule-8eee51@quoll>
References: <20260903080427.6103-1-wahrenst@gmx.net>
 <20260903080427.6103-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903080427.6103-2-wahrenst@gmx.net>

On Thu, Sep 03, 2026 at 10:04:24AM +0200, Stefan Wahren wrote:
> Microchip ATA6561 is compatible to TI TCAN1042, so the same property
> constrains should apply. But they use a strict scalar enum match, which
> makes Microchip ATA6561 fallthrough. So add a "contains" to cover also all
> compatibles ones.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-devicetree/20260902133525.E22DE1F000E9@smtp.kernel.org/
> Fixes: 05ace63d0bcf ("dt-bindings: phy: ti,tcan104x-can: Document NXP TJA105X/1048")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml         | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

