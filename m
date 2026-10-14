Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA747ECC8
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014764; cv=pass; b=GV6471GW+hvws9ySQXeAZKJ4RP6/jqoPc3QbWUYFwj0wjnLSF7dSWa0bOtPCSyTOYwpe46dOrhCLs20OCvobs2A7plTLmgssobZYN+nKpVx8uJoe/JZeMxT8a215ruX2c7ZSiEp3AlT7k/byD2frUeAvBxX5XIdm49QjcB0tfxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014764; c=relaxed/simple;
	bh=oXbhwQ7g79/hoeEZh+oNlIMlAP7ol761JI3h43JdXoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXp+NlkjHh4KpgZ4iOv9WfXZ/pyWRqNp613WxNU93Rnxg2BiVEPFIC95sVFZybSJ5nhTDwgk/BgXD7E/eIw89y0RDq/3wc000RxQEIqy3cvePE5+zudKqiiFUws5eTAooNv8kFL4ZuNy8m4clMv940vWR/lDzn+8IHnjLIWdV2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=geQdLJFt; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="geQdLJFt"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 950ED200563;
	Wed, 14 Oct 2026 23:52:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTbDQ1iTKrb6HDcH/kBB0wnJmjDJKVJs7ERJaLEcdYQ=;
	b=geQdLJFtsWPV3W3htfwE3I7Y16ZIhEYucN3oBeXbOrosTnrrEm3gT8Gok7GNB1NXHGX34u
	m/2XcqsPL+xVE2mMHZdVY+XdvYSIcWC3IE1NKvh36OPf4KUcn4fVYPFA9HZ8f5AePSf5rP
	QyvH0ezDqYZNDfGurWb7jROL9a3KN2RFKJB97YNt2cXQK8RJY8qsaIUd9D0Ax/vtWmzDc4
	hnzgCTB4ApdQ3qpR0IDs8bcyCRrn2WjkHI7tAmRQzhaNmb9OfVtSCfn/AVzI5kix3SKbcJ
	J+ObBKckWp3F43xvk7FhUw3b80pNOYV37kvZZKt3Pf7flJsp1MyDqkIGBOJxGQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792014755; a=rsa-sha256;
	cv=none;
	b=YaPjerB9u6ApjHvEnOIf8p7+GENMKaYz9mASgizZhr1C0WhsNAb3Ypt2bQoo2LXfZqNqnL
	iJ0IeuwwRkz3t4oqlZ3dvUPDkGYRPnQx1JKKE8M/fMFXhmhSoGISCBZfnfMqaE7/lyDQzY
	QjbuMPUTQRiugaCkTKR6VDmPr/EsczBMxoKo/LCvZUnOSQTDU7daUBDxyJczck9sPitvtk
	VP4Ec0LVI+KnIGdYrKGiv/0Yok0+b7zWkLi+54rRoZQM1Wkc88hS3BjPGuOQxQbG9CaU6c
	z1WLQLtUIDOKGYhAIQiVWKai5Vpa3WtdFVLqVASLSHeWqyueQ+dtIXUjdb3bLA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTbDQ1iTKrb6HDcH/kBB0wnJmjDJKVJs7ERJaLEcdYQ=;
	b=MtOnPNTrI68waL0I57pwqHFDvPUldJHTebcPQ6+0ISmpXg1EGL3q5jwjH85lPc2AVVxqUR
	7E0tIevHhGD0bsUmx5Q7L7cusCdSTPvzOARxmRxN/vUmjqSJIr2w4n1bv27p+cYbMUA4EW
	XkabH7BBKnvKM+zmo3DfmeZWNJVy0UDsJbVZ0aJHOyywM+ZmeP/AJPmEWSRuKTMWic5Jfd
	gWqaLpJZJ57vEWb1PuuG4V6RFYpRYxbtntWGXiNZVgdRq4uPxwU0VC+JfYm2x67wH0mQ5b
	sv8Wj83La8MrAZ6e/pTjjdjGffqP929w/g+AYBBgIJnkWEuhRl65DYNzbABSWA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH6tn-005vB6-1c;
	Wed, 14 Oct 2026 23:52:35 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3D1025C45D1;
	Wed, 14 Oct 2026 21:52:35 +0000 (UTC)
Date: Wed, 14 Oct 2026 23:52:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH 0/3] CAN netlayer fixes for stable
Message-ID: <20261014-perky-dinosaur-of-jest-ae755f-mkl@pengutronix.de>
References: <20260928165927.31667-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d7fzbh4wdmcl4pqv"
Content-Disposition: inline
In-Reply-To: <20260928165927.31667-1-socketcan@hartkopp.net>


--d7fzbh4wdmcl4pqv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] CAN netlayer fixes for stable
MIME-Version: 1.0

On 28.09.2026 18:59:24, Oliver Hartkopp wrote:
> This patch set aggregates the open stable fixes for the CAN netlayer.

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--d7fzbh4wdmcl4pqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas/5oAAKCRDMOmT6rpmt
0jVIAP9RVx7bwBalRO3u69upCvkNexm5iCMdyZR6JLl1L2hN1gD9HteGmZkJJk8N
nc8Lmlzndgdz/OzSytzk8QA10mPgkAw=
=D6Ja
-----END PGP SIGNATURE-----

--d7fzbh4wdmcl4pqv--
