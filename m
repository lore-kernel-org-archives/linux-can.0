Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAA3D9028
	for <linux-can@vger.kernel.org>; Mon, 16 Mar 2026 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685266; cv=none; b=NGBEP2i/JZyZRZRf5EIzeZ3q/krlGVHjSVp+TwEoLix9gOg8gvDwdfpiOLyQMnuh/FAccKCBFfH2e3+CdxdBh8Yetb5XLB3JxcZ7M1E1xXpNk0ih7OJ5T7iL8LC+IfTcXj6XoHTTZuxXdQnKYQd3KcIOwaggZnN+l9yOgZ73TaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685266; c=relaxed/simple;
	bh=JTXLB81Ni5gBSmMJkHcRQAN8PgPeI3ihUICk9TKreB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7XBodxvYITSxEY3ZjaEJ6DZmqog2eF1sNqfmnUU8xTd4+XaOmDOWkKvynmVOIZBnKvF+IB6W4WeH19AGwEEKTlDW2hHKUklIR93YbS81cX7G//5hVwfxfAQhCCA8k2QWX81iGNNFXZokN+u4t34Bg3u92rPdBfUQcJaeLAReMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2CYX-0004PM-08; Mon, 16 Mar 2026 19:20:45 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w2CYR-000c94-0a;
	Mon, 16 Mar 2026 19:20:39 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E99A7505359;
	Mon, 16 Mar 2026 18:20:38 +0000 (UTC)
Date: Mon, 16 Mar 2026 19:20:38 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wenyuan Li <2063309626@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, gszhai@bjtu.edu.cn, 
	25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4]can: mcp251x: add error handling for power enable in
 open and resume
Message-ID: <20260316-succinct-colorful-nightingale-2284c3-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_F3EFC5D7738AC548857B91657715E2D3AA06@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5gc4yd3mbvyk42r"
Content-Disposition: inline
In-Reply-To: <tencent_F3EFC5D7738AC548857B91657715E2D3AA06@qq.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--t5gc4yd3mbvyk42r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4]can: mcp251x: add error handling for power enable in
 open and resume
MIME-Version: 1.0

On 16.03.2026 00:00:22, Wenyuan Li wrote:
> Add missing error handling for mcp251x_power_enable() calls in both
> mcp251x_open() and mcp251x_can_resume() functions.
>
> In mcp251x_open(), if power enable fails, the driver should not continue
> with device initialization. Add proper error checking and jump to
> existing out_close label.
>
> In mcp251x_can_resume(), if power enable fails during system resume,
> propagate the error to PM framework and log the error with dev_err()
> for debugging.
>
> This ensures the driver properly handles power control failures and
> maintains correct device state.
> Signed-off-by: Wenyuan Li <2063309626@qq.com>
>
> Add missing error handling for mcp251x_power_enable() calls in both
> mcp251x_open() and mcp251x_can_resume() functions.
>
> In mcp251x_open(), if power enable fails, jump to error path to close
> candev without attempting to disable power again.
>
> In mcp251x_can_resume(), properly check return values of power enable
> calls for both power and transceiver regulators. If any fails, return
> the error code to the PM framework and log the failure.
>
> This ensures the driver properly handles power control failures and
> maintains correct device state.
>
> Signed-off-by: Wenyuan Li <2063309626@qq.com>

Something strange happened to your patch description. Please use "git
send-email" or "b4" for sending patches.

> ---
>  drivers/net/can/spi/mcp251x.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index bb7782582f40..e59220aa70ed 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -1225,7 +1225,11 @@ static int mcp251x_open(struct net_device *net)
>  	}
>
>  	mutex_lock(&priv->mcp_lock);
> -	mcp251x_power_enable(priv->transceiver, 1);
> +	ret =3D mcp251x_power_enable(priv->transceiver, 1);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to enable transceiver power: %pe\n", ERR_PT=
R(ret));
> +		goto out_close_candev;
> +	}
>
>  	priv->force_quit =3D 0;
>  	priv->tx_skb =3D NULL;
> @@ -1272,6 +1276,7 @@ static int mcp251x_open(struct net_device *net)
>  	mcp251x_hw_sleep(spi);
>  out_close:
>  	mcp251x_power_enable(priv->transceiver, 0);
> +out_close_candev:
>  	close_candev(net);
>  	mutex_unlock(&priv->mcp_lock);
>  	if (release_irq)
> @@ -1516,11 +1521,25 @@ static int __maybe_unused mcp251x_can_resume(stru=
ct device *dev)
>  {
>  	struct spi_device *spi =3D to_spi_device(dev);
>  	struct mcp251x_priv *priv =3D spi_get_drvdata(spi);
> +	int ret =3D 0;
> +
> +	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
> +		ret =3D mcp251x_power_enable(priv->power, 1);
> +		if (ret) {
> +			dev_err(dev, "failed to restore power: %pe\n", ERR_PTR(ret));
> +			return ret;
> +		}
> +	}
>
> -	if (priv->after_suspend & AFTER_SUSPEND_POWER)
> -		mcp251x_power_enable(priv->power, 1);
> -	if (priv->after_suspend & AFTER_SUSPEND_UP)
> -		mcp251x_power_enable(priv->transceiver, 1);
> +	if (priv->after_suspend & AFTER_SUSPEND_UP) {
> +		ret =3D mcp251x_power_enable(priv->transceiver, 1);
> +		if (ret) {
> +			dev_err(dev, "failed to restore transceiver power: %pe\n", ERR_PTR(re=
t));
> +			if (priv->after_suspend & AFTER_SUSPEND_POWER)
> +				mcp251x_power_enable(priv->power, 0);
> +			goto out;

Why have you kept this goto out? I've replaced it by a return.

> +		}
> +	}
>
>  	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
>  		queue_work(priv->wq, &priv->restart_work);
> @@ -1529,7 +1548,8 @@ static int __maybe_unused mcp251x_can_resume(struct=
 device *dev)
>
>  	priv->force_quit =3D 0;
>  	enable_irq(spi->irq);
> -	return 0;
> +out:
> +	return ret;
>  }
>
>  static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,

Applied with changes to linux-can

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t5gc4yd3mbvyk42r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabhJ9AAKCRDMOmT6rpmt
0ncfAPsFnLQYl+uhUYKguWqFV9vWqQ7fHxXFERmvV7lGs2FDQAD/YrhMtkh4w7W1
TR9S/KsTeTKB0/pphntouJ0UiBNJrAk=
=r74f
-----END PGP SIGNATURE-----

--t5gc4yd3mbvyk42r--
