Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BD84CB8D7;
	Fri, 16 Oct 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157667; cv=pass; b=NNylHP7DTYz596za3QEgaufgUxL52QRHIWPvA2T8CNZ/Jtb8hhKhxWHWy53l8rz8CsowVVQoAhpg9WSXqk+JQwuPowPL2HO2a/uruLzCzLbWnoP/kQZ3souPvueWTKpJxzUc/oZb3XfuboCiCzsqs1CqNv1M01IYhCz7/bby0No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157667; c=relaxed/simple;
	bh=vccj/ifJc7BK2XQhk38NP+nrVX4c4SiXTzDhAs0eU9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyMCRBhTmR5v7mlKdXGDyZHn5Ea/eh53xRtt9hU2+xZp51+Mf6GuScJr5kJop9ItYh1TM5H4e3H3vmXJeyJvODy7ls46sRD4cWRtDTTVUACoqKCiCjtT+hA4/3JxnwuXZekPzAvAr1lcBtKBESahkt8tO9mBRIqajhSRssVcqi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VQ4LSMIm; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VQ4LSMIm"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 50E5A2027F4;
	Fri, 16 Oct 2026 15:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792157662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nLMiQqnLjn6aVre0f/RZP2YyGl1quEq2a7eoQjxaGY=;
	b=VQ4LSMImcv/161xpQDs9ZVPDfT8fHJo/N/IY8+Ku8osLUz1bb8+5sLdwVKJd4Lwa/b1/N5
	gKo1UBGdafjmyy0RoZZ2tSvFVEic0kOV6mN8bF5IKlXgWCV0MU9DX4tt2Qa96keQHkp27/
	ICIApdgKHAz+KKenLFqPeJoSKP29qgQwz6q464ZtmlxsUr99YRAzCqdxcAFApHhjxptTFk
	zqziyYzXqaDASJc6owOtOwClrtbjOQXGCzaANm5Szs38jjqJCpa38iTI3tq8CU6tUACyZx
	Yu61lvwpyeqr1JFITEbDsWiAGz7S9GUV5sgp1kjJY6rFZ+ORLosgNzA/hbWChA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792157662; a=rsa-sha256;
	cv=none;
	b=MOGWQ2pyh9Mts1lppt+K/8bdG0dNIGJjN5lpy7hygtApxbAM+GwgDz28lJsLj2nQZOKn6t
	NvI8r01cEwb+3cyNL4+ZI6qg+UpQZQlamKK19vCdl3gx3M0jtmoHk500cX3ND1afAikjfm
	4oGTN/sCYvFgpMV3Ms3wPehVuFztfcgWfiGM4IXeGmwGnlJ1Bw1MZnGHjMHWia2CWzltnV
	vsYSou3csltxXlcE2WaCNf2rz/nsdVGWUCk5vSU7KCjcLFgchqu4PlzCc4t9JkqT7vrHr9
	kQPgIKiz4NwW8tKZOe0KRLeiohaWYAru7XOKNgWo2+jTRSJLiPxtxjDF3yU6yA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792157662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nLMiQqnLjn6aVre0f/RZP2YyGl1quEq2a7eoQjxaGY=;
	b=QzerExYjwIYLepg2PZUXx9ywvJL2YKpH/DaR9XLGuYLh9bYXqnpbh4FpLhCQXE+nuOOiRs
	9Fe48Jhd07dH9KRQPx//wK3Cp0Y1tP1ueYo6T3CwCr/HLvsi9voxsbeeQN/jndNI5qU1ps
	vhAmRlQvDR6w9BBvwH2qTftw8687joe+BDsPDG5nFVMUAKw4ONgptvljE1ZFWyHtesPNIJ
	lakGP+fhQTA5DcdnJr73hefMjCKaMztMY0hpMO/JG0tQthSGhXEG3TsFAY241lAACC3Mkq
	/4W8Rkev/h96p0pVdsfnKWgyofYgMCxzROdZEXz2A75f+bl9tHK/7LFpaSFpvg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHi4k-006BzY-0j;
	Fri, 16 Oct 2026 15:34:22 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D884F5C6255;
	Fri, 16 Oct 2026 13:34:21 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:34:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
Message-ID: <20261016-elite-feathered-rook-5dcf2b-mkl@pengutronix.de>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tyz6trijudgkdey6"
Content-Disposition: inline
In-Reply-To: <20260902141544.565763-2-claudiu.beznea+renesas@tuxon.dev>


--tyz6trijudgkdey6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
MIME-Version: 1.0

On 02.09.2026 17:15:38, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The CAN FD controller found on the Renesas RZ/G3S SoC is largely compatib=
le
> with the variant present on the RZ/G3E SoC. The main differences are:
> - the RZ/G3S provides only two CAN FD channels
> - the RZ/G3S supports only CAN FD operation; the Channel n CAN FD
>   Configuration Register does not implement the bits used to select
>   classical CAN-only mode (bit 30) or CAN FD-only mode (bit 28);
>   consequently, bit 31 (CAN FD Frame Distinction Enable) of the same
>   register is also not implemented
> - some bits in several registers (mainly reserved or status bits) are
>   read-write on the RZ/G3S but read-only on the RZ/G3E; their behavior is
>   otherwise identical: the bits read back as 0 on both SoCs and software
>   is allowed to write only 0 to them on the RZ/G3S
> - the RZ/G3S provides 256 acceptance filters, compared to 768 on the
>   RZ/G3E
> - the RZ/G3S can use PCLK clock as the CAN FD clock source through an
>   internal clock divider, while also supporting an external CAN FD clock
>   source
>
> Since:
> - the SoC clock generator provides to the CAN IP only the peripheral and
>   the RAM clocks
> - when sourced from the peripheral clock, the CAN-FD clock is obtained
>   inside the IP itself by dividing the peripheral clock
> - the assigned-clocks and assigned-clock-rates properties are specific to
>   the CAN-FD clock
> the assigned-clocks and assigned-clock-rates properties were dropped from
> the required properties list of the Renesas RZ/G3S SoC.
>
> Add documentation for the Renesas RZ/G3S SoC.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

the netdev review bot has found a nitpick, it's about the comment in
"rcar_canfd.c". Can you fix it, if you re-spin the series.

regards,
Marc

pw-bot: cr

--- Patch [11]: [PATCH net-next 11/37] dt-bindings: can: renesas,rcar-canfd=
: Document RZ/G3S SoC ---
commit 69b4e37d18e5229e1c800b45a5df061af8a98eb9
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC

This adds the renesas,r9a08g045-canfd compatible for the RZ/G3S CAN FD
controller. It adds the compatible to the existing conditional blocks. It
also forbids renesas,no-can-fd and renesas,fd-only on RZ/G3S, and makes
assigned-clocks and assigned-clock-rates required only for the other SoCs.

Link: https://patch.msgid.link/20260902141544.565763-2-claudiu.beznea+renes=
as@tuxon.dev

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
=2Eyaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
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

Discovered by: opus-5-5 =C2=B7 Missed by: fable-5-1, gpt-6-astra, sashiko-g=
emini =C2=B7 Confirmed by: fable-5-1
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
 * "renesas,no-can-fd" optional property to the device tree node. A h/w res=
et is
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
--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tyz6trijudgkdey6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIn2wAKCRDMOmT6rpmt
0tQbAP9Ug/X3eNIoM36oizDYKKb/napIJJRBsaKLAK0rUnv0+QEAgDyu9tkc4gs1
3oMi7A5Lbxqc30SHapAOToYedxza7QE=
=DPtZ
-----END PGP SIGNATURE-----

--tyz6trijudgkdey6--
