Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401441;
	b=GlLg3qIbA+KOtBNoowMMuV7DYmAmfjvT9YDh3qG1uXPKZNJsubxOCV0oG+VkVOX8bxvU
	 W8jk/6lsv+2J/uy2pq59lJMWkt+FgDkdaYkAQVDByCH05/vZPZcZqlsN1zORoDdk3Y5u6
	 gMrOi0Oh1yxGSulH4T1MG5FMxD+qmfO6Aal8GT7EFTUYRgFOfvMTpnY06rURbWfCHhvfT
	 I0rDtpJ+zZK6ANzEtuWmovjaJgrdtJvHnxrE6g1gHtYhDcqXr29a3p0ciS87s+u7Git9K
	 JkTFVnOxCxdm/0BquTM8c57Ty2SEtaKo2MLaEOyY9lulH02LU4GGMtE0pXjctPjcd+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401441;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lJCONQ2S1BJF/RtWm2O9HQRSTMfiKMyOOMP/z54HIUI=;
	b=0p0Dc1/nRmfP1SrjnLEdmmvFAvxHIHC46kJy5piv0FR3SKM95kXiHPoCrCMOy6KQS9gF
	 YnZvhApJch1W3cXawVbrL2az93eeSWFCtUPJl9vIZWpqmX7XrGKrhJgiUjCYAuTsQYKon
	 QQJ3fO4Su3dFmW+XMfjG6IAX7LR+/h0c82ckXAh55B0kjXqRTF8ttu7769zWovrikbgIb
	 bU5jFgPXxh9BK0yIgj9ckYpUckpLZMCn/Y4sDKfo3mcWXgeqxOutLqlykj+54PDabHCch
	 mfqkz702jXHG3Xu0bucH/HDVvVB02eFoZBhtE7ymkoZ3bs02hn5NcACmchRw73gvX4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpVHGQep;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8395C606A321;
	Wed, 11 Nov 2026 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpVHGQep
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937001F00A05;
	Wed, 11 Nov 2026 12:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401441;
	bh=lJCONQ2S1BJF/RtWm2O9HQRSTMfiKMyOOMP/z54HIUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GpVHGQepxVL+7vb6Rzs0Oim9lI9wvWBp0a/JcViTCYcHZhYt02+9dxv3Za+oyW9ch
	 CLQBZsb+Q3iIJSru2CXqzVrp1NtYKn3kZwXBRldYyhIROU+kYsJQTIYeLdHDOO6s3v
	 CqlWnoCKK9WOlrhDF79EGlZ37Mm5SqNaMt0uWUjTNL+DYBV/gFANh8Wvsyf5UC0J0t
	 WZy45TJTfCprK6+EAYrLD4u7Bx1tkSzJ/pdl0hlpKjfvp+xWqYP8Xv+GswrsC2oy9N
	 5oX/kXVy3rt7CzVokZ0nuufYx5pGX78l13y1kYw7RyMAXZGq7M9fLOvLwAm8DCP/zq
	 oBIQVU+gAIYcA==
Date: Wed, 11 Nov 2026 13:50:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Vincent Mailhol <mailhol@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, 
	Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-can@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 3/5] dt-bindings: gpio: mxs: Allow gpio-line-names to be
 set
Message-ID: <20261111-active-brilliant-muskox-dd4cdb@quoll>
References: <20261106230746.21954-1-wahrenst@gmx.net>
 <20261106230746.21954-4-wahrenst@gmx.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106230746.21954-4-wahrenst@gmx.net>

On Sat, Nov 07, 2026 at 12:07:43AM +0100, Stefan Wahren wrote:
> Describe common "gpio-line-names" property to allow DTs to
> specify names for GPIO lines.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mxs.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

