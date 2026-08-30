Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B068C19049B
	for <linux-can@vger.kernel.org>; Sun, 30 Aug 2026 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788094975; cv=none; b=SbBbuJNia6KKKO96KHkyFnJHYWCD/JfXjEQq2pa+9YEzpbW3eQ1XTZog4+mFWJ5c/vAsVUqgP+qj3DRF2KiLjpBAdN1+1/VJmAxvELP7NKP8VQQ0Mxh53glGu6Us4fBHJOu5T9JfJt4r2gUMY34zpWytt/hcg6pa2aiDGvDAsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788094975; c=relaxed/simple;
	bh=AuOibtML9SEnNddmZVyOZLBo8leksJMcLN/88FmowOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dcAgNgMwHNlN+sj1lPG8votb3AV84r+uKxQ0I7T1P/YMVuON8Ag4eThufjky450vsArJOMOjFvqm4EJucikvso1FlO7AZhXuvKYrJS60Vi+oSqeBoCHutrZammoObN2Z5bWdv23PrBAIDkP9zuN/yjwFouQQYwTFt7feXDVkJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kz4SjQ0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kz4SjQ0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A051F000E9;
	Sun, 30 Aug 2026 13:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788094973;
	bh=DnZHKqCw8niGefvhtM/gI9Qp2+82DXwaUyKZrIBEDH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kz4SjQ0NUYtEBXUnD+vGkspNLYRFBuM9f36N9B0Aw1BD3LgVITw+Dtu1it3cGofhp
	 m5oet+qhgydZw+LF2+K5iPdi2NnbMDIpIomaWQAzzJ21PPiCzVvyfJnwWvtZCkrSyx
	 H+CQgNySpFOnmOhlSqgmXUWcFlnimudpV00kdb0T9OeMfbJA9z9QVv5Ckigh6osvR3
	 IH4g6ELJ09d/1oCgKvxykgt+jZ5KSyUg/vU7WlnwCe3lxpr+xD4fdwrqa14CniZqev
	 vqhyIuGtE/BP2rPWvmx06Ny/kl5WptznZ2rwn3xNw+1a2JHluL1PLa7BbcnYC5l7kJ
	 ekAn9y70uPohA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: kvaser_usb: hydra: validate command prefixes
 before parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260830125322.98199-1-pengpeng@iscas.ac.cn>
References: <20260830125322.98199-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 13:02:52 +0000
Message-Id: <20260830130253.16A051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect command length check in `kvaser_usb_hydra_wait_cmd` inco=
rrectly drops valid extended commands.
- [High] Incorrect memory copy source pointer corrupts fragmented command a=
ssembly.
--

commit 1cbbe99543052600da4f97d992d3e51a35e561aa
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

can: kvaser_usb: hydra: validate command prefixes before parsing

The Hydra receive paths derive a command length from the current buffer
before checking that a complete command header is available. This commit
validates the header and extended-length prefix before decoding a command
length.

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/=
net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c

[ ... ]

> @@ -675,8 +699,10 @@ static int kvaser_usb_hydra_wait_cmd(const struct kv=
aser_usb *dev, u8 cmd_no,
>  			size_t cmd_len;
> =20
>  			tmp_cmd =3D buf + pos;
> -			cmd_len =3D kvaser_usb_hydra_cmd_size(tmp_cmd);
> -			if (pos + cmd_len > actual_len) {
> +			err =3D kvaser_usb_hydra_cmd_len(tmp_cmd, actual_len - pos,
> +						       &cmd_len);
> +			if (err || cmd_len > actual_len - pos ||
> +			    cmd_len > sizeof(*cmd)) {

[Severity: High]
Does this cmd_len > sizeof(*cmd) check unintentionally reject valid
extended commands?

Since kvaser_usb_hydra_cmd_len() correctly calculates the length of extended
commands (which can be larger than sizeof(struct kvaser_cmd)), it seems this
check will evaluate to true and trigger a format error when an extended
command arrives, terminating buffer processing prematurely.

>  				dev_err_ratelimited(&dev->intf->dev,
>  						    "Format error\n");
>  				break;

[ ... ]

> @@ -2121,12 +2147,44 @@ static void kvaser_usb_hydra_read_bulk_callback(s=
truct kvaser_usb *dev,

[ ... ]

> +		if (err) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			card_data->usb_rx_leftover_len =3D 0;
> +			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
> +			return;
> +		}
> +
> +		remaining_bytes =3D min_t(unsigned int, len - pos,
>  					cmd_len - usb_rx_leftover_len);
>  		/* Make sure we do not overflow usb_rx_leftover */
>  		if (remaining_bytes + usb_rx_leftover_len >

[Severity: High]
Does the leftover command assembly copy from the wrong source pointer?

The new while loop added just above this snippet can advance pos as it
consumes bytes to complete the command header. However, looking slightly
further down in kvaser_usb_hydra_read_bulk_callback(), the memcpy() copying
the remaining payload still reads directly from buf rather than buf + pos:

    memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len, buf,
           remaining_bytes);
    pos +=3D remaining_bytes;

If pos was advanced by the header completion loop, won't this copy duplicate
header bytes from the beginning of the USB transfer instead of the actual
remainder of the command payload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830125322.9819=
9-1-pengpeng@iscas.ac.cn?part=3D1
