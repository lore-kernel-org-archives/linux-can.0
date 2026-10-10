Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAA372EE2
	for <linux-can@vger.kernel.org>; Sat, 10 Oct 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639844; cv=none; b=lkn69lFxcWIaX661CHCZTqKSb9FkbwS05V9pxeWi234VgDvk6KoGjiqiWdBxhpDJWKzYH4qWR6kG4AhQ9E91WO98S/k2xnhBDTzr2zBpce5/0HkvKxHi4n0w7zHtRGXH/cnHWtv+autuGD5DVzYvwNhgv4OTdgMv/Z4pBDj12mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639844; c=relaxed/simple;
	bh=Pe3es7lr4qDNNJUusWrRGLL76/d2rT3RV/wFPaaDGuE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r2v01OEvsyJALHgsPyzjX8FX+p6+kOnlxCHWe9mk/KxUc1+7Y2TIqkNprE6kLe/b8OpRv+CzECBgkGVZBS7rB1s7il6nI0WinrO6qtgncbla9mFV2+8AF8xJXmEuNst5hD+TnXkv2L89J3r/leOzalBuDTsXPbGDhCKifDxskU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0x6eBJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0x6eBJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858C71F00893;
	Sat, 10 Oct 2026 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639843;
	bh=islDv6xBbWe7NQraAfPp1pRx/zkVKrsaGtpJ7LR5gVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J0x6eBJ/Xt1RCvDf9QeB6tqV6O63V8oEhSsT3aoi3Jjz2Wu1XQ820a4TmzccCiWZj
	 dmB+txcPjUgINFoxiSgg7PMGY18wxf1X2CsrKSkQYEALXA6Golx0cpu09phNqdWo8+
	 1+kJOYNDkJAk0xIfIlebKApPtj+wujiwtVs9gyINCySyxpJgdcBoIhWgOIUMYkmLzt
	 yeJmuIVMA6s+g9Sy/VqOaxGe+IDihxgHUoSJdTE/sVjTHTxFjDa6qQOgT0KiJj+w2/
	 CZmfl+SOixNaRSxdNcxNx6IWJP+uShX+DmdG5FC8NTmiI4A07uY+rYyph1UpTRGonj
	 ZEmU70SrzdBVw==
Message-ID: <sashiko-outbox-166621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 31/37] can: kvaser_usb: refactor endpoint
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20261009134323.64064-32-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009134323.64064-32-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:44:01 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: kvaser_usb: infinite loop when bulk-in wMaxPacketSize is 0
--

commit b4168d21a894a8ed379ae53431fcd63f4de542bb
Author: Anton Olsson <anol@kvaser.com>

can: kvaser_usb: refactor endpoint lookup

This patch moves kvaser_usb_leaf_setup_endpoints() to kvaser_usb_core()
so it can be used by both the mhydra and leaf sub-drivers. It also
removes dev_setup_endpoint() from struct kvaser_usb_dev_ops.

Link: https://patch.msgid.link/20260817112052.1477126-1-anol@kvaser.com

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/n=
et/can/usb/kvaser_usb/kvaser_usb_core.c
> index d0a2a2a33c1c8..9687dfb89b4cc 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
[ ... ]
> @@ -926,6 +926,23 @@ static int kvaser_usb_init_one(struct kvaser_usb *de=
v, int channel)
>  	return err;
>  }
> =20
> +static int kvaser_usb_setup_endpoints(struct kvaser_usb *dev)
> +{
> +	struct usb_host_interface *iface_desc;
> +	int ret;
> +
> +	iface_desc =3D dev->intf->cur_altsetting;
> +
> +	/* use first bulk endpoint for in and out */
> +	ret =3D usb_find_common_endpoints(iface_desc, &dev->bulk_in,
> +					&dev->bulk_out, NULL, NULL);
> +
> +	if (ret)
> +		return -ENODEV;
> +

[Severity: High]
Does this code need to validate that dev->bulk_in->wMaxPacketSize !=3D 0?

If a malicious USB device presents a bulk-in endpoint with a wMaxPacketSize
of 0, the USB core does not reject it. Later, in
kvaser_usb_leaf_read_bulk_callback() and kvaser_usb_leaf_wait_cmd(), if a
zero-length command is received (cmd->len =3D=3D 0), the driver advances the
position using:

    pos =3D round_up(pos + 1, le16_to_cpu(dev->bulk_in->wMaxPacketSize));

When wMaxPacketSize is 0, round_up(pos + 1, 0) evaluates to 0 because
__round_mask(x, 0) becomes -1. This endlessly resets pos to 0, resulting in
an infinite loop and a CPU hang.

Could we add a check here during endpoint initialization to reject endpoints
with a zero wMaxPacketSize?

> +	return 0;
> +}
> +
>  static int kvaser_usb_probe(struct usb_interface *intf,
>  			    const struct usb_device_id *id)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134323.6406=
4-1-mkl@pengutronix.de?part=3D31
