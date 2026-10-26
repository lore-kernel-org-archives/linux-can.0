Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793015510;
	b=a9NEBXOURNYmbVtKWFjJXijSLRxuVANeLmiaKMOxklCouU0/MwqQr9nZ3mKRPgR60BgD
	 s0tAoOPXVDEDUBq6DSkxo0z7NLsQAjZTYsXl0UVIvL4jRQP5soHvd0QnJWLFUk6qdvRP6
	 b0GxG3Q7GZNhYK16HOkpcd+rrqr3kbtoabYPQurEHXGyh+ai3EYmylstiXYznz/kFza1Y
	 XbFhuZTe764d9iwedKNjF7zaoQvYqkOark8ozpSTPQyhl5MG2k+SeNWeyrXXLHVfviz4h
	 yAvbEMQUsgdd2KeVECSepLW2EGVap2Y61BRFE4j2T0377iNv76jg3Z4+Gn9KyN1iDhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015510;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+MVpBQsp9RYot9/4YOPQHJ2KSpWeRb+iG2pPhYOnfGc=;
	b=Ue4pzzZ3fksnSX7974ITb6NtMjrWNSrLvEuFFEgIc4oekL86GtBPPctnCpYR974ZUEGZ
	 yPSUz+a1RAl/vGNRUOUjxbh/TQvSYQ8FfWA1WOXDfgzxEqMcHEPLqHnQ/9SUNVEPzciT3
	 ZTiHb3tH5pb66Q+P7I0PbTWB9Ke1j5z/Z8GM2IRJ6JVKzqJsm7Vei4NkPsteB+azU4vg/
	 u4p2MNqw9uNuw+D8q3yOiDodIlgdmh5fCz2MSUP1y1LAJG5sAGHoan6H/6oAmVCJ5TS7N
	 +f7mA/q+5WDTbk0q9f+KuqvjXOkqBxeAUaYZHAJuPCEww7tWDd/6Y6DTGhhDrhPGr8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fu9dFrKP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518F60A261E
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 11:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4518F60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fu9dFrKP
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6A6842007F9;
	Mon, 26 Oct 2026 12:51:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793015507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+MVpBQsp9RYot9/4YOPQHJ2KSpWeRb+iG2pPhYOnfGc=;
	b=Fu9dFrKPOkzqScZkmxM7oNIn2e6TND71uJgTPKRXnoLZOGYyx5SA6+x96Ha+4utPoA61CS
	vvepMzazbU48zkWWiL/PPoH+iRNz2KgJ/e3MYdu/jRd2VQMYDD9AFptBA2/bLjC7TO2Rac
	fxYflpO5oJcDeb1/FcdR+ZXXdhFbaouLOhfwpCBf11bNhLYui8ZZOWgpYCzPou5Gf3ODYu
	k+6tPr0RxaZaYshuUArSnQt93nyLVFxbK4fbfwcqh6OK7dZKXS/Kxy/cFur4i7gbAf0uOX
	smVIj7lPliioj0mbDQGsGGvSGrp8CB773h8lWdpAibUitHLeULELepZJ6UQvfQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793015507; a=rsa-sha256;
	cv=none;
	b=OX+4Flu/kDEPc2/RT4zPpBPzWPtYwPSL8e9Qnw43q7KtR3TpxnN1hNTAu4tmTWPABF6h38
	b9yM4Z7DNI8tdo6m9Nfmniqyz9CyJd8RmwGt7GqDI5mNJyi322J7XiDdwHVleadFOwJe/i
	Ddl/2yzblb1WyDVWP4ILD1B2lUfFo89ISAXNyic11bLKKHj+Npb6ZUmXNXM1lXlN9+gT4K
	qIQhM/vYV04e+fI4cdaF6cA2ihuKd58pfdFj3Gdh78RJMKljepDMx77W7iZhO1m7EbUf2v
	yZyTzPd66PsAOQKGDwHIekxAu/BzXLLDYKw81rNtNF+HicJ2vFHys8XpxSB/Eg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793015507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+MVpBQsp9RYot9/4YOPQHJ2KSpWeRb+iG2pPhYOnfGc=;
	b=BWHXBIZ7jLrHw3LshhLBeSFNgy13WwYZugAFtmnz4AGwaK5sjAtMw6GeujDZoHr9rina6Z
	DYbGY8PIL+hh4CoeYne/y3s1MFualDj1eIGDYu+n27nr+1JuFQhx9IoPxFcmPWzpk2IG1i
	cYOcR0YJHXy4ko9U6StqXfWO5BZFVDPAibzCVwJsmi5Nbk5pHWXQkGwUB8+8On8MzuFs0y
	asl6QdJG8xssOoey4cQ0anuxDGMbHv1iKlCvtQwrWrA7tL0Cif6qmZzudFlft/0Q4QR/Re
	bCxDhroA06fpncsg6v86qjrxc6G69msyuqc265VVUpRS3FJ6FcAwwRlBcjBhYQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLJEx-001H8K-17;
	Mon, 26 Oct 2026 12:51:47 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2628B5D6CED;
	Mon, 26 Oct 2026 11:51:47 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:51:46 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v9 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261026-belligerent-labradoodle-of-beauty-b07263-mkl@pengutronix.de>
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
 <89bb8afb-dbe5-4c8a-a6f8-66f9b0489924@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="xoyvizw4md2wdwyx"
Content-Disposition: inline
In-Reply-To: <89bb8afb-dbe5-4c8a-a6f8-66f9b0489924@hartkopp.net>


--xoyvizw4md2wdwyx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 26.10.2026 12:31:09, Oliver Hartkopp wrote:
> Hi Marc,
>
> On 25.10.26 22:32, Oliver Hartkopp wrote:
> > This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
> > triggered when a CAN device is moved to another network namespace while
> > a socket bound to this device is released [1].
>
> > ---
> > base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> > change-id: 20261025-can-rx-lock-cecab2ad832f
> > prerequisite-message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
> > prerequisite-patch-id: 20f07b0b0e4dbbdb1263e9bae3b652ec5709d87c
> >
> also with b4 and your suggestions this v9 patch set failed to apply:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025-can-rx-lock-=
v9-0-7ef2a2b5c2b4%40hartkopp.net
>
> As v10 has the same base commit settings it will likely fail for the same
> reason :-(

But it worked on https://sashiko.dev/:

| https://sashiko.dev/#/patchset/20261025-can-rx-lock-v9-0-7ef2a2b5c2b4%40h=
artkopp.net

Sigh. Seems the netdev sashiko cannot handle prerequisite-message-id
and/or prerequisite-patch-id.

| https://netdev-ai.bots.linux.dev/sashiko/#/log/baseline/8711/0

Can you ask Jakub if they can update?

On the other hand. As Paolo Abeni mentioned this series could go in via
net/, it should better be based on "net/main" (without "can: raw: remove
redundant NULL check before netdev_hold()"), as that patch will _not_ go
into net/main.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xoyvizw4md2wdwyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat8+0AAKCRDMOmT6rpmt
0v/iAP0Uwh5NWfoGQHDfTVLsSKMg32KttRpG47nsiAL1p/0VowD/Z9wg9EAcqYnN
stUfehB9AWUBU/PQWQ1mumAm71SNUAU=
=xFVB
-----END PGP SIGNATURE-----

--xoyvizw4md2wdwyx--
