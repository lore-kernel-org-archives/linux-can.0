Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6539E6FD;
	Fri, 16 Oct 2026 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118232; cv=none; b=rKJL9k5zXjxKxwV5p89f0+XBA9B4NZGw2A77UXbrzhUtZwVPfyxVhWlUEnF2navlX2uCnLsIY+mRWF8npIUeWEqeZhMTF5kEN85BPVC7dk2qWrpxk/vPnu5Lh3ivQtpMv8GQ9amJGJSavk4oHjHo2LjzdzUkmWLRj0peO7FdRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118232; c=relaxed/simple;
	bh=xSj26J1Plae/p35T07snYYf9+nGASOZGBVBzt98m+wU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PkhZxsPyk5BdU9ElFwk8JLrvI92zOM0SwIITmxcGa3Fc6u6heebSwYTJ8Cna4YdtvvvkhysbIpuuDQpPj+IgmJtVNW71BPTs8j5gfnpPM5HVoh2z/MDrTWT+V8Ct8RZx0fF3JM1DtEJHhdBiKGPBIoyWxvZrMXPHosEBtNU6ZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDHZgIag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDHZgIag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3EF1F000C5;
	Fri, 16 Oct 2026 02:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118231;
	bh=pAe90VZWnCKWJRrMoyiAefx1L/xwsAfTd/iod2rlGe0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fDHZgIag/EdvVjbaWnp6oeahbwjH21JtsfmcYkqUjKsKmShhM3hmDB7JAiYpNPbcn
	 +RMOpvEwIvtJJvW499OsJ8OuqX+lvxTuwjymegrur1+CTh/B1usgCyrgQlzaqbExAc
	 AD9e3peHmM0QgAKzRyoXxJ3oX7PcZOIwKZp25IWCJbM4bKdeiuzC4kedtmwevAx5fK
	 J9x1hZhTUSYLIH0C9gIh8Cnm65KDAQS3h2wOrAoZL/x/xBza8NyRW2r3a0L8bCDvZZ
	 416+3BHHGIu16kNK37hlLBFsDu9Is0pj1HtjS9KiQhv1e8ZfQ/PNmR4Wt5StSP9tNA
	 /tf2pCmMIu/sQ==
Subject: Re: [PATCH net-next 19/37] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3L SoC
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:10 +0000
Message-ID: <179211823035.434549.5570001472090611125@kernel.org>
In-Reply-To: <20261015015336.816543-20-mkl@pengutronix.de>
References: <20261015015336.816543-20-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The schema does not make `resets` or `reset-names` required
  for the new RZ/G3L compatible `renesas,r9a08g046-canfd`.
- [Medium] dt-bindings: missing maxItems constraint for RZ/G3L interrupts

--

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC

This adds the RZ/G3L (R9A08G046) compatible to the renesas,rcar-canfd
binding. It adds a conditional block for 11 interrupts, 2 resets and 3
channels, and puts the new compatible in the block that disallows
renesas,no-can-fd and renesas,fd-only.

Link: https://patch.msgid.link/20261001075742.21961-2-biju.das.jz@bp.renesas.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index 1a7a9ce45e97..4b94bc8d911b 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -294,6 +295,25 @@ allOf:
>        patternProperties:
>          "^channel[6-7]$": false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g046-canfd
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 11
> +
> +        interrupt-names:
> +          minItems: 11
> +
> +        resets:
> +          minItems: 2

[Severity: Medium]
Should this block also cap interrupts and interrupt-names at 11?

The commit message says RZ/G3L has exactly 11 interrupts, but only
minItems: 11 is set here. The upper bound therefore comes from the
top-level interrupts and interrupt-names items lists. Those allow up to
20 entries to cover the six channel parts.

As a result, a renesas,r9a08g046-canfd node listing anywhere from 12 to
20 interrupts, with the matching names for channels 3 to 5, passes
dt_binding_check and dtbs_check. That is inconsistent with this same
block rejecting "^channel[3-7]$" for the SoC, since the extra
interrupts describe channels that cannot exist.

Was the intent to add maxItems: 11 next to minItems: 11 for both
interrupts and interrupt-names? That would pin the count exactly, the
way the other variant blocks bound their interrupt counts.

[Severity: Medium]
Should renesas,r9a08g046-canfd also be in the existing allOf block that
makes resets and reset-names required? Right now that block lists only the
other RZ variants:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - renesas,r9a08g045-canfd
              - renesas,r9a09g047-canfd
              - renesas,rzg2l-canfd
    then:
      required:
        - resets
        - reset-names

The minItems: 2 constraint above only applies when resets is present. The
top-level required list has neither resets nor reset-names. As a result,
an RZ/G3L canfd node with no resets passes dt_binding_check and
dtbs_check.

The driver will not catch the mistake either. rcar_canfd_probe() gets both
resets as optional:

	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
	...
	gpriv->rstc2 = devm_reset_control_get_optional_exclusive(dev, "rstc_n");

If the DT leaves out the reset lines, both handles come back NULL. Probe
still succeeds, but the controller is never explicitly taken out of reset.

This is still the case at the end of the series. The required-resets enum
does not include r9a08g046, even after "can: rcar_canfd: Add support for
Renesas RZ/G3L" adds the driver match entry.

> +
> +      patternProperties:
> +        "^channel[3-7]$": false
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
