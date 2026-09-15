Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1151480336;
	Tue, 15 Sep 2026 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469540; cv=none; b=QQ3iEmtCwuL+5gub1ICE6zgxM2KkARNe9/FzAkThaCf3+jttOSbeVY8C2Jf/ygHVQrel0Nq8jPeY4dCtO8fV/v7X9+p/HeNGJTp2AFzW4wzVkLbE88JmI29BZt0NUI+nGMasN76+Yw7cHNY7FtllPsb5vOMaz/EATBbOGK7f+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469540; c=relaxed/simple;
	bh=NtN6Xv0DsdRIobrp9DHovp3Vz8rTqNXVLNmt/YcPx9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hipkjp0BNO3wXUTBXdFz/pr18MyaXOpUHdyjJubcY5c7E+rUSZMEfX9wt3d80+NpA25R8NF1q5yr+2NwDenF6cNQyV4ziFwUfxOFcqbkJxYLNOwWKZDaFRLyQ9Dfz4RNloTKpJ8+r6+vsCByG5G3MQIGuVV1QFX1+npwW3Adq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoyItn08; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoyItn08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C187D1F000FF;
	Tue, 15 Sep 2026 10:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789469538;
	bh=kmikUQ3Zsiq+icuznESsAEIuodeMhYfs65QwcUyQTrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WoyItn08+uAe3O6SlJ6ybgRQZdqCUD71kWH7NiLUCjZwjJAaH0fLwWhgf6g78jnla
	 MGQs1ZKzJHoA8rmgM1ew2Ax8AwsjaFHRnB8xqe5I1tFXIuEAh18x2o4uTADroEk0f8
	 K3mUIzoBgtau8DG0yoJUbunnTnsQSvGbTjsxTawfM1sTqBIbBvxXrGHXxv0gwmcjPW
	 YjXz7UMyKd7Z/nCfvxPJybWiCsbF/iclVz7WiwoybxcI2WMuh9RHdQxwAxatB0kV+7
	 J0opj+FnGwOmJW3wJNP+PxUZ9ETxAQv8RuOVIT/sVAU3U5SYgML/LW7xRi3ccxfcWM
	 Hv1b9sz3QjfKQ==
Date: Tue, 15 Sep 2026 12:52:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: can: holt,hi3110: Convert to DT schema
Message-ID: <20260915-elastic-chameleon-of-argument-ab5cdb@quoll>
References: <20260914030215.437602-1-quchaosheng000406@163.com>
 <20260914030215.437602-3-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914030215.437602-3-quchaosheng000406@163.com>

On Mon, Sep 14, 2026 at 11:02:14AM +0800, Quchaosheng wrote:
> Convert the Holt HI-311X stand-alone CAN controller binding from
> free-form text to DT schema, and reference the common can-controller.yaml
> schema.
> 
> The old text listed clocks as required, but the driver obtains the clock
> with devm_clk_get_optional() and falls back to the "clock-frequency"
> property when no clock is provided, so either one of the two must be
> present and neither is required on its own. This is expressed with an
> anyOf block, and clock-frequency is documented, as it was previously
> undocumented.
> 
> The maximum supported clock frequency of 40000000 is also documented,
> as that is the limit the driver enforces.
> 
> unevaluatedProperties is used rather than additionalProperties so that
> properties provided by can-controller.yaml, such as termination-gpios,
> remain usable.
> 
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
>  .../bindings/net/can/holt,hi311x.yaml         | 80 +++++++++++++++++++
>  .../bindings/net/can/holt_hi311x.txt          | 23 ------
>  2 files changed, 80 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt

I see here four patches clumped in one thread, of which I think I
responded to v2, but this is still in patchwork. Probably your patches
are organized in a way confusing the tools.

Please read carefully submitting patches and for example Linaro's guide
for first time contributions.

I am dropping this entire thread from DT Patchwork.

Best regards,
Krzysztof

