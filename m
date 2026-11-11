Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401394;
	b=mkEfQRh7sw9gTWL78L2M6ceupWjGiawhyqI3zvnQbuA6LbzTiALyoceNZMrwikYM4aOp
	 V2T3TjvODH3WXUD7n2xKE1661NEPTKnF/BeeXI+a2wDtNQPEt5OfAdjF+PvJNhOb9eNi1
	 /LOE/tFs8YgTTGVuJBSoxttqkgK30Xb4E84OlMBtOEZW/miAhqYnG5VyDF+3qADm/pxhA
	 cLJvDisy1qvfgzi9/cnjVswuYS9oEFAKcLk/C3S0YAyrhzjZLkt2A46rJpR1BDqZ8iw2W
	 3ZxtRNd9vmaPcjG2JIQSyhA+wa3ZQrcvlawHV1jJb76CdDTzZTxZqL5LVLUp8o2NOtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401394;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Vw96AJ3mehwdEStu3TO7f013SbsHO207gIoE9LmM7es=;
	b=LJU2Qyr7zI2VTLnEPpISx7/UOWs7+CKHhh9Q/kwejQ8cbjvKTSr6/K7cf0dJbzJRLDgL
	 rHMO+iURKHKCUP4JjywYFE2g41tMwOslHxRNEiV1qFBH8pJ9rWaKbNpTOunDBws+3Bwhn
	 yvChDSFGwj5owVeCUyt2598+5cLIS2nhmkEKxQACEY2kY3BhSrbVo82DP/p+b/P8lrA/W
	 O2EuZaz+EABOGLLbtcRyDNiq6TmpHbbZ9OVk7BZdfchIZndsZufKDwLvmjq8i7qWyN4M8
	 b6vbUBWVQS7vB7jODvo4LNJzLso26nB5J6qnmdQDNAjWBOXzQl74lT4jMb1Ub1dGc2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/kFSzAu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707A606A31C;
	Wed, 11 Nov 2026 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/kFSzAu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C32A1F00A05;
	Wed, 11 Nov 2026 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794401394;
	bh=Vw96AJ3mehwdEStu3TO7f013SbsHO207gIoE9LmM7es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f/kFSzAuuQZfZ0Z09AsaztUJTZuvvfGjU2GsYxgR8T2T5QjxMhOkPRPPGqltVbZA5
	 v//THe+5vfQ+cbYnUW+u0lPQNtQYsvhWEsIOwxNE8LG2GjMO4h7FoJK3q+4eJTXFUC
	 lGJ1cwqeLmm84/6WXWhxMsoc2TsaIRoMUuuq1PQhTZj3KluC8HGU0hq/9boE0q3zTQ
	 SbQ1cYh7FxtUCwVwhVlr9VQEfrV154XPp2e/56rMERKNodKsOrhxsL4dWT/JoGl34o
	 to9yeyEXCD+L8AopdlDQVBJi7JrG8qJcstBz6UA9+LPqRkAKb9EtR2UW5juO2xbfmF
	 deL7XRFkXZUQA==
Date: Wed, 11 Nov 2026 13:49:50 +0100
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
Subject: Re: [PATCH 1/5] dt-bindings: arm: fsl: support chargebyte EVAcharge
 SE
Message-ID: <20261111-pastoral-voracious-duck-4d6436@quoll>
References: <20261106230746.21954-1-wahrenst@gmx.net>
 <20261106230746.21954-2-wahrenst@gmx.net>
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
In-Reply-To: <20261106230746.21954-2-wahrenst@gmx.net>

On Sat, Nov 07, 2026 at 12:07:41AM +0100, Stefan Wahren wrote:
> Add devicetree bindings for chargebyte EVAcharge SE board.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

