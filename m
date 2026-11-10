Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286168;
	b=vTnwapjnVdtHJR4JlEJjhwoWI8tzq+G0DnzQAGVr3elYevT6TQ+fk+ErwIjwaQALY6HU
	 2EwoNkVEgB/4+AW+bhPHe1q3ikq01kcvkJnPm6ifMzomlbbPKI6YwEcaF3krzR38qHo7z
	 zaFkIW/wUnTY1mT4wIe44LI4FpwGLwLdcNNfbp7t1O0VeAKx+mMVKKR8HbOH7+0CqWznQ
	 X/b1tXKgxbANYZNlVcZeszQ/esklqMoVfFtzQo5FbGai6NB+Yc/eH74VTEeu5Hs5jAHq6
	 v/gspLV8kR5iPLpamu4nSghqJ25EJFpoR9HeaCx6reNQvn7mblPp1wL05SPmwyT04Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oUmEZlAvS5HqYq0sbbq4PY1Nmbej1BnFbuFOAlcjnsQ=;
	b=xaawBqC3dnij38y/DYpOSwP8a0WPl7BJjGclQvEf22dvw8agsXFUGYb9jGTJmHckffay
	 KnWgiFqXw9shC/NirX23liHO9Q8jm4loJxezAW4iF/uinzK4fZLugbyzR82+WFIWjJDFa
	 ZkzjKlMsKiC7OHfv8Z6XUqd6+S8iLvAtLkzx/ZkvZTv4Y3wu6gnMstmqhiF4VQwZK+s8V
	 /sDYTglQabpTyNcpJORtJWdttT6F1negW+Onzdq1ftt2EkaZ4XRk8iGd7q4rUkHQJz6ho
	 anYFVYQeVwnFHSMMrcVUxLoKWyGzxQq1jYU9vhPtuAYkZar6YQBBtNiyiKbL1TosOtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVzyr6T4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F52606A33A
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SVzyr6T4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2838E1F008A2;
	Tue, 10 Nov 2026 04:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286167;
	bh=oUmEZlAvS5HqYq0sbbq4PY1Nmbej1BnFbuFOAlcjnsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SVzyr6T4cCjKFHbOrVLyysYFBfnOg31PpR7vcj1m341UrLWWOFklrrzanAa9Ltjas
	 O9pRiU7mffnx1WRylGuN6wcB1ekz9hPFC+wTnE+h1TkH5vPME2K6jm5ni0DXSU7kqk
	 xiPgWxFHG+xX1stbxmiMGy3iHodm/fIBJ205mlD+9k8bXix0wlGFvNLjNKe2Of9Muj
	 iE2OkI7JqY5Jzd1wVx7P+FVAxtm+b7wlC80zHWr/cVZTjsvu1LR+nNqZFFnXH31ODz
	 QWiE9wxF4Zq0rodO8YHdmTZrOXOwXDAP1LaxkovUvLFgCMSll0633zcQY7pGb1LIUO
	 CIORRkuejmJcg==
Message-ID: <sashiko-outbox-206243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: peak_usb: pcan_usb: shut down restart timer on
 free to avoid use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: hyunjungg <hj351016@gmail.com>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261109044911.1163505-1-hj351016@gmail.com>
References: <20261109044911.1163505-1-hj351016@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:49:26 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: peak_usb: unanchored restart URB and timer mishandled in
  pcan_usb_free()
--

commit 5d0ce26d62347660cb47c1b9c3037c160879b961
Author: Hyunjung Ko <hj351016@gmail.com>

can: peak_usb: pcan_usb: shut down restart timer on free to avoid use-after=
-free

This commit adds a dev_free callback to pcan_usb that calls
timer_shutdown_sync() on pdev->restart_timer before freeing the device.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 8fd058c328564..113b2e7453310 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -882,6 +882,19 @@ static int pcan_usb_start(struct peak_usb_device *de=
v)
>  	return pcan_usb_set_ext_vcc(dev, 0);
>  }
> =20
> +static void pcan_usb_free(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb *pdev =3D container_of(dev, struct pcan_usb, dev);
> +
> +	/*
> +	 * The restart timer is armed from the restart-command URB completion
> +	 * (pcan_usb_restart_pending()), which is not anchored and so outlives
> +	 * ndo_stop/unlink_all_urbs. Shut it down -- not just delete it -- so a
> +	 * late completion cannot re-arm it after free_candev().
> +	 */
> +	timer_shutdown_sync(&pdev->restart_timer);
> +}

[Severity: Medium]
Can timer_shutdown_sync(&pdev->restart_timer) prevent a use-after-free if
pcan_usb_restart_pending() runs after free_candev()?

pdev->restart_timer is embedded in struct pcan_usb (allocated inside
netdev_priv()), so a late pcan_usb_restart_pending() calling
mod_timer(&pdev->restart_timer, ...) after free_candev() still
dereferences freed memory.

Also, in peak_usb_create_dev(), register_candev() is called before
dev_init() and dev_set_bus():

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_create_dev() {
    ...
	err =3D register_candev(netdev);
    ...
	if (dev->adapter->dev_init) {
		err =3D dev->adapter->dev_init(dev);
		if (err)
			goto lbl_unregister_candev;
	}

	/* set bus off */
	if (dev->adapter->dev_set_bus) {
		err =3D dev->adapter->dev_set_bus(dev, 0);
		if (err)
			goto adap_dev_free;
	}
    ...
adap_dev_free:
	if (dev->adapter->dev_free)
		dev->adapter->dev_free(dev);

lbl_unregister_candev:
	unregister_candev(netdev);
    ...
}

If the registered interface is brought up and triggers a restart while
probe is still running, a failure in pcan_usb_get_serial() inside
pcan_usb_init() jumps to lbl_unregister_candev and skips pcan_usb_free()
completely.  A failure in dev_set_bus() runs pcan_usb_free() before
unregister_candev(), and because probe failure does not call
usb_disable_interface() and peak_usb_unlink_all_urbs() does not kill the
unanchored restart URB, that URB can remain in flight across
free_candev().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109044911.1163=
505-1-hj351016@gmail.com?part=3D1
