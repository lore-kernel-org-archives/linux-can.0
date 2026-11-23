Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795419705;
	b=i0P+WRMjcwIDd4+L2RQhoGRWzuZj5dTm354RD2J7QgEuxpEQ4bzsDySbWwjwiS5oimS6
	 I1sNV5z6kvbZ9Ml9M1FGRuD1F+i7HigxW9fehoiq/WSqLRxoTCuIAKP5tfEprBQAjezL5
	 EV3jGyRY+CfpjSDkZZZnWwigFXZKpsdp8ueOUJtJrmyymm2Fkyxe2mAG1t38goja/78Rx
	 0QfvNiVAUKAGWbDFyjf6PTvi5OcwMgovFdGM48fIbiJEXW6IQrskh68XIaoSrzeU2pYSi
	 0jcSSSHjK1e99gJFZrpiYLfNpJfCm0enRGQeylxRpS3HUNlyoUgohNOb5sKjVijCfKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419705;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Bvc7AoowwAPo7XntmycnI8FGyKPrWwhLlPfleeYwAJ4=;
	b=E9nVJrN7Jcv4evaJ93uMH0GkVipGtxuLql3ENij6cpV65TDWb1rGQUYqqIEuFgGDrcyZ
	 Z1ztpC3hM9UfJAYA7HqlYVJcvA2tlnj+RSI8kAThXkpATZRjSLnMTlQYTChlAoR6HPLFS
	 VaAJbypOMrz1FG4oo8rdDzt5a1KPyi2ILHIsVr/hkWUfpJCctl1jOebilmD2O8PqVder/
	 alDksZnWVfAA57EL4CQZboLZx9IU5IvBSx4i4ZxNXdrgZoMxF6YVHCWv9mS0oGN//FCQs
	 HpKxZFf9AuKhItbdTOThxj9a+odbhiCbnUQnRoDSB7kY8E/Icogf7ChoNtHMYqOkn/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=D9tETJqV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E9606A31E
	for <linux-can@vger.kernel.org>; Mon, 23 Nov 2026 07:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D99E9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=D9tETJqV
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 72A092001A0;
	Mon, 23 Nov 2026 08:41:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795419701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bvc7AoowwAPo7XntmycnI8FGyKPrWwhLlPfleeYwAJ4=;
	b=D9tETJqVsT/dwsBP6rJkAxclEM6hUnrtE1gslzYSH2uZ11IEFGDErr7+0NyzgYpydtkTid
	bWUr9LB6hCAKW/J9OXvLNJ/7SPvBWtpiO15Irpl57JEKRLOE+IJISZ2A8sLf6hMEKzFcpI
	uKsbuK6z59peu9U89LmZD2fu/DWS+TP8w92wxHc9mOeMYYaL/86I0bb3wUdD541EV29a8W
	dVJF4wSpK5GOeJGTO8Qv8DiWH2s14AV9K/UgZCs2+IIEZGOLokkIsP33snTtns90FGKUF0
	VdEw6BRKusT6ylJ5z/R+0OweZ4Eom3BFNzXZYIJd5zS3YhghhFHRO634z459Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795419701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bvc7AoowwAPo7XntmycnI8FGyKPrWwhLlPfleeYwAJ4=;
	b=borU5pDO6dM9FWc++AmBbmJhiB2R63Vcw6RJHcf4j/kolm3haroJuqDi1NPEsv6bG/tBSm
	plLJNWv0wkXbNrcEQHa1b3OUothPTvT/3pzpGVdVy1RLXZBgyQxdksr91B2NJEcxnhH7xa
	UqkzJmHMSBWu9VmKtTePVosmcnl62DuChs0z9Th8m4PVBC0yGg0CLBtlbnCrDb2Aanyu5T
	Yn1Etk3g0+QtqJK8zGDZ4xtTd7MogbU3lHnDV/R+6Wboi4NyJ+DPK3Il+snL8tyOYYNe/D
	wFXtEo0Mzmds+TqCORrSH0jqaJj8GLlYGrcwPDghYG2P/UBN5vhArpl565Ie0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795419701; a=rsa-sha256;
	cv=none;
	b=eWILDawf07XiWyFWGG7TrwdOr1LdBfZ8CMmF0zh2XoqsTj1WdG3ix1Uoi6ig4yzQyaDEDo
	b14aceZ1LGm0xIwido1b8yfmCx41smJ1onTy2WUEl6NmxnLL0QyMN8KdUF0Df+Je7eQQeE
	JBiZF8TnlAzdELBoeAYYh3LjkC51iDsSP7ULAUBsgezPyjx/MmyT1+55MGfhG8MRAPufwR
	Vz2JE1dt6xWUuu2LZpXl1CwXW4h7YHHFdH8bLXfDBVNB5h+MS/tDXaNZ65JsdkEqYMbo9h
	Bl2wBglUObM6TpOW7fEDdKAzPDdoELB3Ch46r0eBAZ6F0EHK/U7Q4bgrxz31uw==
Date: Mon, 23 Nov 2026 08:41:41 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH can-next v9 12/13] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop invalid CAN error frames
Message-ID: <20261123-monumental-stork-of-jest-0ed9e5-mkl@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="6bn7jogvjs5dfhck"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-227474@kernel.org>


--6bn7jogvjs5dfhck
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

Will fix.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6bn7jogvjs5dfhck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawPuMgAKCRDMOmT6rpmt
0mJRAP9q/QV1FFcy51baOE3pZyhWXGGROGcPGK5dZRzTezaHOAEAwdW+8/A7qHju
OW2PhUYsWnJF6/JF5tx3ZC22RyR8MQU=
=ASol
-----END PGP SIGNATURE-----

--6bn7jogvjs5dfhck--
