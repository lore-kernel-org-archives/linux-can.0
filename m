Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033711;
	b=i+6+IRWiCG3bslp1vXcHrc47dq5YOmSRHejjMywdjZt4qa60U5pNZrMpVr/xNZIdSyYM
	 2u/VRSvqjkYxPOsu7h5S+iGa7Xosvf0jGkRaXelbm5uwFf5m3f5jElkZawqVLAAIz07WU
	 GWOMbSBLNdySzioxwkBWK9Bq1u0t9O8R969mRCkyIeAFLJrWQUxzAHqUr98SeyLP8DYRZ
	 xWJJTHeqqlmPw4gPj6kSD1crjSCsiPNMQBKAGVTDb7ERHn9RwwX2BNqzzISxAQWO/sRSj
	 tqS82M/zrWY/BRLyjQo2GURpMEbn/5SPKFsGwL13JsMv0QkUjoV3K8pzSs10vPMjNMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d3oFGaX2H0r11Tuq4ePdh1SMkozXivgNuT8MSXWjTJo=;
	b=pL7MwN9MqJYA0QoIv/HLrEAyJwwzDgVrM963pSvl6tO1PwN+a3mGqoviZXiG192xcLLl
	 mgdG8SeaTNMjsPi6vEZ0IxVsiROJa6CvdCyrzsYH6JC7ptjXBCaNx/VnOpXyCPD4dL8kX
	 naVMaNoWv/VxcP86AXTMomZB0LlMHrM4H872E7NBOvRPyWRSTo/pjJMCgbcWuFevZxMuY
	 ZnZTp11feY4HyFi3f8QkFN8SrasotpdQ6LUiWCn+j5C1Au+TSt2UGo7hwqkJWyYvPY0eL
	 wkIxZTSF8JtagjTKfJv7kwOhFdK2ALD5x1ZBw9CkWJWf/ze9AOGQuW7w78zCdZp1vtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7GcmYXD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA019606A320
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7GcmYXD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA2C1F01825;
	Mon, 26 Oct 2026 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793033710;
	bh=d3oFGaX2H0r11Tuq4ePdh1SMkozXivgNuT8MSXWjTJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G7GcmYXDeuYwNCCqB/T/cCDY8bixbQXvdRuDD+9LdZMu9ttz+JibQVi81la2ieasq
	 oAWRKRtzah+al72r3xRAITFjl43EPJ/NMAW9KhWEUkfkiENcJoOr509HxugfqdMFjv
	 8qb55Wg8APX2T95DeNHB+dEKeVJzli/GWTrcLaghZmJqISBS4hLwtpgsSyKBp6EsRY
	 CXJh4gg/YjGASxfTc6nTh/JSAhjVLcQEHcutsUJ7eoKzIArC9RNSxmlzzf0Cp0Qplt
	 +HMNMAtN1Lcyi6EqhIbh7XOpP60O189bfrkb56DLrTKAlku9EKOCOqSI84aUQ3HEJj
	 q9pYxZhMBYORQ==
Message-ID: <sashiko-outbox-185562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] can: gs_usb: gs_usb_probe(): init netdev
 completely before register_candev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261026-gs_usb-fixes-v3-2-3a68f1f62813@pengutronix.de>
References: <20261026-gs_usb-fixes-v3-0-3a68f1f62813@pengutronix.de>
 <20261026-gs_usb-fixes-v3-2-3a68f1f62813@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:55:09 +0000
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
- [High] can: gs_usb: ERR_PTR dereference in gs_usb_probe() error cleanup
--

commit 2720d49a596fa1eb1aed7686479119245dbc2334
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_probe(): init netdev completely before register_candev()

This patch moves register_candev() and unregister_candev() out of
gs_make_candev() and gs_destroy_candev() into gs_usb_probe() and
gs_usb_disconnect() so that all CAN channel structures and parent fields
are fully initialized before registering the netdevs.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 15f28833f2deb..cbe3750bb68ad 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -1593,14 +1582,7 @@ static int gs_usb_probe(struct usb_interface *intf,
>  			/* save error code to return later */
>  			rc =3D PTR_ERR(parent->canch[i]);
> =20
> -			/* on failure destroy previously created candevs */
> -			icount =3D i;
> -			for (i =3D 0; i < icount; i++)
> -				gs_destroy_candev(parent->canch[i]);
> -
> -			usb_kill_anchored_urbs(&parent->rx_submitted);
> -			kfree(parent);
> -			return rc;
> +			goto out_gs_destroy_candev;
>  		}
>  		parent->canch[i]->parent =3D parent;
> =20
> @@ -1621,7 +1603,37 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		parent->hf_size_rx =3D max(parent->hf_size_rx, hf_size_rx);
>  	}
> =20
> +	for (i =3D 0; i < icount; i++) {
> +		struct gs_can *dev =3D parent->canch[i];
> +
> +		rc =3D register_candev(dev->netdev);
> +		if (rc) {
> +			const unsigned int cur =3D i;
> +
> +			dev_err(&intf->dev,
> +				"Couldn't register candev for channel %d (%pe)\n",
> +				i, ERR_PTR(rc));
> +
> +			for (i =3D 0; i < cur; i++)
> +				unregister_candev(parent->canch[i]->netdev);
> +
> +			goto out_gs_destroy_candev;
> +		}
> +	}
> +
>  	return 0;
> +
> +out_gs_destroy_candev:
> +	for (i =3D 0; i < parent->channel_cnt; i++) {
> +		if (!parent->canch[i])
> +			continue;
> +
> +		gs_destroy_candev(parent->canch[i]);
> +	}

[Severity: High]
Can this dereference an error pointer in gs_destroy_candev() if
gs_make_candev() fails during gs_usb_probe() in drivers/net/can/usb/gs_usb.=
c?

When gs_make_candev() fails (for example, if usb_control_msg_recv() for
GS_USB_BREQ_BT_CONST or GS_USB_BREQ_BT_CONST_EXT fails, or alloc_candev()
returns NULL), it returns an ERR_PTR() value which gs_usb_probe() stores in
parent->canch[i]:

	parent->canch[i] =3D gs_make_candev(i, intf, &dconf);
	if (IS_ERR_OR_NULL(parent->canch[i])) {
		/* save error code to return later */
		rc =3D PTR_ERR(parent->canch[i]);

		goto out_gs_destroy_candev;
	}

In the out_gs_destroy_candev cleanup loop, the check only tests
!parent->canch[i]. Because the failed slot holds a non-NULL ERR_PTR(), it is
passed to gs_destroy_candev(), which unconditionally dereferences dev via
can_rx_offload_del(&dev->offload) and free_candev(dev->netdev).

Should the cleanup loop check IS_ERR_OR_NULL(parent->canch[i]) instead of
!parent->canch[i]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-gs_usb-fix=
es-v3-0-3a68f1f62813@pengutronix.de?part=3D2
