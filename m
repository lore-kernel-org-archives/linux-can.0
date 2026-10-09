Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74174EB870
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563535; cv=pass; b=GHb5MEBr3lkaHZI96LixEJ6vHeAZUSErIe2oD7He8L/o9Z2xWDaMD/2RHQG80QIAi5m1MtKdpC1+tAgCd04pUX4praLi1HOvRGUEXcm8g26TI3JfIo/Elg1N58ixjeIGAvwWbABceUThRugKB808BWXY3Z5woUPlPn8AQRvVyx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563535; c=relaxed/simple;
	bh=ARK8Z7CWrZm0enQ2bSKHny4R6W8HB/4PyCF+eVEJD9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm5ODSTQ05DzYeyY+pd0Z+eINMimEumo1Xq8wQ4hQirqb9RppKs1/r4TpPqSmamODlXzUKXfcKKcinpNlBLY33o51CFAPr3aRargL+VJd9Cp78ZhPW39yHlC4FN68pOsOQ1bGCJQb3ZxWKn8P81FuWj6ya6ZBPw5xQHJofmGa3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VAgYv6sd; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VAgYv6sd"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5733B200582;
	Fri, 09 Oct 2026 18:32:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791563528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPJbdGX5owxOF85vQInDKUxTlzYvWO7jsz+08TamSug=;
	b=VAgYv6sdoQkOB72Ibb6OEJIFWhFuH2yJBHX8dWLHAcL/Vw71DWOngrCPMTYNXPL7xCfWmk
	9qFejsv3W/p1q1G+nNECJ3OIatzz4rhf/iW9ku4uS91Y0SSmgB5DUaLUF2dqornJf0I/iU
	/zL7Y5t57/aTY5t6TbhiaBHwH0DsoAx9kigKrNduxnNnpETTumKl2x5rIk5GroCMjX1+jy
	5Ker7EkJKbKg9aMYd675wDDhzzRCALdqGI7EpX+lHGVoRwIyjxZo09oiGDrczezAIl8LzN
	uqYimbBVrfU2oBK0wvxmmMKWQJjEQODbGZRUxYPzVekOZUa98G2rrbIjGdEGvw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791563528; a=rsa-sha256;
	cv=none;
	b=YkyAgFE9UVTDdYT1Damw+pvXZFsk3AsyyvtCSvHJZXYS2Uhlt+B2a6u4lNYlRhNOqmKWmY
	FuIFJnqbyd0NfWGQFaFoQohRp/lbw4MFroeuxvPs7SEpJUbEwF8CN6MOGShL6a9W3f9CZ9
	weKhvir+gz/9Aq3vf5mfci1rp0tT6+5NekqqAMLII5fCI/RMNBRy5O8X64C40SVDWWVknm
	hFV9RzoFUMTItNWuwjHwnTzM3bfgwOMPBvUmnplnoAMgtVcQ2k16cxTElE8MxccTllO8mZ
	R0pEoy1h5Wn9a/Tx1whJOp4PY5myZ0JzslKDjun0wJBosyIMPu0crWiawdYIKw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791563528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPJbdGX5owxOF85vQInDKUxTlzYvWO7jsz+08TamSug=;
	b=AkeIHWHea89v+UwkrcUnDG6NHl8BZdC30/9MYgKSbq/qhvI5iNLYKHDe5c/o4P8k3y73ZX
	Ih6yyLODTbshBuE393GtFCtATaL9hMU0uJCkknL9gEuP47DZJZPpa61CNUKZTkGAtsoa7Y
	yrR0Y1KrMRNPTGaLagPm2BKweYAwLi8VPm5xxSPiyCUPrhRuToDocgmrUGqC2zQXyGywKd
	4EOUHhh8XYhF3xCg59hLgAf8uC/GUtGRCavDt/a2pzS+5hdrhFYrMQ32oDtEzZM1T7Qo20
	8Q36gQThGQIn/ksHCpN8eka9Pnk6trub2e+nT0b7qMNPxpK8EpQ7UW+/LOuf5A==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFDVw-0054er-0g;
	Fri, 09 Oct 2026 18:32:08 +0200
Received: from pengutronix.de (unknown [185.249.113.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DA77A5BDB99;
	Fri, 09 Oct 2026 16:32:07 +0000 (UTC)
Date: Fri, 9 Oct 2026 18:32:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH net-next 0/37] pull-request: can-next 2026-10-09
Message-ID: <20261009-merciful-certain-dogfish-2c497c-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009-bulky-normal-collie-00a67a-mkl@pengutronix.de>
 <14f90123-382a-42fe-942a-b62f14307c85@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghnijld2hh6unwtp"
Content-Disposition: inline
In-Reply-To: <14f90123-382a-42fe-942a-b62f14307c85@hartkopp.net>


--ghnijld2hh6unwtp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/37] pull-request: can-next 2026-10-09
MIME-Version: 1.0

On 09.10.2026 16:46:39, Oliver Hartkopp wrote:
> Can you please push the testing branch?

You could also use the tag mentioned in the PR, but I've force pushed
the testing branch. Sorry for the delay.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ghnijld2hh6unwtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaskXBAAKCRDMOmT6rpmt
0qleAQDJy8HaP2xN05cjzGi0hiaNgsmECvWNt8iduq+YsUL6tAD/Qt8vs6bgjbS0
+gGsUc31mWVh6/wTCQUnZoRWhtoElQc=
=ZUnV
-----END PGP SIGNATURE-----

--ghnijld2hh6unwtp--
