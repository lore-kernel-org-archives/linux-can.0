Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954103;
	b=ZJEfgPaaeOiIv9QksTWJo6qgJBtURpkgo5WFj7x7V15QPnRabprHD4cU9Tqxnvhgcsfu
	 VfHYGojsVd3igxTdIhtQLWBNn+eGHbJeP1fkdT+U5xH609OmUbXEB2CKIYpBR6hjR4k/J
	 zZXjEUg36k6Icn92hUvBn//hO1fLKiHxlUenAGjeqLHXBQ5Z8VsTTql8AZl8rphNcEQ77
	 zDi1ok5yHcw/+jCAnrgrZ1eoHXY0uerpJMNnSaKsClW/0vSJ5Mvln5LQVfBuFnjSWZhG+
	 MENvFcIOTLjNvt6zVY9sTNRC5IM23QSIFc8gvFHKQ5G9gXesqI3xo1qwKu6wdHCGhSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954103;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PS8pil8gYM/GcTUibiyA9Lmt1SPVPru/1gTk80DxBWE=;
	b=HuPQj1FrdAJNkKkxO7Pxnsz5eWi+NLGmbbMY7CezuWdQK8Bry/8SSqWomuJLZSynxQnc
	 xvZwsAmXI78XhY/TwMT30w7rQlr11+w+1fFTdEmnkTQIktBCw/Wg038+1yQD0qAYomZYd
	 ytdpE42ZBKVWYljsRsI/gzoN2IhQDCO9WCZKNioB3PEaxt9sbcBW8E/hHxcXUY64SPj7G
	 ibDnWxsswjKnFiIX/EVYVUngomwTqglnqAzaZnomlCQ9CIHjvU+YB7YenQ82EZ7IGP2V2
	 LbkJmycGQqNg+KBP6TP1H6VaYo7liGv/6FtUqFjl/8UNMHoemSdzyCQUiNQVkgXEPdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaWKlOgQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F251606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaWKlOgQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C321F01825;
	Sun, 25 Oct 2026 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792954103;
	bh=PS8pil8gYM/GcTUibiyA9Lmt1SPVPru/1gTk80DxBWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VaWKlOgQ/yBO5mMTNlL4uO4vrTMO65gZiGL7jugokcDNJ/jN/xWIDv5FCNawPZfvu
	 CQj3rmnoNUdXhN9xTnEQ8lFJI896GyJF/TLW7toHLp3CDzA2hrwEGaJ0DrUpKZhbrc
	 /ksb0dlLA5mvVoQPCcCnQSFGk+6c2+Y7ulqPTguGwkW83GQZfwH5Xqbgi1CQPUABMD
	 XYv+kZJPO6Q3hwxLQAHcYq/SbC8ItUP3VwtOa7zA1KoVOJuMFVdixWgVGPg5nctlAx
	 8OBqz3OaygOzFsZRxInLUiiOAtCYLC13MsI1gxs9j815/CQpmCt/kvOf6gFmpf10jI
	 XEpTGgWBgNn5g==
Message-ID: <sashiko-outbox-184350@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] can: gs_usb: gs_usb_probe(): init netdev completely
 before register_candev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261025-gs_usb-fixes-v1-2-f74ebbd4da36@pengutronix.de>
References: <20261025-gs_usb-fixes-v1-0-f74ebbd4da36@pengutronix.de>
 <20261025-gs_usb-fixes-v1-2-f74ebbd4da36@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 18:48:22 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: gs_usb: leak of unregistered candevs in gs_usb_probe() erro=
r path
--

commit ec5e749c6eb999f0113e89d14a5c23021a5b3be5
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()

This commit moves register_candev() out of gs_make_candev() into a second
loop in gs_usb_probe() so that all CAN channels are fully initialized
before any netdev is registered.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 15f28833f2deb..985d6a9113d96 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -1490,18 +1490,8 @@ static struct gs_can *gs_make_candev(unsigned int =
channel,
>  	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
>  	SET_NETDEV_DEV(netdev, &intf->dev);
> =20
> -	rc =3D register_candev(dev->netdev);
> -	if (rc) {
> -		dev_err(&intf->dev,
> -			"Couldn't register candev for channel %d (%pe)\n",
> -			channel, ERR_PTR(rc));
> -		goto out_can_rx_offload_del;
> -	}
> -
>  	return dev;
> =20
> -out_can_rx_offload_del:
> -	can_rx_offload_del(&dev->offload);
>  out_free_candev:
>  	free_candev(dev->netdev);
>  	return ERR_PTR(rc);
> @@ -1593,14 +1583,14 @@ static int gs_usb_probe(struct usb_interface *int=
f,
>  			/* save error code to return later */
>  			rc =3D PTR_ERR(parent->canch[i]);
> =20
> -			/* on failure destroy previously created candevs */
> +			/* on failure clean up previously created candevs */
>  			icount =3D i;
> -			for (i =3D 0; i < icount; i++)
> -				gs_destroy_candev(parent->canch[i]);
> +			for (i =3D 0; i < icount; i++) {
> +				can_rx_offload_del(&parent->canch[i]->offload);
> +				free_candev(parent->canch[i]->netdev);
> +			}
> =20
> -			usb_kill_anchored_urbs(&parent->rx_submitted);
> -			kfree(parent);
> -			return rc;
> +			goto out_usb_kill_anchored_urbs;
>  		}
>  		parent->canch[i]->parent =3D parent;
> =20
> @@ -1621,7 +1611,30 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		parent->hf_size_rx =3D max(parent->hf_size_rx, hf_size_rx);
>  	}
> =20
> +	for (i =3D 0; i < icount; i++) {
> +		struct gs_can *dev =3D parent->canch[i];
> +
> +		rc =3D register_candev(dev->netdev);
> +		if (rc) {
> +			dev_err(&intf->dev,
> +				"Couldn't register candev for channel %d (%pe)\n",
> +				i, ERR_PTR(rc));
> +
> +			icount =3D i;
> +			for (i =3D 0; i < icount; i++)
> +				gs_destroy_candev(parent->canch[i]);
> +
> +			goto out_usb_kill_anchored_urbs;
> +		}
> +	}

[Severity: Medium]
If register_candev() fails at channel i in gs_usb_probe(), does this error
path leak dev->offload and dev->netdev for channel i and all remaining
unregistered channels up to parent->channel_cnt - 1?

The first loop in gs_usb_probe() calls gs_make_candev() for all icount
channels, allocating dev->netdev via alloc_candev() and initializing
dev->offload via can_rx_offload_add_manual() for every entry in
parent->canch[].

When register_candev() fails at index i in the second loop, the rollback lo=
op
only calls gs_destroy_candev() on the already-registered channels 0 .. i - 1
before jumping to out_usb_kill_anchored_urbs and freeing parent. The
unregistered channels from i to parent->channel_cnt - 1 never have
can_rx_offload_del() or free_candev() called on them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-gs_usb-fix=
es-v1-0-f74ebbd4da36@pengutronix.de?part=3D2
