Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9504DAF85;
	Thu, 17 Sep 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644086; cv=none; b=izYemgXyBaOQLT2VC+tbq8d6SVHEtqp2oTkVk9Koi2OZa5Y4J0vQ1l/ORUayeSGWxcOWDlvU8UDBdLmUBv3dmcZVMsd8pOqIM1w11S7D13/M1F4jTryR3YkXNJy50zSoYvPPg6yEP2hVTpac5/UhL23aGCLPwHMoJrV2hoL93kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644086; c=relaxed/simple;
	bh=Dim/QSeGUhrQVZ7xvXdr+08HoJesMzwtqPNkQCiQZi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar5z1+fTAfKYjFJu60GX6uGGuQ/cWFdkk0k00h6nWmNQ+26FFN1anSch2pKSr9kvGhOaJsMqd8NFq2iaHqVRjfyLYIrUNqFPFmJv9rkChPXKpgppGX1tG9GEnWmsF5hm9yqPKGlN3pBenR8EMlLBLSI+MOO2w2xmR7vbcNZKJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMVVq2Ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMVVq2Ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B24C1F000FF;
	Thu, 17 Sep 2026 11:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789644074;
	bh=HNVlKCQj9t4F2QxuG5+Nvtx8ehVkwFth5lkkTZy95rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AMVVq2BaaA3ro4YmKSTxDFpK6fKCjPZpAIkS0uvm1IuX4djWApqyTCrxQ5gYhvqnE
	 +XzJk9ryBy1gWGAduc7mAHRyZ45+K6Xom9gQT6hvZ2RD1weznuciZnIevsQQkN8arD
	 kzA6+skezzP533vxDgEnOXgTqr653qyOg04Gm4ozbklG5p8u9GZGo+8DStnYlhnL+B
	 5zuM+QBBtv3z2Z2nBFKs1xAlJZjt9V8Kk0VK1ze4YoIy+vE9Vw9gP2dZD/9OBcNqT1
	 JP9dGNlC9+vjdxMH+4e0OW99haQaxZnEZYPdDTiCOzYx6pjpI4c79mZQHwPg91C5uD
	 dX8IKxcXw35eA==
Date: Thu, 17 Sep 2026 13:21:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com, vishalm@ti.com, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: can: m_can: add ti,am62-mcan
 compatible
Message-ID: <20260917-ivory-jackrabbit-of-discussion-cb4dd2@quoll>
References: <20260915-temp-v6-0-ddf1411d63cc@ti.com>
 <20260915-temp-v6-1-ddf1411d63cc@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-temp-v6-1-ddf1411d63cc@ti.com>

On Tue, Sep 15, 2026 at 01:16:01PM -0500, Kendall Willis wrote:
> Add "ti,am62-mcan" device. Device is fully compatible with Bosch.
> The device supports out-of-band wakeup capability.
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

