Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2C513578
	for <linux-can@vger.kernel.org>; Wed, 16 Sep 2026 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566488; cv=none; b=n7q2sBdaWpycA+QssvF7NRf1SUejg9WLTJeh/6zOiJWRz9hKzTPFPFCTKqT/d0XtwQtMxxGFEpCdsmFR9KXo8lecRmaUiNkJmsHM6eVe2ND9l1rG/HdcsKePjiM2Lu0dIuqbBE0OgWZKDnfKpVCXCXbcIyDiridHE0NUcQww3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566488; c=relaxed/simple;
	bh=9ysRM8k4E2YENNcQ9MVPylU2j5zfie/aNOBeUpYYi64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g5MAKTIEpfUmIaPv2m8T2bwWStrsDBlp/ZILLC+CIJ2f2JRRw2gBdo7rBt98KP9NTBPeexPJaZzLhLNfwzdNBHTWrxfclRtvw6YnMC4Gc7oWFJBo5LO9tZu1nXiB6KLUBV0Uy9d8myh6FZcCRR/a/XOFZ3kFCpGnsYARhVUSQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5DM01vA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5DM01vA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDFA1F000FF;
	Wed, 16 Sep 2026 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566479;
	bh=jzj9ZL+8mXcoP8aFoBkdiE6hbNAgWXgLM86CorPJ/Q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5DM01vA4L9TNDkLKw+gjicpdqOt7uWye4VbwNH7JUqM44Ez+eMYjrnxNgCQjZ2hZ
	 dbCkLEzMZFPDmPxL2uEk81iwDFwRszG/Mvf5OIjmeZWivZYjUEONxqrJ7cwYBeLTAW
	 CCG90TqzKlrkrx8TcAEcW6ivktpEkvrxexSt5UN7/FqzLNx1EUvDVtUTu7z+Rjlqzp
	 6CrXVOnELOY96y2Tz2ImgZCOLtLSBKh7tCWs2Q7xMhE8bnSZMssWKZDz5jGftqgWdS
	 OHgPLUf7aOhMx94N1DNQ/UXoTlNd6HRvXKsL2wV69bf2CsIVpplbzHGvCNqm/Askyj
	 US1MWGrHdaC2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] can: ixxat_usb: add support for USB-to-CAN FD
 and CAN-IDM devices
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260916-ixxat_usb_can-v2-3-9b892e362d9e@peak-system.fr>
References: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
 <20260916-ixxat_usb_can-v2-3-9b892e362d9e@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 13:47:58 +0000
Message-Id: <20260916134759.0DDFA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] can: ixxat_usb: unregister_candev() called on register_candev() fa=
ilure path
- [Medium] can: ixxat_usb: can_fd_idm adapter advertises CAN_CTRLMODE_TDC_A=
UTO without tdc_const
- [Medium] can: ixxat_usb: missing le32_to_cpu() conversion when evaluating=
 device capabilities
--

commit 2f56f582fe161622a9b788d108e941b11e03caad
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
Subject: can: ixxat_usb: add support for USB-to-CAN FD and CAN-IDM devices

This commit introduces the ixxat_usb_cl2.c driver to support the CAN(-FD)
controller operations and bittiming constants for the IXXAT CL2
communication layer. It also wires up the new usb_device_id entries and
driver descriptors in the core. Legacy hardware with newer firmware is
upgraded to use the usb2can_v2 adapter.

> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c b/drivers/net/=
can/usb/ixxat_usb/ixxat_usb_cl2.c
> index 0000000000000..6c08f47915373
> --- /dev/null
> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
[ ... ]
> +static int ixxat_usb_init_ctrl(struct ixxat_usb_candevice *dev)
> +{
[ ... ]
> +	if (exmode) {
> +		cmd.fdr.tdo =3D cpu_to_le16(dev->can.fd.tdc.tdco);

[Severity: Medium]
Will this pass a 0 offset to the device? If the adapter is missing its
tdc_const (as seen below for can_fd_idm), can_calc_tdco() will abort
and leave tdco as 0, which could negate the requested auto delay
compensation functionality on high baud rate CAN FD networks.

> +		cmd.fdr.mode =3D cpu_to_le32(btmode);
> +		cmd.fdr.bps =3D cpu_to_le32(btd->brp);
> +		cmd.fdr.ts1 =3D cpu_to_le16(btd->prop_seg + btd->phase_seg1);
[ ... ]
> +const struct ixxat_usb_adapter can_fd_idm =3D {
> +	.clock =3D IXXAT_USB_CLOCK,
> +	.bt =3D &canidm_bt,
> +	.btd =3D &canidm_btd,
> +	.modes =3D IXXAT_USB_MODES_FD,

[Severity: Medium]
Since IXXAT_USB_MODES_FD includes CAN_CTRLMODE_TDC_AUTO, does this definiti=
on
also need to set .tdc =3D &usb2can_fd_tdc? Without it, the tdc block is left
unconfigured despite advertising the capability.

> +	.buffer_size_rx =3D IXXAT_USBIDM_BUFFER_SIZE_RX,
> +	.buffer_size_tx =3D IXXAT_USBIDM_BUFFER_SIZE_TX,


Looking at ixxat_usb_create_ctrl() in drivers/net/can/usb/ixxat_usb/ixxat_u=
sb_core.c:

> 	if (devdata->caps.features & IXXAT_USB_CAN_FEATURE_LISTONLY)
> 		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_LISTENONLY;
>=20
> 	if (devdata->caps.features & IXXAT_USB_CAN_FEATURE_SSM)

[Severity: Medium]
Does devdata->caps.features need a le32_to_cpu() conversion here? Since
it is a 32-bit little-endian value retrieved from the USB device, evaluating
it directly against host-endian macros could cause the capability checks
to fail on big-endian architectures, preventing the use of features like
listen-only modes.


Also in ixxat_usb_create_ctrl() in drivers/net/can/usb/ixxat_usb/ixxat_usb_=
core.c:

> 	err =3D register_candev(netdev);
> 	if (err) {
> 		dev_err(&intf->dev, "Error %d: Failed to register can device\n",
> 			err);
> 		goto free_candev;
> 	}
[ ... ]
> free_candev:
> 	/* sashiko-bot v1: missing unregister_candev() */
> 	unregister_candev(netdev);
> 	usb_set_intfdata(intf, dev->prev_dev);
> 	free_candev(netdev);

[Severity: High]
Does this crash if register_candev() failed earlier? The error path jumps
here and unconditionally calls unregister_candev() on a network device
that was never successfully registered, which could cause list corruption
and kernel panics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-ixxat_usb_=
can-v2-0-9b892e362d9e@peak-system.fr?part=3D3
