Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC23290DB
	for <linux-can@vger.kernel.org>; Mon, 17 Aug 2026 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003488; cv=none; b=SWV/hjEzMwi17RO9jBJPMQChU6WMhTh5LjT2r3pHBpX24yrKBJpxoe3Z2dutVV4icz7/lUZnyePy3fmT15dLf//XQY3VQSpFRrHBl1P4JX8p839rA4ZEquzUyTCSLGYq8h386/r8JVvfEjMB06Dxu+SEOQxg585I/hTN1oj1i0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003488; c=relaxed/simple;
	bh=DVwyjrAr8kMS22z9H59apCoMBawHC57fwOl2reBodiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5/iuJJmpia2BgHOA0gZllFZhf9upXN6D2VT5SL/fvuaQiQCQu5NWOsAel2DjIaQWrecbketFpFiqNtq1IJOotLYk5Sb9eRKgerDDizYOVyG2WgCXMJgzwD7/OL+v3E0eIhBKmwxyNelgrxaUEjhnoeElU8jz2Ndhj4Bui3QMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Mc6NLGmk; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Mc6NLGmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=DVwy
	jrAr8kMS22z9H59apCoMBawHC57fwOl2reBodiU=; b=Mc6NLGmkKLK9ifZxn4u3
	vgh/Bk/96voSrfNMdZqDKI2LIOsfczjY4eqgFIrN2O61rsp2vwpLDXZ0Zt7uYqtP
	dWUbIb+GZI+NQ6CrnOBn/oUJGwjzdAzvyKaDWikzbgyQya/9VhhtrS/RMJ/Gghq3
	KpBldcnVSB2oSiUHiOTg2CNXwoElGXYPMAt2PuXP9QmDifhVBqYhn6+waLKrYqSu
	CwIF9ui6C23jJ9arx3edmUr9Kg4ZhpNchbUtRM+04F8TO7da+mHkCbz7F3RkTJxJ
	n5loHGQgk071IIup8mbBlff3JQ97EBVBujSTO+euYugH/Ua98e6vun++04ZJf8hb
	6g==
Received: (qmail 3577802 invoked from network); 17 Aug 2026 23:51:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Aug 2026 23:51:20 +0200
X-UD-Smtp-Session: l3s3148p1@CJqnK0VZ3rQujnve
Date: Mon, 17 Aug 2026 23:51:20 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>,
	mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org, bmasney@redhat.com,
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com,
	linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Message-ID: <aoOCWBAKV4lBwLPh@shikoro>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
 <7533fcaa-c676-48f4-924e-bba9195d4871@tuxon.dev>
 <20260817-tricky-monkey-of-admiration-3caebf-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZiDiiahQjpJkCpVB"
Content-Disposition: inline
In-Reply-To: <20260817-tricky-monkey-of-admiration-3caebf-mkl@pengutronix.de>


--ZiDiiahQjpJkCpVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Who takes the DT changes?

Geert.


--ZiDiiahQjpJkCpVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmqDglMACgkQFA3kzBSg
KbZL9A/9HxBzH39Da9KzxPRUXkpQbLNxJsQk18QqE33bmTc5rfeI194Wp2lDXboh
apgJG+8WD3h3skKgWaREy6m+Q60nEy7IG26SwxbjCyxBClll82JuJJ4Ip55G6Zmf
J+yPUFK864n65p1UQnM1WWjJ3cczBOH49S4UDNohbqR6kHeNmmWYM8VGaQlwfu5p
ei9MQONg1uz77+tJ0DUovzxegagKPM0jrqxpV093lCS+s1psP6Ubn2gWlj3rThJ1
li0mMAwbYjtrWrMEKgTHlASdYqwNOq0zo73hPev+1fdJVHWr4s90eC+nGMo4+pEj
Zns3Z/9bZzIofB879AXK/6X6KraWzu6A/2DkGp4wgBImAFdwe7Fo3CUxW8bdVyyX
Uhesx+xK5PojcLbgpGCBQPiZ4Z9ZtWSrstffC/H7QrJv4TzPVeUHqoRTqHEju3nw
l5VTcClcuCgCzdqkcPDaa7Qwbl/qsbPzhaqQz73HcrlTv4IyXbYjR2gQJkRc/pF6
SB+LsMPxh9JPgAInvWe4YHqjJgYajKcfpbufhNfFksN7CD+EBk4FBI/I5VZSvRCW
odhx1ld5w+uQCBm/MIZeNqadi3LEefnfa60xfkUO7SHjb6Q1/cCQVDs3vrT5ucD5
BXQVclLfD2agTP2pTBv2E4+oV15DlyWJNA7tu3TLdP/0xQR4mB8=
=VPZU
-----END PGP SIGNATURE-----

--ZiDiiahQjpJkCpVB--
