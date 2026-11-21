Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795301637;
	b=xh7xTWCj0a0vvzYQHnfULmVmK4lvMapYfqtNvsKh9THCiWxZoX1Sd5CzEoYcQ/0pa/4U
	 VocD8iBNSWlZ3Ty4Y7/uzDTylSezf8DQ6X0x0nTdO8ArAxqzKnk8Z12DcwivVIDXNzrQt
	 cG3Zv1zWYTmcCl/OGu7u7IxNewj/+VwTPIUlVM4PoGxD0co1U75PWjC+uzsGRcYW8yAPx
	 Vi0dLZILfyf55VoDh5l6U7VdKo4c9+XgjZt7DxDaBmJNuBGpTJNOCBdyuIqWSmDRpqqeV
	 tJQm9Pl/oG8h+fpSJYHkET4MvG7JFcJtn74C7CyGfJzi7uiM0b0zUVse408y2rvZ1hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795301637;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h4hB/Y1XNB4rsf4eDaKjDhN+pJkQ67mfMyOPXjfIpyo=;
	b=3qeQKz8ZDs+/JRDlvGdoDGytlS/0ffIg/9yKykj3d1suXD+KWbHHCViP9gSO4EB0dE9h
	 K7Qxh1K3lWICyLraGXCX5zDgBLDqx+/JWMnr7MYEF1YxHY0fSIskQRFaOjjGfdkm6yT2a
	 JY02tQTUfPSkDKuwslt3YlggOyYIwruFlMaiC66NIZIWFvIkTA6OG6ZnNYU5vcH1ym3SV
	 boNyprKPiwqywraIbIle5HWV0L8ssM9MECrMh40+3rnRl2x31q5BjjVIpvuT1dxKG31/2
	 4PLegNH+Us3npsP5uEHTWbe39Q/jNicVImbMw9XSF4tKwJoFutpDLqWyxt3QT16+Jgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jgwl1srV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608F606A320
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jgwl1srV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C451F000C4;
	Sat, 21 Nov 2026 22:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795301636;
	bh=h4hB/Y1XNB4rsf4eDaKjDhN+pJkQ67mfMyOPXjfIpyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jgwl1srVjxzyT0BSggQ0e5Et6zIhgRlP84zdI3jUEVoI8XFB7M1vwROu69CdyqCg1
	 pwpLbnUhetSfVFfSUn+MxYO0E9ecFBZhwjxIa9v1dFjg5RMVvKw2XKLxHZK+RF6JiH
	 szIQXyKoTQQWYG6QvjPo+7meHocFAzhgbK7xWvCvyD8F81zk9bqa0xYndSbfCphlE7
	 WnbbD9XOnP5SwPB5DereFz9DwCRE/eKe/W13izGt3g4pADPBd0KMCrTFGUkf7LCwXI
	 B2rwFSk/U4Gqr2x9iXcjFxtml6o5Zi9J7l1i2Yj5tpddazBAOvqsJ1QwAOQunXCpPo
	 sXB/b5nP3FcIQ==
Message-ID: <sashiko-outbox-227474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v9 12/13] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop invalid CAN error frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-12-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
 <20261121-gs_usb-fixes-v9-12-db121d488945@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 22:53:55 +0000
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
- [Medium] can: gs_usb: TX context and echo skb leak on echoed
  CAN_ERR_FLAG frames
--

commit b1d99b2dbb5c984106e59cf632bd8f01d76e1bcf
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_host_frame_header_valid(): drop invalid CAN error frames

This commit validates incoming CAN error frame headers in
gs_usb_host_frame_header_valid(), rejecting frames with CAN_ERR_FLAG set
if can_dlc is not CAN_ERR_DLC or if CAN_RTR_FLAG is set.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index e4e177aee48b0..a1192867e49b8 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -639,6 +639,30 @@ static bool gs_usb_host_frame_header_valid(const str=
uct gs_can *dev,
>  		valid =3D false;
>  	}
> =20
> +	if (header->can_id & cpu_to_le32(CAN_ERR_FLAG)) {
> +		if (header->can_dlc !=3D CAN_ERR_DLC) {
> +			stats->rx_errors++;
> +			stats->rx_length_errors++;
> +
> +			if (net_ratelimit())
> +				netdev_err(netdev,
> +					   "invalid DLC in CAN error frame (can_dlc=3D%u, exptect_can_dlc=
=3D%u)\n",
> +					   header->can_dlc, CAN_ERR_DLC);
> +
> +			valid =3D false;
> +		}
> +
> +		if (header->can_id & cpu_to_le32(CAN_RTR_FLAG)) {
> +			stats->rx_errors++;
> +
> +			if (net_ratelimit())
> +				netdev_err(netdev,
> +					   "invalid RTR flag in CAN error frame\n");
> +
> +			valid =3D false;
> +		}
> +	}
> +
>  	return valid;
>  }

[Severity: Medium]
Can this leak txc and dev->can.echo_skb[hf->echo_id] when a transmitted
frame with CAN_ERR_FLAG set is echoed back by the device?

The TX path and gs_can_start_xmit() do not mask out or reject
CAN_ERR_FLAG in cf->can_id before allocating a TX context and storing the
echo skb.  When the device echoes that TX frame back with
header->echo_id < GS_MAX_TX_URBS, gs_usb_receive_bulk_callback() calls
gs_usb_get_rx_data_length() -> gs_usb_host_frame_header_valid() before
branching on hf->echo_id =3D=3D GS_HOST_FRAME_ECHO_ID_RX.  If can_dlc !=3D
CAN_ERR_DLC or CAN_RTR_FLAG is set, gs_usb_receive_bulk_callback() jumps
to resubmit_urb without calling gs_free_tx_context(), consuming the echo
skb, or decrementing dev->active_tx_urbs, which permanently exhausts all
GS_MAX_TX_URBS slots and stalls the TX queue after 10 such frames.

Should this check be gated on header->echo_id =3D=3D GS_HOST_FRAME_ECHO_ID_=
RX
(or should gs_can_start_xmit() reject or strip CAN_ERR_FLAG on TX)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-gs_usb-fix=
es-v9-0-db121d488945@pengutronix.de?part=3D12
