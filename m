Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595C3F58F6
	for <linux-can@vger.kernel.org>; Thu, 18 Jun 2026 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791931; cv=none; b=A+ZhtBEFkoTCn66Tpdh625zJtFu4IU8XsI16IoGdMXnXhptnB876MRco0mUa6EiWJ+FFXmlhvydeqUDKXgrotMypPZY9MWN6qEmwHzY2Jej5aP6KDq4QNU4DVbILEE96aFuzWUy+naeO2TPbZQABt3VexwWC+FKpAl7pd+IwaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791931; c=relaxed/simple;
	bh=KVNX1CLx21/EnMNl5c0knbbb35TPJoePH/C5HSx1vOE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RhnAo/zHMUjh+lp+XvAnA5KzWi+Ta4Su6KtvzEdDFLwsiD2J1wAoyrLsaivXy/drDSwc+jD2g74oxQ+GiIPsXxS0DjoxFOZFOby5guzZkPykoeYd5pF9GkYtEh4uzMooT0v6jKRWetFUN2FT8IjQ4jN34onwLEFihdxxb5qOgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYU/ujIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYU/ujIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C001F000E9;
	Thu, 18 Jun 2026 14:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781791930;
	bh=yatM9sUc9kmV5xZFxhihWjNWNExh3lBIsDvAFiTL8lo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DYU/ujIQ1h0e1rhCu65Bazv4glOVrJTjnxlg8uW+WfRIzr+I7iORMzUqz2q7aSOCN
	 o47J3K4U4Ne/xqaMjELGbuMbp2hFsETea7RbqGMBP3glztifjs/jLv6lwwO1pZeG2A
	 RW65U8Hra4hssAIj5k7YRfhdoRR2yh4JdMUh9fwGsb/w3P26Es+Kcu9cfL7qagjvhG
	 vI0kIcC8eKqza4mbppogjaQeLyf5uAMl0v9VseuN01Z7L2ea1pUGA0veIycpJLWcrG
	 N4aSo0j3eFTsjmLGnD3DtF3UglbMLbPIA21aLr5UIyPaI505OZLVZZqWMDSib8GsFK
	 FcO93/i++dSTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: flexcan: Fix probing for m68k/coldfire
Reply-To: sashiko-reviews@lists.linux.dev
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
References: <20260618140147.142489-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 14:12:09 +0000
Message-Id: <20260618141210.11C001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Network device is registered and exposed to userspace before hardw=
are and state initialization are complete, leading to race conditions and a=
 PM runtime underflow on probe failure.
--

commit 3c3a1287a919f302aebc8b9802a583cf3a9bb1c9
Author: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>

can: flexcan: Fix probing for m68k/coldfire

When determining the device details was reworked in commit 5e6c3454b405
("net: can: Use device_get_match_data()") there was no replacement for
the previous handling of non-of instantiated devices via the device's
id_entry which then results in a NULL pointer exception. The only
in-tree provider of such a device is arch/m68k/coldfire/device.c.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503fa..05b8ca72ca2ad 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c

[ ... ]

> @@ -2148,6 +2147,15 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  		return PTR_ERR(regs);
> =20
>  	devtype_data =3D device_get_match_data(&pdev->dev);
> +	if (!devtype_data)
> +		/*
> +		 * If the device was instantiated via the traditional platform
> +		 * mechanisms (i.e. not by device tree), device_get_match_data()
> +		 * returns NULL. The only remaining such device is mcf_flexcan0
> +		 * (defined in arch/m68k/coldfire/device.c). Pick the right
> +		 * device type for that.
> +		 */
> +		devtype_data =3D &fsl_mcf5441x_devtype_data;
> =20
>  	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
>  	    !((devtype_data->quirks &

[Severity: High]
This isn't a bug introduced by this patch, but later in this same function
flexcan_probe(), the network device is registered and exposed to userspace
before hardware and state initialization are complete.

Specifically, flexcan_probe() calls register_flexcandev(), which exposes the
interface to userspace via register_netdev(). Then register_flexcandev()
alters the hardware state and drops the PM runtime count:

register_flexcandev() {
	err =3D register_candev(dev);
	if (err)
		goto out_chip_disable;

	/* Disable core and let pm_runtime_put() disable the clocks. */
	flexcan_chip_disable(priv);
	pm_runtime_put(priv->dev);
}

Because the device is already visible, userspace can concurrently bring the
interface up, invoking flexcan_open() and flexcan_chip_start(). Doesn't this
race with the unlocked flexcan_chip_disable() call, potentially leaving the
hardware disabled while the network core considers it up?

Also in flexcan_probe(), if flexcan_setup_stop_mode() fails after the device
is registered, it goes to the failed_setup_stop_mode cleanup path:

flexcan_probe() {
	err =3D register_flexcandev(dev);
	...
	err =3D flexcan_setup_stop_mode(pdev);
	if (err < 0) {
		goto failed_setup_stop_mode;
	}

	of_can_transceiver(dev);
	...
 failed_setup_stop_mode:
	unregister_flexcandev(dev);
 failed_register:
	pm_runtime_put_noidle(&pdev->dev);
	pm_runtime_disable(&pdev->dev);
}

Since pm_runtime_put() was already called on success inside
register_flexcandev(), does the call to pm_runtime_put_noidle() in the
failed_register path cause a PM runtime usage counter underflow?

Finally, of_can_transceiver() is called after device registration to
initialize priv->can.bitrate_max. Could userspace configure the CAN bitrate
before these maximum limits are enforced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618140147.1424=
89-2-u.kleine-koenig@baylibre.com?part=3D1
