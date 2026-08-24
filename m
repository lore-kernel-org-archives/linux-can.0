Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D1383991
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608426; cv=none; b=PQ+pUF4LaSNlislNsBY2fRnO3YgP/ESK2OCMV3vP900WuPbf50O27BX5hoetd8vWxICN/8gL9fIYOlICX6Am9DsLKcHouffB4zO3MD79PIPkIjgJFJTEWs1WDbpR1YA48X/bv0UO4PtGmrj9msUhbsj4WLW7xdIr2I3GKWTZYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608426; c=relaxed/simple;
	bh=ELK3Vzmcnwq1CPsxTObejNQBNdtbg/vmD1ddU2HAJGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VAQsQXdhpH9dJEQjZBFxEue7SYtlJ6r6MjIcHi3U5srxAkQy0uioe53/s3kKS+x+WkIMLyaR3vfE/DcottJxyt/fDvZMM7hdcdBeKCjGy/3+vtWQvtbQVuD4wy5bCIfgl2iyO3CZEMNaWSeRKk2f/bnzgXHqJnskOp8+WEttrQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkrse/Jg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkrse/Jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5751F000E9;
	Mon, 24 Aug 2026 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608424;
	bh=EvXANji/RT1vIrVl5YlUhSEGC0Tx4VsXd722B0CoxHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fkrse/Jg/BlOMNNtHTqUynn3LgnfYPcetWFarNL/eVt1NEsKAAEYptH6pauFWbAsJ
	 L7A99dDkFFBtgniBwcVmeMMRZAdixr+R5RAwonJEbLv1+zkOp5KXbh6OPd/8R2zpav
	 kJ+L87zLX783U/NOmMNmxPmCR284zu3hxJklPoFtB75zOEJJqqfQSyGrUuYYlVSDks
	 d5pqPIWDgGHsqbmOg6okYHt0CPCqzp8fWlm1WR1XkGJq7SNzNKtVrPK0cntwBC7fHz
	 4p6axq+seog9FHiEw0NTtIwV1QehzBy7ef5fQ0PxPosI5Uga15ekQ64TLtEyaYJMAY
	 oi9+47lreHZdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] can: kvaser_usb: validate command format before
 parsing in hydra receive path
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <blbllhy@gmail.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260824214058.44948-1-blbllhy@gmail.com>
References: <20260824214058.44948-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 21:53:43 +0000
Message-Id: <20260824215344.6D5751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a functional regression where valid fragmente=
d USB streams are treated as format errors and dropped, permanently breakin=
g stream reassembly.

Pre-existing issues:
- [High] The patch fails to validate that the length of a `CMD_EXTENDED` co=
mmand is large enough for its payload, allowing out-of-bounds reads to pers=
ist in the handlers.
--

--- Patch [1]: [PATCH net v2] can: kvaser_usb: validate command format befo=
re parsing in hydra receive path ---
commit 1e011698d1b2d6b5a15d58005d752a57039bcf61
Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>

can: kvaser_usb: validate command format before parsing in hydra receive pa=
th

This patch adds kvaser_usb_hydra_cmd_size_rx() to validate buffer bounds
before reading the command size. It attempts to fix a slab-out-of-bounds
read and an infinite loop when parsing malformed or zero-length CMD_EXTENDED
commands in the receive path.

Link: https://lore.kernel.org/all/20260819145658.29872-1-blbllhy@gmail.com

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/=
net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index efbb7bed34c9d..534bd26830125 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -536,6 +536,20 @@ static size_t kvaser_usb_hydra_cmd_size(struct kvase=
r_cmd *cmd)
>  	return ret;
>  }
> =20
> +/* Receive-path wrapper: validate buffer bounds before reading cmd_size.=
 */
> +static size_t kvaser_usb_hydra_cmd_size_rx(struct kvaser_cmd *cmd,
> +					   size_t remaining)
> +{
> +	if (remaining < sizeof(struct kvaser_cmd_header))
> +		return 0;
> +
> +	if (cmd->header.cmd_no =3D=3D CMD_EXTENDED &&
> +	    remaining < offsetof(struct kvaser_cmd_ext, cmd_no_ext))
> +		return 0;
> +
> +	return kvaser_usb_hydra_cmd_size(cmd);
> +}

[Severity: High]
This is a pre-existing issue, but does this patch completely fix the
out-of-bounds reads for extended commands?

If a malicious USB device sends a CMD_EXTENDED command placed at the end of=
 a
bulk transfer (e.g., 6 bytes remaining at the end of a 3072-byte buffer) and
sets the len field to 6, kvaser_usb_hydra_cmd_size_rx() will pass the bounds
checks and return the device-controlled length of 6.

In kvaser_usb_hydra_read_bulk_callback(), the bounds check:

    if (pos + cmd_len > len)

will pass (3066 + 6 > 3072 is false). The command is then passed to
kvaser_usb_hydra_handle_cmd_ext(), which reads cmd->cmd_no_ext at offset 6
(out of bounds).=20

If the command maps to CMD_RX_MESSAGE_FD, kvaser_usb_hydra_rx_msg_ext()
accesses cmd->rx_can.kcan_header at offset 20, causing a slab out-of-bounds
read that can be copied into a CAN frame payload and leaked to userspace.

Should there be an additional check to enforce that the returned cmd_len is
large enough to contain the extended struct payload?

> [ ... ]
> @@ -2154,7 +2178,11 @@ static void kvaser_usb_hydra_read_bulk_callback(st=
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

[Severity: High]
Does this change break USB stream reassembly for valid fragmented commands?

Before this patch, if a standard command had only 2 bytes remaining at the =
end
of a URB, kvaser_usb_hydra_cmd_size() would determine it was not CMD_EXTEND=
ED
and return sizeof(struct kvaser_cmd).

Those 2 bytes were then safely buffered in usb_rx_leftover and successfully
reassembled when the next URB arrived.

With this patch, kvaser_usb_hydra_cmd_size_rx() returns 0 if remaining < 4.
This causes the main loop in kvaser_usb_hydra_read_bulk_callback() to log
"Format error" and return immediately, discarding the fragment and permanen=
tly
desynchronizing the command stream.

> =20
>  		if (pos + cmd_len > len) {
>  			/* We got first part of a command */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824214058.4494=
8-1-blbllhy@gmail.com?part=3D1
