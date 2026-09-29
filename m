Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334A49620
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714079; cv=pass; b=M/Mgic0IcRj3qXOsT2gR9smgRazBvS/IKby55FL1zFAKOWRUWBx47+Ud3dMkFRyQKrUCltR8qT65GmSig7svJ21O/VHgG0r7U+eSz0f9Rb/gMCjdm7ftEpCcCiDDcl/OHS1pmik4tB1DJxkP2h3AVrhm/YGHHqCuMnH5btdTu70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714079; c=relaxed/simple;
	bh=XVr0si6sZCJCfI6VhPWn1JxiOrYR5IyEHdrHV55qbAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSIdROJjX78J7wJXDOUFEWkywfuLV9XRGN+QzIBgQh2YPYjLkJSZqFyjGSk2Kd27cb9AU6kRW+fj0ERNeiBCfheA5QTRUwrLk7batgtZq1Fuem6R3bEEjIng/LyjOKw/dia4b68AabWgpp+9d38oH2+uZlzyvyAmNQzYid90F68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=JRmycv6S; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="JRmycv6S"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 42B232010E2;
	Tue, 29 Sep 2026 22:34:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790714070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dINADry7UfHouBuHodv6winAZlH/0KZ+JB2q8gPQUY4=;
	b=JRmycv6Stu25l5pDJIF92Gb0EFhNTRowmmeJHPAjq4XTUaLfE7/TFZ57NneDLffZFP5lpC
	qZM6IxkCR0g8RnY8yKlN39vynIJtdJtu4iDu6Tf4+ItxpIm4umw6NA2sCibzaqp2Q02ZF5
	EiMh8vOjDG7phaCzoSHAVj4Ty+5Tg71mJ8PMauyTLAZn8+yV4MyJgaLtxCL9rnQcB5VQ9W
	ocAlKyHBjqR9IzUV7sux8RmANJSbXpWKd0ile2qtQilcNbQTarQVjHpKdqLnxffJpOHSgH
	bC9kn5jopdsDQuRDmUn6mFjUteSCkTCO0UNQkdpWpMEUJJd/zLzLEXLCqNLZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790714070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dINADry7UfHouBuHodv6winAZlH/0KZ+JB2q8gPQUY4=;
	b=B27KxFxMskFMbxrdtXXF4OSmNXGh1fev5Mhm+kXfhgkfkLa7qzOuXFqQ5XNzGn3e4DZlhh
	5A5TG7pIp2hV5DHSDn6CXOrg71C5bUknWRuVn4YXMfLYCKzk1NNXDmAcvQ5KJcSAMsxDip
	1cdz7c+ViMYwYHc+DIhiTl/dIy2j4CDYepfX4Mqmyq7tOmfMN3Lc2bMMSnf2LuDSwf1NEz
	zV7LfH/H5MQDdspiWUnqXQWrD6gDYP6XpPc02KbAfqt4RL+asnOnCr27ib+pLQCHZ6mkfq
	5VPRx/R0ndbisdH6r0Wwhy6S/pNE+NiaL8j3T6WR3lX5kLEaQTCwuHX7KyPrQg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790714070; a=rsa-sha256;
	cv=none;
	b=R43kOQEhHH1fd9cOBnu4lPcQdvuw5fK+Ve2bJsLdp0zbGPYhx8cMm3LikdUvtmW+XSXRj2
	Rl14AkerMzH5pDq8rOqVMu76PM6yz5HfSo/3/4F1VrQARVz8xDgQxGPgV0ZlZITEmKGUGk
	MqGRKBwEwRoe4tNZcywb32S9kboUoobeRQm48otqXu4/iBzt+BDAPq1XiCX5X3CBAaO3f7
	/adUh50dAfFBmzPd0F3G2ZQ0LwEoTEdQ5bNdAK8WaecM5lorZG3bupahpRaULQQSaDUhi0
	J9awoHouiiMdku4/mlA7GJFe68BnrIBfrjg2U3OixRxGuO4K8CVYvvsm5cx3HQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBeX0-003RlB-0a;
	Tue, 29 Sep 2026 22:34:30 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DD1405B4C9B;
	Tue, 29 Sep 2026 20:34:29 +0000 (UTC)
Date: Tue, 29 Sep 2026 22:34:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net 12/22] can: m_can: m_can_class_suspend(): fix suspend
 deinit() error path
Message-ID: <20260929-utopian-adventurous-jaybird-e6678f-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-13-mkl@pengutronix.de>
 <20260929193336.D5E721F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ifw6vvlgn5xqxb2p"
Content-Disposition: inline
In-Reply-To: <20260929193336.D5E721F00893@smtp.kernel.org>


--ifw6vvlgn5xqxb2p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 12/22] can: m_can: m_can_class_suspend(): fix suspend
 deinit() error path
MIME-Version: 1.0

On 29.09.2026 19:33:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] can: m_can: data race on active_interrupts between suspend error=
 path and ISR
> - [Medium] can: tcan4x5x: unbalanced enable_irq_wake() when m_can_class_s=
uspend() fails
> - [Medium] can: m_can: polling hrtimer is permanently disabled on suspend=
 failure
> --
>
> commit c427425150087d727cfdd3220f1be90e0a87c37e
> Author: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Markus can you comment on these? I'll drop this patch for the net PR for
now.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ifw6vvlgn5xqxb2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarwg0wAKCRDMOmT6rpmt
0ntbAP9/AXacipV+3fkDkPVL2J0/L8mH8lNf2N54b4rSRo1N+gEA/rhYQWSfRByi
DJDh15L7GUBj/WEUcJmpkp8vLeC87QE=
=blVt
-----END PGP SIGNATURE-----

--ifw6vvlgn5xqxb2p--
