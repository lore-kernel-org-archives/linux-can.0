Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399625;
	b=I7PeiZ3y4e0SkVFSPq1qZk6GJu0pZqtsVXa+Jca7Yc9+b3mExzbrNbjw8nm1194UgKar
	 HRWdnTYhKLhSlNwS9mhUUKLR2MyIIGiDGy4C3AWliZbH8JTaBGeX1KiAuC2QQP/VWA0G2
	 UmaLuZE1eDfjJFNtsircIQ6Wu21bYnC+qiFdYt8UYhzfOeBSP+EtOU7nX2OQBWhg7hoI8
	 BxckEJcMY7NHasDjmTUeokBi8E5ZQ3RkawXS+ewAA4UNclfNXPfITpFzI+xRl2YLU42wY
	 DpoCl5/uVfXK4y033wU9C4HfenrgZFKAY99pexBlShaNRlhxN8kFHCtUOPTaPnv4Owg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399625;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/L3ffe7Pt6ycIwojqOm3JwdBn/33EOEw/o2Avall4NE=;
	b=w237CpiR115dRIL2uXNn4/TgMzFbsjOPfhZaemymQRUC43MSYLj0PKSOMD79kqyDzIkm
	 AWiIuNIGZT8wPaHfmZFr///dBua2Lfdn05DRxVmgnql5+9h0ZUbRPtVLpbqQlajHw0FhB
	 yhNTdfEimnGLgwQ9Q/TWWXPI4rlCSNO0P3qEMSRUk0Lv25Jc/0fB/cVW/qvU/6mJtsZSC
	 KvwCbdiOkUFzGrct/Uz8/1QrLMC+ERMb7GT5AxERPNXxaAn/7uwem42Il1OUDFKn6MtXp
	 FHnVwuwudqciUfdUg/sdLmgd+d3Ga9Gv+iUcpWtBJqz4eQa6+umyDSq5+Hx2CZ0h97g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1WWhyQ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A5606A8B3;
	Wed, 11 Nov 2026 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1WWhyQ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2C31F00A06;
	Wed, 11 Nov 2026 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399625;
	bh=/L3ffe7Pt6ycIwojqOm3JwdBn/33EOEw/o2Avall4NE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y1WWhyQ1XvBf9zq4sL4RVi4pr9ONQEl7x2awG+Z8C6D+0apdblK9tZz4rFeMhCwLk
	 9hFCCDE8XStygv+DbcVmJV8C+S1AFr6j0EiZ5i7rtTFaNXngNje8Sq95i319ZLABKv
	 nemT5Op9pMcsESSxSjjS+hUrfxWnEYJ0oYFH9vrF9I1FMQwg+xAf9xCmlVreUWOwf3
	 TGCzhALS1SZCh//1uAgJ4zcJMN6cGawdmzir6veiC9gpkC7yzzwOpj2hhlwTSYMhOR
	 lUuvEnvXATHSOx9KklrfvO3SOZgYhS9oAxl01LiQZrqeciFuMuow+c5v83DCTi2oP/
	 vdMiovPKi6VWQ==
Subject: Re: [PATCH net-next 11/12] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3L SoC
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 claudiu.beznea.uj@bp.renesas.com, geert+renesas@glider.be
Date: Wed, 11 Nov 2026 12:20:24 +0000
Message-ID: <179439962412.2199510.7625889299374471388@kernel.org>
In-Reply-To: <20261110115112.3807247-12-mkl@pengutronix.de>
References: <20261110115112.3807247-12-mkl@pengutronix.de>
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

- [Low] When this commit is applied, the driver header comment in
  drivers/net/can/rcar/rcar_canfd.c names only RZ/G3S as lacking…

--

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC

This commit adds the RZ/G3L (R9A08G046) compatible to the R-Car CANFD
binding. It describes 11 interrupts, 3 channels and at least 2 resets for
the new SoC. Like RZ/G3S, it forbids renesas,no-can-fd and
renesas,fd-only for RZ/G3L.

Link: https://patch.msgid.link/20261021-canfd_rzg3l-v6-3-b4abfdba8e70@bp.renesas.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index 81674ea4bef47..dc74377021207 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -356,7 +379,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: renesas,r9a08g045-canfd
> +            enum:
> +              - renesas,r9a08g045-canfd
> +              - renesas,r9a08g046-canfd
>      then:
>        properties:
>          renesas,no-can-fd: false

[Severity: Low]
This isn't a bug, but with this patch applied the binding and the driver
comments disagree about RZ/G3L.

The binding now treats RZ/G3L as having no Classical CAN mode. It forbids
both renesas,no-can-fd and renesas,fd-only for r9a08g045-canfd and
r9a08g046-canfd.

The header comment in drivers/net/can/rcar/rcar_canfd.c still lists only
RZ/G3S as the exception:

drivers/net/can/rcar/rcar_canfd.c:
 *  - Classical CAN (CAN 2.0) only mode (Except RZ/G3S)

The comment above the mode handling has the same wording:

/* This controller supports either Classical CAN only mode(Except RZ/G3S) or

The next patch in the series, "can: rcar_canfd: Add support for Renesas
RZ/G3L", changes both comments to "(Except RZ/G3{L,S})". So once the full
series is applied, the comments and the binding agree, and this only
affects this one commit.

Would it be worth updating those comments here, or noting in the commit
message that the driver side follows in the next patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-2-mkl%40pengutronix.de
