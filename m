Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB442F8EB0;
	Mon,  3 Aug 2026 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770501; cv=none; b=dGQxlgHEdBbDJOXPeg9G+gKe9BzZwVowQ32d9EfbQLw6GFKOemzeNX9SE1ZS5vt5rhXsQNmhIuvD2IFt0MzanDx8FeKLXdLgyZquauSU2G0ocezoRrQzBn4Y0YUzsB+2p9CGhTKPDmU1i8pzTk0LBtxt0czElSomFTeRlq5DTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770501; c=relaxed/simple;
	bh=kRrDqUYJu4CYLa0dhwgk0z3PDbZ9Xk86ftvpTUYNG84=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JELEiE5QHwnU70cCPMB4/A0/qtxv78DyZC2kP+BgBcguByfSoV41iokO6iO7BcYaIt0W2fbg9lFDvMW/11tNbKJosdwVLejuBn+Y2lKMj2Y5JQhTISh65V87o2yB7trFvvDAQDxvDnTe1rGzIasiAZgm7A/kbyThU2ld5hQ5IGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4821D200048;
	Mon, 03 Aug 2026 17:21:31 +0200 (CEST)
Message-ID: <156581f4ba49cdae4ff1a19767eb32ffa64ec900.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] can: arasan-canfd: add driver for arasan CAN-FD
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jisheng Zhang <jszhang@kernel.org>, Marc Kleine-Budde
 <mkl@pengutronix.de>,  Vincent Mailhol <mailhol@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 03 Aug 2026 17:21:31 +0200
In-Reply-To: <20260803140531.12692-3-jszhang@kernel.org>
References: <20260803140531.12692-1-jszhang@kernel.org>
	 <20260803140531.12692-3-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mo, 2026-08-03 at 22:05 +0800, Jisheng Zhang wrote:
> Add driver for the arasan CAN-FD controller.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/net/can/Kconfig        |    6 +
>  drivers/net/can/Makefile       |    1 +
>  drivers/net/can/arasan-canfd.c | 1057 ++++++++++++++++++++++++++++++++
>  3 files changed, 1064 insertions(+)
>  create mode 100644 drivers/net/can/arasan-canfd.c
>=20
[...]
> diff --git a/drivers/net/can/arasan-canfd.c b/drivers/net/can/arasan-canf=
d.c
> new file mode 100644
> index 000000000000..63a6191f84f6
> --- /dev/null
> +++ b/drivers/net/can/arasan-canfd.c
> @@ -0,0 +1,1057 @@
[...]
> +static int arasan_canfd_probe(struct platform_device *pdev)
> +{
> +	struct net_device *ndev;
> +	struct arasan_canfd_priv *priv;
> +	struct phy *transceiver;
> +	void __iomem *addr;
> +	int ret;
> +
> +	addr =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(addr))
> +		return PTR_ERR(addr);
> +
> +	ndev =3D alloc_candev(sizeof(struct arasan_canfd_priv), CAN_MAX_TX_QUEU=
E);
> +	if (!ndev)
> +		return -ENOMEM;
> +	priv =3D netdev_priv(ndev);
> +
> +	priv->sys_rst =3D devm_reset_control_get(&pdev->dev, "sys");
> +	if (IS_ERR(priv->sys_rst)) {
> +		dev_err(&pdev->dev, "failed to get sys reset\n");
> +		ret =3D PTR_ERR(priv->sys_rst);
> +		goto err_free;
> +	}
> +	reset_control_assert(priv->sys_rst);
> +	reset_control_deassert(priv->sys_rst);
> +
> +	priv->can_rst =3D devm_reset_control_get(&pdev->dev, "can");

Please use devm_reset_control_get_exclusive() directly.


regards
Philipp
