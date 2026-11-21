Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300956;
	b=ZgMYWHa3fIsycde61rQwS0sos48uBfmMIsA8FqyIZEzYNO51GTpKrgmv1Fpj3tm2pit0
	 AKULEkD8QWCHdDTDYA0vCi49Al1SgAHtTSmW/8VtOTe9ENcpaNzglRd8MHpFJ1SiSSSaX
	 Mzkb5v6Wh7ZVKT23nLp2x6bQe6gdYID2Xbc8OyEpdCfR2sACkAjmy4ukdQ+a41rk9lcLF
	 /6AYZg+HkTqF9T8QC8WGrz87y/Av6k6Vd+rNkqIaBRSEuoe9q9ZZ9/1oDls7fyu5tLWg9
	 036OuTep1Ypt58eNV1ro/dBsePZHADkS7iTgCNyCs+vs19v2ihSEfkoltXyrsi3wV2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+XcWK2WPTcrwmCkl52YVXNEy9rTd0cxvO1hYB8t3qs0=;
	b=fKm28RS5dFS631O8FJeing0LKEeasu+eENp8J7rnIkdUJTte6E6RMEJ9UdbfuxapP0Aq
	 giQS5MhmpiO1KGFR36l6Iw953Lfk66Pbx0KXgXeFd93ivrF2cPR62wlKJnIhHj5CFExbr
	 ItX9yDzv6ykCCBV9tTd474qHkDg28NjwrXnI+PZRhdLPrJd39dqEyabBSmlJOgPHDQ0GP
	 s8CeFOtTCZ+OgGPK4PAEK4DonI9+QxRBEzvxRR5vUdAL4IQXPoY7hg/DCDWg/DiZ5wJeQ
	 GUMSxPYr/OIsMCGX43VgwnACsaGCik1fCZ8N2f5JeKkDzWRxyZbh553zFJ1SmcmsyHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezDu4lMn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABBF606A320
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezDu4lMn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA8F1F000C6;
	Sat, 21 Nov 2026 22:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300955;
	bh=+XcWK2WPTcrwmCkl52YVXNEy9rTd0cxvO1hYB8t3qs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezDu4lMnuGkOCCAOoU88B8NErgo18CYDVvLe7lZpBjzNl2Er3k38tIwbzPjtR2tRX
	 typ8frCUTq8kdUaMTlA2iuB3K5az6nQzOXT6aukrPf35pIHLNJgv1m7dJE8eEZDMZR
	 AtdbsmaU/jw6U6vRa8A5NyHgpHrOPVjPcIeI9J7/yEX3RWnu4mkeNCBgUBRnrpxxRj
	 bUgrsh+NbYLBMixIa52FBAigmCzHF/64lcsPCJq9cEqsyG6jbUW5ovYAyiSIW9PZFA
	 gDk+revw/5Pzv+2qy2pLp96RxIBnPbkgUi9CyKRBtZ3WDXySdcmbyj+SZpevXKbvQL
	 pz9ByHIb9QQPg==
Message-ID: <sashiko-outbox-227460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v9 06/13] can: gs_usb: add support for context
 analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-6-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
 <20261121-gs_usb-fixes-v9-6-db121d488945@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 22:42:35 +0000
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
- [Medium] can: gs_usb: misplaced brace fixup in gs_can_open() breaks
  bisection
--

commit c9d422d27a7b8018d144a3f7d0351ca265fd88bd
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: add support for context analysis

This commit enables context analysis for the gs_usb driver and annotates
the hardware timestamp counter fields and helpers with tc_lock locking
requirements.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 30bcb734c5df8..ab82dc07f3f50 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
[ ... ]
> @@ -1037,7 +1040,7 @@ static int gs_can_open(struct net_device *netdev)
>  		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
>  			rc =3D gs_usb_timestamp_start(parent);
>  			if (rc) {
> -				if (rc =3D=3D -ENODEV) {
> +				if (rc =3D=3D -ENODEV)
>  					netif_device_detach(netdev);
> =20
>  				goto out_can_rx_offload_disable;

[Severity: Medium]
Should this stray opening brace removal be squashed into the preceding
commit "can: gs_usb: fix hardware timestamp state for mixed channels"?
Leaving the unmatched brace in the earlier commit prevents gs_usb.c from
compiling there, which breaks bisection and standalone stable backports of
that fix.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-gs_usb-fix=
es-v9-0-db121d488945@pengutronix.de?part=3D6
