Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28B455182;
	Fri,  9 Oct 2026 11:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545324; cv=pass; b=Dgkrk7OILy3y08gW0ta0Tqjdc6K9lHxmxxTg0hqS2TL5W/nEUa6Vy/vbyKlTTs1H1y67gF2tIFbFJ97xin31ALVMu7l3JMdRqef9LD+NvjdPHwdY3MkH5epioZ59qO4PEmfXonVRcf5iY97efs9K3Se0OFxTJMXo+4dMGihxhmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545324; c=relaxed/simple;
	bh=JSnVIHDopYavX/dioHSIGiZuWqqntHcGxONBHo1NzX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAKSq+Ip5tvpCyjxz5UoHmWhDXI3/fwNimwVlT16hW8BrLJ9V3QjUvh0/NaY6Y/TtDzN+kxMf0UKal1MAQtZxNS44hK5ctVSy+F15OsT0uCFSRMhaM0Ge0fbDyOzc0F9ZIlS/A+j8PARS9BCnnTTVa1VzFFjW4q4nHqxEdPbzIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=FAwrt9N4; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="FAwrt9N4"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7A164202342;
	Fri, 09 Oct 2026 13:28:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791545311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BOzSpdvClhVykrKcD1fBWHWbEoM3ekxNuGKFGVXs3CQ=;
	b=FAwrt9N4vrjXgZCwrv5jDbq5OLrfoGyCmmeI/5+z6jryagCKbKzciVnHhc22qW2IbRRADU
	OZLSY3urcz5W802B02YIfv2FIptniIruDlWjC0BlKNGkryqf4fvORCQhyTTUbIWIGCkqMI
	9vsZv2/Yggv3JWxdW/2m4bblNKOVrJkiu5BGZspodtHejBP6/MjqNPnNPcanvyKOFpAgj7
	4+nSIoxf5D5tAsyApcDtd/tHiMxDAyk4hxu9r1KGXPBNIdvyeSWmgY51ngut0jtxIrMrHt
	AFLD0iy77uCEtqCULJcDlS15R5N9yOjUocTk+ijvf8VlBMNgP5qBFpF0aS0Fvw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791545311; a=rsa-sha256;
	cv=none;
	b=NTMrnTdrLFTvxBjKUyy5Q+dnMYZuxUyA7DnqixtNWmfcesFcgTe9/nhKrTPfaGJcrkUHwy
	363DfVEBXAT+Uc2K6XnkAbEjEb72MbataKLuSs+kG/Ceu7P6oa0znfKOlp+kE7v2f5e8cO
	RcbAg4RA860jr7icETtlmBq/umZHc1o0T+oqu8/XZN4+FijXRXaYk+rRNUt021ZrAPOmY9
	qHf/5vdHG/1bWS+VmHjbS09K13PdkZtfW4v9krGO5zKgcDdR27RhNbKJHFlNaS1X77/Snf
	FtifN6yvKd3SXqpERnUVOnlSSUQRsGYA+UUOkvuZYh48HTNZiRrBkhnvVNTyeg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791545311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BOzSpdvClhVykrKcD1fBWHWbEoM3ekxNuGKFGVXs3CQ=;
	b=FQU9x0dzRuDziK8qqfdBu91pqxngLmdgOUN/cqfcD/CW8lyw3CHYJDHNcyg+fixDkbhJ99
	hT7/pAr8hkqvToKxSnObEEFs5SFN66QrxAU+rnUH6NAw5APUTZ1BmMiD7JqtYz+me4eHtb
	bRU9sEyGLTzfMrLEG8tb7QSV4vN7xESeFMefJ3GaO65GiZs6CAT/Rz6H15PBh75mOj2BtN
	Pj+oZrpHvbmvYGjFEy3/PJE3niXSjfzj0sE0pY5vFln2ShW5R/Vz1tQZMtsFkT7LwNN/kH
	Om8YWuEhu00zIUiN4rMWId4uObtoMUQRVWXQ1ccGDf3PQoHsDC+6g3Ge/Yc4Dg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xF8m7-0052NN-1I;
	Fri, 09 Oct 2026 13:28:31 +0200
Received: from pengutronix.de (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0AC455BD6D6;
	Fri, 09 Oct 2026 11:28:30 +0000 (UTC)
Date: Fri, 9 Oct 2026 13:28:30 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: can: cc770: don't discard the IRQ lookup error in
 probe
Message-ID: <20261009-rigorous-carrot-chicken-ab31e0-mkl@pengutronix.de>
References: <20261009105556.301821-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vdr7ivw4ipnwobbr"
Content-Disposition: inline
In-Reply-To: <20261009105556.301821-1-quchaosheng000406@163.com>


--vdr7ivw4ipnwobbr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: can: cc770: don't discard the IRQ lookup error in
 probe
MIME-Version: 1.0

On 09.10.2026 18:55:56, Quchaosheng wrote:
> From: Chaosheng Qu <quchaosheng000406@163.com>
>
> cc770_platform_probe() collapses every failure of platform_get_irq()
> into -ENODEV:
>
> 	irq =3D platform_get_irq(pdev, 0);
> 	if (!mem || irq <=3D 0)
> 		return -ENODEV;
>
> That discards -EPROBE_DEFER, so a probe that has to wait for its
> interrupt controller is never retried and the device stays unbound.
>
> Return the lookup error unchanged, which is what the neighbouring CAN
> platform drivers already do (c_can_platform.c, flexcan-core.c,
> sja1000_platform.c). A device tree without an interrupt now reports
> -ENXIO rather than -ENODEV; the driver core treats those two the same
> way, so the outcome does not change.
>
> The memory resource is checked first and on its own, so a missing
> region no longer triggers an IRQ lookup that cannot succeed.
>
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

Why did you send the patches 3 times?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vdr7ivw4ipnwobbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasjP3AAKCRDMOmT6rpmt
0m5RAP4/SkXoJHI5oN3ZLb4YvxLeIzyQKmQA0tuMEWNNLWlDIwD/WWgttDmnumS6
zlxiLDWnerFKFWerGbuWAQ9uOlSsNwg=
=YmlR
-----END PGP SIGNATURE-----

--vdr7ivw4ipnwobbr--
