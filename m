Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792568272;
	b=aUpVc2dDzRwVq1oPQgPqM1mNO9r9aI0lgptPkBaTA2ydyV6sCLGNbEVQ5u4NY5IkaVjy
	 O2Y3rjEdh5WBI8Sx3cMDQcT5Zoa+tS+4duSTIw7xY6Pprg4H+PJ2CttRXvNep3NSwpGtt
	 IJh6lObnYWKsrCG1dj/PrVFtO+gY5PI9aIUnqUYLZ1H4crQXuxfyPjLfsxB1sOyJxQQX8
	 UGMLfgdqcuGR9Msh24XnutjCeVBZOw69L4DV5b014Z9nhTtSAdb5WsHdewITFKpSVqX7t
	 Kf83fCsPv4rIsTQHFvYStd1O7PZq3ZSy6UK6QpvfPJNJBDMl8sDJDeeH21lQSbdbMMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568272;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9v0qix5bPn7iGIJ/fHA9RQFMWwQI/JfRfRPoZOz48tY=;
	b=v9Sr5LdY+cDMFfFsDWkNlRH6NCNCE//y7qpp7y3mdIxrgvj/JUXvaC/NL8XhTMeHAi/b
	 yjUQOl4w82R0fvjCEg3hdiMzhzqIXaIttxgMyZ5HyYqLP9FolpgZbcK+95wPLZ7395Jxu
	 c4LnwYYc8Wd8Mt4oVKbhgL+ju+nZGjWXLzr1U4YOvkr15d0xC6rbltE07UWw/uDjQRKf6
	 U5EO1gAwD1cH9OaxBGVFwBKby6icdznlVAziqkLjW/xffAriNdn9yJXIwT/V6rQLOnLZM
	 ZZTEeNCudwc0JL2/gfatCBO0n68kwoEgiVQ/C+spXwXE3/2ldKv1tJxiXiY10nfg8YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WnidQAKn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA992606A31B
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 07:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA992606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WnidQAKn
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0EE32201E7D;
	Wed, 21 Oct 2026 09:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792568270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9v0qix5bPn7iGIJ/fHA9RQFMWwQI/JfRfRPoZOz48tY=;
	b=WnidQAKnkSv3xwzIkGrAwzj6q1UFb3icXXnqVpWDtNMUwbEMlH3CNO2iNB2vIU2grzWfHc
	CMjfaPuGlMaTaSC4cQyCcf+Y7PIF6WWYbLSxcvCZMV4lqOBOR5+rVlWfuEczJjsvlxGRjS
	9VBWBkHRUnDdz6VSMR2XVOQYKNP3S98YaKPacB73roGxlunZxDmGCEGnkhUZohKEcfrqcy
	U1rvJepZ6+z3muyx8cux+cylVOFrACiRQBv1yJE1/ehbsiPGbEjD2oClrFFZyRJ3PEoCNM
	R0JIMIKMCi1spUiZghawqTZYZc/7O9fR5IoLmnBlKRfjsyl9dt6t1pBvmWKHrQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792568270; a=rsa-sha256;
	cv=none;
	b=PnolOaaT00fXrwLi+rBO+1o/tDAGmt8buk+couMMSfBInoA4C6/NXS9Q4AgSkLZeYjLLIK
	dgmLKRF5A10poa2LU462XasO/vwjclLIOk0gGAPMB0JBAI4aLSZ0TlaKZWfwD0olppFt5U
	5knh1RMlMvtO55fgJvvSlLdsyGa3+ViwUKTg2hAvjLUodVrYqm1HZTrzMpr7bFe2fwkju8
	gBu7JhtcJXdQafQ/qIgFmIMzzccFSFbShgt7b2AmoCDR15Voqx8we7EUcsUErh30LW5hrv
	DdTEvLayQaj3Ak2KO+GBYYixi1Ie9B5agAKQ0JhP1FHfcC0UKbdL7074j6GECg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792568270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9v0qix5bPn7iGIJ/fHA9RQFMWwQI/JfRfRPoZOz48tY=;
	b=TVOzPf01/H7MsxGVsxpeBxyBaeA79YZ9qdqUf0bJAl/DOaJUYWqS+Hu2t1LWsx/caR5bN0
	Dl+No/8RpTNSpqr1y8553v5VcFSzvpBSoJBJDj1LsYf5n+n29ycYWaH8q8YDyhnInUZaKM
	25GVzm+e7TErDwNXZTnggdDP2sZxB4Xd6LxvOIj/QNvCberMf0t1l5HoJqOKe1vrMX8UTa
	1EzW42KZscJ4fYxQ2rS0EDC0LMJokMvYZeFW9EFHcaEvkfBkNemS1Aq++S3wyBCrCOu8wt
	iEHgRlFMrtEQGZ/iX9tKIM4J9pdB8Ov2r8QoVkX/+R2AfQ6VWH9Nu82cAEqaHw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJQtR-000WbN-33;
	Wed, 21 Oct 2026 09:37:49 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B4AF75CACFB;
	Wed, 21 Oct 2026 07:37:49 +0000 (UTC)
Date: Wed, 21 Oct 2026 09:37:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Filippo Storniolo <fstornio@redhat.com>, 
	Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH can-next v3 0/3] Introduce diag support for CAN
Message-ID: <20261021-aggressive-musical-bettong-bd84da-mkl@pengutronix.de>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20261020-funky-buffalo-of-progress-fa4bf9-mkl@pengutronix.de>
 <d23196e0-6307-458b-ba31-15f54ef46b73@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="kewsyiomvco2xnkm"
Content-Disposition: inline
In-Reply-To: <d23196e0-6307-458b-ba31-15f54ef46b73@hartkopp.net>


--kewsyiomvco2xnkm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 0/3] Introduce diag support for CAN
MIME-Version: 1.0

On 20.10.2026 18:20:22, Oliver Hartkopp wrote:
> The fact that the inode number of the socket is visible fits great to the
> upcoming CAN procfs output:
>
> https://lore.kernel.org/linux-can/20261018164417.1540449-8-mkl@pengutroni=
x.de/
>
> But I'm not sure about "Local Address:Port" being "vcan1:1110".
>
> A CAN-ID together with a CAN interface is a unique "content address" to
> identify the content which is in the CAN frames data.
>
> I assume "1110" to be the decimal representation of an 11 bit SFF CAN ID
> 0x456, right?
>
> Having a CAN ID in decimal representation is generally unusual - especial=
ly
> in Linux. Additionally you can have 29 bit EFF CAN IDs which does not fit
> into a 16 bit port value.
>
> And 29 bit IDs have to be marked as you can have the value 0x456 in 11 bit
> and 29 bit CAN IDs. We usually do this with 456 and 00000456 to indicate
> 11/29 bit IDs.
>
> So the "Local Address:Port" output does not really fit to CAN here ...

This probably needs changes to the "ss" tool, right?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kewsyiomvco2xnkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCathrywAKCRDMOmT6rpmt
0vHKAP4rHUA8U8WQSLApQYtbx8uudIVWNDnMf+bZZdW+MWQdoAEA8KN0/OpoUwBU
+AxFjHLPFDisfr9LGQeEj/hxO0hr6g8=
=KXC9
-----END PGP SIGNATURE-----

--kewsyiomvco2xnkm--
