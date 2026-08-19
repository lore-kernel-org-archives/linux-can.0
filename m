Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE9339398
	for <linux-can@vger.kernel.org>; Wed, 19 Aug 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152228; cv=none; b=hiMq7yKOE/ARnzYBy0pV0pKXsVVJreathqT0SZVFkA31aKvCWRS9lqmuLr0J56shni/bAhe4I0TBl5lq/8tyriBuchOIZI30qezsYlWLqO2R/WXt6iHf+poCixFk7TEidZ4N0qeAoskbLtRhK1ScaCY5zhSEF4PUDc0Q7hE1ENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152228; c=relaxed/simple;
	bh=O3FCH0k908ncrZEvg57C7ySRA2tDes0S10pDYDnklaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pUgdbtWU0k1q02LenrYEytbY3rMgIdXU0rEvOF8DPQ0QJDFt87yuKNn46LwzjZwBtbOyjDcOg5zs4f8xd2pqGw+H+zrv70tzXzzkl7EauRSL//Y24DTOtRvK7T3Cw9ottrHPswgEDKKVJ2zPZ0qigocGnXUezfnm/9fNe0dtlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSBS2xWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSBS2xWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9296F1F000E9;
	Wed, 19 Aug 2026 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787152226;
	bh=4eSzJ+KT5ewtJD9Q51Exo5eTmobSYz7uwpIKG50obeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LSBS2xWTuAF0My2Ap1D6iWcSia7sSolkHBQ0TQQQueGZGVfWTIBipTZ+DRtXY03xF
	 fIqhttG2dySkW/0UJ+cHtg2khmpjTvlDZjXRcl+0KOitYYq69JmHRMWt3E3h+t/ygs
	 zlDtQtizK942Sn5zhPR8pWxNSMCrQ8T50TPQ+9eKqhuXPoCh4mOH85tQPT3F+eg09J
	 qXGDZxPTRh00LpeyV9QYA1I/kgcfjgAW7WTjo5HvAN+9u8+pfpKtUA0yap4hNWMveT
	 Agx1p5OFr9doH8DHi+vyn6IRtL6XScrNYVDPmstStifhMmI8+NH2wpI0ItEIwIITrZ
	 rmuPU977O897g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: kvaser_usb: validate command format before
 parsing in hydra receive path
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <blbllhy@gmail.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260819145658.29872-1-blbllhy@gmail.com>
References: <20260819145658.29872-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 15:10:26 +0000
Message-Id: <20260819151026.9296F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing structural minimum length validation for CMD_EXTENDED payl=
oads allows slab-out-of-bounds reads and potential kernel memory leaks.
- [High] Leftover buffer parsing errors fail to reset the buffer state, cau=
sing a permanent denial of service on the CAN interface.
--

--- Patch [1]: [PATCH net] can: kvaser_usb: validate command format before =
parsing in hydra receive path ---
commit 656b69d0272cad412a6756864385d2b4307a6e5f
Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>

can: kvaser_usb: validate command format before parsing in hydra receive pa=
th

This patch addresses slab-out-of-bounds reads and infinite loops in the
kvaser_usb hydra receive path. It introduces a receive-path wrapper,
kvaser_usb_hydra_cmd_size_rx(), to validate buffer bounds before reading
the command size.

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/=
net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index efbb7bed34c9d..a964edde5783c 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c

[ ... ]

> @@ -2124,7 +2139,14 @@ static void kvaser_usb_hydra_read_bulk_callback(st=
ruct kvaser_usb *dev,
> =20
>  		cmd =3D (struct kvaser_cmd *)card_data->usb_rx_leftover;
> =20
> -		cmd_len =3D kvaser_usb_hydra_cmd_size(cmd);
> +		cmd_len =3D kvaser_usb_hydra_cmd_size_rx(cmd,
> +						       KVASER_USB_HYDRA_MAX_CMD_LEN);
> +
> +		if (!cmd_len) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
> +			return;
> +		}

[Severity: High]
This is a pre-existing issue, but do these error paths need to reset
usb_rx_leftover_len to 0?

When an error is detected here (or in the subsequent pre-existing overflow=
=20
check in kvaser_usb_hydra_read_bulk_callback), the code logs a format error,
drops the lock, and returns, but it fails to reset
card_data->usb_rx_leftover_len to 0.

On the next USB IN transfer, the non-zero leftover length forces execution =
back
into the leftover parsing block. The logic evaluates the exact same corrupt=
ed
command buffer, fails the exact same error check, and returns again.

Can this permanently wedge the parser and cause a denial of service on the =
CAN
interface?

[ ... ]

> @@ -2154,7 +2176,11 @@ static void kvaser_usb_hydra_read_bulk_callback(st=
ruct kvaser_usb *dev,
>  	while (pos < len) {
>  		cmd =3D buf + pos;
> =20
> -		cmd_len =3D kvaser_usb_hydra_cmd_size(cmd);
> +		cmd_len =3D kvaser_usb_hydra_cmd_size_rx(cmd, len - pos);
> +		if (!cmd_len) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			return;
> +		}
> =20
>  		if (pos + cmd_len > len) {
>  			/* We got first part of a command */

[Severity: High]
This isn't a bug introduced by this patch, but does the parser loop trust=20
cmd_len (derived from the attacker-controlled cmd->len field) without
validating that it meets the minimum structural size expected by the command
handler?

For example, if a device claims a length of 8, the parser only ensures 8 by=
tes
are present. The command is then dispatched to handlers like=20
kvaser_usb_hydra_rx_msg_ext(), which unconditionally read fields at fixed
offsets far beyond the claimed length:

drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:kvaser_usb_hydra_rx_msg_e=
xt()
    ...
    kcan_header =3D le32_to_cpu(cmd->rx_can.kcan_header);
    dlc =3D (kcan_header & KVASER_USB_KCAN_DATA_DLC_MASK) >>
        KVASER_USB_KCAN_DATA_DLC_SHIFT;
    ...
    memcpy(cf->data, cmd->rx_can.kcan_payload, cf->len);

Could this result in a slab-out-of-bounds read and potential kernel memory =
leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819145658.2987=
2-1-blbllhy@gmail.com?part=3D1
