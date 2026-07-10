Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57E926F293
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701790; cv=none; b=Q1cxITf/b527ykblLSFgMxJNU0LqD4NrSXLixOJrAFCSsarvXsw2aRm7lN5sTB2YmRY28TND5ST7f+THQ160NSekfrsy4Mpw2ogHNFpf39NRyTRi4pW2WwQtbboti5s2S1SZkPkGFAQo8/JFgORdTMqj72fSbpTKXN4dcDHI/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701790; c=relaxed/simple;
	bh=e3loEmGXk+qF61Eu2CnkEtB73k8OPBivupAiSyRNHtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hOHrZ50LZBdjU3ohp0pnIGMkqDsrYVfbc2MMO055WkBbiYnJnL3zis02bem0fM8QXPJ0VgahlHOupxxTSR9sIbWEA7EElTOz+4jANfQSVdPuQJf0id2/ctMv+jCdgl44W+l2yIJ768WPmiHG7KQBYICVG7qoS9baibR0uNy9oLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XME9wnrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XME9wnrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4171F000E9;
	Fri, 10 Jul 2026 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783701788;
	bh=Mle/u4hxrK1EHVfJ6LOocapL1+b9BAB6R9pt1EiaQGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XME9wnrKZktFuiHU0J+yI16FyIZxGDNnQETfd8f0/fPpNFa7I9TOr5hE7/L7Cc51M
	 CLVPBhcLGvPLtY+lCpP9lv7j4XIEdMTwjuS0417mp0FzRsIiJGXtbX8sJT7Yg+gXfe
	 EeB4WO+j0m858SOoIVyySLflGtHSGKHzqqsM9ETX8uOOOq8bOLarqOc8Odz/4jZuD3
	 fDtA1cP0ibY/A1+IEzFb6ppYmHH8VWyNT0TUfjgZ/G3gNGDqJUpcqdODz0+UwsEhLl
	 KSA26c62t5VewXIvzbHvKNJJQ01DyyYIMDpuJiCtzMJuEGSnMbHqs6lQ1om4bBdKup
	 nflz12JavQ00Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] can: esd_usb: kill anchored URBs before freeing
 netdevs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260709164159.497640-1-fanwu01@zju.edu.cn>
References: <20260709104620.133765-1-fanwu01@zju.edu.cn>
 <20260709164159.497640-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:43:06 +0000
Message-Id: <20260710164307.1C4171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on `dev->net_count` derived from untruste=
d USB device input leads to an out-of-bounds array write.
- [High] A zero-length message from the USB device causes an infinite loop =
in the RX completion handler.
- [High] Missing NULL check for `dev->nets[i]` array elements allows a mali=
cious USB device to trigger a NULL pointer dereference.
- [High] Missing bounds validation on the URB buffer length allows an attac=
ker-controlled USB device to trigger out-of-bounds heap memory reads.
--

--- Patch [1]: [PATCH net v2] can: esd_usb: kill anchored URBs before freei=
ng netdevs ---
commit 61e5cb7cf9d6a05752ca57498b34f59417480dc7
Author: Fan Wu <fanwu01@zju.edu.cn>

can: esd_usb: kill anchored URBs before freeing netdevs

This patch reorders the teardown sequence in esd_usb_disconnect() to unregi=
ster
netdevs, unlink all URBs, and then free the netdevs. This resolves an issue
where the URB unlinking process accesses a freed netdev structure.

> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index d257440fa01ff..f41d4a0d140f7 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
> @@ -1390,10 +1390,13 @@ static void esd_usb_disconnect(struct usb_interfa=
ce *intf)
>  				netdev =3D dev->nets[i]->netdev;
>  				netdev_info(netdev, "unregister\n");
>  				unregister_netdev(netdev);
> -				free_candev(netdev);
>  			}
>  		}
>  		unlink_all_urbs(dev);
> +		for (i =3D 0; i < dev->net_count; i++) {
> +			if (dev->nets[i])
> +				free_candev(dev->nets[i]->netdev);
> +		}
>  		kfree(dev);
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but does this code in esd_usb_probe() allow a
regression where a USB device triggers an out-of-bounds heap write?

In esd_usb_probe():

	err =3D esd_usb_wait_msg(dev, msg);
	if (err < 0) {
		dev_err(&intf->dev, "no version message answer\n");
		goto free_msg;
	}

	dev->net_count =3D (int)msg->version_reply.nets;

[ ... ]

	/* do per device probing */
	for (i =3D 0; i < dev->net_count; i++)
		esd_usb_probe_one_net(intf, i);

If a USB device provides a version_reply.nets value up to 255, the driver
assigns it to dev->net_count without checking it against ESD_USB_MAX_NETS (=
2).

The initialization loop then iterates dev->net_count times, calling
esd_usb_probe_one_net():

	dev->nets[index] =3D priv;

Could this write past the bounds of the dev->nets array into adjacent memor=
y?

[Severity: High]
This isn't a bug introduced by this patch, but does the RX completion handl=
er
contain a regression leading to an infinite loop if a zero-length message is
received?

In esd_usb_read_bulk_callback():

	while (pos < urb->actual_length) {
		union esd_usb_msg *msg;

		msg =3D (union esd_usb_msg *)(urb->transfer_buffer + pos);

[ ... ]

		pos +=3D msg->hdr.len * sizeof(u32); /* convert to # of bytes */

If a USB device provides a message with msg->hdr.len =3D=3D 0, pos does not
increase.

The loop condition pos < urb->actual_length would remain true forever, caus=
ing
the loop to spin indefinitely.

[Severity: High]
This is a pre-existing issue, but does esd_usb_read_bulk_callback() derefer=
ence
a NULL pointer if a previous interface registration failed?

In esd_usb_probe(), if registering a netdev fails in esd_usb_probe_one_net()
due to memory exhaustion, it returns an error:

	for (i =3D 0; i < dev->net_count; i++)
		esd_usb_probe_one_net(intf, i);

The error is ignored and dev->nets[i] remains NULL.

Later in esd_usb_read_bulk_callback():

		case ESD_USB_CMD_CAN_RX:
			if (msg->rx.net >=3D dev->net_count) {
				dev_err(dev->udev->dev.parent, "format error\n");
				break;
			}

			esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg);
			break;

If a USB device sends an ESD_USB_CMD_CAN_RX packet specifying the failed
interface's index, it passes the dev->net_count check.

Does the lack of a NULL check before passing the pointer to esd_usb_rx_can_=
msg()
cause a crash here?

[Severity: High]
This isn't a bug introduced by this patch, but does esd_usb_read_bulk_callb=
ack()
read past the URB buffer bounds?

In esd_usb_read_bulk_callback():

	while (pos < urb->actual_length) {
		union esd_usb_msg *msg;

		msg =3D (union esd_usb_msg *)(urb->transfer_buffer + pos);

		switch (msg->hdr.cmd) {

The code accesses the message fields before checking if the message size fi=
ts
within urb->actual_length.

Additionally, if the message length validation is missing, could this lead =
to an
out-of-bounds heap memory read in esd_usb_rx_can_msg()?

	memcpy(cfd->data, msg->rx.data_fd, len);

If msg->rx.data_fd falls near the end of the urb->transfer_buffer, this cou=
ld
copy adjacent heap memory into the CAN frame, leaking memory contents.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709164159.4976=
40-1-fanwu01@zju.edu.cn?part=3D1
