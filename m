Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0313016F1;
	Sat, 10 Oct 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640983; cv=none; b=DI0/3DlAQ/BF47obtFfD/IcN0KVSPnIOHdeB7X3JXu8cJajbaIa1EldeMj3ObnVu3A4F7Zmc022AdbKpG0oacfbxF3fYoYJEhoAONgyE7jgHYE86qdgMuz60mbdoOCjGxJGQJxwe+FhomZAc83ozJNFeQFz07KFNPwGo19ZG4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640983; c=relaxed/simple;
	bh=Wgorhtni15w/b3BpOK/9uyGHvVFCWHORESkF6x5bBqc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FZO7nPzSSRs3rNQdRVh7LxlxOAbqLr/WxamWQzvnJesuRKHGOn5MqLu4lfTE6rwQYVTkhQuCJ+Ks+VrHetnlHR8MBl3n2fUwEA/ra2LS2n8y3OiVKnrK4SITbb7ceBjhTiOUL1KDHD1IHL95ux2whW0CaPBkhdFRUlUiu3HtC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfpRWsH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfpRWsH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422C11F000FF;
	Sat, 10 Oct 2026 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640981;
	bh=JUbaggXbz4QdjUkckQve33StgIsloIC00Dn9qZk7dw4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HfpRWsH0UMXiAEDLSnQ7Dmcfiy7s/ohFNjc7slDsiJlCb9CsoVF84k9PhmiSugKZY
	 t9G1Vc4VZ2gdSjLO37wFPG0jbetFT+GVlUm1KU8TMRJ1Py0uT+ielWdjR7nWFMKRET
	 OA4viT30EBd7UEeGPBOZddtnJs3UTLykF0WeJ4ElFyplT5JP2QYOpJOg2x6kEl+SBD
	 RZECeUkCzxtCy3CcFSHvYB+CUOnkIA3iujXBAvpV390mQdL6QbVCfVGbPnmAE5b42Z
	 kMXo+gE4wjwppiRuiHGqEKJtgKJtlQQNW+WdJQ3LgeI+gmQ+19i+V/Bo0PTwLZ1LoV
	 1alolsc1ryVvQ==
Subject: Re: [PATCH net-next 20/37] dt-bindings: can: renesas,rcar-canfd:
 Restrict resets in top-level
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:03:00 +0000
Message-ID: <179164098076.434549.11905933863482884010@kernel.org>
In-Reply-To: <20261009134323.64064-21-mkl@pengutronix.de>
References: <20261009134323.64064-21-mkl@pengutronix.de>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The binding never makes `resets`/`reset-names` required for
  RZ/G3L (`renesas,r9a08g046-canfd`), although the driver treats it…
- [Low] The commit message says the patch disallows "reset-names" for the
  two R-Car variants (renesas,rcar-gen3-canfd and renesas,rcar-…

--

dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level

This commit adds top-level minItems: 1 and maxItems: 2 limits to the
resets property. It drops the per-variant maxItems: 2 lines, which the new
top-level limit makes redundant. It also adds reset-names: false to the
R-Car gen3/gen4 conditional block.

Link: https://patch.msgid.link/20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index cef20f0403715..4b94bc8d911be 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -232,6 +233,8 @@ allOf:
>          resets:
>            maxItems: 1
>  
> +        reset-names: false
> +

[Severity: Low]
The commit message says:

  Since top-level part says "reset-names" cannot accept one item, disallow
  it for the two variants which do not use it in practice.

Weren't these two variants already blocked from using reset-names before
this patch? Further down in allOf there is an existing block for the same
two compatibles:

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

The patch doesn't touch that block. As a result, the added
reset-names: false copies a constraint that already exists, and validation
results don't change.

Could the added line be dropped, or one of the two copies removed and the
commit message reworded? As written, the message describes a behaviour
change that this patch doesn't make.

>    - if:
>        properties:
>          compatible:
> @@ -247,7 +250,6 @@ allOf:
>  
>          resets:
>            minItems: 2
> -          maxItems: 2
>  

[Severity: Medium]
This patch reworks the per-variant reset constraints. Should
renesas,r9a08g046-canfd (RZ/G3L) also be added to the allOf block that
requires resets and reset-names? That block currently lists only:

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

The RZ/G3L block only sets resets: minItems: 2. That constraint applies
only when resets is present.

The driver handles RZ/G3L exactly like RZ/G3S. In
drivers/net/can/rcar/rcar_canfd.c:

  { .compatible = "renesas,r9a08g046-canfd", .data = &r9a08g045_hw_info },

rcar_canfd_probe() looks up both resets by name as optional:

  gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
  ...
  gpriv->rstc2 = devm_reset_control_get_optional_exclusive(dev, "rstc_n");

Consider an r9a08g046 node with no resets, or with resets but no
reset-names. It passes dtbs_check, and probe gets NULL handles. Then, in
rcar_canfd_global_init(), the calls

  err = reset_control_reset(gpriv->rstc1);
  ...
  err = reset_control_reset(gpriv->rstc2);

do nothing, and rcar_canfd_reset_controller() runs on a block that may
still be held in reset.

This gap came from the earlier commit in this series,
"dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC", not from this
patch. It is still present at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
