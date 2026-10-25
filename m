Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792931279;
	b=kiIEDxg9BtOr50NwBHX4NjcWKb43jOg7WxUPXRwDHQQwHaQIX52j+VxZC/iF9C5P4LoU
	 i8LXWkNFauPza41J2jzAyKJq+GAz3k63YRlunPPYBp+Tp9LbDcy/Yin9f9HilKl6/7Lz4
	 2vo3cPjWgQPYeyrCypzO12fpGuFS8tc7dU/nxnZwm6gjX6xwHosRcjmboxwf9HJO1DNWr
	 l3D87qilbfQibwTwoSYn5W/PmtCfbaACVf/dxDzyzmpIU6lK31xzWhjPxjJ37F59Ab10s
	 iRLkBNtRZeYq6o5uJ9VIKjHUr+vSgqBl+QkuqFdGhbv/wnduYtzj4xG5yzPP/hTEyrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792931279;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UWLJkgOApwiOx7aIfT2ETCe3s9V8yIBOrj931rWwW3o=;
	b=AdcZpOGzExlgNnjV29rPDdLIP0FbE1qrlIBnUiKkw/aX9yQ2ov2V8sRgh+9rSMZUQAgC
	 Hm/Ym/aBfyzxTzb4H+WHARdMRd87KmeQ72iIDhHl7lyYT+qkB5/Fz20VbUBMj2H5ZKcwN
	 oxDSTZ+yij0gDuVNUhu4tfK3ND0sIaYqfEzu5naegdpj8AocyzyxgBIxpg7cNNPqNMsHM
	 g4aLs6H5rccW//qxWEnIDkw+x9aVfmsJhQWV7qroThT/d78XHxgk6rKQpba1ofjlDPu1O
	 yWhNghjZu4YnqIvGctcc+Ekb2AS1WzcE/bq8yndwSgztRqg2gsjzEATyNEHBq+FZdXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P2APi++5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED195606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 12:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED195606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=P2APi++5
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D96B22005A6;
	Sun, 25 Oct 2026 13:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792931268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UWLJkgOApwiOx7aIfT2ETCe3s9V8yIBOrj931rWwW3o=;
	b=P2APi++5rQPxfltm4Rw2Aq3zAQAv9JhAWoqdZQMtzH4UKpyNOM/5a9jltXPK08uu/VBETv
	RsKV34/+Jhsi7huQ8A8+hWMEcoiAfdNTqGOf32gRYJN2aOkqTbNBvw+1hMy7EqKNW4pfny
	jCNIpBVCvrWJf1DOHXiPO3f9Qlxr2H992vtrl1e8Ax5h0LkX4Ap39HQjf2QTSLVKKUS3y7
	zRobCSAqWAjrSxwD3ZfwjJoVgftS3XKEXv2oQhAPqnHriNSk1VUGBZyed/YoybSzRUQtCN
	HGepzfZC/pve4eDtxzgkvtNAgMh+TL0pw1RsKZiyJIKot87ULVwck9cktFPvfw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792931268; a=rsa-sha256;
	cv=none;
	b=WfoPV1gSWT7Gv+KcjDjicHws/d+wOKKQdHUNtsNx8q/fLuj2f9DK+Zpn2XG1mufuLUckkX
	xsKHz4y5otZw7WpSKCEcfiatj29xCzaMnEaJRsNK4uIMtbiTiFFxTdboNK59N5zEDBP/2i
	3WcKk8Qy1jXY0t5WQQ0ZpP554bLfTgpNk2An/ETFi4yYj8pixYovEql3kdT+/5RoE3WGEu
	yz6raO24D1fCBCxFqu1HHe+zYdZdbBKvmcwrpjfHhCJfLXBlRSL0jzqxAoBV/gkKP1dQhH
	S127WIWPZibfia3P5TjvYzg5ZlZKmBwpZMxcN+nAMXuUJNgL0rsNtb1ZAf3W1w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792931268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UWLJkgOApwiOx7aIfT2ETCe3s9V8yIBOrj931rWwW3o=;
	b=SYyP3KnltPIz+c2zzspqpot6k3pRYVGOzLW5kaN5eNQZ8r04OJk/RP6ScX8+laOpGbP4qW
	GkvDftcpwnQl2eLl8N1jKosyG9H01Wjxcd7uFwF/2sOb3nOzaE6zG4wM5HtuPYEMJRT9TY
	d16Y/9kHhRqypwzyxLa0te+NDYpwzuhwEML78mDTQWVyQFbaakrwnBLYsrf78PjsTY1Mau
	SKsa3zxXoV0V2oqDxAcmPtmzYw+GWmn9f9rSNauEtfZofikN/aA039OL+wgELo/gWKMKUF
	5lobAgkAwOO2lVG+kosN91Z1knjE9xCcMOuN58megdm/yjyIUMuVU/0E0K7acA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xKxKG-0018Eu-2S;
	Sun, 25 Oct 2026 13:27:48 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E021F5D2D72;
	Sun, 25 Oct 2026 11:28:16 +0000 (UTC)
Date: Sun, 25 Oct 2026 12:28:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261025-pompous-mahogany-koala-f18498-mkl@pengutronix.de>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="porpxwfzclozi6xu"
Content-Disposition: inline
In-Reply-To: <20261023121801.3052075-1-socketcan@hartkopp.net>


--porpxwfzclozi6xu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 23.10.2026 14:17:54, Oliver Hartkopp wrote:
> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
> triggered when a CAN device is moved to another network namespace while
> a socket bound to this device is released [1].

This series doesn't apply to net-next/main, probably as it's based on
https://lore.kernel.org/all/20260831052031.902699-1-ekffu200098@gmail.com/
Sashiko fails and you'll get no review feedback.

"b4" has a feature to track dependencies and put annotations into the
series. Please consider switching to b4 and use "b4 prep --edit-deps" to
track dependencies.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--porpxwfzclozi6xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat3nzgAKCRDMOmT6rpmt
0mjLAQCSfIIFgFMehhKkP8JeXEvAQQZjaZMqPFItGnnkyoopCAD+Kgdnpwnm53am
MX87e46L6LARurDf/PhAegn3IgV/Ggg=
=+U4w
-----END PGP SIGNATURE-----

--porpxwfzclozi6xu--
