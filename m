Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81894BAA0C
	for <linux-can@vger.kernel.org>; Mon, 12 Oct 2026 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826427; cv=pass; b=qb0skJ0p7m+GPgH4Skc8YUlGorRV8IQmLRJO397FkJ5oNh/DkezjLMHAh5sIRrbHGj/Zmz1fq/ZtaEsSYyWb+iJDucfsq8B3jUgMUdPE9UFSHkQjXKmXN9KmT5njd5iRHfouiPo2G/J46o7QbP7b1a62wJ6NhyvMKbdMbtXNbEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826427; c=relaxed/simple;
	bh=KgOIDLUvSf0WwxNmDrnCeIH6I1JKg5xvPW+fRCXmHvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDE1TyeL7brjBMSKDZGZrZeXmgra4L9cqVkI2+wKUzOTn6YDH9G8zLVZdAruis8gNzpVQJvaRzuFnPJYAf6dtlmE5dN+AE9LIb9XPDNkq/1+QGNdLSAncXpPuLVuYE9qNUagpiS6xCgmohqGb0qcC1Fy5WUw3WVJJXLsNlN+vxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ef0M/pyv; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ef0M/pyv"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 701B72018A0;
	Mon, 12 Oct 2026 19:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791826418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+1tbnGrduBYHCZ4/SURJV41tMopC2rLPNt0nfu+7eE=;
	b=ef0M/pyvFnJ3P/FNmrSRAO0WBy0PQwcTi+Un8hUaSf9uUGLb3T8oFHMbWF5o57FRH2LzMm
	t1zK1WxQeLbjIRjBjFBl2lTJeUG/3KcxO3aooU8/+gnJ66XjpgNMqMdGt1+TqbCkQjzQ7c
	1FQqZCeurce69esD1+sekqXi/4Q+CohMQHQXxcdp0h+f28ecYbfAJacU8p4zOhXxCE6P03
	l6UBpF8jaeyjU/kQ4p+KQv2Jdmh+XJ7l9WN0e+Tyx9KXAlpZUiRX83lbnYAL9MUC0cVJkv
	E9lCCMnpn3rhMDXqedKx/9oAGIiU2V9XOHe/+gxUigVsA+dc9dPWRmc/9/4Aug==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791826418; a=rsa-sha256;
	cv=none;
	b=a3NkKC0TRpZj+yjBnXeukItxkiMbYYtLmWw55VauazQ3z+HRfl84q20EyZ3OMRbE4eaOFP
	3oAGZKHAgCmzrZ9PR78iYftxKT8BhWMO2Wrw3SpJzHoDaOeU5URDaQ2f4dLaLPP4OpvhY2
	llpJiE0Yg3aflbmuU5I1MvyRD//kkcQapiV29mWVis2/Ti8yykRcp66YU9/fECI5HhL0CG
	eale3p08IZRlBTUA3dbqOGwOTn8l7R2mViVeHDMZB7wi9UXCOZ3JwalMoUWd9AaoQFkNJl
	2Js14VHfVLE13uXsI8+/2W2j2dcbARqT5aLoIigvPRM0KtW6Uzkjldnp6i3vPg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791826418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+1tbnGrduBYHCZ4/SURJV41tMopC2rLPNt0nfu+7eE=;
	b=dKVsCQBHfIUcf1ZGZ7o2ToII/wVQcHdY3BT7U3+2bVfEe8BubeTnDqI+LH2drb4W7WKFhk
	LY+XUcqUv1nEIS5reGKZQ0UDrgcQdAdptMIC3fPnsu5IlEyR9BwOfLibRLigc3+YRpp6hK
	BsfKTmAQ6ATKcOERAP8jhDhWOTf5aagiEDc0TjO5xapOERau4p2KA8NAtdOGljJS/tmd0G
	drfsHzTwC8kcz5MB5Jnh5wa9WwE/kW4QyjTmjQZKWvuJnHny+Ewx73bkJbAvFxhfQBZUqX
	8NjAZYQmluQTWGQHS7FtSBqEbr0oDQwRTiaR3VogIC2IQIPe3ECoRLnyI0mS5Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xGJu6-005YsB-19;
	Mon, 12 Oct 2026 19:33:38 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1A0685C249D;
	Mon, 12 Oct 2026 17:33:38 +0000 (UTC)
Date: Mon, 12 Oct 2026 19:33:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, stable@kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [can-next v2] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
Message-ID: <20261012-vehement-serpent-of-expression-8b5bfe-mkl@pengutronix.de>
References: <20261012164802.94113-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rh6miuvwl5xxng47"
Content-Disposition: inline
In-Reply-To: <20261012164802.94113-1-socketcan@hartkopp.net>


--rh6miuvwl5xxng47
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [can-next v2] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
MIME-Version: 1.0

On 12.10.2026 18:48:02, Oliver Hartkopp wrote:
> Commit 4e096a18867a ("net: introduce CAN specific pointer in the struct
> net_device") introduced an explicit way to assign the midlayer private
> pointer (dev->ml_priv) to named users like ML_PRIV_CAN. A valid pointer
> returned by can_get_ml_priv() therefore identifies a real CAN device.
>
> The referenced commit only converted the j1939 and proc code to this
> check, while the other parts of the CAN subsystem still rely on
> dev->type =3D=3D ARPHRD_CAN.
>
> The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
> type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
> netdevice passes the ARPHRD_CAN checks and triggers a NULL pointer
> dereference when CAN filters are created and when they are removed,
> e.g. by the CAN protocols' netdevice notifier handlers. This only
> requires owning a TUN/TAP device or CAP_NET_ADMIN in an unprivileged
> user namespace.
>
> Convert the remaining ARPHRD_CAN checks in af_can, bcm, gw, isotp and
> raw to can_get_ml_priv().
>
> Fixes: 4e096a18867a ("net: introduce CAN specific pointer in the struct n=
et_device")
> Cc: stable@kernel.org
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
> v2: rephrased the commit message due to sashiko-bot feedback
> ---

Replaced patch.

Thanks,
Marc

pw-bot: accepted

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rh6miuvwl5xxng47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas0Z7gAKCRDMOmT6rpmt
0pTEAP4oBKZjQvTTAJBgOC8Bk+D6+T3m+VLsSxlbAFRqn876ggEA9R6yKPWLO34k
TW039ZRdgEa3JDJK6t9EARnldhYFIgQ=
=ye2Y
-----END PGP SIGNATURE-----

--rh6miuvwl5xxng47--
