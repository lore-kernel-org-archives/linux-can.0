Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462633A71B6;
	Fri, 16 Oct 2026 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118231; cv=none; b=RMsT2543vTStTpA+b1ywxo/gDKSdV4QUVAQT2QZsrshrusBaqOehbUIrMX6hoPt0b2tOoF1FaTx8fJ63Et8zeB54cyyptQIttY18yG9vDKUgzmdp0Qe25mtDVhdk180GpN/sDK2a9SanjkFJKfBrJc2OYnVVra5OaAujXmGfg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118231; c=relaxed/simple;
	bh=S0oR/ksfT/A5SiA9a6RDU2YXmwezsqbzTKtkSZzoOK0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AKHsMy16rTNus+dlVlIJ9A8hU/pbrWUgAW0ON5gPqAWaNS9mmeb3vxU2P+ZS4Uaj/ImF196m2u1XFt4A4ACeaTUEXmwuBEbHB7YQ/C8I6NzPbvkStINAWPHOU8xuM4wyvZjCMTycf7LsYIVJQ94En5syvddHn/UQj+H2qzT9DxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqTMLq8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqTMLq8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47B21F000C4;
	Fri, 16 Oct 2026 02:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118230;
	bh=2LNi1N/y6bNeFg3dfIP3bTT1ijZQ8HMVBLcPreeM9YM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CqTMLq8nCVSQ/bdfWDTE4Y+OM8b91OEt2tEuhwVLQUmZWXFAIkr5CdJq5ZGPok4ji
	 Ok2Q30wJuEERwVkRAJoxcy9XDj+5LzOG1zdpjfk52RxFse9UqzJCBG1YTRgVrfso9Y
	 jzuJRHgef5VqMNeh87LtF8yLmkg3BGK4iXk66c8xMMzuXYuHYd2LnXLQL4NlkTF6ZY
	 Uob41peKSSnNnBMl6L02lnbyRCDd3J9WOi8khmWiSRi9H/0omSesxAHJ+rMpkUGP5Z
	 WRr41EGfsmVoBRXrGVxq3ne33vlVm0aBkGe4HvzaF38blR3GUwr+4t+l9Om6lpbbJk
	 R6MEiH1FB/CQQ==
Subject: Re: [PATCH net-next 18/37] dt-bindings: can: renesas,rcar-canfd:
 Restrict resets in top-level
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:09 +0000
Message-ID: <179211822938.434549.16327090214645030529@kernel.org>
In-Reply-To: <20261015015336.816543-19-mkl@pengutronix.de>
References: <20261015015336.816543-19-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the patch will "disallow" `reset-names`
  for the two variants that do not use it, i.e. renesas,rcar-gen3-canfd…

--

dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level

This patch gives the top-level resets property its broadest limits
(minItems 1, maxItems 2) and drops the now redundant per-variant
maxItems: 2. It also adds reset-names: false to the R-Car Gen3/Gen4
conditional block.

Link: https://patch.msgid.link/20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com

> Since top-level part says "reset-names" cannot accept one item, disallow
> it for the two variants which do not use it in practice.

[Severity: Low]
Is this part of the commit message accurate? Before this patch, the
binding already disallowed reset-names for renesas,rcar-gen3-canfd and
renesas,rcar-gen4-canfd, in a later allOf entry:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - renesas,rcar-gen3-canfd
              - renesas,rcar-gen4-canfd
    then:
      required:
        - resets
      properties:
        reset-names: false

That block came from commit af6b427c7ad09 ("dt-bindings: can:
renesas,rcar-canfd: Specify reset-names") and commit 1e3710b1fe915
("dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H
SoCs").

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index bbaaef8f4282..1a7a9ce45e97 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -231,6 +232,8 @@ allOf:
>          resets:
>            maxItems: 1
>
> +        reset-names: false
> +

With this line, two allOf entries now have the same if condition (contains
enum renesas,rcar-gen3-canfd / renesas,rcar-gen4-canfd), and both set
reset-names: false. The schema accepts and rejects the same nodes as
before.

Could the duplicate be dropped, or the two Gen3/Gen4 blocks be merged into
one? Could the commit message also say that the only real change is the
top-level resets bounds? The duplicate is still there at the end of the
series.

>    - if:
>        properties:
>          compatible:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
