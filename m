Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765ED4D9F8B;
	Mon, 19 Oct 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408482; cv=pass; b=oZqjnUDY6+Wp5duJ7eX1pPZnN5/vvJMiCy1vH3xFmR+QDXym9qesrnJZ0rB3y3Y3i4R/m1wms8xoH4zhkF+iqEil2FrizDQlX9fotfb08aXkjcEI/FydVoVL2TR+QWNRap0P+889sZ3JipV19hl+dG7M7KbZ/LKVyKkpPoS4QnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408482; c=relaxed/simple;
	bh=w9TWBncQX0n5hnJO5IAk+Fqfk7b+TUVX3dO2YZ1le+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftz1mQK0ogqoNGlMylmtNm1jQiRmdJ8ZTBNf8zoHJo0/6nhiDlf+/aQLO7uj69Jb5nGz6QK7hcl0xsXgEjxvZTjtYSExOxpVY34nrZ4FRQ1veGdveb1PP1fBZLG4utkZcDMwGDbFoQmxsUor4hHtrJYxIDx/eHeaRgI4dA9XLis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=PqaW1AvN; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="PqaW1AvN"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AFAE120125E;
	Mon, 19 Oct 2026 13:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792408477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMlaC4IhkRYhbOlewPIpi3OjL0Bg5JnLklStR01s8iU=;
	b=PqaW1AvNwwGpmlJrUoue9zo5k9WZzLHl8qTvTuzSRZDfyn4QveGi5AEBaMLFl9ICHa66CF
	AV7VwkehAMcUhcIKk4NYBgp8mhjx/9d4mg82SfXTjxlx3jGW3nniGWTO/37EZrjifHeB23
	hxtOWR1EthHGKZUuSTttxUpvcb1ljiiUdgo97MaTR7qyA6RCTqP5dw//5ufsHfdrAleBiQ
	73mI7idxFn8FrZpnzxI0ZOjfrn3YHCbXLLE2uHDe8FWbL2zR0tmI+nScn9kUYWuxui2uyl
	c6jeJRzCiVH1R91v5a7d1TW286BjSsVTzJghCmaBP+/RYUXc0RrrKZFT6eP54g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792408477; a=rsa-sha256;
	cv=none;
	b=MdIoDPtimuGgdLtIcQaYXPdffgv7joH3EX3emuO0PkrURUXUMt1kHkRGykdNvG9Py4QxTt
	gc863S50tDK4Heq8E+0INqzfySR+PbWzo2td90bv2tuY4aVUEOeR82g40tiCTocY2jBCxh
	0NWRIvk0+TyRIUtgf+337TnQtYfB16jlgSoojVtoXtI5IFSFV1vU/1o657xS50naM/pb6W
	FHLtyhsHKILwEY9LT+w5lh+wqOAaOB6CwtytGEv0QiNZ93hKvYuj1KGF3UmmtVLFszIX51
	OKVBdBX0jhUQPuEBz04VH8XUOHj2wWPKkEIEfzFc3pWxLckNBGZC5vJe4YiRCA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792408477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMlaC4IhkRYhbOlewPIpi3OjL0Bg5JnLklStR01s8iU=;
	b=Kc96U+x2FHucxI+JS7xjPEcUlxI8i3/MyiwDQKfBUEdsd9Y5fABBS9Tf2u2giFDz1pQrOL
	gZsiclQ1gpucIx6tesAwhspl3Vc/nr1oBZ6ByAv1iSVLTUuqVL4HaBW0fEuoTGzPxcyFwH
	RZBVARdZv21YMsRAP8/hXV26feg7ghm5kDvgwb5Ryf3PM/B7x7WtNNucuyvy00DPJ93TFg
	2x3ZcI8Kk3NAeFNIT+9iQRPm9uTGzBdEzgZRfl5ogqKAqrW03B4EK7803qyNfXweglK6mj
	BoKjA0GAHx732OECuMwGnkBdll8yrfIcWlv0cD80b08SC+0qZcwFhEXGBO3vNA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIlK9-000DQg-1t;
	Mon, 19 Oct 2026 13:14:37 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4BCF75C8FC4;
	Mon, 19 Oct 2026 11:14:37 +0000 (UTC)
Date: Mon, 19 Oct 2026 13:14:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: chunyuzhiqiang@yinhe.ht, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, haibo.chen@oss.nxp.com, 
	shawnguo@kernel.org, imx@lists.linux.dev, kuba@kernel.org
Subject: Re: [PATCH net v4] can: dev: can_fill_info(): don't wake up
 controller if interface is down
Message-ID: <20261019-enchanted-garnet-teal-bc6dad-mkl@pengutronix.de>
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
 <179240547538.3135.2010975389384383545@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6z3bikantkdtdtqi"
Content-Disposition: inline
In-Reply-To: <179240547538.3135.2010975389384383545@kernel.org>


--6z3bikantkdtdtqi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v4] can: dev: can_fill_info(): don't wake up
 controller if interface is down
MIME-Version: 1.0

On 19.10.2026 10:24:35, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] The fix is incomplete.
> - [Low] The patch changes netlink uAPI output for every CAN driver that
>   implements do_get_berr_counter: IFLA_CAN_BERR_COUNTER is now left out=
=E2=80=A6
>
> --
>
> can: dev: can_fill_info(): don't wake up controller if interface is down
>
> This adds a netif_running() check to can_get_size() and can_fill_info().
> When the interface is down, do_get_berr_counter() is no longer called and
> IFLA_CAN_BERR_COUNTER is no longer reported. The check used to be in the
> flexcan driver and is now in the CAN core, so it applies to all drivers.
>
> > diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlin=
k.c
> > index 766d455950f55..b958c04d53db6 100644
> > --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
>
> [ ... ]
>
> > @@ -1006,7 +1006,7 @@ static int can_fill_info(struct sk_buff *skb, con=
st struct net_device *dev)
> >  	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
> >  	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
> >
> > -	    (priv->do_get_berr_counter &&
> > +	    (priv->do_get_berr_counter && netif_running(dev) &&
> >  	     !priv->do_get_berr_counter(dev, &bec) &&
> >  	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
>
> [Severity: High]
> Is this fix complete? Later in the same expression, can_fill_info() calls
> can_tdc_fill_info() for IFLA_CAN_TDC and IFLA_CAN_XL_TDC. That path can
> still read controller registers while the interface is down:
>
> drivers/net/can/dev/netlink.c:can_tdc_fill_info() {
>     ...
> 	if (tdc_is_enabled) {
> 		...
> 		} else if (dbt_params->do_get_auto_tdcv) {
> 			err =3D dbt_params->do_get_auto_tdcv(dev, &tdcv);
> 		}
>     ...
> }

Can you add the same for both IFLA_CAN_TDC and IFLA_CAN_XL_TDC.

Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6z3bikantkdtdtqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatX7mQAKCRDMOmT6rpmt
0tFOAQDYP4BErMp3uekfG94tq4e06Qdunylx5DqihGB/3rXyZQD+IbOCoPEzK2lR
LaKvNyJw6b1Tz35KL7h0T7/+aqMZIwc=
=OL6H
-----END PGP SIGNATURE-----

--6z3bikantkdtdtqi--
