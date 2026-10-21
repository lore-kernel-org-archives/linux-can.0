Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792573889;
	b=urBXH2CamGnKJqJ33F0WSoQWDenW00YVVFRyhD8gPSWCbI/lPK8Sg5tUPxnTN8qy2k/S
	 kdmIv7NZixGLXhCfgOi271riA6P2rjtkF7WpAUgKBhw4Aaw3sqVZOWbKnAGTXt3wKPl7R
	 8WZ7pgSkBeLjwN+BhR3TxrwYeCCug1cTQYQGEDeXVhFmqdonWUsjOtk8jBHUeLVH0VSp0
	 RyREOhNeuKsMZ74TrVRLYf939gkbR2BjxtScoDp3nGttLOy+TXwlQ7wyCZIHV7F6pQekC
	 q5R1W/7hcqEkTZlWBPNNVA9dgEkjTUccdgaPfHdoa4QUwVAUMDiG4u0z0Z3aFo+WAYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573889;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=k2RYGAx9cwQJNBf8a6ToX5jGnQOGLrMccRgqTwtyvMM=;
	b=YZZX20UJx3ZDzq6dI3eKunjj31sTTIYT7S9X5xD86jQP6J9S18U9odrf0DAagewnlHog
	 I7Vqo7OS3jxfkq8hxcmIYwWvszq7EeKxl6SJEaSHiU8+dLpkJbMPaPmVs3urWcJuezuIG
	 0UAO7cJCTvQHuMX8QlXsCoPan6tz127lRCWPasAnoxq4Z7f25sr8IPKJjxybbF4yCcNUm
	 lbD+sM4JGsY5iRjQTpRXYlBQGrKjQJaVWGkJQm6W8097eS9mpalxS1pclDCXLihlC7h34
	 z36U0iCoIfVZHQl510VbLDf46rvbe8dpDwy2yOACr3l65EhOoEglGMElKFJD4nJbOOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UTYDReh0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE304606A324
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 09:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE304606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UTYDReh0
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1D0AF201CE0;
	Wed, 21 Oct 2026 11:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792573886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2RYGAx9cwQJNBf8a6ToX5jGnQOGLrMccRgqTwtyvMM=;
	b=UTYDReh0+iHVTJQpBsdyNit8t/cpfHdwGBIG7XM6dgCTPHFoGtt9dBZEi//82tgXggEIIm
	SPMZirWJ0CRbG+hd4VVnbM9eiZZiC19VZ3QxRUJblOG0+/8Tfd4pDtEIG4HKXBXoWbb6Wj
	scOKpBmnUK44gOdrgLtuijh8OCQPyLBB3yWccwI/pqpaH+TOoVJWwl3zxmE3G8C8LYJO6n
	jkinIIPTOrk/B89/eFcq3lTIKuNhknSysKfNgCIxusErfRNJnN/VssF1O0d6cM6vGoC8kd
	8GX48NWLT5ppMj3eSbwC/XoHzhH9E1wqeJRpcBOhMElfLhlKizb1JeqV3VLFKw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792573886; a=rsa-sha256;
	cv=none;
	b=e+neDUtiF7c4eh0CMH0Sa4WPLEGLNzFE0zQqsfhH/o7WelBfz8PioNryDtWuQG+g81U3TE
	j/rLC9szn1YiC6B4Bo7e1GjNdax+sEJTOkpdib5nza/wmUWbzQrXCGDF3CgsvLDwpUNfL7
	RLeSe6pUt3J/WFzysEL0g6G2RgCVMIr5CUJCEZ6TC/QoKI0GeuYsn+DLQsexdt5sztvjs8
	HOeT837SUV2TfelxN2O3rY9tmLNaAB2NfpQyBaw7XEhJCSsZXkNplmYVwcBtzdyqmYG4lA
	r+14fvVOOo6zvyO5aXxxnhWWtLQVk4fFcLOHdBAzyZj5EODIa5G73j35zSwmCw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792573886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2RYGAx9cwQJNBf8a6ToX5jGnQOGLrMccRgqTwtyvMM=;
	b=PlC4ZFf0Fk+J8gfy1TQkqeOk3NQAy/9TGOP1BP0sP2ojBiPuu1QAgmI5K8yqyQjBBejDhk
	Gvojnb4qGiKk2zVfLX3/au5++NYAozu7Y5WW/KJuowv6evKDo55G2NuVUyZCX1587xFeTx
	l9uc0u2FLqLJpzG+dqhPN25+gyH7P85XPJgd/tOfurvTm8qQyAOUfbrCSHX7T971atinFc
	1GdoU2duq7ZU1kAqQhoCqyAFGLlixThG54qXhzpPeP2W1z2rd/Ey2OIsfdjbSNilhGw/1g
	n9Hh3scDB67xpM1+BKqqEs3KKQAw6lCn3uuh8pU7h0WO2/0/Ou0qa+bu7ayPpA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJSM2-000XIc-04;
	Wed, 21 Oct 2026 11:11:26 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B120B5CAEB9;
	Wed, 21 Oct 2026 09:11:25 +0000 (UTC)
Date: Wed, 21 Oct 2026 11:11:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Filippo Storniolo <fstornio@redhat.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
Message-ID: <20261021-significant-umber-jackrabbit-bf5643-mkl@pengutronix.de>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>
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
	protocol="application/pgp-signature"; boundary="z35uk5wjs4f2772p"
Content-Disposition: inline
In-Reply-To: <20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>


--z35uk5wjs4f2772p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
MIME-Version: 1.0

> diff --git a/net/can/diag.c b/net/can/diag.c
> new file mode 100644
> index 000000000000..647a94636a54
> --- /dev/null
> +++ b/net/can/diag.c
> @@ -0,0 +1,203 @@
> +static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
> +			struct can_diag_req *req, /* will be used for filtering */
> +			struct user_namespace *user_ns,
> +			u32 portid, u32 seq, u32 flags, u64 sk_ino)
> +{

[...]

> +	switch (sk->sk_protocol) {
> +	case CAN_ISOTP:
> +	{
> +		canid_t tx_id;
> +		canid_t rx_id;
> +
> +		tx_id =3D can_addr.can_addr.tp.tx_id;
> +		rx_id =3D can_addr.can_addr.tp.rx_id;
> +
> +		err =3D nla_put(skb, CAN_DIAG_ISOTP_TX_ID, sizeof(canid_t), &tx_id);
> +		if (err < 0)
> +			goto cancel_nlmsg_err;
> +
> +		err =3D nla_put(skb, CAN_DIAG_ISOTP_RX_ID, sizeof(canid_t), &rx_id);
> +		if (err < 0)
> +			goto cancel_nlmsg_err;
> +	}
> +		break;
> +	case CAN_J1939:
> +	{
> +		__u64	j1939_name;
> +		__u32	j1939_pgn;
> +		__u8	j1939_addr;

there is name_t and pgn_t in the j1939 UAPI

Marc


--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z35uk5wjs4f2772p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatiBuwAKCRDMOmT6rpmt
0pmjAPsGKfg9ufljhEl2LQTs2PXPnJdWAO2wM1lxxrWXEbfyqQEA/5UHYnTMGdRN
vmwFS6yb/oaVTpFX7YeQMCyh2WW8mQ4=
=wKq8
-----END PGP SIGNATURE-----

--z35uk5wjs4f2772p--
