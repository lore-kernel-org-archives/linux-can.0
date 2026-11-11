Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401405;
	b=u0m5w0hn97mEo5iNZqCLI8riuMpcaYY4Y3SZIuOBkW7O6x5jP2LBiPjUR5L6QnSZdkFA
	 ULpIP/9fZDNA6FCKajfkY29VZ6ZDUDLhUvBcSxS8RkYYDnIujWopGDWm2ydTLDxFaZenN
	 hwRB7vBsvMJJ6Ay6WA09BZ6cJ0IgwAG0U6MSZBbVVFR9fiKd203RYufXVXHc6/AXD/5In
	 X2TWOVfTzYBMhzsoMuzfEiGg6ORzlMWpkbH6GFLZoKnafJjPG3rQQVcpH0kRFBd7BjNE0
	 qUJXiAvNm5+REDERqCUuFZmNJgumjI74Wm9cCnDtRu4smV8b4/M4fS2Mg9AMnOJ+LVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401405;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GnuTaDcgxhuKNoNjz0bLXEXDkPUqZAVG2LRpEVxqJxk=;
	b=vcq0LmAerw52ve5il7VXD5H8KnHw4EgxsC4sYudRCseAMwRRon7fzED7Yb5491z4BS2d
	 KaHUJwd+V8VdVX2LXd+Twxv/ZcqyNwid0CtpquoGC0tzvnjgofg1uGcs7xtgdeGC2VcTD
	 Z4zfVp8ihKnSWII7ScgQXmR3BI0L6GOHpohBAWmOGrpXsl2Hg71o3KYhLrcJGRXGUjX0g
	 3vOxSh12CvIEr5n6Yocp2SVSNIPByfW0RTD+9TXyL/0zL5wUu1XZK4onon5pqeSTP1ObL
	 H4ArBOvacxgKVB9/gfsy0CbliXhk7YqGXU/+u89ftzwlKu49K16aQQeOI4TYaPlMaSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9TAa6sh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EEC606A31C;
	Wed, 11 Nov 2026 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m9TAa6sh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9EC1F00A06;
	Wed, 11 Nov 2026 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401404;
	bh=GnuTaDcgxhuKNoNjz0bLXEXDkPUqZAVG2LRpEVxqJxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m9TAa6shkN0tp7T68kqEMjjdQ4BVnf1cj5XNy0OfdBGYvw26bbB10SrQ6hkevNpPv
	 Z3MQ7LUf/dpMLS83mqk/IFuSj8MaYLqAQErQIPM2P9JKjwTa2WUKvAaRQ1k1JXvAwn
	 mi0vkIINq4uQOIbmu08d9HcZtpbwbMjnP+FBhF2r5jK/LDhj7KPSVAtaZMynWJH5sw
	 uZh1wFqJ4iSyUuPZISwxExvmmYqS2O2kmJftsIwIXixEVm9A0PYneSjL1UJM22Xsz8
	 ZnFmRDziYJ607pGRLPiaz3MABwNheKA/5BZb7GcPv7FdSEO4cQMf5F5LFcmSPCUCO9
	 g05dO/TcCmfrw==
Date: Wed, 11 Nov 2026 13:50:01 +0100
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
Subject: Re: [PATCH 2/5] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip MCP2562
Message-ID: <20261111-inquisitive-banana-shark-3d1a6c@quoll>
References: <20261106230746.21954-1-wahrenst@gmx.net>
 <20261106230746.21954-3-wahrenst@gmx.net>
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
In-Reply-To: <20261106230746.21954-3-wahrenst@gmx.net>

On Sat, Nov 07, 2026 at 12:07:42AM +0100, Stefan Wahren wrote:
> The Microchip MCP2562 High-speed CAN transceiver with Sleep mode is
> pin-compatible to the Microchip MCP2542.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

