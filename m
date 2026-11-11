Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423284;
	b=itWEs5xKQptiefi8Ard+rN/Uj8jgpcpmp1fw/5BP0bCKncV2hDH6hgmolP+H3NUoDfVU
	 AWB9lJNcIpLEiA4Uhy9ePGRir2PA9BqyvzZsTMpb5Rxcw67rWLZE2pkwkv8D0RWQfIzNH
	 Mll6Ib1meyex6MSw6+2ipr19/d9qfoD4LuteJfdQBZJXo50GdpBNvGnXropGrqobzEiqg
	 UBXozcMnerW71ochUp1P6VQSSLCJ4Pgatiu1dtBymPV53PG7Xb4KyCw34mzJGwUAZ1yXd
	 dIlxhbUa+nQZrqNoCS6rSCB74WghY8U2vMZwDimpI1rtHU/5nGIS2TwYCXlNEs2r5NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vY+O8PzHjlLsZFJ64pYuT7MRIZ/KUmM6riFyf5APzbE=;
	b=3kgz6cirBetLhDrAT+Qixn9FnjUQvFP/A4YZ7gmz5N2bJHHJzBZAklwEJRdvxtD7FA2I
	 hIbZLJXrzsfQhs9YIHZ+YqWWH2gX7JaX6A+gnC9ctXT6e7uhMzrnKWNdqtlVx7NlU8FdF
	 I+dyFBffzhfuVHxz40tknTdeukKxVwdH5pC9VWAJ5vOmV5JYpU4pzyeaCKSvQej2KjTUr
	 r0hIg05tAXakAOKUT4VrancUyOM6utJ1OJRZLLh84sSHzn7KSHKFJEC9hsDfwpBsi3KX1
	 tKVoAggmgOO/SuO/91qbOMlR4jCuGKFc72U4wL5jZNvx8IRmjh9JUgMYNUEsB02DZvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZGgcReI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D75606A321
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZGgcReI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944D81F00A05;
	Wed, 11 Nov 2026 18:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423283;
	bh=vY+O8PzHjlLsZFJ64pYuT7MRIZ/KUmM6riFyf5APzbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JZGgcReIvlkedRVUY/VuSkyhg4d3o47PDCD640813I06b4GpLmt+JheGbUMTX/DO+
	 rJ6Uyi+ahVZGS+CkkHOgGo9a8YNu1h9Vi0HJy/vLB0zYkVosyAignsMeYAozDWUZQz
	 mSCr3bON0ifcmPJUkUrQzSWcFTRkwxowzXsksx02U1AfPwyWkKMmiATAqeRzoseQxH
	 5Q/cObK5WaQBZwZ3sDcvRgPrjuf3SVtLbaxp2/sAH0Fho12vM02/CTs94jiPBzY0GQ
	 dEr2FFo3LD+QTZWBW+Yp9HBsLfD4csIDJ8089GrSFgpuvg4u127PDxzSY3WsMBVrS8
	 GOU2hm1K7WJOA==
Message-ID: <sashiko-outbox-209507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] can: kvaser_usb: hydra: reject commands shorter
 than a standard command
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joas Antonio dos Santos" <joasantonio108@gmail.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261111-kvaser-usb-validate-v2-1-193dc10ca19b@gmail.com>
References: <20261111-kvaser-usb-validate-v2-0-193dc10ca19b@gmail.com>
 <20261111-kvaser-usb-validate-v2-1-193dc10ca19b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 18:54:43 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] can: kvaser_usb: hydra: out-of-bounds read in
  kvaser_usb_hydra_cmd_size()
- [Medium] can: kvaser_usb: hydra: out-of-bounds read in
  kvaser_usb_hydra_rx_msg_ext()
--

commit a4f2c83cb489ac1c24979859f6f3261cc4e94f0f
Author: Joas Antonio dos Santos <joasantonio108@gmail.com>

can: kvaser_usb: hydra: reject commands shorter than a standard command

This commit rejects commands whose length is smaller than sizeof(struct
kvaser_cmd) in kvaser_usb_hydra_wait_cmd() and
kvaser_usb_hydra_read_bulk_callback().

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/=
net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index 687911d764ded..9adb4eb36e394 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -676,7 +676,8 @@ static int kvaser_usb_hydra_wait_cmd(const struct kva=
ser_usb *dev, u8 cmd_no,
> =20
>  			tmp_cmd =3D buf + pos;
>  			cmd_len =3D kvaser_usb_hydra_cmd_size(tmp_cmd);
> -			if (pos + cmd_len > actual_len) {
> +			if (cmd_len < sizeof(struct kvaser_cmd) ||
> +			    pos + cmd_len > actual_len) {
>  				dev_err_ratelimited(&dev->intf->dev,
>  						    "Format error\n");
>  				break;

[Severity: Medium]
Can kvaser_usb_hydra_cmd_size() read past the received bytes in buf when
fewer than offsetofend(struct kvaser_cmd_ext, len) (6) bytes remain?

When tmp_cmd->header.cmd_no is CMD_EXTENDED, kvaser_usb_hydra_cmd_size()
reads ((struct kvaser_cmd_ext *)cmd)->len at byte offsets 4..5 before
checking how many bytes are left in the transfer.  If a full
KVASER_USB_RX_BUFFER_SIZE transfer ends with 1..5 trailing bytes and the
first byte is CMD_EXTENDED, this reads up to 4 bytes past the end of buf.

In kvaser_usb_hydra_read_bulk_callback(), a valid extended command split
across two URB transfers with fewer than 6 bytes in the first transfer
also reads unreceived bytes from buf[pos + 4..5] to compute cmd_len,
either tripping the new cmd_len < sizeof(struct kvaser_cmd) check or
saving fewer than 6 bytes into card_data->usb_rx_leftover, where the next
callback calls kvaser_usb_hydra_cmd_size() before the rest of the header
is copied in and without checking cmd_len < sizeof(struct kvaser_cmd).

> @@ -2156,6 +2157,11 @@ static void kvaser_usb_hydra_read_bulk_callback(st=
ruct kvaser_usb *dev,
> =20
>  		cmd_len =3D kvaser_usb_hydra_cmd_size(cmd);
> =20
> +		if (cmd_len < sizeof(struct kvaser_cmd)) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			return;
> +		}
> +
>  		if (pos + cmd_len > len) {
>  			/* We got first part of a command */
>  			int leftover_bytes;

[Severity: Medium]
Does checking cmd_len < sizeof(struct kvaser_cmd) prevent
kvaser_usb_hydra_rx_msg_ext() from reading past the end of cmd and buf?

In struct kvaser_cmd_ext, the fixed fields of rx_can end at byte 32, and
the union holding err_frame_data and kcan_payload[64] starts at byte 32:

drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:kvaser_usb_hydra_rx_msg_e=
xt() {
	...
	if (flags & KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME) {
		kvaser_usb_hydra_error_frame(priv, &cmd->rx_can.err_frame_data,
					     hwtstamp);
		return;
	}
	...
	if (flags & KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME) {
		cf->can_id |=3D CAN_RTR_FLAG;
	} else {
		memcpy(cf->data, cmd->rx_can.kcan_payload, cf->len);

		stats->rx_bytes +=3D cf->len;
	}
}

A CMD_RX_MESSAGE_FD command with cmd_len =3D=3D 32 passes this check, after
which kvaser_usb_hydra_rx_msg_ext() reads err_frame_data or copies up to
64 bytes from cmd->rx_can.kcan_payload (depending on the DLC in
kcan_header) past the end of the command and potentially past the end of
buf into the skb.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-kvaser-usb=
-validate-v2-0-193dc10ca19b@gmail.com?part=3D1
