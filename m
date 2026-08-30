Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA638D41A
	for <linux-can@vger.kernel.org>; Sun, 30 Aug 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788095414; cv=none; b=p63s/8OJG4zGz+3Rg6R6kbQv9exCvGBjyakVFVzM3sm075kR+SvwGuy2Q7XxLY1i/YOXqi5TGzjdR/gs/J7HrIPET7cLtCIpeGuzE5Z8cg27hzYYMOCJWwNf0FQPWUse2HdTmMJE4Qx06VemcocW23gcldGNfvM77R+b2Tdwym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788095414; c=relaxed/simple;
	bh=IfcZoWaf4EygfF+sT3X32A5FGD2urfA6bajK19qmeZE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N5WISAZDv1t1DEXr422RbZuu/8+UCkdoVWr+yPb6ddb5FeO/uD9PIHRDLT5/EuXwSzfG8+BmuZkFGGtZleoCDDSZ3pS10ivR6ST+eQsUDLqyfXDtSGMJyiZMwQTLU//iGM/oTijubr0/EI7fNo0EjqP8ylaAANvJYYSgbALg558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd3qXrHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd3qXrHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB71F000E9;
	Sun, 30 Aug 2026 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788095412;
	bh=Ad1mhQzW2JpSamRh+fs5LxfU4YlZZl91dfjw7qMydtU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pd3qXrHuuKOZm0CfVs4RHNmeq9JW9KFfXhPqXzWYeMThYJIUi7kjbs5cKtbz1KHy2
	 ZHBvSv4Sp4biMA0Elgka3GP75kIvE3jraATt+ypPlYGF2lMcDcOEgvgj0zEkN7CLLd
	 PgvzPEGIgLlUIVeSTLHvG4qu7YbrC421b8THvF+ej6me+sA9/7yXJnGoobg1o0ZNd9
	 ZHlNtrirRBMRFBjyPOyNMpy9GKe4BbXlKV9TFbo5ZiATJaiiZNeKWdOgP0/ipssMtV
	 0IRSTgY0NAYZzesu5orjhdDA/Bzpgkw8rjSKUV3L83ir5qFAGFBXox9UgREZ4p2YCp
	 qOgjxNbOHe82g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: esd_usb: validate receive message extents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260830125640.98787-1-pengpeng@iscas.ac.cn>
References: <20260830125640.98787-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 13:10:11 +0000
Message-Id: <20260830131012.51CB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on `dev->net_count` received from the USB dev=
ice, leading to an out-of-bounds array write in `esd_usb_probe_one_net`.
- [High] Missing NULL check for `dev->nets[msg->rx.net]` before dereferenci=
ng it when processing RX or TX_DONE messages.
- [Medium] Permanent leak of TX contexts when `usb_submit_urb` fails in `es=
d_usb_start_xmit`.
- [Medium] Information leak of up to 8 bytes of uninitialized kernel heap m=
emory in `esd_usb_3_set_bittiming`.
--

commit 80cc711006aa828bbd745bab396f97f761d0c5dd
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

can: esd_usb: validate receive message extents

The bulk callback reads the message command before proving that the current
URB remainder contains a header and dispatches CAN messages before checking
the declared message span. Short records can therefore be consumed before
the later position check.

> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index f41d4a0d140f7..1112af5d41d9c 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c

[ ... ]

> @@ -507,8 +534,20 @@ static void esd_usb_read_bulk_callback(struct urb *u=
rb)
> =20
>  	while (pos < urb->actual_length) {
>  		union esd_usb_msg *msg;
> +		size_t msg_len;
> +		int remaining =3D urb->actual_length - pos;
> =20
> +		if (remaining < sizeof(msg->hdr)) {
> +			dev_err(dev->udev->dev.parent, "format error\n");
> +			break;
> +		}
>  		msg =3D (union esd_usb_msg *)(urb->transfer_buffer + pos);
> +		msg_len =3D msg->hdr.len * sizeof(u32);
> +		if (msg_len < sizeof(msg->hdr) || msg_len > remaining ||
> +		    !esd_usb_rx_msg_valid(msg, msg_len)) {
> +			dev_err(dev->udev->dev.parent, "format error\n");
> +			break;
> +		}
> =20
>  		switch (msg->hdr.cmd) {
>  		case ESD_USB_CMD_CAN_RX:

[Severity: High]
This isn't a bug introduced by this patch, but it looks like there might be=
 a
NULL pointer dereference when processing RX or TX_DONE messages.

If esd_usb_probe_one_net() fails to register a CAN interface (e.g. due to
memory allocation failure), it returns an error but leaves dev->nets[i] as
NULL. The probe function ignores this return value:

	for (i =3D 0; i < dev->net_count; i++)
		esd_usb_probe_one_net(intf, i);

Later, in esd_usb_read_bulk_callback(), the code validates the net index
but does not check if the array element is NULL before passing it to
esd_usb_rx_can_msg() or esd_usb_tx_done_msg():

	if (msg->rx.net >=3D dev->net_count) {
		dev_err(dev->udev->dev.parent, "format error\n");
		break;
	}

	esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg);

Can a misbehaving or malicious USB device send a CAN_RX or CAN_TX command
targeting a failed network index and cause a kernel panic?

[ ... ]

While reviewing this code, I also noticed a few other pre-existing issues in
the driver.

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds array
write when probing the network interfaces.

In esd_usb_probe(), the driver trusts the number of interfaces returned by
the USB device:

	dev->net_count =3D (int)msg->version_reply.nets;

It then iterates up to this value without bounds checking:

	for (i =3D 0; i < dev->net_count; i++)
		esd_usb_probe_one_net(intf, i);

In esd_usb_probe_one_net(), the index is used to write to the statically si=
zed
array of length 2 (ESD_USB_MAX_NETS):

	dev->nets[index] =3D priv;

Could a malicious USB device return a nets value greater than ESD_USB_MAX_N=
ETS
and cause a heap memory corruption here?


[Severity: Medium]
This is a pre-existing issue, but there appears to be a permanent leak of
TX contexts when transmission fails.

In esd_usb_start_xmit(), a transmission context is reserved by setting
context->echo_index =3D i. If the subsequent call to usb_submit_urb() fails,
the cleanup path unwinds the active_tx_jobs and the echo SKB:

	err =3D usb_submit_urb(urb, GFP_ATOMIC);
	if (err) {
		can_free_echo_skb(netdev, context->echo_index, NULL);

		atomic_dec(&priv->active_tx_jobs);
		usb_unanchor_urb(urb);

However, it omits the required context->echo_index =3D ESD_USB_MAX_TX_URBS
reset. Does this leave the context incorrectly marked as in-use, potentially
leading to a denial of service where the driver perpetually returns
NETDEV_TX_BUSY?


[Severity: Medium]
This is a pre-existing issue, but I noticed a potential information leak of
uninitialized kernel heap memory.

In esd_usb_3_set_bittiming(), a message buffer is allocated via kmalloc_obj=
()
which does not zero the memory:

	msg =3D kmalloc_obj(*msg);

The code populates the fields of the esd_usb_3_set_baudrate_msg_x structure,
but the 8-byte baud_x->data structure is only initialized if CAN FD mode is
enabled:

	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
		...
	}

The entire 28-byte structure is then sent over USB:

	err =3D esd_usb_send_msg(priv->usb, msg);

If CAN FD mode is not enabled, does this leak up to 8 bytes of uninitialized
kernel heap data to the USB device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830125640.9878=
7-1-pengpeng@iscas.ac.cn?part=3D1
