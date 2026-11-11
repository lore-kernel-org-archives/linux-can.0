Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397895;
	b=0JQYhRvFyJ/FQ3XZ6d7Ssbrrmq0Y71FkLkIpjwDjE2ZvGAPRv3VEt72VDV7CUDyC125C
	 xYw0IYBUVUOFJbExAbg9S8uVobPks5K1a26I89fIudSkJTV6iQMVCm+uI8OIQQbG1oOEu
	 T/i+JnEbNVFJjolw4sf698/Id40FhaXb24x9Hby3AtZMOb8X+L8eTpqY03BP7A0OiIqrU
	 tix4+jpO1MA+hAVgOt+eYYx01cvkFU0Hak5ephbxu/+nAq34pLOHKw94tNGMg06jGpm+X
	 cHAF+fmYdzkxVBOxhqWpWdDuHOwzaRpyvorZgOO7lfQEwPuIGGw+7kxZWaqjVf6Hl8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397895;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FsbY8AudZjixZbGA6GxIg8IHccpDI13RfCLq5yH6W+U=;
	b=mE3wqw9fiog8KRdM41OgvS5ZUOIHYB+hITqeo9To/28LXTu2i7Xsj4WKlNz3xdHJFntj
	 Rxhy8L98Ng3tTBX1h6RC7lifMKQx1dExv2g2MRBfTcZ6xINi7G8cLbX7vZ0y8FCaG06P0
	 Tju8VA408d07r1WaYV6OBnLE3T+r3um5W4VneLW4FNmkc1xuWaWOGxfBbX0uy+nPt7s0t
	 RDwCK4jsDgTrEd5vQjBDCwm/kKo7XFjEqSTIvCdv3GpK/B/U0aeyn1jjbSE5KJAHBVh3h
	 uAAB7gSHiw/M53U6mb+Neokf27kimfjly+x4r6EiPnt138vI69Gd55Gt6iuVGPxQkow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSk4HMpf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C27606A31C
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSk4HMpf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312FC1F00A05;
	Wed, 11 Nov 2026 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794397895;
	bh=FsbY8AudZjixZbGA6GxIg8IHccpDI13RfCLq5yH6W+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSk4HMpflJyQ4HhjODLx8pcoDh8b3rhCP3TJEjnO63qh3GMh5SfCGdD5NJtx0dPyP
	 HqETgzZboOoKD82sk/n4CabDziTwgBvlv42DkW1/ehDDvpmgYSVuhLWj5snM4xeOA1
	 bUW23S10VbjNhBtudYjT009mUOUb7CeHGwWOu7mJ+HPRb2Lh3WO97+4Tqrj1a/XQpH
	 YCxk219CAn8KGdXW8v3ierzLxrhl1m1mh5KEWChIVulIQVpMWAVXckiv4CuOxmRQi6
	 DVeOdRrx/moTc90RGx/gAleeSz4pOOLQad+F05mi04JFbT+wWBQKwjfvmTzYngaUQH
	 PUku3XHkZyjXw==
Message-ID: <sashiko-outbox-208910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 08/12] dt-bindings: can: renesas,rcar-canfd:
 Restrict resets in top-level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261110115112.3807247-9-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
 <20261110115112.3807247-9-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:51:34 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: can: renesas,rcar-canfd: duplicate reset-names:
  false in allOf
--

commit 673edc90f4112a3f288e1450d2ac3c1b416dd41b
Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level

This commit constrains the top-level resets property to 1 or 2 items,
removes redundant maxItems: 2 entries in per-variant conditionals, and adds
reset-names: false to the renesas,rcar-gen3-canfd and
renesas,rcar-gen4-canfd conditional block.

Link: https://patch.msgid.link/20261001060825.53335-2-krzysztof.kozlowski@o=
ss.qualcomm.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index bbaaef8f4282e..1a7a9ce45e977 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
[ ... ]
> @@ -231,6 +232,8 @@ allOf:
>          resets:
>            maxItems: 1
> =20
> +        reset-names: false

[Severity: Low]
Does this duplicate the reset-names: false constraint already present in a
second if-then block for the same compatible strings further down in allOf?

Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml:
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

These two identical if conditions for renesas,rcar-gen3-canfd and
renesas,rcar-gen4-canfd could be merged, or the binding could be split into
separate schema documents to avoid accumulating fragmented per-compatible
conditionals.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110115112.3807=
247-1-mkl@pengutronix.de?part=3D8
