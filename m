Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE6E39EF0F;
	Fri, 16 Oct 2026 02:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118228; cv=none; b=Zda5D7+ygEb0wo87OJb1pKzIkPbjN/LVQtib6aqIwHm0BK+T/JnMMbZHXbj6lBZMQ+Mzy4+OJBBcy92U+0QonfEIJx4rS98NM42EONFpyjwvKf6yJD9yaKx4KK+O0RbrtEsqntNydCPQ/WtPgAUeZGLg2SzQ+27lqDgdw8MH1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118228; c=relaxed/simple;
	bh=rvFXOpzN1CT6wXMoyTATyXlBBlxkX8HFBohfqkAEjc0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=syvFQqxEolYX+KF/IO4Cx4bVRAq7piqp8v6E0IzM326JVzH63xQkEfh3JbShNdvPy3qEOv8HXuJ/zc9QijSV6laXHJgEvX8/i3yp2mtieI7B58ECnMJo7tvY2fN6DkUJiZGaatYVCGGyUU/v87TS5d+D3G9dxCMY+/0BLlDFbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfJgSx9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfJgSx9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26F41F000C4;
	Fri, 16 Oct 2026 02:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118227;
	bh=KpGzUkY68IOVX5Qp26PLD7y5jX9/auxJhj8C5sce3T8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EfJgSx9NU6eNhV+8GYnYrSyKFsQUJLfgtQcILWbDGJoKjx2AvYr00xDphSbCwbzZ6
	 H91ozNE+BSh64PtHo8+JetLtbdrPMdgIdLxbGY366UxI+mBsjBc9B2fxRjIptOTkDO
	 tS0fYFWvIpxuKX8GWYl1gq6ZkQwd49YyH83z6tg9aLXF+aXYXVIb8UYq+S44dSK6vH
	 qyTgH9NbglhCaNUuDyK8RzJgbGArSUv2F9YkYedg+CWEe/KyAFZe+K4f1zo+5M9P/g
	 MtbSb7A8zDuDPe6kR1rZOXdeJaG9SwrrsOWiH3pvnOo+LXtiwFRb6J6QuZR1h9jqCr
	 e2PsVXCuE1r3w==
Subject: Re: [PATCH net-next 11/37] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3S SoC
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:06 +0000
Message-ID: <179211822620.434549.8950926089601634766@kernel.org>
In-Reply-To: <20261015015336.816543-12-mkl@pengutronix.de>
References: <20261015015336.816543-12-mkl@pengutronix.de>
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

- [Low] The free-text description of renesas,no-can-fd in the binding
  still says Classical CAN mode is available on every controller: 'The…

--

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC

This adds the renesas,r9a08g045-canfd compatible for the RZ/G3S CAN FD
controller. It adds the compatible to the existing conditional blocks. It
also forbids renesas,no-can-fd and renesas,fd-only on RZ/G3S, and makes
assigned-clocks and assigned-clock-rates required only for the other SoCs.

Link: https://patch.msgid.link/20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index b9d9dd7a7967..bbaaef8f4282 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -350,6 +352,20 @@ allOf:
>        properties:
>          reset-names: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g045-canfd
> +    then:
> +      properties:
> +        renesas,no-can-fd: false

[Severity: Low]
This isn't a bug, but should the renesas,no-can-fd description be updated
to match this new constraint?

The property description in the same binding still says that every
controller can run in Classical CAN mode:

  renesas,no-can-fd:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      The controller can operate in either CAN-FD mode (default) or FD-Only
      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
      property to put the controller in Classical CAN mode.

With this patch the property is forbidden for renesas,r9a08g045-canfd,
because RZ/G3S does not have the mode select bits.

The header comment in drivers/net/can/rcar/rcar_canfd.c says the same
thing:

 * To switch the controller to Classical CAN (CAN 2.0) only mode, add
 * "renesas,no-can-fd" optional property to the device tree node. A h/w reset is
 * also required to switch modes.

Neither text is changed later in the series. Both now contradict the schema
for RZ/G3S, and for RZ/G3L once it is added the same way.

Could the description exclude the SoCs that only support CAN FD mode?

> +        renesas,fd-only: false
> +    else:
> +      required:
> +        - assigned-clocks
> +        - assigned-clock-rates
> +
>  unevaluatedProperties: false
>  
>  examples:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
