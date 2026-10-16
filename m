Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF0337BE93;
	Fri, 16 Oct 2026 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159460; cv=pass; b=S1KCQqkIuPYRHW9ml+94GRgRmiMLRL9T9BV7VBOx6usJXiiHlqlZ7mHtsjF6Apdaa75sfZj/v+caL0Cio5jb1KxYx4dADaR4QDNr7h+A4UXv/P43z7KzY2DQMEoZSl3/z/FSLKbzv9+uoKDGCcojRf6H8JpJefuEFperuBm1Qps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159460; c=relaxed/simple;
	bh=VUl6gVNdKIJ4s7OSqVmASoXnpQR4GceeAj8byAowHyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bmsm/vzwXDarcmrNVgnlDiLDeBOYR/+Fr5RXZQ3nKb/ulUQ59DCxUmrVpMnxt+q9mfB4ro6ClSm6hbNdsHOWKV/Bpz0kAIBcVTwxX1i7GLc+BnNWYw/rXBibqyrga5A2HXLMNpSz2m3jIBp37Kcdn3ywuFYgbApqEcbnr6Teh/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=JWlKjW0m; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="JWlKjW0m"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2A9F5201F04;
	Fri, 16 Oct 2026 16:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792159451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UBP8mrt0TVmY8wFyoJstIq+aP6ShlwP9Q3lNVa4Ugw4=;
	b=JWlKjW0m+H/CLIuVL90Clpv0PougBoPD/p3irnKqbHM/yNGg3bGH5RpMBnSwIsEDWIjCTJ
	gJEBfTv1xUnM11qcMZHx1u3ohZJt9lO4MbuIbKB06NixNtDj8KldDgM834eBYtUU4IPzip
	etTIY7mt8AZltdheDSAqBVUoxKBf2t8wfUojGhuywl2PKS0k5usI88Gdq5fqvI/zgNaQZu
	9PxFTFaEn/sWBuJv+4BUxypd5/coQV4D82oMnDfOlVylUdW7MIj9gLI8W/sOH5bkkrl82J
	IdiZNDcGukDPR3jmrIG+9PN4CmX2SnJzYmObvQOppMgSN4OD/O5e1NKfinxHMg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792159451; a=rsa-sha256;
	cv=none;
	b=bog+iWE6FVjLbgsx4iXHlkcX24BmnxPit2HPnmvvLXRQpUoS7dUdVHxElVvMwSaDyRIg0G
	w6X4xGalUOB5AZzeKsRrsFRZCgwcwdW5lFla7L3UX7alG6+1n9i7pX0bGtO5zMfq62jXsa
	k3pTDj1XXGjFDl0lC903BkYsgS22KNxwRMedLVA0KvlbcppY5oLEjWgavQXwfgaJIUe4ik
	0++gDEu5FPPK7M/hTNpGfdvNuomer2kGnHnYC0nFWIMjqtKaqFbtggqr99jLmBxq/51UAD
	rq5A/36kEpVSvFutHSFz+EQVMaZQUiYv4bmo5mq8ndRAz/b+pa1ozN+6T9hg4w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792159451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UBP8mrt0TVmY8wFyoJstIq+aP6ShlwP9Q3lNVa4Ugw4=;
	b=XAsoT7lgpgSmfc/Z+aAi8nx4CcwsP77cWYiADEuXmCDgvOBty6T0mpLkkiGPcjvmcFKXTj
	ZX967jyWOk652ajqbDDbQkcLZ2IvMr6zG62/fzLINNFBM25TMom/GO3ahMKrBXAZKuuulW
	sPgOib5TuVDOf87mfambo7/MsRY3subIXx/vo0lkC/NSiuNRVZtqHUi8aZdW21mswDBuQ5
	l/nOJEupqfGJEJjP8fdnVIvhCNUah8PHLn2avwEDI8HbD6V5LTajvpaCc7JjoW+mzGL7IB
	Bya6zq/8offK+51PZjx/ffNDk28pLaxr1xCdDcaAnuIdGXqXYouP6o6DCrPSRA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHiXb-006CHD-0D;
	Fri, 16 Oct 2026 16:04:11 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 99A7C5C62AA;
	Fri, 16 Oct 2026 14:04:10 +0000 (UTC)
Date: Fri, 16 Oct 2026 16:04:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Biju Das <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
Message-ID: <20261016-rebel-ostrich-from-vega-f759c8-mkl@pengutronix.de>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
 <20261001075742.21961-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esxko354vy65ak3h"
Content-Disposition: inline
In-Reply-To: <20261001075742.21961-2-biju.das.jz@bp.renesas.com>


--esxko354vy65ak3h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/3] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
MIME-Version: 1.0

On 01.10.2026 08:57:37, Biju Das wrote:
> Document the RZ/G3L (R9A08G046) SoC support.
>
> RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
> and 2 CANFD channels on RZ/G3S. RZ/G3L has 288 buffers in total
> compared to 192 buffers in RZ/G3S.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

netdev's sashiko is not happy:

regards,
Marc

pw-bot: cr

--- Patch [19]: [PATCH net-next 19/37] dt-bindings: can: renesas,rcar-canfd=
: Document RZ/G3L SoC ---
commit fc695079a1d27e4f3c22db8f5e2f44e2caa44db5
Author: Biju Das <biju.das.jz@bp.renesas.com>

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC

This adds the RZ/G3L (R9A08G046) compatible to the renesas,rcar-canfd
binding. It adds a conditional block for 11 interrupts, 2 resets and 3
channels, and puts the new compatible in the block that disallows
renesas,no-can-fd and renesas,fd-only.

Link: https://patch.msgid.link/20261001075742.21961-2-biju.das.jz@bp.renesa=
s.com

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
=2Eyaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
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

Discovered by: sashiko-gemini =C2=B7 Missed by: opus-5-5, gpt-6-astra =C2=
=B7 Confirmed by: opus-5-5
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

	gpriv->rstc1 =3D devm_reset_control_get_optional_exclusive(dev, "rstp_n");
	...
	gpriv->rstc2 =3D devm_reset_control_get_optional_exclusive(dev, "rstc_n");

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

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--esxko354vy65ak3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIu2AAKCRDMOmT6rpmt
0uDBAQDZJ48T9INBV/kt3TlwBa6nGVEr112QaJdbWsN2fvNvggEA5J+7XLk7LczN
ahYkOkq9J9eWhRx+CnfpqL7TPOUYBwo=
=mTk3
-----END PGP SIGNATURE-----

--esxko354vy65ak3h--
