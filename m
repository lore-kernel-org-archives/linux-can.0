Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283685;
	b=WF+v5472vF+qITybMZ7VdPe7Aj3Lc5r/T9ccK32h/2rxJnjfbKNYAf3bAL4HWvCkY2LH
	 WUSQSadhWltNiPF1GwFETo824lIFkegrJKnCSGzAaIOeoSzcvYPX7guQtLOW45M5iXhju
	 cEOG9z0ba64LKt4Bu1mFzlq1mARXgvOef+qzIXeLpDsyF1o2Z7UvDB7FzYBbeiwSjH59R
	 GYyaapfgApbtVfaBUXKyJj9Lnbf2mVDRcYSE28sqrk0GBNA7LE16wTNHfJi22ngzRjZMO
	 iiPVpFE6Rwy3r4T7+0JDMrvq32FFniANuiEMt9AfYrAVUC+VbDniCXyyukSQnOVmSGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UMlFrJQFjgrD4fVQXRmgs4/95Zb/Oeeir61l5NqojoM=;
	b=IHHUN62k0AwbiY7NNcdV9MOsT8zbB17o2GBOiiF/WcJU1L16S81gF/HnCvU9ulQRsi9L
	 5CvcPqJ75MnQoUgorOjwZwZtvH786KS8Pad1RTesznlLf/WuM7ELfb6k3+W7Yww4e2WHa
	 GY01xrJB2iKGB3FO8nPFu0dx6t9TuKg85VDfxGRebCZ4TgurIyC4scx2qmSX3lGUcZXJV
	 wXefUSYGEyh1smCcoJMMXEFJH62ZeRlwlN//OH8aaKe+MzEvfff3C93ttWQpDE9zuzV51
	 hYR98spigNHOLGGvoZDkcxA1q/Q8zPgS1KITEs9BaweP8xYWiwgma40TOoh4IRN+wMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHz+H9Jl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED5606A31C
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AHz+H9Jl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA9B1F0089F;
	Tue, 10 Nov 2026 04:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283685;
	bh=UMlFrJQFjgrD4fVQXRmgs4/95Zb/Oeeir61l5NqojoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AHz+H9JlMKnmU1RVrGOIwBDBnrfh2vV19WgM1wMc48RF2ocsGHUoUvhhOQ82SIzar
	 BS33Z4ZzbXuCI8Ntp8MisFlDeLlZRa4h3szL5x8ocfnzcZ+wbinhTQC+ZcYFpEV9V1
	 uIvOkn9Bc1dwZ9vUzfELTnCpDkN3LOvvGLEoiP6w87NoUakJYOk1fG+Q0oIe9BxT5Z
	 HxWysD8vYTIvT7AXQ/5AsYeS/6vz1Qxrt3GUe+NEBSxkfpJhlGOd1C1Mcp5orcp+AS
	 Ogwkl8gAuc4iRI8Tac6Pj2EYMnIVRwc5LyAMo3EznZ3efywdBGSOEyehC5JYoBIsXf
	 /35aDyP2+/lqg==
Message-ID: <sashiko-outbox-206169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] can: kvaser_usb: hydra: reject commands shorter
 than the header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joas Antonio dos Santos" <joasantonio108@gmail.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261110-kvaser-usb-validate-v1-1-f266b85aa908@gmail.com>
References: <20261110-kvaser-usb-validate-v1-0-f266b85aa908@gmail.com>
 <20261110-kvaser-usb-validate-v1-1-f266b85aa908@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:08:04 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: kvaser_usb: incomplete extended cmd_len check in hydra
  parsers
--

commit a17f31efe99f81a18058ca235af35d386b0380de
Author: Joas Antonio dos Santos <joasantonio108@gmail.com>

can: kvaser_usb: hydra: reject commands shorter than the header

This commit adds a minimum command length check against
sizeof(struct kvaser_cmd_header) in kvaser_usb_hydra_wait_cmd() and
kvaser_usb_hydra_read_bulk_callback() to prevent infinite loops on
zero-length extended commands.

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/=
net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index 687911d764ded..92bfdcb04b019 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -676,7 +676,8 @@ static int kvaser_usb_hydra_wait_cmd(const struct kva=
ser_usb *dev, u8 cmd_no,
> =20
>  			tmp_cmd =3D buf + pos;
>  			cmd_len =3D kvaser_usb_hydra_cmd_size(tmp_cmd);
> -			if (pos + cmd_len > actual_len) {
> +			if (cmd_len < sizeof(struct kvaser_cmd_header) ||
> +			    pos + cmd_len > actual_len) {
>  				dev_err_ratelimited(&dev->intf->dev,
>  						    "Format error\n");
>  				break;
> @@ -2156,6 +2157,11 @@ static void kvaser_usb_hydra_read_bulk_callback(st=
ruct kvaser_usb *dev,
> =20
>  		cmd_len =3D kvaser_usb_hydra_cmd_size(cmd);
> =20
> +		if (cmd_len < sizeof(struct kvaser_cmd_header)) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			return;
> +		}
> +
>  		if (pos + cmd_len > len) {
>  			/* We got first part of a command */
>  			int leftover_bytes;

[Severity: Medium]
Can an extended command with cmd_len between 4 and 31 still pass this
check and trigger an out-of-bounds read in kvaser_usb_hydra_handle_cmd_ext(=
)?

kvaser_usb_hydra_cmd_size() only returns a device-supplied length when
cmd->header.cmd_no =3D=3D CMD_EXTENDED; standard commands always return
sizeof(struct kvaser_cmd) (32 bytes):

drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:kvaser_usb_hydra_cmd_size=
() {
	if (cmd->header.cmd_no =3D=3D CMD_EXTENDED)
		ret =3D le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);
	else
		ret =3D sizeof(struct kvaser_cmd);
}

In struct kvaser_cmd_ext, the extended header itself is 8 bytes (len is at
bytes 4..5 and cmd_no_ext is at byte 6), and the handlers reached via
kvaser_usb_hydra_handle_cmd_ext() (kvaser_usb_hydra_tx_acknowledge() and
kvaser_usb_hydra_rx_msg_ext()) read at least 32 bytes from cmd without
re-checking cmd_len. Checking against sizeof(struct kvaser_cmd_header) (4
bytes) lets a CMD_EXTENDED frame with cmd_len in 4..31 near the end of
buf pass pos + cmd_len <=3D len and read past the end of the URB buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-kvaser-usb=
-validate-v1-0-f266b85aa908@gmail.com?part=3D1
