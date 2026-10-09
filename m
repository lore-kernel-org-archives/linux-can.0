Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146A4DD3A8
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546428; cv=pass; b=gp6cKlalDnBQ+MoqEqanYalZQI8SBSlp2n82i5KfgD0WHxN+htM3QhjpN/k19tPDR9M1/JbuclFg8a+NLhaPlDcQYnCd5yE7pC69GhG5dFL2K1nE9HCQDV7XG0kjlY3/gpaJ+EzeZu8fL1IKQzACif/dWRCApQDVXl2P3A0oSa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546428; c=relaxed/simple;
	bh=Hf+J10yEnCqPy2X0LO8fxgdVgmXZznEGVDvTgHMtEDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV7w2ADnv2/J78u6ZxYpcHLmFQPB1E3F9YttFp/V2/kW4CwJlTAJtkUVl11HEJJegV9jVwUXNbE3Ph+/7Idi8W+gph/sEHNLJjoTw4Uv9pprbadM5Dih7J8/TWlRQi2nIcvvraTI9iU0D0BDx8DcW9EpmUw9DOhg9i8q/ULMFeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gy7B96NC; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gy7B96NC"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AAC9820236B;
	Fri, 09 Oct 2026 13:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791546417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WtQeouEX4bas9vhP/cTV/BpD0A1ANHM4OE0qCNXJk4c=;
	b=gy7B96NC3GGNdW93kHZS7vk/CikDXOq3SciUyYgmbPudVYgrnPl518ojIhxsKQgl1z6LKW
	au0g2R0F2+gL7RLaWz6nUM/eWXIg6ZyI3YQwqgwR1im6dE1OTRWVingK4cvIqG07CXvfcC
	edJv9D1cougHhQkCry3t/Jy2Sac4Uuu451GvaOlPk6YN7iAP6rz+KhfK6DVZ2YqaKti8p/
	EbLmFYxBY3xVE0a/Usw/Gbzbgc5ykhGzS6EPWEmA52q6khJEbspd38QTkxMef7FChejlQk
	xKTtRMIjoFd+RKRHBH5vm5h92yVf7nhIoy8J4p4DxZA/9OaDh9FsfJ4UTj5Wsw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791546417; a=rsa-sha256;
	cv=none;
	b=KO5zvhpX5yEltcch2FYNwdn+6tyyvmFeQM1MwxLoOLdHw7Dpr9OcKR0jCNjgaRsOh2QK5V
	g5bw8i+hzY3IdP+BU5D8O2qY4x4GBKQgulOzsj1pWi8QVdBvsGjarGn5lXpv6jlk7kVSJZ
	WPgfHIIpWR/KA5QhRpkpZxNuGKWe3hEo1ACKGzPkZ/y9LGxAksCY3jRT5WiKajEKMqtrwp
	d0BJuB2W1OTRLGIoQTuDHdj1bylCf+ePgSIipx1lS17/Q+humkkTK+rNXrXG3cZiPM8pco
	sqfUe9LjEtGNchQ+F0Glur0ekOOTLGzZSaonrsr7iqiLZOQonxmazzPvPonWmg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791546417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WtQeouEX4bas9vhP/cTV/BpD0A1ANHM4OE0qCNXJk4c=;
	b=JpLhKmvwruorWcx8KqSJecr60Anz5D8u5f0yQysHDOqjEtCd+B54MwC6Zvf/O0zvHBboqv
	SwNdj6ArIClYOmx2/K8RT/CPz5cn1WTSppuW5BiIoVBmoOZfF7Q51ewi/+7Hsx8U5b53bJ
	yznLuHxISUe/82r1dXkNQSxO2FtETKcLbxjBGRP4jyWzlIot/XGcQOYrAEp/FjWxGkRfRG
	8EOQkRG+soir+9FfOQLuMl3zmRRyfD/unt380lqPeDGVzhYeZYF9g7zpQuu/+eZNpaHzeh
	9/gLtIGqo8yz8PKG0XP7dinQu/duE07c7whdYfvWe4hntt1e+cF4ibfBJH18VQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF93x-0052TI-1q;
	Fri, 09 Oct 2026 13:46:57 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4154F5BD703;
	Fri, 09 Oct 2026 11:46:57 +0000 (UTC)
Date: Fri, 9 Oct 2026 13:46:56 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
Message-ID: <20261009-hoatzin-of-sexy-poetry-3d407c-mkl@pengutronix.de>
References: <20261008192253.574195-1-kuba@kernel.org>
 <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
 <a5860c87-b034-4cb2-9995-763c6b2cf58b@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zssbbxwg3ugvsr6o"
Content-Disposition: inline
In-Reply-To: <a5860c87-b034-4cb2-9995-763c6b2cf58b@hartkopp.net>


--zssbbxwg3ugvsr6o
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
MIME-Version: 1.0

On 09.10.2026 11:48:16, Oliver Hartkopp wrote:
> now that the latest real CAN fixes are in Linus' tree and I can re-spin e=
=2Eg.
> the patch to use ml_priv instead of ARPHRD_CAN:
>
> What is the status if your can-next tree? Which patches have been already
> applied (e.g. my Softing PCMCIA driver removal)?

I'll be submitting a PR shortly. As for the Softing PCMCIA driver,
there has been no response from Kurt regarding:

https://lore.kernel.org/all/20260815103428.117201-1-socketcan@hartkopp.net/

> Against which tree do you want can-next patches to be sent? can-next or
> net-next?

Please use can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zssbbxwg3ugvsr6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasjULgAKCRDMOmT6rpmt
0nYmAP9Bvj9ZBkMvzKfmsPzsp0LRLD9J0u1zjRWgT1uXRon6SgD7BvwD/I/it9eb
M3d5LY+Gl8A3gDblXzKd3Ku27PqWBgU=
=58DH
-----END PGP SIGNATURE-----

--zssbbxwg3ugvsr6o--
