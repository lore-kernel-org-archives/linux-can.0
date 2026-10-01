Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441E4570C3;
	Thu,  1 Oct 2026 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790834654; cv=none; b=kQyb/oMw9mGcGxVDpKSfai1TBcuz48JZzE3eTWbv0d0zvao2g3dpMvFsIPQAzYSj3cQWSw9pEEqKkhA7rOPl95tjB/ai54vyfqP1N26zQImA7VGOXmcatsAiiXhqjBJrwDvzt60UozatONFiULU0h1HOzpA4P3VjRQUJqM2VbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790834654; c=relaxed/simple;
	bh=Z63aULE6eiAK27ZE4Ys5OoEJkjpDtqvWAJuGm1hmsjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNDMq8rQ1dXvjPn3XOuawjzGGyG8Ko/TL93PO6Rs2UMfeOQttz12zXtPQZ/XlSllnwe0z/L75AtVw/BBUCq/1Kto8MmaM4fNWiFP5rg0nrlfNTJRGoeKj1kWGGWy1IyrqWB2/dMYEF2kd2c/pfnJd5NVZY4pRDZdyT1c34qAgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFCtMkgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFCtMkgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2083E1F000FF;
	Thu,  1 Oct 2026 06:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790834643;
	bh=IEblyWJLZ++17Riml7gmK5vXX58wHwqOT3xHv1rBg/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oFCtMkgUXpJjrJt6HtEIOH6yFjmkS/UsPmsVMnHgkx9Ad1D2MQV1VcsZSJiv0wuZn
	 7wvu3sK98GxRa/SsVEi4ZJqwmaFF4UCkd5SLRnizIgwpTXVAVNXvZwcR5Kl1Gh+CJg
	 XMTUbr0HjIrl8DrGGImJVFxUVh4y0nO003uVo5D2kfUXxr4llc/YGYDysMQ21DFC+b
	 YQ1PE0q0oaaCBibZYZ+QmXZn9E79skccydHU+ZQBGrjNPT9BYC+Bre74koVQvauGqd
	 /Woog6NVVjP814WSdyse+ObRtDbzulyqfQ4rsE4n3Xiff+IbNMLLi65OyPW5AU1qlg
	 PqbNnJfLOM0KA==
Date: Thu, 1 Oct 2026 08:03:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Biju Das <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
Message-ID: <20261001-chubby-tomato-vulture-e1a69c@quoll>
References: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
 <20260925082134.146015-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925082134.146015-2-biju.das.jz@bp.renesas.com>

On Fri, Sep 25, 2026 at 09:21:28AM +0100, Biju Das wrote:
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 11
> +          maxItems: 11
> +
> +        interrupt-names:
> +          minItems: 11
> +          maxItems: 11
> +
> +        resets:
> +          minItems: 2
> +          maxItems: 2

Drop maxItems

I'll fix existing code.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

