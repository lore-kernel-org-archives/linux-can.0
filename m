Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792955177;
	b=G3KEaNXQkm3k66jprSt5Uc53TgFTldFdtI9xhOKN9Z24PrTiVI1Hp6XGR1dF7KJYyIDd
	 cj48E16AcVNx4F7hBGmjkX4Yd4Y7+WtbZyxr8UmSoEdH47kDp+k9TqA/9YXpEOphYu3Dr
	 02109VehPBtbWlgsh0tbP3e1yigCTEwEL0J4LZ+h0EgJ7JCtfPdPPHztI250a6nlpWyla
	 NC8YAe4vfbDfT3anG6Of/NiQZbTLdaUgxUJhhj4KGUSvb55JlP6XaM+ogSIOkaHWdFaZd
	 mouQfxypkEuOC2rXKqBSNw/4Ud/U/EP0WSWNrbrC1QDTWPegANPV45q3BbksKte+s+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955177;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eX1n1jZKWkrdPn2fTaRRF/5VhWSAcFIYQI3qFidND08=;
	b=19neWDQ1USNyMO0J7tSpnnqYDCTaNiTwI+kgZ7LtjDf5HNjFET8kstaC8rtm0RPcavQd
	 c74bBNTlfBLhYFmLJYv2MVJQEwAGdFVfLE3KNsNXjq9hAOQeI5MYwxH++Cjts8R5jYzj9
	 bvuy/W6QRMLrY+GKcvj3HTEnbZ6moHQ+Sn3KbIi96DJCbJVvss3SKEAr0RKFgNa8zXtl8
	 j8Q82pMEKCDrMfTax0RphwqQcAex/FMR35cX0YzT9zVhu4qVLenQel0p2arqe8nIeV36g
	 YmvT/vJ9r0XyZWfsbLP1UJLIQvKQ4qT5EFNB7O/exTNROto+R0eeBZHxOA7N+X0FKhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NPdnxkmb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA6606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 19:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0EA6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NPdnxkmb
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 984B9200582;
	Sun, 25 Oct 2026 20:06:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792955173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eX1n1jZKWkrdPn2fTaRRF/5VhWSAcFIYQI3qFidND08=;
	b=NPdnxkmbHO26jHX6b3WzGEa8/bLI/17W9ix6kQQpt8mQDKyZJq7XIZcGAn7z6ljNjb3wU5
	qNi8LfNHFRmAfen9Uz/NTW5TgJ2A9fhhXv6MObkjSSjX4/rg6AehaveffNtcTfIjAq4vnk
	R074EPfeAqBat1gyAUGLouLWmtnDcygThWuEZRcnoTlIDPVdU0ehXzDb2uTtqRqHxkMl0z
	HRz1D56Rfn6H4Yfa8oephAEn8WNbpqVLxk8apx6lYgE++Cl4v5UIy54EOsRWBKXd9Pptsu
	8m+q4GdNLyYhqmCH0XmGKnXb+YJsgeLwqZntoAgEs+QTAIxpI6GxFwW6cMIamg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792955173; a=rsa-sha256;
	cv=none;
	b=Mobzk+z5tQmsxFd/gA9Tk5+tQ+Yz4JhoZanSqroqNUwpOWbswBYO6pqs7r2BiqURpWWaB8
	83kRwpfDSMA/iq+jmhEadFIWc3a2jH3RxuMmVFKMpFdHGuOAArSIhTrzMEkjurs1DtxnTg
	A5398iAK6ZE1b39yji2WbOvL/jAh12mY8BFYt5YRNKPI2911afBlpBKWxjF2lFNUqUdeB+
	3M5eLTNLgwF9/8wAhy2DVyWpsftsoLSqPblQcRLNrV4yGAQrz/1VEcFS3fuHLNWY5fv3Lr
	G0xdf2IZGgJRtW/iSkGq88/v80c4R8uNmQ4C6r0ze8JFjRgtuy47E6ADVSiqAg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792955173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eX1n1jZKWkrdPn2fTaRRF/5VhWSAcFIYQI3qFidND08=;
	b=SA9Yy3Zc9emSCqLQYCv9/AIVpbQS+i+vSUh6Y3vVezOqnC4rDWyMpmBW25bfbkMOgjDwug
	dXyhIRLJxZqBqowBvpr9EBoXYVz9PUD7JVRRRP3Fn4vhr3InIEAVDLn1qzDdfpkUOfWn0S
	F2l3YyE84L0fiAmeA0sCSBYXDBCQ62qKW9G8i6ofu2XpFodv8rGFONKOv4dpxb1MdcTA01
	t+d9lT7PdIuIM4U2sXsgV53VzMhqItJ3WVkuG0horlS5dMdZ3l1a4NQ+EuW+Ruds3MlHwm
	UXJS/wq2Lngp6xFzkZ9j0kiSHuB2U73ta7HCxXVDPoep1x9yjJ0kRlYgXkoZyA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL3Xp-001Aen-1b;
	Sun, 25 Oct 2026 20:06:13 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3E2125D4185;
	Sun, 25 Oct 2026 19:06:13 +0000 (UTC)
Date: Sun, 25 Oct 2026 20:06:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261025-unstoppable-valiant-woodpecker-20c6dd-mkl@pengutronix.de>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
 <20261025-pompous-mahogany-koala-f18498-mkl@pengutronix.de>
 <ee27f899-0ac1-4059-ac74-e4ddaab61b0c@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="bt4tjdbg7godq645"
Content-Disposition: inline
In-Reply-To: <ee27f899-0ac1-4059-ac74-e4ddaab61b0c@hartkopp.net>


--bt4tjdbg7godq645
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 25.10.2026 19:55:11, Oliver Hartkopp wrote:
>
>
> On 25.10.26 12:28, Marc Kleine-Budde wrote:
> > On 23.10.2026 14:17:54, Oliver Hartkopp wrote:
> > > This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can =
be
> > > triggered when a CAN device is moved to another network namespace whi=
le
> > > a socket bound to this device is released [1].
> >
> > This series doesn't apply to net-next/main, probably as it's based on
> > https://lore.kernel.org/all/20260831052031.902699-1-ekffu200098@gmail.c=
om/
> > Sashiko fails and you'll get no review feedback.
> >
> > "b4" has a feature to track dependencies and put annotations into the
> > series. Please consider switching to b4 and use "b4 prep --edit-deps" to
> > track dependencies.
>
> Good idea. But it does not help for my current problem:
>
> https://lore.kernel.org/linux-can/bd31fd1b-1fe7-44a5-99ee-635262a1ed33@ha=
rtkopp.net/
>
> Against which tree should I post the patches?

Does this work?

base-commit: net-next/main
message-id: <20260831052031.902699-1-ekffu200098@gmail.com>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bt4tjdbg7godq645
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat5TIgAKCRDMOmT6rpmt
0r5fAP9NfmX7EDKnQdmbOgNb3BGk9AQ4krI7C9rZx/RPMothaAEA4azO6q3gMx/J
mgfN8nBgPGVYh4NtEmFQx05+U4gjKA0=
=yCyR
-----END PGP SIGNATURE-----

--bt4tjdbg7godq645--
