Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794555964;
	b=wBcWGTMttZESWr2xXtwUqf6cCQr+gcMKaBEc7tE8AEDRTQWV0Vd6CevHhVe3TGBFwPbd
	 czBO/rqab5yfFB2VqwicnrPTXMiiECdcPGo9IXmK2URrOpxMNrn4TCFzVudGp3BOBQTA+
	 soUBKvpBiheYug+/gh81zwq7b/sPgIYS/px8mccVXcf1x4Rfb2PBR0H9zGwXXS5mUTFN7
	 vRtGYSAca5iZrjSTofchiYnIhxV77vcCn3SoOA/FhGaOno0ybS/oFIcOXV90kjIMd/ZUx
	 +5Pj0ktvXWcc81LPwWDyuSJgMhELYPxO0bZMZjroP6a/RVFXL6aedfGV/09GhrI1JSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555964;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=yQ9ZomOvv4VvYQp6jWbOGKhZMY9AMyIgxAu3ElNHBqw=;
	b=H5tHzNSgvaN0DL3DLqcKkCNXHXgfW9yqysdtHj5+RQpFaSpMW+MiAI1mFeRAUZ+x2A64
	 7Ka0Cnt2Phr5gNl6IC1Sk1GVu5s2TFXUJjfVP889XeGLkl3XZqK7WyD/mFDb+7MBSYsK2
	 ZHTJXUCkuCNDQmjIugDXAmSlrf/C/OiPgZujYLITRuyjCn7hUqxk5apnHQ5POJNY5ufrR
	 cw/+eCFl5hbFd+ffdmXpLCbGIgR5MmOADFV1h67Yl7cf7JJGOJGZo9Fj+Q2YUOxXPZvQk
	 U45GnzDmTTOWsLJDgzury1bzXsoEa7QL1kgLX2pPX9kCwWFbFTW6ArjAk8hff016uQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="f2H/7eiL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B22606A31C
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 07:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B22606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=f2H/7eiL
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0CB15201544;
	Fri, 13 Nov 2026 08:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794555962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQ9ZomOvv4VvYQp6jWbOGKhZMY9AMyIgxAu3ElNHBqw=;
	b=f2H/7eiL0lFNdselJu7wcmTom6bocbDckRqNc4X7Bhyqo0IkDxXNY9XkcTiuGAwsy8kThO
	3laMGVs1N7xrtwj2mUoXtsLNzqlMD91g+RzOtxyycJHPIN8b2IWQMv7U0X1lVf2jdGZ/lt
	vRYOgNdDB5ijeWGVNuC0dYLnQvLtoaR6Q3bQHb7q6cfWK6LGSwI6r2jecXaQVDON+2jGcH
	fZcG5bok0WMuyZFgbxkD7XfqwXVLEP44vt2e46euKtQk1M/9+6lwApKqylDMQvuvSdz1pp
	7Dz1XADrVc1FaYMl/WYYLOjfqCBxHEZGpIcLTXhh3kFDtvAROk/38KWlAUtPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794555962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQ9ZomOvv4VvYQp6jWbOGKhZMY9AMyIgxAu3ElNHBqw=;
	b=EL5cZoSNRSkGhCmsJkGHdrVQbpA8WEvo4mPahav3R9jK/O9BWXitj1nZxUFgqgQv8LRNid
	RJhQceZsx0KtVTvJW+faeiKNe4Ay+id0PfB7mpuN6Jivu1UXSf3aAUrOzGbEXMNmj4OTOI
	7lO4bHaoWBSS8a3J0vWEK4wAcybPhssZ8+/2lHpDJI9IBxLHxmnpUMd23yTS3giwXrcHLI
	hWL6+ci2Nn/vcl6QoRjk69ntXmwC9qj9Tn2036WLZCxFiHhQsoMW4qO1rJYqmD+T1Xld0Y
	SzgROKm1BWKsvObelOiaVU1NOd2eVBJt8upRBAjs+g/+VFuN8da47UHuM3wTSA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794555962; a=rsa-sha256;
	cv=none;
	b=LHk37UPwAsij+UUki3ovprtsEWyPnunrdRo8H1KtGwv5r9f7VYjpJd/l6YPiubFdBfHMmr
	Xf8qdqUoiHd/X7/6NuWEQ1PAC8j5SWVe7ZUTGWXEIvOZiJGpeHSr9UyedMJi5gsCs0JMf/
	AJJ+ifgE9AHaFUHIFc1YDNY3/d8RMU8qBXureYuIO869gIVHT1lf+10B4yGpisSi8TIYfH
	jD/2wwVpf6bfX1Vj/m6v3fj7qCXiAYwJKFUu4Tky/ccFWviNs8qpXHgkY7QGn1wGVEKSDH
	VYWrfZzPB37Tui8sArBtsiQXN9R2epSVS/SiMVZo/m1ghBD7Dg/6v1j3wqSP6g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlyz-003xPM-35;
	Fri, 13 Nov 2026 08:46:01 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B732A5EA640;
	Fri, 13 Nov 2026 07:46:01 +0000 (UTC)
Date: Fri, 13 Nov 2026 08:46:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 7/7] net: can: grcan: update the binding file
 reference in the driver comment
Message-ID: <20261113-literate-flounder-of-renovation-586064-mkl@pengutronix.de>
References: <20261113071325.4092169-1-mkl@pengutronix.de>
 <20261113071325.4092169-8-mkl@pengutronix.de>
 <sashiko-outbox-212361@kernel.org>
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
	protocol="application/pgp-signature"; boundary="xqdrc5k6itgfmyva"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-212361@kernel.org>


--xqdrc5k6itgfmyva
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 7/7] net: can: grcan: update the binding file
 reference in the driver comment
MIME-Version: 1.0

On 13.11.2026 07:38:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] net: can: grcan: single-word handle Quchaosheng in
>   Signed-off-by trailer
> --
>
> commit 790597b86422386244176a3f727ee476daab6ccb
> Author: Quchaosheng <quchaosheng000406@163.com>
>
> > net: can: grcan: update the binding file reference in the driver comment
> >
> > grcan.txt is replaced by aeroflexgaisler,grcan.yaml.  Point the comment=
 at
> > the new file.  No functional change.
> >
> > Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> > Link: https://patch.msgid.link/20260929073703.2748220-3-quchaosheng0004=
06@163.com
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> [Severity: High]
> The Author header and Signed-off-by trailer use the single-word string
> "Quchaosheng" instead of the spaced full name "Chaosheng Qu" used in comm=
it
> 2c42ef8efdf2 ("net: can: cc770: update the binding file reference in the
> driver comment").  Documentation/process/submitting-patches.rst requires a
> real full name in Signed-off-by, and the unspaced form splits the author's
> identity in git history.

IMHO this is outdated information. Since d4563201f33a ("Documentation:
simplify and clarify DCO contribution example language")
submitting-patches.rst requires a "known identity" not a real name.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xqdrc5k6itgfmyva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavbANwAKCRDMOmT6rpmt
0hecAQD/eVjAljHb/mYcwGvwf/Bx3lOpS73qu1CC8WNm+QmAHQD+PcbMo8G0O8aj
cj0aVmHzjAEFrnTqu9t6oiCtcN/qow4=
=x6wL
-----END PGP SIGNATURE-----

--xqdrc5k6itgfmyva--
