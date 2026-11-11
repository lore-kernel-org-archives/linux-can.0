Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399623;
	b=OWsSX1NN7jdbSuLfk9z2owcbXLfdz7rt2rCJaeJyaat02j2OECuFbKdKAc+UOWzwBwNZ
	 b8o9W2KZayTh+MsMShVis0OpZGem2YXhA9p8G1FQ7qlDF6gpViSqY12HaMFk1kfBXLQzP
	 p6s9Q4vSaGGY2fmongUKExTSn8NOGG7/qQRWOVenaKCrQss+ofyHRPK+/ak4HOdWUv+yg
	 XuddOmBRQlWAdF7URHQpt0Dw6ZLrQJrp9e++KkEqC899u+puOzHRAPbVMecgDdHmZzNqB
	 4IdRdKR1BK93XpJ8Li1sqTPXz7jaKYVzcmQ26I0Rc/lvRbjrD7cHDDjm3SF9SuxVNyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399623;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uvTO/BGLZIZbUjQrcyChcQsusy9kc1T9we0lQKGwQ98=;
	b=b99hmh01+Rwj2Bu1/8uvjVkX1en6J7FzHkzPgrBuw19hu2bQGcaokRkjAJKX6mEJ021Z
	 C+nqPRNgjW3aalLOSCv+3D+AnjEDx44/TG5tgugcYRX3Qfq58uoSprBWX6xDHxaY0jcBp
	 Q/FSW1TYytSiRuuIVl/ambWV+iS9JIL+fy94aghYMJaqgAXs13T2chzRHqBNkBnO7jC5e
	 5SEWUtRcThl9B+tL6gtKdzhwTwe0fF2onDy6MQWHSyonURg0qz2OGWI+ZAKzTBo/Nrgqw
	 UK17w2TqcY6meaJqI79o49BwuUW8QhUNSql8dfNPNSJPqixh0xVYXMtMbNCqcrNivhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYMtDnvp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034D606A88D;
	Wed, 11 Nov 2026 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYMtDnvp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927291F00A0B;
	Wed, 11 Nov 2026 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399623;
	bh=uvTO/BGLZIZbUjQrcyChcQsusy9kc1T9we0lQKGwQ98=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RYMtDnvpFvdP8OHSwZT4k2fO/3Sdl9BTEHztLyPmnXJzUNYR9s1pe/uTTBlVnrxWr
	 V/vd7r7NE/8cIidAps0UK1IcCBINa8vtd/8W6z6oj2c6sNWtYVdhl6/hymtsqMvNce
	 oXynS/37XgRgbAyCNA1r24K14PXVZ87+w3iBWraGGfbcQ1S+zONpa+wK5wXTUzPsO/
	 i1ZEKjFzPCy0QOtbZPy5ZGaHFtuFN8fBjh5rUoGzKAp14TMtvdyBeOUzH8IZ6FFTw2
	 Nq5N68eDot7n7LOyn7832eXnUeYOjMeCfSvokmXfZNv5pKOqMDNp4QqnDvNmJf5yPd
	 U3B4dYuyWRDyQ==
Subject: Re: [PATCH net-next 08/12] dt-bindings: can: renesas,rcar-canfd:
 Restrict resets in top-level
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 claudiu.beznea.uj@bp.renesas.com, geert+renesas@glider.be
Date: Wed, 11 Nov 2026 12:20:22 +0000
Message-ID: <179439962217.2199510.18202330076530254925@kernel.org>
In-Reply-To: <20261110115112.3807247-9-mkl@pengutronix.de>
References: <20261110115112.3807247-9-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In Documentation/devicetree/bindings/net/can/renesas,rcar-
  canfd.yaml, this patch adds `reset-names: false` (line 235) to the…

--

dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level

This commit moves the broadest constraint for resets (minItems 1,
maxItems 2) to the top level and drops the per-variant maxItems 2. It
also adds reset-names: false for the rcar-gen3-canfd and rcar-gen4-canfd
variants.

Link: https://patch.msgid.link/20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index bbaaef8f4282e..1a7a9ce45e977 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -231,6 +232,8 @@ allOf:
>          resets:
>            maxItems: 1
>  
> +        reset-names: false
> +

[Severity: Low]
This isn't a bug, but isn't this rule already in the binding?

Further down in the same allOf list there is a separate block for the
same two compatibles. It already disallows reset-names:

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

So the new line duplicates that rule, and validation results for gen3
and gen4 device trees are the same before and after this hunk.

The commit message says:

  Since top-level part says "reset-names" cannot accept one item, disallow
  it for the two variants which do not use it in practice.

That reads as if this patch adds a new restriction. Could the extra line
be dropped, or the two gen3/gen4 blocks be merged into one, and the
commit message updated to match?

>    - if:
>        properties:
>          compatible:

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-2-mkl%40pengutronix.de
