Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B363CD8A4
	for <linux-can@vger.kernel.org>; Fri, 14 Aug 2026 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731379; cv=none; b=fEWZon3BDzHUz8XhqYmsF9qCQyKbc1GidCkafoa/YgVpxCTv/CCyncnKZV2vz2owTU8vE01Mia5g5RzztgT6T2T+XVYiXMKXi8mViEOnRELV4FY8uKe4PJVouW9mJMX8R4bQj1mwzPTRlep96LctdehJw5AqkfbKSLaBW+5QhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731379; c=relaxed/simple;
	bh=DWpcn6hZm/S8a9ZdhR0xIocTvdVdIEAWyEHNsLH/rN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P5XC20NvkT5UnFrp14yWk6aFtgec3d/FKkNjBdy7QfROqNdGXiXd2wG2vNeDfvBkYqXW/sEb7zbtN1miZxReNhtAlIZ8q7dbQW6FE0uO37DOQGY600NoSL8wqIfOfxDqEXZSgVzwvBllF/rhJ1F/S0mqWOBfJnftbLWrf/aXIRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZfl9jI4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZfl9jI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6B61F000E9;
	Fri, 14 Aug 2026 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786731377;
	bh=pIQj2+wN4qJYo2b1PclPHIRr+vIjA/ghjrXhw7t7eZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UZfl9jI4HDI7N6CMGaBIGDJPNNO7JibdsxN5xUmNaoKQ3iMSSy2Bp2LuNiRIGVe7b
	 yhOn/OIpti6TVpTqRFbEcIfxgXleJ6+teReeGfbEJ/T1GnZtiqU/hQXbwSpzpeySzV
	 AKuJwhUaitRXEzWof8AxBBWQVicKKqi0HJiDDHd8JKoohcfch8CWKj3znRQH+56p+z
	 +mRxxrypLQ2wekyts4wsUHEnKfaWYYncs4afwlj4d/a4jUnBs58TlYZ9aWRFHgFzHe
	 ohO2An9cxbVP9UgtuF0NXnyqZNHrm93v5clJRDgorVBaGdU8CI8eMBkKrcy09I7YQ7
	 FkFgQAk8qP7ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] can: esd_usb: validate received message length
 before use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiran Qiu" <eritque-arcus@ikuyo.dev>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260815-can-esd-hydra-fixes-v1-1-de644cbeaec2@ikuyo.dev>
References: <20260815-can-esd-hydra-fixes-v1-0-de644cbeaec2@ikuyo.dev>
 <20260815-can-esd-hydra-fixes-v1-1-de644cbeaec2@ikuyo.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:16:16 +0000
Message-Id: <20260814181617.4E6B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated interface count from device causes heap buffer overflo=
w during probe.
- [High] Dereferencing uninitialized network interfaces from USB messages c=
auses kernel panic.
- [High] Spurious TX_DONE messages decrement inactive contexts causing acti=
ve_tx_jobs underflow.
--

--- Patch [1]: [PATCH 1/2] can: esd_usb: validate received message length b=
efore use ---
commit 38efd7f38912ccfd78688896fcdf77da350528fd
Author: Yiran Qiu <eritque-arcus@ikuyo.dev>
Date:   Fri Aug 14 18:05:46 2026 +0000

    can: esd_usb: validate received message length before use
   =20
    esd_usb_read_bulk_callback() walks a sequence of variable-length
    messages out of the RX URB buffer. The only length check,
    "pos > urb->actual_length", runs *after* the current message has been
    dispatched and after @pos has been advanced, so it can neither protect
    the message being processed nor stop the loop:
   =20
    Validate the header and the declared message length before dispatch:
    reject a message whose header is not fully present, whose length is
    zero, or which extends past the received data, and advance @pos by the
    validated length. Pass the validated length to the message handlers so
    they can confirm that the fields they read (and the payload they copy)
    were actually received.

> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index f41d4a0d140f7..13356e68f3f60 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c

[ ... ]

> @@ -455,7 +479,7 @@ static void esd_usb_rx_can_msg(struct esd_usb_net_pri=
v *priv,
>  }
> =20
>  static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
> -				union esd_usb_msg *msg)
> +				union esd_usb_msg *msg, unsigned int msg_len)
>  {
>  	struct net_device_stats *stats =3D &priv->netdev->stats;
>  	struct net_device *netdev =3D priv->netdev;
> @@ -464,6 +488,9 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_pr=
iv *priv,
>  	if (!netif_device_present(netdev))
>  		return;
> =20
> +	if (msg_len < offsetofend(struct esd_usb_tx_done_msg, hnd))
> +		return;
> +
>  	context =3D &priv->tx_contexts[msg->txdone.hnd & (ESD_USB_MAX_TX_URBS -=
 1)];
> =20
>  	if (!msg->txdone.status) {

[Severity: High]
This is a pre-existing issue, but can spurious TX_DONE messages decrement
inactive contexts and cause the active_tx_jobs counter to underflow?

In esd_usb_tx_done_msg(), the context identified by msg->txdone.hnd is acce=
ssed
without checking if it is actually active (e.g. echo_index !=3D
ESD_USB_MAX_TX_URBS). If a malicious device sends spurious TX_DONE messages,
this will unconditionally execute atomic_dec(&priv->active_tx_jobs).=20

When the queue eventually fills up with real packets, esd_usb_start_xmit()
won't stop the queue because active_tx_jobs is negative, returning
NETDEV_TX_BUSY. Returning NETDEV_TX_BUSY without stopping the queue causes =
the
network stack to infinitely retry, softlocking the CPU.

[ ... ]

> @@ -507,8 +534,27 @@ static void esd_usb_read_bulk_callback(struct urb *u=
rb)
> =20
>  	while (pos < urb->actual_length) {
>  		union esd_usb_msg *msg;
> +		unsigned int msg_len;
> +
> +		/* The header must be fully present before hdr.len / hdr.cmd
> +		 * (and the net index below) are read.
> +		 */
> +		if (pos + sizeof(struct esd_usb_header_msg) > urb->actual_length) {
> +			dev_err(dev->udev->dev.parent, "format error\n");
> +			break;
> +		}
> =20
>  		msg =3D (union esd_usb_msg *)(urb->transfer_buffer + pos);
> +		msg_len =3D msg->hdr.len * sizeof(u32); /* convert to # of bytes */
> +
> +		/* A zero-length message would never advance @pos and would
> +		 * spin this URB-completion softirq forever; a message must
> +		 * also fit within the received data.
> +		 */
> +		if (msg->hdr.len =3D=3D 0 || msg_len > urb->actual_length - pos) {
> +			dev_err(dev->udev->dev.parent, "format error\n");
> +			break;
> +		}
> =20
>  		switch (msg->hdr.cmd) {
>  		case ESD_USB_CMD_CAN_RX:
> @@ -517,7 +563,7 @@ static void esd_usb_read_bulk_callback(struct urb *ur=
b)
>  				break;
>  			}
> =20
> -			esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg);
> +			esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg, msg_len);

[Severity: High]
This isn't a bug introduced by this patch, but does this loop properly hand=
le
uninitialized network interfaces?

If esd_usb_probe_one_net() fails for one of the interfaces during
esd_usb_probe(), it leaves dev->nets[index] as NULL. A malicious USB device=
 can
then send ESD_USB_CMD_CAN_RX messages with the index of the failed interfac=
e,
which is passed unconditionally to esd_usb_rx_can_msg() resulting in a NULL
pointer dereference.

[Severity: High]
This is also a pre-existing issue, but does msg->rx.net >=3D dev->net_count
properly protect against out-of-bounds array access for dev->nets[]?

A malicious USB device can return an arbitrarily large number of interfaces=
 in
the version reply message. In esd_usb_probe(), this is directly assigned to
dev->net_count without validating it against ESD_USB_MAX_NETS (2), which can
corrupt adjacent heap memory when writing to dev->nets[index]. Furthermore,
since dev->net_count can be larger than ESD_USB_MAX_NETS, the check
msg->rx.net >=3D dev->net_count above does not prevent dev->nets[msg->rx.ne=
t]
from going out of bounds here.

>  			break;
> =20
>  		case ESD_USB_CMD_CAN_TX:
> @@ -527,16 +573,11 @@ static void esd_usb_read_bulk_callback(struct urb *=
urb)
>  			}
> =20
>  			esd_usb_tx_done_msg(dev->nets[msg->txdone.net],
> -					    msg);
> +					    msg, msg_len);
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-can-esd-hy=
dra-fixes-v1-0-de644cbeaec2@ikuyo.dev?part=3D1
