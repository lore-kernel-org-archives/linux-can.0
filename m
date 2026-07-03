Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6421D32AAAB;
	Fri,  3 Jul 2026 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060756; cv=none; b=h7rHzaoiDeN960/8YQs/iyFXStYy75YFPVg3YzoZny9Qq3rVfCGNDpM64BWa2caU7CHORlNNQLXqe6dnid7FsfpgdepMktTLodqjLLmGGPOZQPOLfQJ8p2afvUevFr3rkPO7wv5F++pydXnp0ACT2g0h5yy0KYizHkejofpl7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060756; c=relaxed/simple;
	bh=6BxbcMdOIcZsfnhqpZbwKAM6k2MH606Q9Oi22O3Jxpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev0gerzOIyCrUm6UXcYucH3MaQiOx9UIc31GtaIn39M2SbVJRrQTBbfAp62XXXflA5hY8yROInMOK/qg9+5PFBkOFy+bXJtfDsUPquNVKDOepq3+DNxZ/ZuvniFrkGByUN8P/XUNlZx6vmx18VFoHxtOdUnGBX9OYVQ+WQ7jlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXA1EWj8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXA1EWj8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174F01F000E9;
	Fri,  3 Jul 2026 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783060755;
	bh=D3QWF9QEhp1MYt6N9b3KeNj8xni59MRNrkc85etaxMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DXA1EWj8RozS1lVUZfUQ23DjASd/q3OBgJzO5YP2g4jyXPNQCs2o6DbpQW/QPcp5p
	 oX/s40PFzy+bCCx+bhYnj4pJqp/dpRESOObhZWyuVu2gM3D4vtIpg7b9QjUZIO5zxk
	 1Fr6yQ7Z4LBDHHnP6hu3jGySPxnj/ldwDQRU7450Q6AUmlJPE0OdNE8BcknEv1fJx+
	 MlVyumgmQvVzDCerFheHXCqJHXblkynw5hbXXvPnP+yOOnok0xcKArkv4sZU9hZMSn
	 HL3o2SARmYIJ9/8YDk4Tjz7crpUW7oWgNCqnMhVEtv0ZY/vxfrfGN5sXs2dc+aVmGp
	 WPspsgTGVzUDw==
Date: Fri, 3 Jul 2026 08:39:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: can: rockchip: add rk3588 CAN-FD
 compatible
Message-ID: <20260703-truthful-aardwolf-of-spirit-b6bafc@quoll>
References: <20260703-master-v3-0-6d56de6fd2f3@qq.com>
 <tencent_3E31CBEFAE0986665A26322171642BC00B05@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_3E31CBEFAE0986665A26322171642BC00B05@qq.com>

On Fri, Jul 03, 2026 at 10:35:40AM +0800, Cunhao Lu wrote:
> RK3588 integrates a Rockchip CAN-FD controller variant that is not
> fully compatible with RK3568v2. The RX FIFO count register field is
> encoded in bits 7:5 on RK3588, while RK3568v2 uses bits 6:4.
> 
> Add a dedicated rockchip,rk3588-canfd compatible to describe this
> variant. Do not use rockchip,rk3568v2-canfd as a fallback, because that
> would describe a register layout that does not match the hardware.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

