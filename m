Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D250C2A3
	for <linux-can@vger.kernel.org>; Wed, 16 Sep 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566578; cv=none; b=K3KkUurJXpDdmriMvG9OkarIem90RzB5YW9IxEnLY9qfcfSufeOdGZ2WaMiw06nH9PIqucg5V5E3JWL/jvl/4RC8lUWI6FzLrM8Sfa5Dv2V/+xOuaREHDZ6KDWTVOz+qoUXn9LznQH/+jGN3Dlh5mulKsC8XJu1jvUMUKgmZeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566578; c=relaxed/simple;
	bh=Q9yy7Q3dY59TT23eJ7TqwkqHpkz+w+1Zcvk9FCMMNGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HFAYPyV+/I5NI0ltTTK9AGrIqAgqikEUeeainU/+GX7dY6QxMjLoY5TYm2hLfOOZjwaVGfXsZBfvW9dlNhIn7nkkHvXB/awytNU1NDlvUzUejM6opDl8XreFPyc+13G/aPgP1aQlVXg5bNIUOrJg0MIU4GWaA4EeZkNBGNy/SEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/4tthaZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/4tthaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B81F000FF;
	Wed, 16 Sep 2026 13:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566571;
	bh=F9gAjiqipY2j2l8vY64mss1QEcCdu/6ekkTH9sMghuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j/4tthaZ4JHLFAEBOurD2vDyvR2DmH8nQ3rbsrlcswTcaIzBXlQKdAeO8owD/U2HR
	 Xf25P9L8CAud34o/agrngQwPwzf1tI/K/vnhIcFj7jGi+BRkdnzzqbSLUDmkLcLZih
	 Nl/yDnh7M2g+3EKZ/ztbSUs/AM19LVqQaHIFpBTp+0g9ct4Ui5zhR1jlfYHloGl9sX
	 RrOtQ3jZvHdpg+eSP1Sce19wpfQHkpCw1KiDjFej2yBnXIwqQNBleSgoFk+iA3yCf9
	 F+8cNKdbUo+HjyMWPi7apG8cLB1AasTZVGa+tXt8krpFc0NdMqK+LYMM4KPCfaMvMU
	 592aem3IR+FeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] can: ixxat_usb: add support for USB-to-CAN CL1
 (V2) devices
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260916-ixxat_usb_can-v2-2-9b892e362d9e@peak-system.fr>
References: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
 <20260916-ixxat_usb_can-v2-2-9b892e362d9e@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 13:49:30 +0000
Message-Id: <20260916134930.BB8B81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: ixxat_usb: FORTIFY_SOURCE panic due to field-spanning memcpy
--

commit 8f14df1317ca74accd08abf72e9dcfad2f429804
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: ixxat_usb: add support for USB-to-CAN CL1 (V2) devices

This commit introduces support for the IXXAT USB-to-CAN CL1 communication
layer, used by the legacy USB-to-CAN compact/embedded/professional family.
It wires up the corresponding device entries and control caps.

> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c b/drivers/net/=
can/usb/ixxat_usb/ixxat_usb_cl1.c
> new file mode 100644
> index 0000000000000..61d1f5dc44075
> --- /dev/null
> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c

[ ... ]

> +static int ixxat_usb_get_ctrl_caps(struct ixxat_usb_candevice *dev,
> +				   struct ixxat_cancaps2 *caps)
> +{
> +	struct ixxat_usb_getcaps_cl1_cmd cmd =3D { 0 };
> +	const u16 port =3D dev->ctrl_index;
> +	const u32 req_size =3D sizeof(cmd.req);
> +	const u32 rcv_size =3D sizeof(cmd) - req_size;
> +	const u32 cmd_size =3D req_size + sizeof(cmd.res);
> +	int err;
> +
> +	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
> +	cmd.req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_GETCAPS);
> +	cmd.req.port =3D cpu_to_le16(port);
> +	cmd.res.res_size =3D cpu_to_le32(rcv_size);
> +	memset(&cmd.caps, 0, sizeof(cmd.caps));
> +
> +	err =3D ixxat_usb_send_cmd(dev, port,
> +				 &cmd.req, cmd_size,
> +				 &cmd.res, rcv_size,
> +				 IXXAT_USB_CMD_TIMEOUT);

[Severity: High]
Does this cause a fortify bounds check panic when the payload is copied?

Since we are passing strongly-typed pointers to the .req and .res fields,
but passing sizes (cmd_size =3D 24, rcv_size =3D 48) that exceed those fiel=
ds
(which are only 12 bytes), the memcpy() inside ixxat_usb_send_cmd_internal()
will fail the bounds check on __member_size(p).

When the kernel is compiled with fortify bounds checking, copying 48 bytes
into a 12-byte struct field will trigger a runtime panic. Is there a way to
pass a pointer to the outer cmd object, or use a flexible array to avoid the
strict bounds check?

[ ... ]

> +static int ixxat_usb_init_ctrl(struct ixxat_usb_candevice *dev)
> +{
> +	struct ixxat_usb_init_cl1_cmd cmd =3D { 0 };
> +	const u16 port =3D dev->ctrl_index;
> +	const u32 rcv_size =3D sizeof(cmd.res);
> +	const u32 cmd_size =3D sizeof(cmd);
> +	const struct can_bittiming *bt =3D &dev->can.bittiming;
> +	u8 opmode =3D IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STANDARD;
> +	u8 btr0 =3D ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
> +	u8 btr1 =3D ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
> +		  (((bt->phase_seg2 - 1) & 0x7) << 4);

[ ... ]

> +	ixxat_usb_setup_cmd(&cmd.req, &cmd.res);
> +	cmd.req.size =3D cpu_to_le32(cmd_size - rcv_size);
> +	cmd.req.code =3D cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
> +	cmd.req.port =3D cpu_to_le16(port);
> +	cmd.mode =3D opmode;
> +	cmd.btr0 =3D btr0;
> +	cmd.btr1 =3D btr1;
> +
> +	return ixxat_usb_send_cmd(dev, port,
> +				  &cmd.req, cmd_size,
> +				  &cmd.res, rcv_size,
> +				  IXXAT_USB_CMD_TIMEOUT);

[Severity: High]
Similarly here, passing a pointer to the 12-byte .req field but using a=20
cmd_size of 28 bytes violates the object boundary of cmd.req.=20

Does this also trigger a fortify bounds check panic when the device is prob=
ed
and the CAN controller is initialized?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-ixxat_usb_=
can-v2-0-9b892e362d9e@peak-system.fr?part=3D2
