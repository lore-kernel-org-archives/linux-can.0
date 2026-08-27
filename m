Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7444062D
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832657; cv=none; b=fo+Q4X7UTDaLswc0qXQgIXfreNsGA+9JLNOQCoZpCUxEnizQCwtscEBDGSznJJVUrAZSp6zH1YDB9qrFze4U3/Vn1zVtIN8xW3KPj6jPNbfClcDNeEhTPqci/S3p1a/9R1x8Z7D9IHy0IcTM8c27ETGLonZGzktRAUA/4wmT+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832657; c=relaxed/simple;
	bh=5hM8TqaNf2ZW7/nDgz68fmMN6xxOjTSONwG0hAneQVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=najC7poJM5BhBm+RLs31EtT5SOpxz/vIumXsn2PsMI0a96aP15hRmsA9HE8hBPnR9tEeTXoeY11stBZuRc9puZT5O697rt3CpZQ9U1OkBPCyKLtTi+dtq7/RzU8p2Z7/VSWbMt4E1P8mkVEL/xVoDAB16XJCt3juFRwUT2enX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+vzyn6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+vzyn6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF51F000E9;
	Thu, 27 Aug 2026 12:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832656;
	bh=R+dYUaub5D0+zzLQOAqiX7DN4Jer19TZUosFVBnwCfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+vzyn6+nvwGK0r7O4R3QDwCytNq5OX7d47CsaH134BXE2FshKVljgT5umPWiLBfB
	 5x12N3v9Uc/I9v8Yhc8MQqEBft+kpxbBnBDcZhRSaPkUsjmEE9HlpwM6dX7alQXmzu
	 SgIJLXAXRsTy9wWbGIsRPGQIwPeZXOLElFWj09J2XXgDgP6F+fIJr7hfFcCGhW4rsw
	 SlWw10MIpvAR0AIVXar2S8f+AIzMX49wZPQ02ZBM3zSF6lmT6/zpfp2HDC3uNVgNrz
	 QYIZHpSZwc40qVDffAheCFHZy1uBIo13ekTCShnlL9wYdPDWH9kJmbkSzY5h3gSIpp
	 NClWauEE9DGsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 12/14] can: kvaser_usb: validate command format
 before parsing in hydra receive path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260826121036.2706424-13-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-13-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:10:55 +0000
Message-Id: <20260827121055.E1EF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch prevents a specific out-of-bounds read of `cmd->len` by =
verifying at least 6 bytes are available, but it fails to enforce a safe mi=
nimum structural length for extended commands. A malicious USB device can p=
rovide a trivially small `cmd->len` (e.g., 8), bypassing the buffer boundar=
y checks in the parser and leading to severe slab-out-of-bounds reads in do=
wnstream command handlers.

Pre-existing issues:
- [Critical] Missing validation of the `echo_index` sentinel value allows a=
 malicious USB device to trigger a slab-out-of-bounds read and an arbitrary=
 kernel pointer write, leading to potential privilege escalation.
--

commit 36da6d5bcb0fd8b842d165066e47c1ff8b40c308
Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>

can: kvaser_usb: validate command format before parsing in hydra receive pa=
th

This commit adds bounds checking for command formats in the kvaser_usb hydra
receive path. It aims to prevent a slab-out-of-bounds read caused by malici=
ous
USB devices sending truncated headers or zero-length commands.

Link: https://patch.msgid.link/20260826013037.6933-1-blbllhy@gmail.com

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/=
net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index efbb7bed34c9d..efe7b3ef489bf 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -536,6 +536,24 @@ static size_t kvaser_usb_hydra_cmd_size(struct kvase=
r_cmd *cmd)
>  	return ret;
>  }
> =20
> +/* -EAGAIN means incomplete; -EINVAL rejects zero to ensure progress. */
> +static int kvaser_usb_hydra_cmd_size_rx(struct kvaser_cmd *cmd,
> +					size_t remaining, size_t *cmd_len)
> +{
> +	if (remaining < sizeof(cmd->header.cmd_no))
> +		return -EAGAIN;
> +
> +	if (cmd->header.cmd_no =3D=3D CMD_EXTENDED &&
> +	    remaining < offsetof(struct kvaser_cmd_ext, cmd_no_ext))
> +		return -EAGAIN;
> +
> +	*cmd_len =3D kvaser_usb_hydra_cmd_size(cmd);
> +	if (!*cmd_len)
> +		return -EINVAL;

[Severity: High]
Does this length validation allow maliciously small extended commands?

While this prevents cmd_len from being 0, it allows trivially small values
(e.g., 8 bytes). If a malicious device places an 8-byte extended command at
the very end of a 3072-byte USB bulk transfer, kvaser_usb_hydra_cmd_size_rx=
()
will return 0 and set cmd_len to 8. Because pos + 8 =3D=3D len, the overarc=
hing
boundary check in the parser will pass, handing the 8-byte command to
kvaser_usb_hydra_handle_cmd().

Downstream handlers like kvaser_usb_hydra_rx_msg_ext() then blindly access
payload fields extending far beyond 8 bytes (such as cmd->rx_can.kcan_header
at offset 20). Does this code read out-of-bounds of the 3072-byte heap
allocation?

> +
> +	return 0;
> +}
> +
>  static struct kvaser_usb_net_priv *
>  kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
>  				   const struct kvaser_cmd *cmd)

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a pre-existing issue where an unvalidated echo_index can lead to
an out-of-bounds read and arbitrary memory corruption.

In kvaser_usb_hydra_tx_acknowledge():

	u16 transid =3D kvaser_usb_hydra_get_cmd_transid(cmd);
	...
	context =3D &priv->tx_contexts[transid % dev->max_tx_urbs];
	...
	skb =3D priv->can.echo_skb[context->echo_index];
	if (skb)
		skb_hwtstamps(skb)->hwtstamp =3D kvaser_usb_hydra_ktime_from_cmd(dev->cfg=
, cmd);

When a TX context is free (or newly initialized), context->echo_index is
set to the sentinel value dev->max_tx_urbs:

	context->echo_index =3D dev->max_tx_urbs;

If a malicious USB device sends a spoofed CMD_TX_ACKNOWLEDGE with a transid
matching a free TX context, this code directly indexes priv->can.echo_skb
using dev->max_tx_urbs.

Since echo_skb is placed exactly at the end of the net_device memory block
(via alloc_candev_mqs), an index of max_tx_urbs reads 8 bytes of garbage
from the subsequent kernel slab object.

If the read value is non-NULL, the driver dereferences it and writes a
64-bit timestamp derived from the attacker-controlled USB packet into memor=
y.
Can this be triggered by a malicious USB device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.2706=
424-1-mkl@pengutronix.de?part=3D12
