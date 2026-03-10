Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2844D6A9
	for <linux-can@vger.kernel.org>; Tue, 10 Mar 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137795; cv=none; b=LUza9XbVoYQyZA4L84l5kiO38u9zVv14GA5f08HQv8rfxv33owpZngCNdzfemy7megskLDOkqwOaLFP3n7T9pDLpmTcRnlwZZMLhy1elitMNOwWPmd+8kqwit6bVPRYltch9Rcr2aZnQ+CstKsg44e/dLMW28k4NoZorwTtYN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137795; c=relaxed/simple;
	bh=6k8FzuvSEAu6h40gF2LmNvtLXlxk2PNOsQC5IQH+rGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdTQ2kRLQbaXc6/bt47YKz/4hYluLeixVa5tPwaA1mNur6EdnnvgJ73KZRkIHw7xRBFvlCiHJ5udSNApYrt7PhEorQbv/PnzBmU2wMiinSsn5tCg12/5GnRa7zc+eXRqXDv/dtd25CsQJExe99isFEJVhcQaPCzFGmBD98yHb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzu8N-0007Ab-47; Tue, 10 Mar 2026 11:16:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzu8H-004gGT-0W;
	Tue, 10 Mar 2026 11:16:10 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 33F474FD273;
	Tue, 10 Mar 2026 10:16:10 +0000 (UTC)
Date: Tue, 10 Mar 2026 11:16:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wenyuan Li <2063309626@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, gszhai@bjtu.edu.cn, 
	25125332@bjtu.edu.cn, 23120469@bjtu.edu.cn, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: hi311x: Add check for hi3110_power_enable() return
 value
Message-ID: <20260310-luminous-fortunate-mantis-f17b71-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_B5E2E7528BB28AA8A2A56E16C49BD58B8B07@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ndo6ahgx3v4tnusw"
Content-Disposition: inline
In-Reply-To: <tencent_B5E2E7528BB28AA8A2A56E16C49BD58B8B07@qq.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ndo6ahgx3v4tnusw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] spi: hi311x: Add check for hi3110_power_enable() return
 value
MIME-Version: 1.0

On 10.03.2026 13:08:44, Wenyuan Li wrote:
> Add a check for the return value and propagate the error accordingly.
>
> Signed-off-by: Wenyuan Li <2063309626@qq.com>

Applied with fixed subject/patch description...

> ---
>  drivers/net/can/spi/hi311x.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
> index e00d3dbc4cf4..f0444b4c5b6e 100644
> --- a/drivers/net/can/spi/hi311x.c
> +++ b/drivers/net/can/spi/hi311x.c
> @@ -755,8 +755,9 @@ static int hi3110_open(struct net_device *net)
>  		return ret;
>
>  	mutex_lock(&priv->hi3110_lock);
> -	hi3110_power_enable(priv->transceiver, 1);
> -
> +	ret =3D hi3110_power_enable(priv->transceiver, 1);
> +	if (ret)
> +		goto out_disable;

=2E..and renamed jump label to out_close_candev

>  	priv->force_quit =3D 0;
>  	priv->tx_skb =3D NULL;
>  	priv->tx_busy =3D false;
> @@ -790,6 +791,7 @@ static int hi3110_open(struct net_device *net)
>  	hi3110_hw_sleep(spi);
>   out_close:
>  	hi3110_power_enable(priv->transceiver, 0);
> + out_disable:
>  	close_candev(net);
>  	mutex_unlock(&priv->hi3110_lock);
>  	return ret;

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ndo6ahgx3v4tnusw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaa/vZwAKCRDMOmT6rpmt
0tXnAP46UoSAswEs/d6B/JVP9m3QdAGBpQwFuS3+v4awrCJ+TAD+JF13OUPT6pLT
Wh2QdFNV96z4zCUUV5T38HKMNBf2vAc=
=dZwx
-----END PGP SIGNATURE-----

--ndo6ahgx3v4tnusw--
