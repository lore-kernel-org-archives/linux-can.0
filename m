Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC9638F251;
	Fri,  2 Oct 2026 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932108; cv=pass; b=j+DIMNzfBDnwbMNGyQ7kcw6FWtGdIk7pUb+aBAcTePZMgROjxMGerQD0eT4jac8sCFa/HOb9x3RuYYiCogOEXMFDIK8GX0hO593fAc/h9ZRjChO11LTWPPj+hY3XFQzFIoucnubtBmhB806uYnnZTTGPckXal1t+xGqUZnmE360=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932108; c=relaxed/simple;
	bh=SxNAnGwYgghYI9SlRTIjv1LGA4j9kEXCh9dTYQ+IioA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umX7QQlbKnpj3t3VlbU2zEMgEPgNSAqy9GEF3dexIcyA4F41IvdueVdHR/CDrHtqSI8gw8NqwAwzIproUDM2u2koGjWvSo4ghgkk6bYCmuhpUlL57EFjsccJ1PcCIPYuCQGT+Pd7i+R6zxOU8NWN1RkXh72vlAKOaUi0Os5PgGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=guDdqKD4; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="guDdqKD4"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5999720196E;
	Fri, 02 Oct 2026 11:08:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790932103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l99jnKZHJb7HazCntOdV3ExQiyvLfl26SZ+ORlybioM=;
	b=guDdqKD4yYk+js8a0RQz1grbfrgrtEQWnU7IYdzX5uqDnZlzOnYd0FqCfYMv/4/oqlIO9X
	P4SLmHLja7PYEpPMDyy0lILmJ6uSusOfPNmo4ykxsmAxNuts9Cr3ES53FV9wBdfZHovPUs
	s2DUBWtkjBguAPIgNtxNXC7rySFu3O5pqhMn1AvqrknQOpYrcyLbWKAxiXnLYFkw4dzMjx
	YTIzG7+BryKGsghsO+kNABDGxxCNJU+zzDUUZlIpTBV50t+h693b1UD1K/4xlyqhR+mVTY
	ebPWnyWPi0cIvX9X9axttz/eDSgf0Kvdln7FBwV1KNT+NE9uW5NG5GIZOsLQUg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790932103; a=rsa-sha256;
	cv=none;
	b=TGxbP2vN5o0ZZUZ4nC2HX3pqpmBmu5Jo2Y9pPdBgAi6VJp21QhLCwN6YlDnWUah6+CyzAZ
	rzER8piYuK6Oizh+Au6ltxdk3p12NrFdLEZgqz6Kg/rwe6ossx0yDYvTsuMYr+qJMZrDUa
	GuUKjZsYOglvYUBJK7dEauNICsO7tUK6heMkSQfP/KkDcr0QiBD2YFbZevLTFkR0Ipm5Ha
	toZVBqrfZyjwEi3VhJFlNHQT8FN8BApo5dgwycuhg9PTvKOuZjG/CAOy7RYz8xkkSlht2u
	OUMSPr77xh66ziK6HrADhJEn1aNACAdx4hCnmaxrqVy9i+r2hmiRmrHntMgnmQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790932103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l99jnKZHJb7HazCntOdV3ExQiyvLfl26SZ+ORlybioM=;
	b=cb0NKr2ckBSpGMtOm3IMDQXYacz3DTH0Jv44p3a9zguHPgMmT5ZHGI5vYI5H6L5Fu3cGeZ
	LcMYDbDWAhuP3J7K8lltysFd2Bem83eQmQbN2vkh96rkEg20MG80VY2FMb85Y+g9Pijotv
	DWJa0QqTnnHaTJdbYmVbJioMHCHw1dWkGFOCSmbNyiST55HRzGpBcfESrLCGcGriXGp+mp
	/dFUz3e4TZw9yJTkzHwjkLXnPlMazbKDxnFOXqPU7GmjcQEx6iZh/oWjQsFlyQlilCetxV
	yWsAAAYUB3kmpeBeUsZ9FWA6BtOu81jng6tXsPCaxKWhSEmHnDDp9Jniq6WWdQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCZFf-003rkK-0s;
	Fri, 02 Oct 2026 11:08:23 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 064105B83C9;
	Fri, 02 Oct 2026 09:08:22 +0000 (UTC)
Date: Fri, 2 Oct 2026 11:08:22 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next v3] can: gs_usb: add workarounds for HScanT USB
 to CAN adapter
Message-ID: <20261002-rousing-axolotl-of-effort-29c26a-mkl@pengutronix.de>
References: <20261002-gs_usb-hscant-v3-1-f9b2b2319079@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lijdutfyrx7z6mrq"
Content-Disposition: inline
In-Reply-To: <20261002-gs_usb-hscant-v3-1-f9b2b2319079@pengutronix.de>


--lijdutfyrx7z6mrq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3] can: gs_usb: add workarounds for HScanT USB
 to CAN adapter
MIME-Version: 1.0

On 02.10.2026 11:01:56, Marc Kleine-Budde wrote:
> The HScanT is a RISC-V-based USB-to-4-channel CAN-FD adapter that is
> compatible with the gs_usb protocol. The device ships with firmware
> version 0x00010007 and requires several quirks to function properly.
>
> The HScanT firmware specifies 5 channels, but the =C2=B5C contains only 4
> m_can IP cores. To work around this issue, change the value of `struct
> gs_device_config::icount` to 3, which corresponds to 4 channels.
>
> The HScanT supports CAN-FD with different bit-timing constants for
> arbitration and data rate. The firmware reports that it supports
> CAN-FD (GS_CAN_FEATURE_FD), but does not support querying the data
> bit-timing constants (GS_CAN_FEATURE_BT_CONST_EXT). As a result, the driv=
er
> uses the arbitration bit-timing constants for the data rate.
>
> According to EcuBus-Pro (a cross-platform CAN analyzer), if the
> firmware supports GS_CAN_FEATURE_FD, it also supports querying the
> data bit timing constants. Fix: Add GS_CAN_FEATURE_BT_CONST_EXT if
> GS_CAN_FEATURE_FD is set.
>
> The HScanT firmware requires a USB High Speed Hub, bail out if device is
> connected to slower USB Hub.
>
> The HScanT firmware requires In-URBs with a length of at least 512 bytes.
> If In-URBs with a length of less than 512 bytes are used, the firmware do=
es
> not send any In-URBs.
>
> When using In-URBs with exactly 512 bytes (=3D maximum packet length of t=
he
> endpoint), 512-byte In-URBs are sent, immediately followed by a 0-byte
> In-URB. This results in a "short read" error in
> gs_usb_receive_bulk_callback(). This can be avoided by using In-URBs with=
 a
> length of 513 bytes.
>
> Add the GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE quirk to allocate In-URBs th=
at
> are 513 bytes in size and work around these issues.
>
> This driver supports up to 255 channels per USB interface. The HScanT
> device has 4 channels, but the firmware requires that each channel be bou=
nd
> to a USB interface via the USB request
> "GS_USB_BREQ_HSCANT_SET_INTERFACENUMBER_ENDPOINT." Add a quirk to
> "GS_CAN_FEATURE_QUIRK_HSCANT_BIND_CHANNEL" to bind the CAN channel to USB
> interface 0 during "gs_can_open()".
>
> Link: https://github.com/cherry-embedded/HSCanT-hardware
> Link: https://github.com/ecubus/EcuBus-Pro/blob/86f6e1bab0de/src/main/doc=
an/candle/api/candle.c#L307-L313
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes in v3:
> - Link to v2: https://patch.msgid.link/20260928-gs_usb-hscant-v2-1-a7c1c0=
2460e9@pengutronix.de

Doh, forgot to mention changes in v3:

- described GS_CAN_FEATURE_QUIRK_HSCANT_URB_SIZE in more detail
- use ensure that GS_USB_QUIRK_HSCANT_IN_URB_SIZE ist bigger than a
  struct gs_host_frame CAN-FD frame _with_ timestamps, not just a struct
  gs_host_frame CAN-FD without timestamps

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lijdutfyrx7z6mrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCar90hAAKCRDMOmT6rpmt
0hNgAP46ihq46LXb49VfoB7onFyiOlmZnU7OOqX/twWcMo3fZgD+Oxj2nekgiifL
nnypr23/NGCvSxxy8Lxh2DTabZeqDgg=
=euht
-----END PGP SIGNATURE-----

--lijdutfyrx7z6mrq--
