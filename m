Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795302131;
	b=Iv5h3zeFZ+0XPw8dEE4itpBo9bbsQ1jAOS1jnhWepuipMLiKZN6lP69zkA5humHdNh4H
	 u4ghTwlQQOCclmHLI8nIPj9knhhUPhxhFVy34VuYabj3cpiDO6yrN2PT7BVzpyJFD/CN1
	 YvyEE4w52daEKPkAKBMp0QHr5H8PD5b8p+Op0XAvpc4VSAu8wYuaHMxQDfM5LcOiRLPRX
	 zU1BQCr/pEjPB/k22ckbscFcvTIW1TeKZ+XxCEZls4gEpvHo59h+C51Vf3hDjeE7Kwlc6
	 TsFVo+8IET/wc9ABivWLrAoMIqrCNuBuJEb4vrKhrg1k2YM6lMoCK+udbn2CZuv0JlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795302131;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=2CIJfHyWl5VHYsDIYiEy/+3hUwP2HvnNLQy8v9q2CE8=;
	b=bmRHlw3dnPzEXjAo1g2fHuI5h7b2dbVzpEmuUzF/7UGpdLCyX25HsODQSP4zNX/aLEvX
	 Yjwp8cFLd+QM4566UXrPBg/EkkJXqX5hxLvo+JBdKoXVVdqbHSuxhT0l0iEKTSIzWGPlv
	 KL82DxhvqoEOH5/pyHcaGXJf+o++YBZLD4nDZ17NJqBV9iyV+aV5MeZ+y619kSN2XW+yC
	 ZD6YvurVjEBBhZBA3c93eCDA144NBokklOykTE+6ZxDy26rQkxWY8UMV1tGNlJiu7u8uC
	 gSeZ13hpLe5WNZNn2LSB1bYGq7dE94xJGekHnNdw7rKFte4aLfySLDfnN74f9SfeqHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="gcn/3w6I";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C73606A332
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 23:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C73606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gcn/3w6I
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 164C9201CE1;
	Sun, 22 Nov 2026 00:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795302128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CIJfHyWl5VHYsDIYiEy/+3hUwP2HvnNLQy8v9q2CE8=;
	b=gcn/3w6IBFsTYe9u8+qkQPQ7qYiacd8GByD6D7YCMXGp7giqaTXZ9napM69YcFsbQsVmBM
	+kTMeRD3zcFPToqxEh56UYAK5y/Ed3oNooxPGEv7Gs8IlrAfrzkTwwfFyq0Aq76lV8ggxQ
	KBp44vfV/xa0t7gb8D/1RqkFFWjo5JgnvJpnqA6YzSRGD45Ilx/zwbWimCi/87FqgMnwip
	lxwTShYSbZvadqbvShzcToQnakYqPfiI/0ntUNKMrlGTLoFCimPMboIr5rLZQhk6H6EIls
	JM7N7PhUspj/kZ5H4DKfi0XrmxhpgWu+l1yW0KFJUKWa5bkZYWWC75Iu3a2aXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795302128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2CIJfHyWl5VHYsDIYiEy/+3hUwP2HvnNLQy8v9q2CE8=;
	b=HzzK8AIgzeHajZ9VBFwShAmsZrKTW8if0eY1xbVfEyVdnv+1MQ3iV7eDwFL41SuKKg+OFk
	KhDqQGbTjUymSz8XHPmQsdOB9W+UQurfrAxFdUrfXzy0MR6Rzp0LQerd2QQSmwHv9mivmP
	6/rmDFGw/v2yf63cQj20Vsl2gHs3o3kDFasRf6exvJee+EcC72+k2cJWPPDukrhf4z2aYB
	L26tvfAzXJ7OTdPRuywVD2idMcXDB21tKvopLG03X3TXz830/BzEqs+okexnrhaXXODrvH
	+FzerMnn4nY/TAkn9yFgIlPAMub8uFZ2tayqo4Bbavw8GpAcRryYlkD81DgFSg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795302128; a=rsa-sha256;
	cv=none;
	b=Vf1Fv6tfhUBqsh1699VQ5l0rLqPgrU2KxDYwD1pRAOMltrIa1L79CiEOR6sMd+veAF/U1R
	64gFBlL1vIZQm5BnsWJct8CY2ZjPHJl9U0vAerJ3K8PPWo5QMKM8QE5TjIKxYJXUpSAGq7
	MoPLFRkYHnDwCy2iSzWw8ND3oGUrpK7DtMM1t7SMoYYAzYWGYwRjWO3znfCwXU1QVDc/Iq
	BRvPqZadpoLZ3aTJkpwU0H8SShatMtIXFi9k70lNkdsDa9ZRQR5Hx1jaFzlReCtU/7hk55
	srGgpgPrXHBOuGVxBWQeLQQm4i9PHuny6RHK7ofZBSVFoTw6PvvFh10kpj6fOA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Sun, 22 Nov 2026 00:02:07 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH can-next v9 12/13] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop invalid CAN error frames
Message-ID: <20261121-imposing-practical-slug-597199-mkl@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
 <20261121-gs_usb-fixes-v9-12-db121d488945@pengutronix.de>
 <sashiko-outbox-227474@kernel.org>
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
	protocol="application/pgp-signature"; boundary="h2ua7p7txyn5bpk2"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-227474@kernel.org>


--h2ua7p7txyn5bpk2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v9 12/13] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop invalid CAN error frames
MIME-Version: 1.0

On 21.11.2026 22:53:55, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] can: gs_usb: TX context and echo skb leak on echoed
>   CAN_ERR_FLAG frames
> --
>
> commit b1d99b2dbb5c984106e59cf632bd8f01d76e1bcf
> Author: Marc Kleine-Budde <mkl@pengutronix.de>
>
> can: gs_usb: gs_usb_host_frame_header_valid(): drop invalid CAN error fra=
mes
>
> This commit validates incoming CAN error frame headers in
> gs_usb_host_frame_header_valid(), rejecting frames with CAN_ERR_FLAG set
> if can_dlc is not CAN_ERR_DLC or if CAN_RTR_FLAG is set.
>
> > diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> > index e4e177aee48b0..a1192867e49b8 100644
> > --- a/drivers/net/can/usb/gs_usb.c
> > +++ b/drivers/net/can/usb/gs_usb.c
> > @@ -639,6 +639,30 @@ static bool gs_usb_host_frame_header_valid(const s=
truct gs_can *dev,
> >  		valid =3D false;
> >  	}
> >
> > +	if (header->can_id & cpu_to_le32(CAN_ERR_FLAG)) {
> > +		if (header->can_dlc !=3D CAN_ERR_DLC) {
> > +			stats->rx_errors++;
> > +			stats->rx_length_errors++;
> > +
> > +			if (net_ratelimit())
> > +				netdev_err(netdev,
> > +					   "invalid DLC in CAN error frame (can_dlc=3D%u, exptect_can_dlc=
=3D%u)\n",
> > +					   header->can_dlc, CAN_ERR_DLC);
> > +
> > +			valid =3D false;
> > +		}
> > +
> > +		if (header->can_id & cpu_to_le32(CAN_RTR_FLAG)) {
> > +			stats->rx_errors++;
> > +
> > +			if (net_ratelimit())
> > +				netdev_err(netdev,
> > +					   "invalid RTR flag in CAN error frame\n");
> > +
> > +			valid =3D false;
> > +		}
> > +	}
> > +
> >  	return valid;
> >  }
>
> [Severity: Medium]
> Can this leak txc and dev->can.echo_skb[hf->echo_id] when a transmitted
> frame with CAN_ERR_FLAG set is echoed back by the device?

valid finding.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h2ua7p7txyn5bpk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawIi7QAKCRDMOmT6rpmt
0l1sAP9Ft9akJLU6UeQJLY7YEOn5enlHcDMzfiCGv+zRaDDezAD7Br83IhBn31TI
C8/fw60S/uI9oTZfonAbw1oCeX21TQ8=
=svIc
-----END PGP SIGNATURE-----

--h2ua7p7txyn5bpk2--
