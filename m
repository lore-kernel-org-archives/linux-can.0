Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437C377A98
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014177; cv=pass; b=S65w1jXLwbRutdOp+YNXZ1gC8LT+e5saKRCXcjoEzHdAnKjl3XTwwEC4tIBU6UMJx//nZlIqONxvo4BnSalrdmCQ+iBrGztoetOC5fRdhd4Thjz1/erxtTrj4swqvS8qeWzBZEYhzFpIC1oCiFERsUDPceYmgAoyhnbMtBl2eLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014177; c=relaxed/simple;
	bh=MHx+0YkPz5qFJsIBtBOrpyU+E5RK9sCZ92ORGTo6KRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEjjQOIpRu4aRihycz5Y+WroEzQ7p4nzSncVcGEoRLQ6BD337qO689c/10UzOW4PJOWOryihlHvRZhXzCFLH1oT3X/BMECThI6n5j83a4L2af/cbvuc1KckvAnI7awAd9bggdcpdzJA0/SN7CyyS/uHjA/YUoLfCnGdkyVMDQ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=WY5dwFdz; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="WY5dwFdz"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0BD68200153;
	Wed, 14 Oct 2026 23:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKH8k5CVgTBABU2VsFgqhTFM+NCyeDDG+wAZGQcAXAo=;
	b=WY5dwFdzvARN3rZko/7h2hMS0z5CtzbFHolvJOwUSc9VqHNvSVC2nyE2u7U/9JNe0xM89u
	4YwcCI1VJ3+tPoKhBr4+uz86g+qsSh6apQ8+UGDx9uFLgHxHu+i5Z2BTyNp6ym/IIarJGX
	DiNAcsflNm1IR76Bmpc5cp7ti4li8idaItVrdW2yQKu/BypAgYc2UNFWRZYxlHtHxXKO/J
	oe/vA/eleGsBkEOKi938FblUpwmV60mx0hBCCXfsvni9QjfFNR1UdPvLpHH5h6VPi5yoIl
	cuLp+U7t1ttofT172yKayCTfi8ylvwuMG41bWupThcfdgu8s4v5esDKOhUGGgQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792014168; a=rsa-sha256;
	cv=none;
	b=QCV+1pkmV1qPbZMQUenA91xWov3YeSnMV36UuqZWSo+FdxvBP7X9yqeyGzTUZD8TeWiD+T
	224r11aPXG9CSyqlCtKROr0VYsI4d/Q3GCje9y7zft4/oxggtSo69cc0Tvpun8iEGSbTxH
	meSg/m6S4Bdi4Yt9iYHCbmM0pikIIx03SQs4IFfPs58OqC5U9Bo/B2gmOvkdutKyI3lRZD
	OUKYM8KQVzwyaNIwnTJ1IYQ8bGASdmBy1chzQjAF2cr14VTbK/wLZVe+pqOZ569uqfA1RX
	O+M1CUwAQaOBNEwTvlAPSueD3hZgLhjgR0XLYwXFy1FWvfpfG+8sNaytpqQSkg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792014168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pKH8k5CVgTBABU2VsFgqhTFM+NCyeDDG+wAZGQcAXAo=;
	b=S25OeDPk/XBfowguM4j5Xf1mAj5+hkVQSZ/7qDPDx7nFJjWDqsKYm8r1IwJz8RGoqVzi/w
	oKx0GFIlg7EcNAWIH/d6d2S2mJyzcjU/S5eTIjHuF/BNZG13vIBIW3ZonJtNrc4jK5bzx9
	OERa1cF8ZM1rdn8TdDfYsCcY+txaFEwE4C/nDVoh1Anv8DY89A2HySZW7ghYI9x8rnQl/F
	zyD5K5Qnw1Lqr66Az15s5uvjULpEuF11N+zJQ4bG8AuafqUBK3a/DPrfef1ZDFasxFe/X8
	IrzsXJY12uznNp6tZeKdL8nTV8GeAGyQzkAVgY+1TQDPxpxdCaUrVSihoKW7Yg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH6kJ-005vAK-2x;
	Wed, 14 Oct 2026 23:42:47 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9E75E5C45C4;
	Wed, 14 Oct 2026 21:42:47 +0000 (UTC)
Date: Wed, 14 Oct 2026 23:42:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v2 0/3] can: take rtnl_lock() before leaving the
 notifier list
Message-ID: <20261014-fresh-perfect-dragonfly-8dd992-mkl@pengutronix.de>
References: <20261014142114.280279-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cyfym7fjyviqq7ss"
Content-Disposition: inline
In-Reply-To: <20261014142114.280279-1-socketcan@hartkopp.net>


--cyfym7fjyviqq7ss
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2 0/3] can: take rtnl_lock() before leaving the
 notifier list
MIME-Version: 1.0

On 14.10.2026 16:21:11, Oliver Hartkopp wrote:
> Norbert Szetei reported a use-after-free in isotp: isotp_release()
> removes the socket from the netdev notifier list before it takes
> rtnl_lock(). A socket that leaves the list in this window is skipped by
> the notifier and has to remove its CAN filters itself. If the bound
> device is moved to another network namespace in this window,
> can_rx_unregister() silently skips the removal due to the namespace
> mismatch and the remaining receivers point to the freed socket.
>
> bcm has the same window and is affected in the same way. raw has the
> window too, but removes its filters with dev_net(ro->dev) under RTNL
> and is therefore not affected.
>
> This series takes rtnl_lock() before the socket leaves the notifier
> list in all three protocols. As the notifier chain is always invoked
> under RTNL, the busy-wait loops on the *_busy_notifier variables are
> dead code and are replaced with WARN_ON_ONCE().
>
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301=
A8E@doyensec.com/

Applied to linux-can-next.

Thanks,
Marc

pw-bot: accepted

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cyfym7fjyviqq7ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCas/3VQAKCRDMOmT6rpmt
0qyjAP4qbF/yhKlQacSdMmn2haDPGuAw+jPF8+mhNjnp2U90ngD8D432KL4qEgct
VXEmPA2PJyGrnaKQHpPxV/hFWrp0QwQ=
=sCi8
-----END PGP SIGNATURE-----

--cyfym7fjyviqq7ss--
