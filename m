Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794661779;
	b=opmIU21HW8Oz/xnxqO/cq52ceQpO8o7heGUeWyEGY+kCylXRLS4p0dSVurTXF7v3dORP
	 muTienlxX5iSbLgOuURIaQrj0FFiJPLZy3LaZhieGFHamte2YnNi/gScFmelJGKKIhMMw
	 p1+jEcCDBrO/n7lHBl6z0JliHXzuWvod3FXR6soOEJTyiQENy3BwyZWh0FaJvpTDTb5zg
	 WJQbGtCep4zRrUTe6V89u+C693CT/r0vA32PL8DTzd4WhUc8UtDXHb9zCFW/s6s7noZs0
	 HHrCE3EjHFDVAqsAUlsrc+tl2Gm3oBdM2c6zB8jhR8PHjHav217VGLN3JCYJOnpA3/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661779;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Y/vygKYTS+eUO2ILh8p+Eh/J5zjp34nfhMcWGVPLe5A=;
	b=Q7LSfckYtOLiz62RARJFeebIvhcMxaxUUl+O+Tz1KMUCP0jiR7/Fq86G05ySJdpFX74+
	 kQ+TL7ahr6eNbEzXSaKafUcHuGxdbk/NLBhtGFnUnizmUIAFz03uxPOTWXI2jQYJTPTEQ
	 vW04YmNpvgLSztXcUWm5nUFF8D4Bpv8Ml6llK0axigIHK3gfSf5DCXfXBEu6IDarBGQZD
	 rDeRdRsktoJkw7BMCjHQHkCn5q9Kqm7elzoLIzpxeIp7lLmA1jOBIbeKUOgyJD9QjGwmk
	 auJ965CylCWGWUM6+H8ghzHyMirOl/VbBNQMpXHqFP5SMmMzIKghJ37GDPDsg9WaxGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=V1JUeloh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716760A2610
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 13:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E716760A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=V1JUeloh
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1BD86201E6E;
	Sat, 14 Nov 2026 14:09:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/vygKYTS+eUO2ILh8p+Eh/J5zjp34nfhMcWGVPLe5A=;
	b=V1JUelohzcs9y0B3/oxRzrX+iIx2RIQrsuCxMaN+wi6V5NLJPmbpL3Ja04WCBWlWBIOP5z
	m48r6XFuhJObKQ+OkvNUs5nGhWvayGHVo8NaSMYMgO+gHIzIf8Iu1sdHck6h4vtCz2p9NW
	ZansSg0oo5DGsMcJV/5Ej94mifEgTYxmQuc+SC/T+BVnBw8iADCETdZpd2VM9Z/aDbV8QP
	YNnK47FRVnbjGOCpSPsW9H40K7Rz7rXRPkCAE9qqFDb2xyZjBdg0OEPQhz+oXvZ2mooPN/
	gVfVht6UcQ7Mk3XCJi6pJa0b0djvFA+WwN1oQPI9UxYbDyfPGVCtLUYF/VLL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/vygKYTS+eUO2ILh8p+Eh/J5zjp34nfhMcWGVPLe5A=;
	b=anydxy3XzUIsue9lajliRvr61FJZnMqfhN3StXHvtjxFkdTQAiBR/Pk/CgBTCwWrvm4D4B
	3RotsDiRoI1uGPPzk1y5s8QKsoXo2pbL5eDyV08xeii+425d2lYyBTtXgS6eZhOJSLkakD
	ScvrClHN9AQ3/Gfs+55lMAKUcLk5HBl0voorCy8gg69ijsrGvtneF8mm+A1+NFTVpIuPS+
	rl7B+6priL06gkS9vjlJYwT60taKwnGVc3LTS3XLEJM+YmZCmdF0ukywU1n+hNTCAuemZs
	zFOyU9axQYw8yrCRvRF7vqc9N0Pb9sadM5ssg17kPGv1S4Vhq5q6ScBOvxB5Yg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794661776; a=rsa-sha256;
	cv=none;
	b=WNKCGVfmFMnzxi7JwaHLvnNXFqHID47FtmlON8Ef2kxr9I99ew55zk4SfujN/Vs82IFOuI
	wuO3AcqlEjMsATGpGhBMeG+61P1+XU9HF6OftDLeDx8um0YNCy32jwlwHEnVLpnjMFy6OR
	bDeN85/1YErXKUHIEWpIfA6vDkacMiTViIC5NakdzWSOWGdqfIgEKAexhJXvSy9WRP8QC2
	a9MlBokkdUk0oeXcvD4vjyB0thScNPulYwE+tKXyv8fludy/1tGNij93uNWKuOFW1mSqb/
	YDjoiq6j6knVZvJmdo8J6fgnWQqJBzCzebAwcClt9vlRP39O7U1w1CsIvB6kVg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSDVg-00496M-05;
	Sat, 14 Nov 2026 14:09:36 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8BAC95EB9FF;
	Sat, 14 Nov 2026 13:09:35 +0000 (UTC)
Date: Sat, 14 Nov 2026 14:09:35 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	wsa+renesas@sang-engineering.com
Subject: Re: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
Message-ID: <20261114-fuzzy-chupacabra-of-security-74271b-mkl@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-4-2d82025e9646@pengutronix.de>
 <sashiko-outbox-214520@kernel.org>
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
	protocol="application/pgp-signature"; boundary="og3mzawsiysim2ta"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-214520@kernel.org>


--og3mzawsiysim2ta
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 4/4] can: rcar_canfd: rcar_canfd_probe(): reject
 devices without match data
MIME-Version: 1.0

On 14.11.2026 13:03:20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] can: rcar_canfd: missing Fixes trailer in rcar_canfd_probe() fix
> --
>
> commit cdc806522e3e7626b43c3c2411bfae563ed95e04
> Author: Marc Kleine-Budde <mkl@pengutronix.de>
>
> > can: rcar_canfd: rcar_canfd_probe(): reject devices without match data
> >
> > A device bound through driver_override need not match an entry in
> > of_match_table. In that case device_get_match_data() returns NULL, but
> > rcar_canfd_probe() dereferences the result.
> >
> > Reject devices without match data before continuing probe.
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> [Severity: Low]
> Since commit ce7c5382758b ("can: rcar_canfd: rcar_canfd_probe: Add struct
> rcar_canfd_hw_info to driver data") changed the match data from an enum
> value to a struct rcar_canfd_hw_info pointer and dereferenced info
> without checking for NULL, should this include a Fixes tag?
>
>   Fixes: ce7c5382758b ("can: rcar_canfd: rcar_canfd_probe: Add struct rca=
r_canfd_hw_info to driver data")
>
> Also, rcar_canfd_probe() calls of_device_get_match_data() rather than
> device_get_match_data().

Will fix.

Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--og3mzawsiysim2ta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavhdjQAKCRDMOmT6rpmt
0pcDAP0fKD0dAF7sNVuHl5LJG+dbm6OV3yHI5r1mPwaC/XpnLwEAtAbZYx84cbKJ
jhMYZe6WUMQDKZI30eIG5vPm5GevTA0=
=/JAM
-----END PGP SIGNATURE-----

--og3mzawsiysim2ta--
