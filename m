Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793170772;
	b=P5emj71gI+6R3IJxH4vbaKj4oLT1C/ERpGzs0oZdMcPLJ1XMqalqh8lzlyYgEodXbWst
	 xPFWv3xopFcePbuTGrlDy6Mvbij787NHT/ONa69X8g/w5XZkE/mu4TPgoXwZyRSko/O0R
	 kEO9kkA4f7lbiY8bssEgaiebH/1fw1mnGtAdhKpnBfS+plUiJSFUrgyhtMITBrb1Oxyn+
	 54Boj5NYe+ujFVkXpADKg3uzMvLQ0zPpYqyKCoh5BVAgavDkDdMzJBptciZiG2en5ovjd
	 +p/RoS3y4KSsgQ2XOoriSNM9Ytt9VS3wGtvqxgPnM34XGFJ9emBNk6spXkO6iT2N1dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170772;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GVHE714RG7i9OtS3pCmu1vAiNQBVPuk8379998KPX34=;
	b=qSpQjfEfoHi+jvXbgs4GlC1CIDvv2VpeZcRcAh1jZ2+6sI0Glv8wbZZNMjI9DFPEnqZJ
	 fK+EDK2i30NmEu5PrwK8nK0zUT/beImq/JMuk+NxRR1d9LEOYSPhzOeWVGpOGytRCs24p
	 HyvtC1qwALVtkpz1jZ+a1wocdI4CH7RgxxY6+HRkODLqcRMQOIS5pyqFCKAjRhggKPy6p
	 MnqJZkzEosALqoms5E7kK/0P/IlsPniDlG+uI5Xpi8i/7CuWvvv08DJcBRTePxC5L4dzL
	 wIG2/Fzn1iX9UUH6bG45q3YbNDxlBOCI6HT0B72D4TqJNQ0UPObnA52ajkAUBMqpD6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sp+93WvI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E7606A31A;
	Wed, 28 Oct 2026 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sp+93WvI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F24D1F01825;
	Wed, 28 Oct 2026 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793170772;
	bh=GVHE714RG7i9OtS3pCmu1vAiNQBVPuk8379998KPX34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sp+93WvII8ZYXlCPlpMElqzLpKTJTarLzctoQWFyTwA7qi799Vp8Tf7L+ArRC38zk
	 RKQdsbWBVcU8n3/LbKDraRTkNUKR0cLYrYsVVl1FCC7UgdsbOiBl+1UIBSp8tV6BHr
	 XCS4b5c2FWUJ5qCnTuA0wNxjAgMaZaDUUH5GuwOzg+sD0EmyDWKFWyzBMp3y0pNT70
	 bPslosLMNB/CpWw/wpZAoRtgqG3BSY9iSW9EMWnUfWcSAdZb9+NdKk61oO5og1YVmB
	 IQZLH5rd2Cu7o3PgXznKQDSSjD4Q+/RbZ+yaujdcBwTu5C/ZtShCEo4l6x/BEE8LmJ
	 D/uf5ZtkfTcpg==
Date: Wed, 28 Oct 2026 12:29:27 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6563
Message-ID: <auGdT2kdxwfbB_ol@parshuram>
References: <20260930214729.809649-1-marex@nabladev.com>
 <d8c3ca76-3d93-4abc-8a78-d23e0f018975@nabladev.com>
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
In-Reply-To: <d8c3ca76-3d93-4abc-8a78-d23e0f018975@nabladev.com>

On 27-10-26, 18:18, Marek Vasut wrote:
> On 9/30/26 11:46 PM, Marek Vasut wrote:
> > Microchip ATA6563 is High-Speed CAN Transceiver with Standby Mode.
> > It is pin-compatible with TI TCAN1042 and has a compatible programming
> > model, therefore use ti,tcan1042 as fallback compatible.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Signed-off-by: Marek Vasut <marex@nabladev.com>
> > ---
> > Cc: Aswath Govindraju <a-govindraju@ti.com>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: imx@lists.linux.dev
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-can@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > V2: No change
> > V3: No change
> > V4: No change
> > V5: Add RB from Krzysztof
> > V6: No change
> > ---
> >   Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > index 0cf5fa21106b6..e97b1bc0a2e45 100644
> > --- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > +++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
> > @@ -18,6 +18,7 @@ properties:
> >         - items:
> >             - enum:
> >                 - microchip,ata6561
> > +              - microchip,ata6563
> >                 - ti,tcan1051
> >             - const: ti,tcan1042
> >         - items:
> 
> +CC Vinod, is this patch OK with you ?

Looks good to me, I will pick this after rc1 (monday)

-- 
~Vinod
