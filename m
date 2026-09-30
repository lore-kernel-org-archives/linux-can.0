Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97D45DF5B
	for <linux-can@vger.kernel.org>; Wed, 30 Sep 2026 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756130; cv=pass; b=GyS6PzB/YLWm7bMuVidbT4D0VmMV1ET0IY+7jysq6H5EAPVFW/pew3m2E/vY8YZ5f0ITTQ8tgdT5Xb6PcwN80y0v2XpoH8g9SghTqzBrPgRDCsH9y8baGIr/glo+9XISbUyqJW3vRLp7BrchS0hsTKjW7QOY23rhuVIstmv00Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756130; c=relaxed/simple;
	bh=b4eALtRF5j+u3x8Fv/t0J+rgOBusq4tKIthSxHXjxt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB3JOZtlJkxxkD3uVJ4X7K6oCzkpi9K1aVneIZe/0q6QBoZF80Dtuz40johf4MRmBmxKkpdDsOEVY8/Q8sdfRPBf9G81z6Dy0KbBqggihLAvthvtKqBJ2+iO+ey1JoYPeWGyep+PDt6kx3FMNTpQtTKOUSpqRpEd2yMONaTjuAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=dwJjsBaJ; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="dwJjsBaJ"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 89F512010AE;
	Wed, 30 Sep 2026 10:15:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790756126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0thUQbGGaOGEGKmv0+PizX1SHQ7VKbyctZLfSSdSZU=;
	b=dwJjsBaJqz2QJybXdXta9vESiAZkLZkx1PlZtj1S96iP64iP6tO17c3qDor+Jyvnouemna
	2F9dRxa0sUElHMuCPXw30v2zYQVDzqwWbNzX4oj6AYIRvLSvplZ0WOgz0TLK/W5DPmF97J
	6MhlTvis7/henHS9vHq2KtkbzYd1h13uuGJIqPFjt0O58ef3zjI8id3BJ4zZDkyzBcKTjj
	28ujOyCWTCl7aw529Q8tgkd+ZMRs/U/4Td8BYUjJ18SSbp1rS4Xs9wWyBNELGNWiBxVfGV
	A87aZenbMcYeZO4J7Lv43g+kazhEOHUtjf2WOX765DkEw4BuF5zsB+Ei8soL1A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790756126; a=rsa-sha256;
	cv=none;
	b=IEr47HHB7OglC1egUDUsGsjObtHaQuUTBfVTaylFEnSkzfnilCoSvEUicDRKUDpvZW3WP0
	f5sSCnnaoOjPeHGKu1mhldKKIN2v0P+L9JjADJMIj2gZK/KCGWgtQu9pihi48LG+63hjX+
	073quqWZlNA6v7LYOZ7AuN5XpkfhDaX8hELLWxwy+ZfmntAtahbbRmKBXMeLBdgcZEbP5Z
	9yts4jVUEpT/HAQIjmYraZO2f24b7Py+y575pwPn+40y9O9D8qHa2XGXcM54HYbgvIiAIs
	ZP+LGnONx/pJeeh9RMf/YE1LWgsmy9D7LBe4swHoq3JtObW9M+dJYiALBQLt9w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790756126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0thUQbGGaOGEGKmv0+PizX1SHQ7VKbyctZLfSSdSZU=;
	b=ZPlVPk76t46fOJWbRBmcljsCswVl3c907mzyGDfJE9FrVKmVHIYYgGt3wpJIoA0e7djXQk
	wH4kDP+FfGU5GF2+KhHJ+2UCmMZRKw5eAXKYUiI0Q+grkIcgeyEMxTTjH3HCNgMlW+eGJ9
	OfzKeTgtibcu1MFmTJXLd8TzG9xB7GEIzhi5CNFPxpQt4P0z0ZaG+xhct8MgODmiyl2JdL
	X68kyubrBcq5dDQxt3CXJBfpt7A1/bquRhaSji8cYzeeTYMDfCsJ0YWlmReekFgnZD71MC
	PvC/tB0e9p9tn76bnM+HvAtcenTX0uMXm+Wl6hEh8o59zRBtzz0Kn5lnxT4dRQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBpTK-003WjB-1R;
	Wed, 30 Sep 2026 10:15:26 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0EDEC5B53BC;
	Wed, 30 Sep 2026 08:09:13 +0000 (UTC)
Date: Wed, 30 Sep 2026 10:09:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] can: peak_usb: Add bus error reporting for the
 PCAN-USB FD family
Message-ID: <20260930-defiant-invincible-mole-8090f2-mkl@pengutronix.de>
References: <20260929145401.6FD0C1F000FF@smtp.kernel.org>
 <559842824.808060158.1790754559351.JavaMail.root@zimbra65-e11.priv.proxad.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2jmauk5w46k4s4si"
Content-Disposition: inline
In-Reply-To: <559842824.808060158.1790754559351.JavaMail.root@zimbra65-e11.priv.proxad.net>


--2jmauk5w46k4s4si
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: peak_usb: Add bus error reporting for the
 PCAN-USB FD family
MIME-Version: 1.0

On 30.09.2026 09:49:19, St=C3=A9phane Grosjean wrote:
> The NULL check was added to protect against a malformed PUCAN_MSG_ERROR
> record reporting channel 1 on a single-channel adapter.
>
> Such a value cannot be generated by compliant PCAN-USB FD firmware and
> therefore indicates corrupted or malicious input. The driver already
> returns -EINVAL and aborts URB decoding for other protocol violations,
> for example when the reported channel index exceeds the bounds of the
> channel array. This change follows the same policy.
>
> Since the input stream is already invalid at this point, I believe
> rejecting the entire URB is the correct behaviour rather than attempting
> to continue parsing subsequent records from untrusted data.

Valid decision, let's document this, see my other mail.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2jmauk5w46k4s4si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarzDpQAKCRDMOmT6rpmt
0jFHAP9lVKrakc44xXaGpj1WpbSEFS59waHx+Gwcv6QRleo8CwEAn1NssgOXsGMX
wfjIHw4mPgI54pMXyb1vHETEaGgwuwA=
=3tS3
-----END PGP SIGNATURE-----

--2jmauk5w46k4s4si--
