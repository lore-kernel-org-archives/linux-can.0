Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794555947;
	b=SxGp9ooSkJbHObpgIYGKhpeTwm5oxCRQqmLTTYj21bnRM6j6Q+ZOt/dBqKcPVFkHdNQh
	 ZtEWa2tkePkk+7ksVdXBPf+mbOZndy23fz2WEeUyI8o+HWNAl0hYJj9HdmkCFP1EA7Th4
	 2oEgtAXG6CtIBYNxUFNXN/Ydnv838CAq7yb9V3Mj+mUcAVv1h41uNASqZc/q+/0RCUORR
	 4PkHf+tfwacs0pLS/dcoq2dZB4mDMc7ntqqPIPILrspwzHUhK0UROzLCcOB0K9sjEYtd9
	 4zdVe4gQKZdJgFAGTe+MDGFmCTGYP2VmdbCHfpwKcxecJT/UlcYieWjZMxIKLwwAP/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555947;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sL/KuwE/7KbPD5e/uyCAKzKdrthJW5q3nrw8k77Bv9Q=;
	b=m/VfzFCG0nZklhTJmNBowpY7dczps2CfC4dQnTpyIPU2IL2PyMhTlgEU2/pO932MZnrI
	 5BgXrKrClMqdgPmowizzZ2tY9jTfdq3ViIb3Dr0kB35aRdpS7mh54VdLotndCYMmwNO10
	 5LwsMExjuDiYepfIwODSRJTDBlQqU/TKQmk+ec4TdyPFXdYx5OIi8a4BpwKi7BJHeWUGD
	 Rd9Z9lrZxd9asIoQvP7eoqbpqtZ+WY9NFPnL1GSlJgDNvRRTCHY4lky3IyNJbNTXpGpSH
	 DpPaXDzswzYw9pBYwpPjUOgeS5KSM+D/zniA1gr+f4XKt3aTYavKwKUJx42GbOsP6Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RZqJDKsr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B7606A31C
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 07:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D2B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RZqJDKsr
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DF492201544;
	Fri, 13 Nov 2026 08:45:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794555944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sL/KuwE/7KbPD5e/uyCAKzKdrthJW5q3nrw8k77Bv9Q=;
	b=RZqJDKsrF+pRB3xMb24cTEKyFIkj3sQF5zuuEg+DrtYzzPDU7ZlwCkcuWTBDLZUmCEsJAF
	Aqy4+haYNDLe789wQnNKgHuGiy4b7oHVqjZ/gXp9/D9RFXmLMP+teqqn2YRKCfnLUHd1cj
	0/sMWt3QFTXyvc6E01CeIfcnfrfrP97hQj8agLUghZJLGDHebR/4MsE1zlvJnWCXalqQ4D
	D6UJQtelAtabBghAt8p51SxupsBJShPAjPqaFHxsPcwn+hbku3qlCf/LqGbXgvTsTg8X6m
	vPhJBfaXGfG0HOJCcYfPWwwDBAVOg1+OhvCVNiZgMrx4HTPIejtx3dXf5ZPbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794555944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sL/KuwE/7KbPD5e/uyCAKzKdrthJW5q3nrw8k77Bv9Q=;
	b=GCpOIpA4gLlJpHxepXsXc9n+lolWGpukS+kzjYZavvifFEsU9fb4bgIYjCy94LOVP7K4nC
	VpAozWAsz5ktNWl0q9VHzSkqWmSI7qgFPDXLfjk2JPjoqDyVmSGT20h7HfOquz5tAnAXUr
	SF79fUaFh+FPvdD9i08hldjWGcewkRnaHNJG/ICE8TBlIQw4sVuhS1ci5UZ42Fk9CCQC8T
	m9xXNY5ECtO0za5kKLJCFOu9b1vK4MKul2BnVwltnDrOypw3D5rbTgMLekpGaHfO3VYQ97
	P7LJeVi/eXZmfAuNXvLOVTdWDojdC9uZv/xPYYU778dAYCHWfQge6YOt5Q+DKQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794555944; a=rsa-sha256;
	cv=none;
	b=Qx4204doTY8HDk91vxGqQHyzFMtidpvIkRZZl0+3psLMmx5i8161Jyenj+DfyNv2WhDQoL
	IWbGjGw9U0JcYwDMu7ZdXK8Puje7SKEACGzMzZH/TNu+bQmgu82HznFtOMlcX8BPMU3Jhx
	mwEuHPHSjUHqIriaWTmbW3ZtcCulFyf+G90Q5gUMNruyqpCV8HJ+D1Tz4+kEGef1r2Hj4H
	Ow5FE7/SnulWaZLnTRM1ah30Zvg8S5D/8dIHLS/xRxFd7DcBY6zknsioYYWBeG1jt1Mwl2
	/cdIEatF87WmWcmufa/ZpyO/C/9Ja/4izPltYRvYNvAqh4l5jL+Nrljg8JVXtA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlyi-003xPI-2f;
	Fri, 13 Nov 2026 08:45:44 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 944FD5EA63F;
	Fri, 13 Nov 2026 07:45:44 +0000 (UTC)
Date: Fri, 13 Nov 2026 08:45:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 3/7] dt-bindings: net: can: holt,hi311x: Convert
 to DT schema
Message-ID: <20261113-messy-aardwolf-of-defiance-c39ee4-mkl@pengutronix.de>
References: <20261113071325.4092169-1-mkl@pengutronix.de>
 <20261113071325.4092169-4-mkl@pengutronix.de>
 <sashiko-outbox-212357@kernel.org>
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
	protocol="application/pgp-signature"; boundary="77o2ajtyhgty4gcc"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-212357@kernel.org>


--77o2ajtyhgty4gcc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 3/7] dt-bindings: net: can: holt,hi311x: Convert
 to DT schema
MIME-Version: 1.0

On 13.11.2026 07:38:06, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] dt-bindings: net: can: single-word handle Quchaosheng in
>   Signed-off-by
> --
>
> commit 10f7c3c38441fe802ef963f0ba282453f08176ed
> Author: Quchaosheng <quchaosheng000406@163.com>
>
> > dt-bindings: net: can: holt,hi311x: Convert to DT schema
> >
> > Convert the Holt HI-311X binding from free-form text to DT schema.
> >
> > Reference can-controller.yaml and spi/spi-peripheral-props.yaml. The
> > HI-3110 sits on an SPI bus, so its node carries the standard SPI
> > properties, spi-max-frequency among them. With unevaluatedProperties:
> > false and no reference to spi-peripheral-props.yaml, dtbs_check rejects
> > those properties:
> >
> >   can@1 (holt,hi3110): Unevaluated properties are not allowed
> >     ('spi-max-frequency' was unexpected)
> >
> > Keep the properties and the example as the original text describes them,
> > including clocks as a required property.
> >
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://sashiko.dev/#/patchset/20260922084542.104788-1-quchaoshen=
g000406@163.com?part=3D2
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> > Link: https://patch.msgid.link/20260922102258.138753-3-quchaosheng00040=
6@163.com
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> [Severity: High]
> The Author header and Signed-off-by trailer use the single-word handle
> "Quchaosheng" rather than a full name as required by the Developer's
> Certificate of Origin in Documentation/process/submitting-patches.rst.
> Should both use "Chaosheng Qu <quchaosheng000406@163.com>", matching
> commit "dt-bindings: net: can: bosch,cc770: Convert to DT schema" in
> this series?

IMHO this is outdated information. Since d4563201f33a ("Documentation:
simplify and clarify DCO contribution example language")
submitting-patches.rst requires a "known identity" not a real name.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--77o2ajtyhgty4gcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavbAJgAKCRDMOmT6rpmt
0jGCAQD+fCdpgcUDEqCbObZh6GS8zVhbWVRF+3FX6iBpizmNDQD/X7LmfMLv108Y
7HLqXP++jTFpOqaWFL8VO9hdkIlzrw8=
=1n1I
-----END PGP SIGNATURE-----

--77o2ajtyhgty4gcc--
