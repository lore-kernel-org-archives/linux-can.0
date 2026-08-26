Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7249363A
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708997; cv=none; b=OQc8tV0r0ar1U2Z397ubZazb7q3BxejULbZ/LGj7/pedXqC6l41fgRxL4+JC0Gd9Ch8Nw6MWSeQXVA4tvupkx5gSuHwWP9jGeqzibEcrgF+9XD74FWjq2ceK5+CDloFGSacRP4z+6l/EIVYXKqBXMpxug+XFX+qN89+/Wg9dRT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708997; c=relaxed/simple;
	bh=VM5EYIyhjTFnlYIMREzUSbaZdeSdbzLK9rHdZo0/ewg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CTwkFWifHAEdHmq7VIyhABeJ7JUsFTixbn3wMhTjhDIs1z4fts9hpRJCi7UnaMPefLKwjcf27jGmCz/RUdDKPQYw5P41RinGtiXnfj1c/qj+9zQ0HQDI8AuVRHUO23aTd56d5npPDj2982h9Mq6mT9qrTQV/w8RemPBAfIDxyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVC7c3Ov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVC7c3Ov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ECE1F000E9;
	Wed, 26 Aug 2026 01:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787708996;
	bh=sJFqQaJpDVWHuEJThtIUTwLLNzIYF/BBtZwCFcVh1EQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NVC7c3Ov1N80J2TfetqSTEDE43gaxxCVIyLtg4lkUmhXODoqxqi15DylIrrWoCVE/
	 6/EWcsx0udXFLIsHZA4yV7cCLiqHZZHv4d52J2Ed8Ds53XkKtDBZZTcXMV4UKtIhKH
	 IHtqTyTRyPfOGCGaete5kJUQkPRSi01rfQgP1AzeMpDsE0KF5OSCBGD3BeMxAwkUOC
	 pntz47qu/bKbftJRuB90ZKxqqdXbdLlXIkoziYoE6kd30OaUnZObbuIjTK1/lOBLFK
	 3XO2ng6qwj4RwXNJ8N/yZapPE9Cs970KMsBCztF4af+clu//NC4Fnsn0J1lwf5GGkJ
	 9Gs74n2Y1L9Pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] can: kvaser_usb: validate command format before
 parsing in hydra receive path
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <blbllhy@gmail.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260826013037.6933-1-blbllhy@gmail.com>
References: <20260826013037.6933-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 01:49:55 +0000
Message-Id: <20260826014955.B9ECE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents an OOB read of the `cmd->len` field but fails t=
o enforce a minimum payload length for the extracted `cmd_len`, allowing ma=
liciously truncated commands to bypass buffer bounds checks and cause slab-=
out-of-bounds reads in downstream handlers.
--

commit 25501dc93a8df5ec40c88edcab68f9d2a1cded89
Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>

can: kvaser_usb: validate command format before parsing in hydra receive pa=
th

The receive-path command parsers call kvaser_usb_hydra_cmd_size() without
verifying that enough buffer remains. This patch adds
kvaser_usb_hydra_cmd_size_rx() to check whether the size field is complete
before reading it and rejects zero command lengths.

Link: https://lore.kernel.org/all/20260819145658.29872-1-blbllhy@gmail.com

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/=
net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index efbb7bed34c9d..eddd207ee8daa 100644
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
This is a pre-existing issue, but does kvaser_usb_hydra_cmd_size_rx() need =
to
enforce a minimum payload length for the extracted cmd_len based on the
command type?

If a malicious USB device sends a CMD_EXTENDED packet with an artificially
small length (for example, 8), this function will extract that small length
without validating it against the actual structure size.

[ ... ]

> @@ -2154,9 +2204,13 @@ static void kvaser_usb_hydra_read_bulk_callback(st=
ruct kvaser_usb *dev,
>  	while (pos < len) {
>  		cmd =3D buf + pos;
> =20
> -		cmd_len =3D kvaser_usb_hydra_cmd_size(cmd);
> +		err =3D kvaser_usb_hydra_cmd_size_rx(cmd, len - pos, &cmd_len);
> +		if (err && err !=3D -EAGAIN) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			return;
> +		}
> =20
> -		if (pos + cmd_len > len) {
> +		if (err =3D=3D -EAGAIN || pos + cmd_len > len) {

[Severity: High]
This is a pre-existing issue, but because the extracted cmd_len is
artificially small, the buffer bounds check in
kvaser_usb_hydra_read_bulk_callback():

    if (err =3D=3D -EAGAIN || pos + cmd_len > len) {

can pass when the packet is placed at the end of the URB buffer.

Downstream handlers like kvaser_usb_hydra_rx_msg_ext() will then read fields
at fixed offsets far exceeding this length, for instance:

    kcan_header =3D le32_to_cpu(cmd->rx_can.kcan_header);

at offset 20, or:

    memcpy(cf->data, cmd->rx_can.kcan_payload, cf->len);

at offset 32. Can this cause a slab-out-of-bounds read past the end of the =
USB
URB buffer?

>  			/* We got first part of a command */
>  			int leftover_bytes;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826013037.6933=
-1-blbllhy@gmail.com?part=3D1
