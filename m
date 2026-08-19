Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC053655D8;
	Wed, 19 Aug 2026 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119048; cv=none; b=L/mGeRl6sS1w5QIr/RH9SR1ij6TrYPMyKe3GBoMrajbTBpERAHH3d+X9Okq912Zm9c56bfu1tndR4IPSeSIzmerjAw9CjAbkO1iff4twkBfRD83zhPYHWWcRVwcEhTk3LU3748UJcuERWg7ESrqyhJghKSPp5JHupAOBvGLa2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119048; c=relaxed/simple;
	bh=2wnc0QQjJgHi7Uk5FMqpcUQhzrkTQfFg0gS2QV9apCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR9HPNWwz0fKz/9IrntrLQoQRaRSm+ogYHZ8BgED81rbLDlHKlIVsrdgkKlL5BCGVhlVlrIsllpJlElhLzTrDPBwhIhK/wdNcziCDh8ZlKdntIq3CCu/h9Ku2nzf+NHglJKyuxxJ9QE3ckQ/FzmeJvNKO1mQffeFO0A+j89LvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8B9D820044D;
	Wed, 19 Aug 2026 07:57:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wwZIi-002FBZ-1R;
	Wed, 19 Aug 2026 07:57:24 +0200
Received: from pengutronix.de (unknown [89.207.172.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 81389585FFF;
	Wed, 19 Aug 2026 05:57:23 +0000 (UTC)
Date: Wed, 19 Aug 2026 07:57:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Max Staudt <max@enpas.org>
Cc: Baul Lee <baul.lee@xbow.com>, mailhol@kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com
Subject: Re: [PATCH net v2] can: can327: Fix out-of-bounds write in
 can327_parse_frame()
Message-ID: <20260819-rigorous-ruddy-mammoth-abf127-mkl@pengutronix.de>
References: <20260818221818.49430-1-baul.lee@xbow.com>
 <c88e0f37-b9b2-4f92-a0c9-1ecee44d6d7c@enpas.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5v4rhv5e5ntkawfy"
Content-Disposition: inline
In-Reply-To: <c88e0f37-b9b2-4f92-a0c9-1ecee44d6d7c@enpas.org>


--5v4rhv5e5ntkawfy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v2] can: can327: Fix out-of-bounds write in
 can327_parse_frame()
MIME-Version: 1.0

On 19.08.2026 07:28:44, Max Staudt wrote:
> It seems like your patch sending tool didn't pick up the Cc: line in the
> commit message :(
>
> Can you please re-send it just like v2, but also ensure that
> stable@vger.kernel.org is on the email's CC list?

After I pick up the patch and send a PR, my tooling will automatically
send it to stable (if on Cc).

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5v4rhv5e5ntkawfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoVFvAAKCRDMOmT6rpmt
0qrYAP9OC9EyYrX8T6DPlzYbSP7KirQO7os2f2tbg2QH3V0HBgEAwByB2G/LN6Uo
v+OtpxH8gAbD69gykmdQhAX5ZLPCyAQ=
=Owi4
-----END PGP SIGNATURE-----

--5v4rhv5e5ntkawfy--
