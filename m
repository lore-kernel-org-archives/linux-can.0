Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E472E06E4
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163343; cv=none; b=JHJewzDgPxfsfDgl+S5XPVsopFfgA4SvRJL2vP2nf4ySr4EWWg42dwR8xJZUmt0IxwrPmMXJXuEt4zryQcNtHa4dLV9lj8cE7UkuOhBty8PaaNuSgjqNAYF7qn3lIKzUpnYRoPVIKEff42MVJYCJAm+k/ECmNLW3q1AMTXzYlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163343; c=relaxed/simple;
	bh=4Aw18HLBnW2N3rq3/84adKqq2hEoFT9IgzDOyhgVIOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCFHWQxYj2diMgqi7No49Gbc886RvANJa1+QkisyYQZY1j+MO+zFZirru48Hr8D2FFBuOtgL+8BeDyzLwNV0EY+qmtpd/l8Str/FrmNPpczJyl0+LrJNDru6dE3VQNL4b3SUCIAeysK7vWEk9d9bQl62Z2TR8Lbvw7xpWLflMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjECU-00062S-Pi; Fri, 23 Jan 2026 11:15:34 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjECU-0024ic-2T;
	Fri, 23 Jan 2026 11:15:34 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C31AC4D6BBD;
	Fri, 23 Jan 2026 10:15:33 +0000 (UTC)
Date: Fri, 23 Jan 2026 11:15:33 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Michael Tretter <m.tretter@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Achim Baumgartner <abaumgartner@topcon.com>
Subject: Re: [PATCH] can: sja1000: use error counter for error state
Message-ID: <20260123-savvy-active-alligator-aae1e8-mkl@pengutronix.de>
References: <20260123-can-sja1000-error-passive-v1-1-01e5d454ab5f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfn7cbapesjeq6qo"
Content-Disposition: inline
In-Reply-To: <20260123-can-sja1000-error-passive-v1-1-01e5d454ab5f@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--sfn7cbapesjeq6qo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: sja1000: use error counter for error state
MIME-Version: 1.0

On 23.01.2026 10:18:33, Michael Tretter wrote:
> The CAN controller sends the EPI interrupt whenever it reaches the error
> passive status or enters the error active status from the error passive
> status.
>
> Instead of keeping track of the controller status in the driver, read
> the txerr and rxerr counters to determine the error status of the CAN
> controller.
>
> Suggested-by: Achim Baumgartner <abaumgartner@topcon.com>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  drivers/net/can/sja1000/sja1000.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/=
sja1000.c
> index a8fa0d6516b9..4bd310b0f82a 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -498,10 +498,14 @@ static int sja1000_err(struct net_device *dev, uint=
8_t isrc, uint8_t status)
>  		/* error passive interrupt */
>  		netdev_dbg(dev, "error passive interrupt\n");
>
> -		if (state =3D=3D CAN_STATE_ERROR_PASSIVE)
> -			state =3D CAN_STATE_ERROR_WARNING;
> -		else
> -			state =3D CAN_STATE_ERROR_PASSIVE;

What about using can_state_get_by_berr_counter()[1] and remove evaluating
of warning and passive IRQs completely? I've prepared a v2.

[1]
https://elixir.bootlin.com/linux/v6.18.6/source/drivers/net/can/dev/dev.c#L=
136

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sfn7cbapesjeq6qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzSkIACgkQDHRl3/mQ
kZzMvAf/TU1b71m1i2aAeDaXlklE4FkWK247db79RK9mstAQHAOSyaV349y6yTzy
shL/yWZpe0WfDRSX9tryx9+P+8qciIncI7aMCJLFoCI5d+T30Ar9wPajG5oRCgza
CylVeu/iIN2MgLXfOtrMNtCt9s61WGkk7s8DinRjr599vRkPs1oClgFgtkghHjE7
JE/NnaTGl1RhgpTaQbOcvIhNhEIfiQkQgwJwksjbMPCcO/llylZGIaUgd8W7+kGC
sX2vmd/jpTilzvj8+GCkIz1C96I0ltv2cVEMZFKimCpm0uQb01VKPS6r7DChzSeU
Ac5hFaZJNJ6q8BHIfNld95SSS73kRw==
=0vl1
-----END PGP SIGNATURE-----

--sfn7cbapesjeq6qo--
