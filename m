Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B34DF4D7
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549229; cv=pass; b=UzEBjkBL4R/A3EHpsn4hWZ8H5gWpnjjtW8Izi8ZFnnbBYmplLA3kEWiAMZdlL9BecJBAPIcMpa2iIu0vvdRcrqKEiho7Tf7rL0ss11TRf177SwY9NBbdMPKzjZOgj5ePZFu+2AKvl0hv6ayuZYLzz8koYzbmXUXREkb9iTozRTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549229; c=relaxed/simple;
	bh=hRBwgteDkPw16J8Tb6MYbkV7EB3GpQCMRRO+6KTah2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHPgr6c3DDzkqPgZ2glk80gYt2gAwx6dGnePA6smEEE7I4N1JVk+e3WTLmuFTiiWuGKYKNhfBqTgxrKx9DXicSZDu6kUZvdoyr4Hwqr0YWnl9K+5Yprxp1Si0SEVTBGCaAQstWrtr8Zz7DBsSxdnW+93wD8Ei9z/7uXf/G+rwTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=d3c9eRuN; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="d3c9eRuN"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E78702004FC;
	Fri, 09 Oct 2026 14:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791549221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdFzt0Qe3aynQbmqFvJLUDvEu+owmcJs7/zMVh9266o=;
	b=d3c9eRuNyxq60529C0aH9+xzQoLGF5QoLfgWQjMPjyrngIPREwiNF8j1zFJWDanFZNpeNS
	JyRKZPNTVcV4exWChQy0zKt9p+i51yP66yx0a6c/9dcPAdMReg6eIXfWfbMheN0TCjX86u
	22hhuctYeUzH8jAb9AcDvZ9fwpMTPHU7xOGRr8HLvoGqf0udUwrghg5FxFeE87GmW2cnAC
	dz3Sc4Dh6R/9LSHitfI4K+YFShL+6g+CIcumHHGRUWA0BZ6dgSzjj/0WCogVCvpVOj0U4J
	vNlpMIGEbCO0wIIuD5YYQG2FBKhQCqapuyXZsuu5ricyituWB8SZ7372rlq0FQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791549221; a=rsa-sha256;
	cv=none;
	b=FuBDeqEW45gXrfqc9TGjmLB7ZBRhsUxaX9r2UEWS9t0One6fPjVFgyzAsYBZT9uI/GltP6
	UEEB/Zj3KtMYdrpCFlCEagHvhmWEEv8JLJIi+zaqaFuR37IPnhfXd2JyMBGrgPvZuXabIg
	mJ7wqZdYXExqweD1qU3J36FVIj4JRj663d5MdG1grC29CEXNvbhctGJ06YNNP4NdhO807X
	zSF5Jgys2W2wzzEt93FGXVBVwUYA/+6Uz59NBW8FRj4ImHmBoQ/1q/SjX/KzgFCbS5KKGE
	h3Vs6s4vr5Gd+0bnMmwGQs55IDDO4vi5VcVJUekOxOBh2ns4hqJDkUghH5WnxQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791549221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdFzt0Qe3aynQbmqFvJLUDvEu+owmcJs7/zMVh9266o=;
	b=X/q3CMKpgQAiRC1J22A4JNSzJCOhg+s5jURFe3FJZIRdHZsDPoUZwdywAPw1CkrNyJc74u
	zBqML7QLXXAbCf7bCzzierWLDDbqqF3Odq8uWeFzUd9DQnZYqvJqbOgd7DZat9reSc72b1
	rIdC06AN5AncZpbuciYOj2PoZ+IC8L0xEVZxt7pgjpZEGJqVwmU09t8y76ksZGFMJp8R2m
	B0NNM5q4zoSKIAZlgYrbkrksaYMDo/NvEo/99R93UHr37fXuzJ2AIB+TXgvo0WNoPMJRAz
	WXsWKiF3YHN7TmpTKQGm89iVz86qaiL6ej5TYLi44jDTW7ZlJu0yPv5WKukXbw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF9nB-0052n5-2k;
	Fri, 09 Oct 2026 14:33:41 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8CB4B5BD794;
	Fri, 09 Oct 2026 12:33:41 +0000 (UTC)
Date: Fri, 9 Oct 2026 14:33:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
Message-ID: <20261009-exotic-tremendous-vulture-225cab-mkl@pengutronix.de>
References: <20261008192253.574195-1-kuba@kernel.org>
 <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
 <a5860c87-b034-4cb2-9995-763c6b2cf58b@hartkopp.net>
 <20261009-hoatzin-of-sexy-poetry-3d407c-mkl@pengutronix.de>
 <7099597c-7b8d-46c6-ac5b-6a0662869862@hartkopp.net>
 <20261009-noble-straight-eel-4a729b-mkl@pengutronix.de>
 <df3da1ab-9a03-4720-9486-f5c5902cb9b6@hartkopp.net>
 <20261009-furry-coucal-of-rain-04a98c-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dcnn5gmjzqfilbhj"
Content-Disposition: inline
In-Reply-To: <20261009-furry-coucal-of-rain-04a98c-mkl@pengutronix.de>


--dcnn5gmjzqfilbhj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
MIME-Version: 1.0

On 09.10.2026 14:32:54, Marc Kleine-Budde wrote:
> > > > Do you want to apply my ml_priv patch - or do you want it me to do =
the next
> > > > 5 minutes bevore the PR?

I'll send a PR now. I suspect we have to work on it anyways :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dcnn5gmjzqfilbhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasjfIgAKCRDMOmT6rpmt
0voaAQC96SOQZFsH6iDBECkrkC/au69WMG+vj7V0hoXn1Am6qwD6AkOAXOEWsy5M
Ak4uitVcEBWBiKkTuHcgE3Z/zLZNTAQ=
=fCPb
-----END PGP SIGNATURE-----

--dcnn5gmjzqfilbhj--
