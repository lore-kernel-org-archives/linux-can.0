Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792567502;
	b=booxplMgEr4Qy1Sku23BCnyaaT7vuruCDPb2xxB3LzCEp+HHI65Vmfcd06FYTobsK6QT
	 81BuE+TgtBszzsutj1W3Cj5ayNFfuCcGYQ2pJd1bdRwSbfM81yys7iULVshyWnqJFlKi2
	 NbvOUHVwQI5XOyK5JJWjHGUGX02X5gu/xkucAgpUsLxyQHi1bUbFHzO2qVEh9v5Fu5Z5p
	 FoZ1ig3EoDFPBsp0yeD1lKPjD2OaR3BF8msqyTQCq5RBSC4is3fZnYckMuuuq3T3DwLKL
	 +ECHzk2r94OIPnoyEFIljdRTORVgGK2AoXAtBvMip05ORTs+TOelqYNNu8gjVlOezLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567502;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=D0D3E2cAiAIZQoEFLdl9T7y/51zl4DQsl0GH96BRBUg=;
	b=F/nKfkrsgm8Z750VF1WTOWVzLSmCpYtHkWcrqteeY/8HVdertyRb3fHylgixbTR7dwXR
	 /qxyUW1zVWgwTF99zv3ra5YsBvuVzez67x7upsrqhjGjHWVrz3rFEP99I7hDz6ewUx4Q0
	 ArB7eDxy++WwXxWChBk2jTD/QgQsud9aU5Q/JusoYTLmn58t4FTtNt/F52hW75+sVCziS
	 ToL2fmRa3uVz6sFY7ilx4iqi0rFh1InYNawKc2rZ7EkorwQbp8ONGGJC+0Ge96h5gCwib
	 KA+d5wRB1uSHjfmiJXcExPNn3gQZHvS5UkIUQdjViZ1nDicPnHo09MNhkdHp6pg7d8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XjG++CsX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE469606A31A;
	Wed, 21 Oct 2026 07:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE469606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=XjG++CsX
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 12634201CE0;
	Wed, 21 Oct 2026 09:24:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792567499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0D3E2cAiAIZQoEFLdl9T7y/51zl4DQsl0GH96BRBUg=;
	b=XjG++CsXncxGqv5pPhsgVFrSHV8ZhzKetfhdJEQrFvqJ0vDPca1dBUd11pZhpPg/0dLay2
	abcJFexxQw073xWGqsse5sFMlj4fao2wbvBZl6Hub31KHFUld8cp3ZWaIv6NnsweQKF1Du
	7ucJbsENniT15TsNqPPb2ROtTTEj3Nzl1QnxqXTtcpT7fh4XiF8V+8bujRnYKFsosD7ztP
	C2TgINOfaqLxrCoD3J1A9DKyiTuHoZgPw2NVdFP6XITAAU85LWB2th5BDyP0JN6lsz+M6C
	L8AVca+o7G39VufkIHYvfdqKW7wIFCygzFMfqbs5OKlaWipCyV04cM0t+2aS9A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792567499; a=rsa-sha256;
	cv=none;
	b=TlzoeljIGZ/yMv0TYX0Z5CLoyms54/Tf09XKpprrw/Gl4weCNwVD3HUNZNVsBq5815cur9
	2BdwI0vfuEeHX3zdgssRIn4bq9w9z7tNU9du6onp/6OCrSbV8tM057iY36rqRkTdiHqX4G
	3ntIsO+UpLKMz+CZkeyfQOSZS4mM3DnmklFAYAlzJfWbrpFMChmTo4iyGu4R1VZbjO4nDw
	42bsFEqebH+MCwBr5HsgRacG/34DEHS+mjaYlxxqn4IxCCoBqSGryMDbkKw8Ks9qUf4U8Q
	ZKDT22Ab48VFQ8LtgKDlIMREAp774Y+At+Wp8XaBUFId8+RcpINpbrazQSfZFg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792567499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0D3E2cAiAIZQoEFLdl9T7y/51zl4DQsl0GH96BRBUg=;
	b=HlT9bk9Xccy9gDPChuNN+OCcqw81Nnv6CX5ztaMhqN1yKY85xYhUlhUmUl5zJ3Rx7ThdiH
	dXR3+HCMf6cj5H0RQZU0YE3SBKQ/nyTfe5bk2FlbMOcBK+rTUhQ59W8h+Kz5hKrDQ7xKMZ
	dNOWgZz5756evrMVB2nxgOxBpJBx/7jaJIl1FXIK/xPHi37FkWgj1zRg0L9NOucwOJYXti
	F/ao3A4f0djdA7RkNbMk9Xdf3HilFtJ+eDMfM15iQbaOmJIYDDYTg1A4f0fVJDuEaplF/q
	1ZXmalLNxCmgHHUjh1vebURhXFpgK7XIuUWl61JlB8URWZRL0k9CWglgTDqIjw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJQh0-000WWK-39;
	Wed, 21 Oct 2026 09:24:59 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9DFD85CACD1;
	Wed, 21 Oct 2026 07:24:58 +0000 (UTC)
Date: Wed, 21 Oct 2026 09:24:58 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Rob Herring <robh@kernel.org>, "biju.das.au" <biju.das.au@gmail.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	"magnus.damm" <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: RE: [PATCH v5 1/4] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3S has no Classical CAN mode
Message-ID: <20261021-grinning-infallible-perch-48286e-mkl@pengutronix.de>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
 <20261019120220.166163-2-biju.das.jz@bp.renesas.com>
 <20261020164840.GA4094037-robh@kernel.org>
 <TY3PR01MB11346F23C5532B7D9F23579A286672@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
	protocol="application/pgp-signature"; boundary="ydnewgb3beyexvtx"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346F23C5532B7D9F23579A286672@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--ydnewgb3beyexvtx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH v5 1/4] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3S has no Classical CAN mode
MIME-Version: 1.0

On 20.10.2026 17:17:45, Biju Das wrote:
> > Can't this be expressed as a schema?
>
> OK. I'll express this in the schema with an if/then that disallows
> renesas,no-can-fd for renesas,r9a08g045-canfd, and Will update the
> description as "Specify this property to put the controller in
> Classical CAN mode" and will remove the unwanted description "The
> controller can operate in either CAN-FD mode (default) or FD-Only mode
> (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode."

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ydnewgb3beyexvtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCathoxgAKCRDMOmT6rpmt
0ghmAQDXTBHJRBEEieDxuwMs2d6Gjdm1KYf9PBVJ18Ehd088/QD/Us+BY/jtxHri
/96zMFs9jJ4CruTHjN0dU9+xg7mkdgg=
=8ODC
-----END PGP SIGNATURE-----

--ydnewgb3beyexvtx--
