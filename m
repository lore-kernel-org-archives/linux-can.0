Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793085483;
	b=AitiA+uGth5dLFNYdml+wsUGDaGtehjAdB6QTOwfo++WNy3Vz5/jjEE7IaQy8LzIQ6BN
	 GagPmYXZNG/7Ew4aP47CvkCBXLjxjgFjqJydGiIlkHvqd1dx5Ye2qjMN10dGmoP5jUgdv
	 9k7cIEDxWMAxKEUZPTtyH77ve/HWQinlL1L5L0T2qTmqDJpXRMgeZv0sYwkqy4PcH1488
	 c4+hAHyROW/bIT2g6X53VT5IKVNwOhOX+ahklKc8ZGLF/yxZ13vxxE4LVu588Do/dGIFM
	 5H0qEUQVJBACLWTdwMs4J+66ORPF0/zMVMOMZ+QtMkaEvcvicEhFa3+mjJoW2C4m9RA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085483;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Qkg/6q+Whe8l2S6app6iE7cwQnuMxIPYg14DPS9JQL8=;
	b=QeOurFBC6J5HJu2bIAcC3xXmnY9MNrnPJzUlKqtZZY0kpqX6N8Hb4t6X/TDWOvAqfGJv
	 9EZ2Bg26j8cgiRCa7W43TvxOEn3XfwaH3wtSBSBMo9X8kYESVmxp8siExCEnuaZYjcQj6
	 psbqnBvgqX1vh3GYhWezsvnQ02epBCWEfbB4mmzYw4AA+S9V/w/d4eB5GGnSZpMuxN9z3
	 GC1FMU7MyA+dPKeTOgrhYIwpixxr1hF19uxw0oniJCo1HUzp0hCL9kBaIIH8zz09vfAz9
	 /zTp2t7iAqgxkHHEGp/U3j9dZ0+mS25UWP5zinqi6VAyiaMXNBhyCOzgrzWkVAcUyJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Dmbz5A68;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F167606A31A
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 07:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F167606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Dmbz5A68
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7DDBF20155D;
	Tue, 27 Oct 2026 08:18:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793085480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkg/6q+Whe8l2S6app6iE7cwQnuMxIPYg14DPS9JQL8=;
	b=Dmbz5A68hNvtqsgN3fpygng/Wb8kL+WWkS+RK6ril7S4z8SaSUPflGAVAHMgEv86dS9XZp
	PbEOGj0qWqOfDuqCI+bOOxOJcHZyivnhgTUqtH7PC9tEiAzsYe9KOud27KLzeCPjlm+7sa
	jeQM9gsBZOxWPWJAotRyUG4fARrcKIdNlvdVziWJi2DasPXLO6KtrQ6PWr68Eh57WM2z7L
	iuQymK4Ft/HZxdHIYgx6tQpqfPoBZgX7bcQ/6vL3EKcDDUfrQ+fW6ScaFbHToiGnX7i9KS
	JY6srFyUR45cL6qe80+7cRDhRSWwWqVY3cJZCQdJiNuthgLoW/F8VbavX6xhlw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793085480; a=rsa-sha256;
	cv=none;
	b=Uue11IvRYHDBAvLzMZlXpYMOd5gpvthYpw8/4RRTuFwck4gZQlx1Ed7AqJPmRY5uX7xb/L
	PYjDUQJySl6t9z/4TyBe4xkn+8qqoIwgNKV7Ygd3uPmvGSw2K6l7JENmXh2lFcILs9SUiZ
	6AbC04MRz9zG8wYlfAZnjzsmW0HonsArXu3tinIso8Q1gpxzRHBlMK2bwM3BZ4FRCrCSVs
	H09r7SVq41H5Cm1kMNALJENezxhDVXpGoiIl1X9VGgMrmZiGOUJYExTc853D0HyyrEO/NR
	dLuEjxCQULwclrjt0+E0Jg0q0FmjISAJVjlx3YSjuIsZeh5cTqrGOW2N7D3Ejw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793085480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkg/6q+Whe8l2S6app6iE7cwQnuMxIPYg14DPS9JQL8=;
	b=WwblGiaX6JB2VixOviQWzarRTwCKzz7LC4JukMYgDuBcLALSzbRayWsgBHRSz9BNRL2Ljm
	y/ua/pYrExop6L0oHSMci2W/80Nq1gD4yVu66up3CcO5Q4i5NWK6bCRiLgg6qSqGJbULMz
	5vJ+hLpx/31QzGBMkyOhj5STtSYcs4RiRhBu0cZKuzi22MRIPZGstpQ42kOL1un8XNok5b
	NU4S88RnDAdXDU0SR5RDzqOMB1/6wIjWML2RKvBjM2LkHJ+O3IeaBa3+RtyGO/URUT5W4z
	EzB1VZ27MZrdtborhzRPPFCnBjDb+6V/wglQax8FPtnuCSPj/njGv0/AU5GA6w==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLbRY-001Ocy-1N;
	Tue, 27 Oct 2026 08:18:00 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EF05D5D78E3;
	Tue, 27 Oct 2026 07:17:59 +0000 (UTC)
Date: Tue, 27 Oct 2026 08:17:58 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v3.2] can: j1939: fix j1939_ecu refcount leak
Message-ID: <20261027-invincible-emu-of-pleasure-cf2c67-mkl@pengutronix.de>
References: <7df4f6c6-b53f-42d6-9725-e60b763d01f6@I-love.SAKURA.ne.jp>
 <3958917c-1484-41e8-8d62-99575edbf980@I-love.SAKURA.ne.jp>
 <20261027-silver-mackerel-of-symmetry-5b5b66-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="fpqh6zkogmhqzsgs"
Content-Disposition: inline
In-Reply-To: <20261027-silver-mackerel-of-symmetry-5b5b66-mkl@pengutronix.de>


--fpqh6zkogmhqzsgs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3.2] can: j1939: fix j1939_ecu refcount leak
MIME-Version: 1.0

On 27.10.2026 08:09:43, Marc Kleine-Budde wrote:
> Hello Tetsuo Handa,
>
> please _always_ send CAN related patches to the CAN mailing list.
>
> Don't invent a private patch numbering system, only use integers for the
> revision of your patches. After v3 follow v4, the next one will be v5.

Also, don't send a new patch/series as a reply to an old series. Start
a new thread. Consider using "b4" [1] to send the patches, there is even
a web-hook to avoid local smtp servers.

[1] https://b4.docs.kernel.org/en/latest/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fpqh6zkogmhqzsgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauBQJAAKCRDMOmT6rpmt
0hg9AP4jZ8feKYSLUEQf7i7g7Yp5S2rXrFDKTz7KrfCqLJOWAgD/aqGQNd6BgdIv
1F0VHcTXM67i61A9mkqJxuKIjf8xqgY=
=ZdVy
-----END PGP SIGNATURE-----

--fpqh6zkogmhqzsgs--
