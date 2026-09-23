Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF6511E8A;
	Wed, 23 Sep 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173855; cv=none; b=SNwjwlTD3vHTS9A0+OGBkzPQ5UnvkvjwBatB++pv6+kWeIXqJbhiG6vat7WTW5IwDSFz6Ue4rmoq2BdNm49QddS6rgxr5jKhPqZKfcytcL1yh2EoxWkGCleA8orHVv2FmPH10k3whnjzvaixaNIGNQyENJ+8OXoMcsZ44DqdZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173855; c=relaxed/simple;
	bh=N5YqmKihMPoUFLmWlgyIrlyHZ1ar4Pmirq3scgwhBAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAP4Va7nPgvKDXImc86JOBc1NmHx2ybk83lFUV0LGb4vGzTFxOceW/H0zD0epHoXRXBW/DCkOw8uElSLtCJe8daBeO2BjEFbXzdHBxQ6o89QxlFKEWjaOC74gY/8FaOli/MeJSW4Dj4abZTifFQFyKY/Nj2jq680rgp7VVB4YbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDh91WxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDh91WxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0611F000FF;
	Wed, 23 Sep 2026 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790173853;
	bh=AKQFNKkkPF9N3C14+Wm2pRhX/CAnaIcorL6P/HjrDIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gDh91WxM+CHwV8l4yb/tpPEoplnXiWKN/NZZJDNBjBSpzmUoohaqGXVtJC6Na2az0
	 SHK0VfJ5PrQBV5Q1Z8v4LA+6PiwaAESe4gyFgiLKt+guhJ1oXPTTr6wI61QpuwaDhK
	 6+VxR3qEQBxJyTSrOUG67xQUAcas2HWVaI0fsnyeHzQaChoQr66I2d6WdyGUSFFO7m
	 CtQguCxbL1wsXAXmmCAd5ghIVGDF37l56pYJzQWzgswMif05yRA64xuY0PTBvAmnNV
	 9ktzy4hma6jyk0AGOc/SMmujr7Ykrq7WBey95Mgmm8tSGeb0V/wekPhXDW87Oj1EjH
	 8QAy6NwHX8fOA==
Date: Wed, 23 Sep 2026 09:30:52 -0500
From: Rob Herring <robh@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert
 to DT schema
Message-ID: <20260923143052.GC27237-robh@kernel.org>
References: <20260922102258.138753-1-quchaosheng000406@163.com>
 <20260922102258.138753-4-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922102258.138753-4-quchaosheng000406@163.com>

On Tue, Sep 22, 2026 at 06:22:58PM +0800, Quchaosheng wrote:
> Convert the Freescale MPC5xxx MSCAN binding from free-form text to DT
> schema.
> 
> The original text documents fsl,mpc5200-mscan and fsl,mpc5121-mscan in two
> separate sections. Keep that split: fsl,mscan-clock-source takes "ip" or
> "ref" on fsl,mpc5200-mscan, and "ip", "ref" or "sys" on fsl,mpc5121-mscan.
> 
> Add fsl,mpc5200b-mscan as a fallback of fsl,mpc5200-mscan. mpc5200b.dtsi
> uses it.
> 
> Document clocks and clock-names, which the original text does not describe.
> fsl,mpc5121-mscan requires the "ipg", "ips", "sys", "ref" and "mclk"
> clocks in that order, as mpc5121.dtsi supplies them. MPC5200 does not use
> DT clocks; it takes its frequency from the CDM block.
> 
> fsl,mscan-clock-divider divides the selected clock, so value 0 cannot be
> used.
> 
> Keep the note that the MPC5121 Rev. 1 processor is not supported.
> 
> Assisted-by: LLM
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> 
> v8:
>  - No change.
>  .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 109 ++++++++++++++++++
>  .../bindings/net/can/mpc5xxx-mscan.txt        |  53 ---------
>  2 files changed, 109 insertions(+), 53 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
