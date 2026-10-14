Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3EE4A5EB7
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014788; cv=pass; b=bym3tToRTtaEfYJFgaDSIyL2IQgrAG9fGR4Ajn9R/ZpQlVDzeojnQiGix0bs4AaV7IZY9zav5C97+OBp28uwUS/l1pkIWVbbyETar+UA0nKYVr6icVPsxrxI1ogZY0B2vQZnBO7WXHHGfqXLTxxKg11yaAwU1giZxaoTI4L6CyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014788; c=relaxed/simple;
	bh=c8poG2IC8vlBTq9Y8K3gxCsirf8Ps8DNO2Et7jceqfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUV0hQHwiA9kJS04UFuBuEIfJyNdusNhCsKC3yyoZcr5w8/XJwtOwLPuBjGrw3KDvj3IWsXUgzNAC6qGiT29/F/TCwIMw+lqiFfRE4m+Dwh+7rXZtlltq+ZtzdBdKEo6vSrTmksJHvHQGYYm8TtZ+ovugIomFkuBEyxOp9CqkfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=JcSTn6H+; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="JcSTn6H+"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C870D201CE0;
	Wed, 14 Oct 2026 23:52:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qwDMVGZPymKcwMn5bL7AP8+mFTnq4p/bQGKsHtygu/M=;
	b=JcSTn6H+mAj8PQ8gJn0nTNUw5bY/+n7LTGUJgpO/OQWcJP3l8Qp7JEta05Rd/JdsuHXE2u
	z2SlGgja8nGPZ35V6qYGfnoI1+bugillTjH/4Xj3C0BCgQ8mHtLXrtRYKxMWxGxUydMMAt
	sNpcWvBKZc353fW959aDq4YpDPZUlj8RHMuKcJdWQyfTVIIolPssgIxjCtLpFXRNbfdYZq
	gkTjZPXn+oKsSbj/Vf/B3Ze4Us/t6EEqXzRsOyNPoon+CZh+gxe6bANi6JGi3WJZ0OgyVe
	22YE08xOvz9AX3DToL5gmYXzk5I5FiQZd7iiBDQ9cI8gLP3lhsztPlbYEykMOg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792014779; a=rsa-sha256;
	cv=none;
	b=Pt/ezf08wWe8poxt6DtSyvYJ+HCPvD7WFOHWr0f1ZHz7RcaOBpd37/o4SAIzkuZLKxJIom
	3Z20UCrmpOKIjtfI1pqg8ABPl4dt4tfqWZL/GMQj7NElgFp7MYrvMOvyTWRQBxs51E8Lku
	OnxJzd2zgF21nwYtMobAK4qjQlROmxlVYl6kbbPdyqaAtHA+kGxMRR89tclEdP6Hu23epH
	QWBk5cZWP3YDbf3kTIU9N8pcE9MFHYrxVNOj3fHVmnoJpaq3N9+PTaMC3rf0+rc6nhKnw8
	RbDp7Ruf+Yne7Ieonw1ilLGxx0Z+6U5lSb4WJ6kYNr27JgHgL0zplN3YaKPxNA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qwDMVGZPymKcwMn5bL7AP8+mFTnq4p/bQGKsHtygu/M=;
	b=OaNs4MWlSjmFZuxOlwrBaSlcz+RxcQx/LbmkBsjXpQT/OAtKGiPe3WDv8SQiGWFrrDtdc4
	yfYXmyTtCJjcbbg7rfHp06f5IkhJeAbOi7nkn82edpSZthB725XOOrLr5BN7fF3P97BM7j
	XLvNkpiV5Y5baSPwc4ItFZTceM/d8t7h+Wg3/4aUb8mlnOtoohxOsQZmuChJvgMre3uhxg
	edeUmtbZNbNROpjwvvK/y+dbhyxeLWG5V0sJNW59tCYnZs4Hy+GuNGEMc3rLuPtf2USiyf
	J2aKMV/BSNcQTFmf9ZNY8H/CeMnxRuQTYnAKm/VyhM9/PuJ10cff08yAs4TYdg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH6uB-005vBE-2J;
	Wed, 14 Oct 2026 23:52:59 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7F2B45C45D3;
	Wed, 14 Oct 2026 21:52:59 +0000 (UTC)
Date: Wed, 14 Oct 2026 23:52:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2 0/3] CAN netlayer fixes for stable
Message-ID: <20261014-keen-statuesque-dragon-324730-mkl@pengutronix.de>
References: <20260928173105.51765-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtq6mjezkthyqo52"
Content-Disposition: inline
In-Reply-To: <20260928173105.51765-1-socketcan@hartkopp.net>


--jtq6mjezkthyqo52
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] CAN netlayer fixes for stable
MIME-Version: 1.0

On 28.09.2026 19:31:02, Oliver Hartkopp wrote:
> This patch set aggregates the open stable fixes for the CAN netlayer.

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jtq6mjezkthyqo52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas/5uQAKCRDMOmT6rpmt
0rUIAQDPi8XNurekXK1KXGDKeUP9XmJ549oz++He0k8kmE4RKQD8DrI3Rb/OZvsc
YRh1J8c6nA3p0LcAQIY2KnckSGupyQ4=
=vn5W
-----END PGP SIGNATURE-----

--jtq6mjezkthyqo52--
