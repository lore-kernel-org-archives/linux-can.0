Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46F381AF4;
	Sat, 10 Oct 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640978; cv=none; b=bawwZZlYDYILx7Q7PDActc7whyu9IeORi5b7vU+VzVL2ve9QjwYw74X7+foYOsXn1vAyAfT9hdOImJRUOSdy2CvKsAklMLyy8FrluFsH4wD493WM7YM1XfJ0b336jixwHnN5EQb80F0C6Ts9/FPk8coUZhBCe413I1ewev2uwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640978; c=relaxed/simple;
	bh=EU+eBOqPWm62Qq+isKz8W6PCeX+iuBYe+ZpwytuGcEk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JtZjcHVBVMrzdyLOOpWtZQP0ozmGsxSbN2pvo+KvYQSsI/2UxUeC7KHpJtc9sHMIVnHBd2pMBL4732ueanvWwF7ApRrXwxflspBMznfLnWeOzp23x4VPC2yIZXdwqLOMFBEOaZAjLGt/aMfrr8Ofxtqnmrp9eGaS/G92ltgZZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNck8e+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNck8e+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0721F000FF;
	Sat, 10 Oct 2026 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640977;
	bh=lhzzyVP2KBxhvCc0eFGXZe2FcP78lD89ZEoRe4vQwRI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZNck8e+jPdWB+eXpW5eWqdxRdwUl4cdGkOljNq3pwhKfnj0IsWQKax0ip035HWPfU
	 HjfifBkMufdoMX126ptiEFlbsbdk9RLCTp0sQ6N6B3/nI1tijaN4jzUtD5uEknDWqh
	 F4ZRNLw2XwPIQ81BggnDM5VZzU7BtpsLJ1k7B/TAwm68JmBT+lC2jkWV03HhMZsdZA
	 mBewYiJ0vvOH9FwSFgWlu7D/BqUo8Oq1u40sTDiaFmQ+ENhBtYyZ8idGh1sECPpscT
	 YiEcBV7cp3OefPuymAL6Vg3oKYwsnPbDzxfFf1sXnMnc+Ua78QX1CcwynBW4CEM6NG
	 BuYn+mIyiwAzg==
Subject: Re: [PATCH net-next 16/37] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3L SoC
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:56 +0000
Message-ID: <179164097608.434549.2353662905960345381@kernel.org>
In-Reply-To: <20261009134323.64064-17-mkl@pengutronix.de>
References: <20261009134323.64064-17-mkl@pengutronix.de>
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

- [Medium] The patch adds the RZ/G3L compatible (renesas,r9a08g046-canfd)
  but does not add it to the existing allOf block in…
- [Low] The new RZ/G3L allOf block in
  Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml…

--

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC

This commit adds the renesas,r9a08g046-canfd compatible for the RZ/G3L SoC
to the R-Car CAN FD binding. It adds a new allOf block for RZ/G3L that
covers 11 interrupts, 2 resets and channels 0-2. It also adds RZ/G3L next to
RZ/G3S in the block that disallows renesas,no-can-fd and renesas,fd-only.

Link: https://patch.msgid.link/20261001075742.21961-2-biju.das.jz@bp.renesas.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index bbaaef8f4282e..cef20f0403715 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -292,6 +293,25 @@ allOf:
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

[Severity: Low]
Should interrupts and interrupt-names also have maxItems: 11 here?

The top-level interrupts and interrupt-names lists have 20 entries. With
only a lower bound in this block, the schema accepts anywhere from 11 to 20
entries for RZ/G3L. That means ch3_*, ch4_* and ch5_* interrupts pass
validation, even though this same block sets "^channel[3-7]$": false. The
commit message also says the part has 11 interrupts (2 global plus 3 for
each of channels 0-2).

The other variants use exact counts:

  RZ/G3S and RZ/G2L: maxItems: 8, combined with the top-level minItems: 8
  RZ/G3E: minItems: 20, combined with the implied top-level maximum of 20

Since 11 falls between those two bounds, RZ/G3L seems to need both a
minimum and a maximum. The upper bound is still missing at the end of the
series.

resets had the same problem at this commit, since the top level was
resets: true. That part is fixed later in the series by "dt-bindings: can:
renesas,rcar-canfd: Restrict resets in top-level", which changes the top
level to minItems: 1, maxItems: 2.

> +
> +        resets:
> +          minItems: 2

[Severity: Medium]
Is renesas,r9a08g046-canfd missing from the existing allOf block that makes
resets and reset-names required? That block still reads:

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

The minItems: 2 here only applies when resets is present, so it doesn't
make the property required. An RZ/G3L node with no resets and no
reset-names would still pass dtbs_check. Every other variant either
requires resets or forbids them (RZ/T2H).

The driver won't catch the omission either. rcar_canfd_probe() gets both
resets as optional:

  gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
  ...
  gpriv->rstc2 = devm_reset_control_get_optional_exclusive(dev, "rstc_n");

These calls return NULL when the resets are absent. rcar_canfd_global_init()
then calls reset_control_reset() on those NULL handles, which does nothing.
Probe succeeds, but the controller is never reset or released from reset.

This patch does add r9a08g046 next to r9a08g045 in the no-can-fd/fd-only
block. Later in the series, neither "can: rcar_canfd: Add support for
Renesas RZ/G3L" nor "dt-bindings: can: renesas,rcar-canfd: Restrict resets
in top-level" adds it to the required-resets enum.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
