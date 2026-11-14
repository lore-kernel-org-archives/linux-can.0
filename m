Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794692204;
	b=XOdK/+i7Atxq9tGQuszu93/o4wOpXU6ebPzenppAUsjFZrrTY2KtSFGmEwLHQkx35toH
	 MW/AI/5nZHCmSMVlgVQVyFxMGwKUk9gYBMwsiQZuY6e36kBX5QB0vkCp86vK+NhALXMT/
	 S2oktfQSDXUZ1JfWDlusBLP0hVmkhT/Mx1D42pZgQHk8iMcoYIZINPSimN04zO8eEx7M6
	 hv6eDBRo6r/h4Kne2sUdFepw9z49MCSJhFjerE+OZoXZ7diS6XWzKqVw14ZmM7kObRkma
	 dXpdbvNtRVtQ2Hv1D6LKuWo+cBVTtHVShn4q9WljLNGewbQ85BzoVD3P89yrBovn0cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794692204;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sDtoYtjh1QB34Ix7imdlu7oGFG8yHkdIWvAeEQPPSdw=;
	b=SjAUNRDgt23r+x0VKhyuJEDb32GqztYAdxw1ALfbVX145tSV4jI6EJpu+kbapYOB89wa
	 AxcLiupIUvo4lae7aa9cygf3GfCitmA22tHLQJdnVbcuYWo3W30kGXBtKc03bvq+RPovy
	 6mignK5Cq1yeXf0+DGFBdiXl6nyBk5n+f/63YuEBDzOSikBGnm4f6cYEz6j687e1DvFD3
	 5PYth3FHTtXNxsMjDcmsgqY5wlTKo4g9sI/3pw6jRG/aEifkL1fEzc8Zb2D9DbTnh+fTQ
	 JaLBC1pcn3GFoBbobRlslH6XVESeZlxhGI2k0ToGUWHt/jZEPUaepip3yE08LPZJDpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SneGxGRJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E66606A323
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 21:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8E66606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SneGxGRJ
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0750D20167D;
	Sat, 14 Nov 2026 22:36:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794692201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDtoYtjh1QB34Ix7imdlu7oGFG8yHkdIWvAeEQPPSdw=;
	b=SneGxGRJwIBsUz9oCpGwQawgeXzOWLmjza6RAjydGS0G6aqqNE5d02MUcbIjF039mktXqy
	FrxaPBEpO+JFG5Y2/yjTjbpADj3JJOk9vVatJg6GDv98NaZqR8aQMmhYfV9y7XQrAw4lVj
	x+T0I+sDF+k+RKr50sKtEDp/AIAAnYZxZ6x5kghN9Uwtdpsy74PZFqHkyeUemchmNnjOHV
	VXMkkkfTfvsbDjzAGjC/Rc9my3p2CI2qh1lqhL4FZ8lbey/dww9CwWbPu/LRRRBHJxM1w0
	Y3Jlcxf23wfjcJyl2RrrwreH7YQ36CFL5vQBRXIVTvk95kH4NnDGyyBVYlcaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794692201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDtoYtjh1QB34Ix7imdlu7oGFG8yHkdIWvAeEQPPSdw=;
	b=Es05SWIPyNy7OVBvLYGap7csGIZqhIPXqRf4MiJ5Ng06H23/MDPuy1AJktp5QV38JR0Y7x
	P8iuf+xhkazf3K804BEyQIW8JedhvLnFReXsz5yzk36hNAW/A2EIjCPzJnv1M/nHa3WQf0
	sw1qz2PhaxosfsKhGuvbHWUjkzxQLMx9E5hEMSAWfV0Ieo8l8vbYGQb/KcqiKWADxE9A4a
	XmRkV37T+P5+BJLbVjKwOOpV1MqnU6c57SbD3Bn+DxlI0iZrPkCrzYHP1kfskBMEQobd9f
	zy9GG6mb9cdPAtkc9M3/waW8t9RW2CVReVmVT4uTvOCGI678Cw3kJO4CI2oXVQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794692201; a=rsa-sha256;
	cv=none;
	b=cWQY/AoJSMV1Za72AqBNrPW1lI6cN9AZHMD5MEyiws0lGG5UXLgUfCFSunxVqtTZUd9kIa
	vPfCjm1LgWADNuFjlPm68EkvzXOH5y9ZonJeT+YbHQdwAanzzxeOikuwZpFs1EGKuB9g2p
	WKqtsflCLEIt2Q5G8jbqAEEvAqjPZtYpH82v9h0kyH6ff449KWOjxBJM5R8rP1Pgz268cb
	wAex6TEvM/9vCEiRJkLL2F9lGk3CVzU/5kTe+anStwZLuK2N40rNd+FwlC3YRcRILzndeJ
	MUHQXekKok0zffpg0FJljrZnlMc4B6vbXCOcRbLctU2gXPBRzYyekY0G6ykqQw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSLQO-004C1K-2v;
	Sat, 14 Nov 2026 22:36:40 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9DB415EBDCA;
	Sat, 14 Nov 2026 21:36:40 +0000 (UTC)
Date: Sat, 14 Nov 2026 22:36:40 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
	Eric Evenchick <eric@evenchick.com>, Maximilian Schneider <max@schneidersoft.net>, 
	Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH can-next v8 7/7] can: gs_usb: add support for context
 analysis
Message-ID: <20261114-amphibian-purple-manul-84cf19-mkl@pengutronix.de>
References: <20261114-gs_usb-fixes-v8-0-f615502b005b@pengutronix.de>
 <20261114-gs_usb-fixes-v8-7-f615502b005b@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="d6mfjdunhx7oihyd"
Content-Disposition: inline
In-Reply-To: <20261114-gs_usb-fixes-v8-7-f615502b005b@pengutronix.de>


--d6mfjdunhx7oihyd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v8 7/7] can: gs_usb: add support for context
 analysis
MIME-Version: 1.0

On 14.11.2026 21:50:01, Marc Kleine-Budde wrote:
> Enable context analysis for the gs_usb driver.
>
> Tag the hardware timestamp counter infrastructure in struct gs_usb as
> guarded by the tc_lock. Add context analysis markers regarding the tc_lock
> to the low level timestamp reading functions.
>
> This has been tested on Debian testing with clang-23 and clang-24.
>
> | Debian clang version 23.1.5 (2)
> | Debian clang version 24.0.0 (++20261025103442+7e3c57157096-1~exp1)
>
> Cc: Vincent Donnefort <vdonnefort@google.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---

Current checkpatch in net-next/main produces a false positive warning about
externs in .c files:

| WARNING: externs should be avoided in .c files
| #49: FILE: drivers/net/can/usb/gs_usb.c:339:
| +       u32 timestamp_initial __guarded_by(&tc_lock);

Vincent Donnefort has already send a patch:

Link: https://lore.kernel.org/all/20261112151203.3129005-1-vdonnefort@googl=
e.com/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--d6mfjdunhx7oihyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavjUZgAKCRDMOmT6rpmt
0gqMAQCKglwqjPJjO3kTRyAHordDXWtBjZ1ZwTiUafkUN+cRxAEA3WndBZvsvvWv
Y1o/gB7dd6H5o9qya1R3i2Cvpf1QmgA=
=BY8B
-----END PGP SIGNATURE-----

--d6mfjdunhx7oihyd--
