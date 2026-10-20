Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514952;
	b=S1D+y+khGtMjm/g9i7uAL833DJyxURB1my6e3UjM7gMeofO4J2LrtJWMIOzocBWaOi/6
	 jXmjtOI+2o/3Cm6r4R/jJr+8kF512KJ0PXXpjSVMXRjM6lpzhlJSAiu8CzhEGlIzh+y7Y
	 4EmIoqCw1ELLGwN5clvlbhfqi+M4Ou4UV4mFh/g3LgoTI5hEkNLl8byFkRv3b1+CKIh0T
	 tUtHJ6nNGJcJD4sfeyB6Ri0RizBERKJGmq+kSsksVuB4THnyLMRhNN/WYERDfTE1uhjKT
	 XlNK1eCRRuBRQm9c4clAKgN+KJYNew/f1vbRyJoU4h1ItPpQX3w4Ne99OVdiOgZ0+qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514952;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tlyBco/6nuBK4I+/Y/ntapwbtlwqL9qb97HWwAexah0=;
	b=ClgVTei5/iIIMAXRIQ7DpX6exlK4QaPRRcBmipb16GBT6ULhsWoa7gcZasaCtvF06VTQ
	 IXSQNO29EEzUjVseEOUBcYYbeg8J/gG06xILLZAT4AOFeGSkWivHzo3QMmzDOUlWx9sEy
	 Pyr6ITKXN49V1kHXaCPJdQ2HTOUsB0lBECrfn+zsFHRMC2n3VklA55oMVL9NMLwdpJBC1
	 w5hrn/0oGBIzFpYwmOxtfZaIuAPBl7C8A8Q9Rk4AIFoomaM0INehV+qJENsPDYmtfmEHX
	 O0e21xD+K7JWBQJQYYGxGWVKSotBAnIUV4iOvA4wLannaSuL0iua65EBJRoge6N66TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7293606D551;
	Tue, 20 Oct 2026 16:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA621F000CD;
	Tue, 20 Oct 2026 16:49:11 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:48:40 -0500
From: Rob Herring <robh@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S has no Classical CAN mode
Message-ID: <20261020164840.GA4094037-robh@kernel.org>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
 <20261019120220.166163-2-biju.das.jz@bp.renesas.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019120220.166163-2-biju.das.jz@bp.renesas.com>

On Mon, Oct 19, 2026 at 01:02:13PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The description of the property that selects Classical CAN mode implies
> that every supported SoC can operate in that mode. This is not true for
> RZ/G3S, whose CAN-FD controller supports only CAN-FD mode.
> 
> Update the description to say that Classical CAN mode is not available on
> RZ/G3S, so the property is not mistakenly used for that SoC.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v5:
>  * New patch.
> ---
>  .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml       | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index 1a7a9ce45e97..7d3330f8fc1a 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -146,8 +146,8 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
>        The controller can operate in either CAN-FD mode (default) or FD-Only
> -      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
> -      property to put the controller in Classical CAN mode.
> +      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode(except RZ/G3S}.
> +      Specify this property to put the controller in Classical CAN mode.

Can't this be expressed as a schema?

>  
>    renesas,fd-only:
>      $ref: /schemas/types.yaml#/definitions/flag
> -- 
> 2.43.0
> 
