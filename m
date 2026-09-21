Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C434C9E18;
	Mon, 21 Sep 2026 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012855; cv=none; b=Czeasg3ZJm+4tYaMsNAUZvM7dCt8BCu6szQM5YsuB8EwWRaYYExqDqDZudau1bTfsTwommqzBPkC0JCa6212YyWdYDLdZ5mmAeCnzJGDOUMJYqGsk0dqs9W10+ztDYkg9G6/5PnCXxR48ATzdyFY8jKqg8jDq8ggoOX1U9qZJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012855; c=relaxed/simple;
	bh=e96vwgsNYb9CLh4jQ6Vic9jQLzBWKPkUx6fTeYAjZhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdautxIfsh4Tw9Yx5dwf14soVWBQhUCff7NHhmOgckoQC4id7WSnNUfgv56a91s+Cj404HH7tBIX04UQDRPdLpD7ZiPstBcI+iz57nnR6zpunifE5OyE9HB3fHSQSPPI8Cy35xtPmNY2XKomBFsQ1zw/u3V0TKCtosH6az2ZE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7S2cLn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7S2cLn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2123F1F000FF;
	Mon, 21 Sep 2026 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790012853;
	bh=RVZ4WmKDpqAI67d1qCz80Y6egPdWQqjCQfbaphHPGM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F7S2cLn0ti5p77ONW6coAjLKtIQtTZEA7Hf+k+6VCRa6VKSfFnRj3zVjCw0y6u2M4
	 RTkycXBfQ9FtViz3XIpe0yh2I41gaxFPF4tMMLfcJKA/tvN3JI/YWVzQOK1a/iOgNq
	 QNo7iHFOMWPTKv1Y3Q+J8BgxU7KKIcUHOdmGpKLDDhpCx5wjCww1WFWICi7Tr41bWl
	 Zc0A3E/H7xVTvAE/h24sIgFYV+B5P5twquA/sSOHKr9K3JFURpGhCdim6us5cyaVIk
	 Z0gT/API4JpC5M0SKBWGBW59MQttBE3lCRzrRivVA4wRmo8Js2XIcSJjfszddP8rtG
	 C/YkxzraWFkgw==
Date: Mon, 21 Sep 2026 12:47:31 -0500
From: Rob Herring <robh@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to
 DT schema
Message-ID: <20260921174731.GA1044853-robh@kernel.org>
References: <20260914090440.552884-2-quchaosheng000406@163.com>
 <20260916015803.112328-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916015803.112328-1-quchaosheng000406@163.com>

On Wed, Sep 16, 2026 at 09:58:03AM +0800, Quchaosheng wrote:
> Convert the Freescale MPC5xxx MSCAN binding from free-form text to DT
> schema.
> 
> Describe fsl,mpc5200-mscan and fsl,mpc5121-mscan in separate sections, as
> the original text does. fsl,mpc5200-mscan accepts "ip" and "ref" for
> fsl,mscan-clock-source, fsl,mpc5121-mscan also accepts "sys". Enforce both
> with an if/then block on the compatible string.
> 
> Add "fsl,mpc5200b-mscan" as a fallback of "fsl,mpc5200-mscan", as
> mpc5200b.dtsi uses it.
> 
> Document clocks and clock-names. The MPC5121 driver looks up the "ipg",
> "ips", "sys", "ref" and "mclk" clocks by name, and mpc5121.dtsi provides
> all five. The original text did not describe them. MPC5200 obtains its
> frequency from the CDM block and does not use DT clocks at all.
> 
> clock-names accepts the names in any order and allows a subset: the driver
> looks each one up by name (devm_clk_get()) and only needs the clocks
> actually selected, so a node providing just the clocks in use is valid.
> 
> Keep the note about MPC5121 Rev. 1.
> 
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> v2:
>  - Add "fsl,mpc5200b-mscan" as a fallback compatible.
>  - Document clocks and clock-names.
> 
> v3:
>  - Split fsl,mscan-clock-source by compatible string, following the
>    separate sections in the original text. "sys" applies to
>    fsl,mpc5121-mscan only.
>  - Rewrite the commit message in imperative mood.
> 
> v6:
>  - No content change. Fix the patch format: the changelog was placed in the
>    commit message instead of after the '---' separator, which confused
>    Patchwork. Move it back where it belongs.
> 
>  - clock-names: accept the names in any order and allow a subset, as the
>    driver looks them up by name and only needs the clocks actually
>    selected (devm_clk_get()). The previous strict ordered 5-item list
>    rejected valid nodes that provide only the clocks in use.
> 
>  - clocks: add minItems: 1 and note that MPC5200 does not use DT clocks
>    at all; it obtains its frequency from the CDM block.
>  .../bindings/net/can/fsl,mpc5xxx-mscan.yaml   | 118 ++++++++++++++++++
>  .../bindings/net/can/mpc5xxx-mscan.txt        |  53 --------
>  2 files changed, 118 insertions(+), 53 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
> new file mode 100644
> index 000000000..7f01008f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/fsl,mpc5xxx-mscan.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale MPC5xxx MSCAN controller
> +
> +maintainers:
> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> +
> +description:
> +  The MSCAN controller found on the Freescale MPC5200 and MPC5121 SoCs. The
> +  MPC5121 Rev. 1 processor is not supported.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,mpc5200b-mscan
> +          - const: fsl,mpc5200-mscan
> +      - enum:
> +          - fsl,mpc5200-mscan
> +          - fsl,mpc5121-mscan
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Clocks feeding the controller. Only meaningful on MPC5121, where the
> +      driver looks the clocks up by name ("ipg" for register access, plus
> +      the clocks selected through fsl,mscan-clock-source). MPC5200 obtains
> +      its frequency from the CDM block and does not use DT clocks.
> +    minItems: 1
> +    maxItems: 5
> +
> +  clock-names:
> +    description:
> +      The driver looks clocks up by name, so the order is not significant,
> +      but each name may be given at most once.

There's only one defined order, so please define the order. We only 
don't define the order if the schema and/or users are too much of a mess 
to do so.

> +    minItems: 1
> +    maxItems: 5
> +    items:
> +      enum: [ipg, ips, sys, ref, mclk]
> +
> +  fsl,mscan-clock-source:
> +    description:
> +      Clock source used for the controller.
> +    enum: [ip, ref, sys]
> +
> +  fsl,mscan-clock-divider:
> +    description: Additional clock divider for the reference and system clocks.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: can-controller.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,mpc5200-mscan
> +    then:
> +      properties:
> +        fsl,mscan-clock-source:
> +          description:
> +            Clock source used for the controller. "ref" is the default when
> +            the property is not present.
> +          enum: [ip, ref]
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,mpc5121-mscan
> +    then:
> +      properties:
> +        fsl,mscan-clock-source:
> +          description:
> +            Clock source used for the controller. When the property is not
> +            present, an optimal clock source and frequency based on the
> +            system clock is selected. If this is not possible, the reference
> +            clock is used.
> +          enum: [ip, ref, sys]

You can drop this if/then. It has no effect.

Though looks like this should define 'minItems: 5' for 
clocks/clock-names?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    can@1300 {
> +        compatible = "fsl,mpc5121-mscan";
> +        reg = <0x1300 0x80>;
> +        interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-parent = <&ipic>;
> +    };
> +
> +    can@1380 {
> +        compatible = "fsl,mpc5121-mscan";
> +        reg = <0x1380 0x80>;
> +        interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-parent = <&ipic>;
> +        fsl,mscan-clock-source = "ref";
> +        fsl,mscan-clock-divider = <3>;
> +    };

One example is enough.

Rob
