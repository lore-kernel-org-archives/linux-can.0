Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794555916;
	b=Hd7wIX2OERf17j/tA99KtX3ft0ARb2gvLbgRZgNuh3qSpwR0NuUyrAS4FAk4ovnCrhZz
	 ZPSNaA1wpmli6rLt2hL4sZGOCi5g9jFuDvjq/qq/pLMbuiY6ESIW7QZ+OramvoUL7WA63
	 T9BdQviBraN+ehO3ucfcONOZyW3DXyMylX/tVIU/N8QUEI24h0AhwxHE7hjw6rUz7UZTQ
	 NOGHgk3CJr8ThdtAUYX3VJL4hpreG+qe88o2AK6aE5KDXVXoOgRiVW7LL0mSrjOd6Hr8R
	 T51OJeN2EAk7yqtG3QhrNCDlgMz4kbtXIw7f/014pNY3Muw6pAtvxO0d/5lTQOv8GWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6KH9QoU86U6t3uiSeKZEJOixBUtRHmeH/AmGTPraC44=;
	b=yxK675m7Bq7cO8jc0Ias8aSAE38Bk17bR9CqVmzmAUBAO2dXjuLs/Tp0CxTxA3TO7VZk
	 /ibIGr+ca4mSXD39koz9PZ774WjVHw974qmLDyW463FCkzRtSjxdN7Uwe1X+7xU7873XX
	 LGzRJgSNcg0Nl3KKiGrBQwL4WoWgPKMSGB3QlJTDITYwRNpucbrEIAzUtOv/NgATrDPYJ
	 FDJOseIdfuzu2AJbIVPlwoObWFFeINv64GWKM7PolFe1uWxNPAyVQ5iZaSnCNMlcInKxS
	 R7InWj+ZcnrrvbEHJZgLbMOcd/TXnRGMEPACiXp+Q/zYbF3TduQdTkbGCCrxzbFYbYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cXx1NoXP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBEF606A891
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 07:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBEF606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cXx1NoXP
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DF855201544;
	Fri, 13 Nov 2026 08:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794555912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KH9QoU86U6t3uiSeKZEJOixBUtRHmeH/AmGTPraC44=;
	b=cXx1NoXPoHlQ+nkUQmmF3LfYklZEje6io/2gOX9HCKbfyJh81haLZTN6bLaNbvpMJlZMKs
	EtvML2/Aac0qSRsEWX7QTKXp+MosPqZ3Ymo21g93hsIkhBcgo6+tTWptKjB2+rjJDjOcsN
	6qztW2l00KEVEmnRktvMzD1QtjNmevpi+fJezGCMPsxv0isyxeiQOeYdDFJdwlgMI/9bLe
	4OOIXAWkiFj6Xl1v2IzEOZm4EneLfnulVwG8xYh0Xlb5Zcf837qoxTDCzotTEoai+Xxewp
	pCwsnSJIvg46Odcoe0UQyL3Jjp5a8LhRfwrk5hjSunreVf6SnxriaWIWEz8Sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794555912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KH9QoU86U6t3uiSeKZEJOixBUtRHmeH/AmGTPraC44=;
	b=L7E/XIcnkxGnxjbBq5MRb3pJVUjzWWVWOCbF76qxQJXJSiZCBMB9jePF68XHMjsQH6TMXk
	ALoxNAj8OZDr0RZqBnVKKnqUZsQGh/+Y5Jr0m/OFSJ3wfmS78/MevJqG2GbFrO65CnTo5P
	IRHabuaTjWSspI55xn3nYWE3L0aRp2+wO0nfY6VlhXkXQiIcjQ4+YCyQlavOWPgR+JQ8gD
	tSL3WwyTxuok8KP0Eldf9wHiuZ8o/mN/eg9aifJUIYqt8R4IKy2genvcaNFy5aOiSGOKiV
	SGOEvw88pktjpy4E3dip6LLEHAMJysCwNXYrsd/PHs2lFT1I2lmQ0qhRA2W5AQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794555912; a=rsa-sha256;
	cv=none;
	b=YSOd7DuoDv680zAM+bNBAOJkLUiAUcTr0QBmAjZ4XOq0zPKTYB3/1rJ1PbqnNtTn4rzT8g
	FmCLs2MCyvOwb+jXFOFIHJSQ/PiwrnIm6FpGrwaje7Je5BMz3pccoDWw1/jSlPOMMVAEox
	HUWoYBYrrC6YXJkcB9OD7YErbJba3H7H1PVlUxdmdBhff0AlNibVaVOb5YTce185uVkQOe
	9jgYbndDefWMVAhgCeeuk2DLH4hmFjY6xP1k9PfgKa29H8QLpMeU91y2kQpiUS1IjmFwyC
	vA5F2jJio9ujEmZ22HemslM82B0Z198JNkZkXdhNcbjAtLQlsIzR6kuSOrjVhQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlyC-003xPE-2c;
	Fri, 13 Nov 2026 08:45:12 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 852445EA638;
	Fri, 13 Nov 2026 07:45:12 +0000 (UTC)
Date: Fri, 13 Nov 2026 08:45:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 1/7] dt-bindings: net: can: ifi,canfd-1.0:
 Convert to DT schema
Message-ID: <20261113-electric-unselfish-woodpecker-57a446-mkl@pengutronix.de>
References: <20261113071325.4092169-1-mkl@pengutronix.de>
 <20261113071325.4092169-2-mkl@pengutronix.de>
 <sashiko-outbox-212355@kernel.org>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iymezpuzgsefxgzt"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-212355@kernel.org>


--iymezpuzgsefxgzt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 1/7] dt-bindings: net: can: ifi,canfd-1.0:
 Convert to DT schema
MIME-Version: 1.0

On 13.11.2026 07:38:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] dt-bindings: net: can: single-word name in Author and
>   Signed-off-by
> - [Low] dt-bindings: net: can: commit message claims unused
>   IRQ_TYPE_EDGE_RISING
> --
>
> commit 20b578f1ac5dfb3641ca1495585b6a04db880f29
> Author: Quchaosheng <quchaosheng000406@163.com>
>
> > dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
> >
> > Convert the IFI CAN-FD controller binding from free-form text to DT
> > schema.
> >
> > Reference can-controller.yaml. interrupts is required: the driver obtai=
ns
> > it with platform_get_irq().
> >
> > The example now uses the GIC and irq header defines instead of raw numb=
ers.
> > The values are unchanged: GIC_SPI is 0, IRQ_TYPE_NONE is 0 and 1 is
> > IRQ_TYPE_EDGE_RISING. Rename the example node from canfd to can so that=
 it
> > matches the $nodename pattern in can-controller.yaml.
> >
> > Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Link: https://patch.msgid.link/20260922102258.138753-2-quchaosheng00040=
6@163.com
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> [Severity: High]
> Under Documentation/process/submitting-patches.rst, the Author header and
> Signed-off-by trailer must use a known real full name with given and fami=
ly
> names separated by a space (for example, Qu Chaosheng or Chaosheng Qu)
> rather than a single concatenated word.

IMHO this is outdated information. Since d4563201f33a ("Documentation:
simplify and clarify DCO contribution example language")
submitting-patches.rst requires a "known identity" not a real name.

>
> > diff --git a/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml b=
/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
> > new file mode 100644
> > index 0000000000000..c8c3105c727b5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
>
> [ ... ]
>
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    can@ff220000 {
> > +        compatible =3D "ifi,canfd-1.0";
> > +        reg =3D <0xff220000 0x1000>;
> > +        interrupts =3D <GIC_SPI 43 IRQ_TYPE_NONE>;
> > +    };
>
> [Severity: Low]
> The commit message states that "1 is IRQ_TYPE_EDGE_RISING", but neither 1
> nor IRQ_TYPE_EDGE_RISING appears in the old <0 43 0> example or in this n=
ew
> example.

Bad bot! The commit message says the meaning of the 3rd value of the
interrupts property is unchanged, it's the standard meaning as defined
in "dt-bindings/interrupt-controller/irq.h". The example lists only one
example, not all possibilities.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iymezpuzgsefxgzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavbABQAKCRDMOmT6rpmt
0vA8AQCHfeyyFHy/T1hNRX9Ft6Ps9CEZaL92LtvXy/qScNZypgD+KA2XOpdPilFp
wGE0YytDfhZRE5maC2CN2KAA76gTbAc=
=KSSw
-----END PGP SIGNATURE-----

--iymezpuzgsefxgzt--
