Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D843BB9F8
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407396; cv=none; b=J3yz2Qu7ymVCl5c7/cRVMhcsCDj804AKBnQUC4FWRZ3bbwg7Ou/yPROIG8gV72rYBtWmkoVMLt6pEnKKBCG60Wwrav+3WKW9tLJyk86Fe4AFJEXLJLmuLXPD6aoAKQW1vvnUyJPaeO4HyKnwMl04jfb0ZsQZZZk6Ure3ABdcC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407396; c=relaxed/simple;
	bh=GXl2CHz+sJcnzYcAEKSAAz2lAZoPdZHwMhJu+CD1CqM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jZoUYtG2NNZPczKmGh6zp8um4vRluckuHn8QhOjiVLieHB7okMX62jiJYlCLblcPpApZYdfKYTqgebCj0NYJrlYPijGeBYKCCeT25mxYeA8YC0j8FhSdWlEyab5iM9v3meF1eUNHxNXLfF5U9EZXo600g+eopdUdq7/YO1fMBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOx8q6gw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOx8q6gw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925EC1F00A3A;
	Thu, 30 Jul 2026 10:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407394;
	bh=wkbO2hTu6MV1c8Ilwx9yuqRm/8s24krmcfaxcHIS1vE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOx8q6gwS45KUYXthwRg397nmEPIshM4ptLDmRiQVxUA5UUOyphNzcPXdAxCdS9td
	 Fbx9w0gAkPlaeTuSnJmaHRzgafnwUOzvLu46rOfwnbCOEBtcbQhqX8YvQlLVLApP/F
	 xIQIWS8Ggs3/ws4tPkcesChHVvRsh7gacgSNZ/MDmtVs4N1k0R1kK3LzNcyTE+sN77
	 GtNkQBqnpLc1PEImLv01tf0mtyYjMESV3XJxU+ABMcPPpjr+nfIAO4zbhxwfnoHbWf
	 /v+gKX1BLN0OV+EODgdE+ooqih9lE2bAF3BbNpCsj+G4z9xOW7fktYWxqJp/C+cBT4
	 l32yvsHcDmaJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 12/20] can: peak_usb: validate uCAN receive record
 lengths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260729102802.505168-13-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-13-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:54 +0000
Message-Id: <20260730102954.925EC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The new buffer length check prevents graceful loop termination for=
 valid 4-byte padding records, leading to severe log spam.

Pre-existing issues:
- [Critical] Missing NULL check for uninitialized channel devices leads to =
a NULL pointer dereference.
--

--- Patch [12]: [PATCH net 12/20] can: peak_usb: validate uCAN receive reco=
rd lengths ---
commit ae45d78fc07951e0485a1ba7921e266e598fe209
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

can: peak_usb: validate uCAN receive record lengths

This patch validates the length of uCAN receive records before copying
their payloads into socket buffers. It requires each record to contain
the fixed header for its type and verifies CAN payload bytes.

Link: https://patch.msgid.link/20260706092836.79754-1-pengpeng@iscas.ac.cn

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index ef9fd693e9bd3..0d46f4ce5dca7 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -566,6 +566,13 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb=
_fd_if *usb_if,
>  				     dev->can.ctrlmode);
>  	}
> =20
> +	if (!(rx_msg_flags & PUCAN_MSG_RTR) &&
> +	    le16_to_cpu(rx_msg->size) - offsetof(struct pucan_rx_msg, d) <
> +	    cfd->len) {
> +		kfree_skb(skb);
> +		return -EBADMSG;
> +	}
> +

[Severity: Critical]
This is a pre-existing issue, but is there a missing NULL pointer check when
extracting the channel device in this function?

In pcan_usb_fd_decode_canmsg(), the channel index is checked against the
array size:

        if (pucan_msg_get_channel(rm) >=3D ARRAY_SIZE(usb_if->dev))
                return -ENOMEM;

        dev =3D usb_if->dev[pucan_msg_get_channel(rm)];
        netdev =3D dev->netdev;

For single-channel adapters, usb_if->dev[1] is never initialized and remains
NULL. If a malicious or malfunctioning USB device sends a CAN RX message
specifying channel 1, will the driver fetch the NULL pointer and immediately
dereference it when accessing dev->netdev?

This same pattern appears to be present in pcan_usb_fd_decode_status(),
pcan_usb_fd_decode_error(), and pcan_usb_fd_decode_overrun().

[ ... ]

> @@ -728,6 +753,12 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_de=
vice *dev, struct urb *urb)
>  	msg_end =3D urb->transfer_buffer + urb->actual_length;
>  	for (; msg_ptr < msg_end;) {
>  		u16 rx_msg_type, rx_msg_size;
> +		size_t rx_msg_min_size;
> +
> +		if (msg_end - msg_ptr < sizeof(*rx_msg)) {
> +			err =3D -EBADMSG;
> +			break;
> +		}

[Severity: High]
Will this check fail on valid 4-byte null tags used for padding at the end
of a transfer buffer?

If the hardware or driver uses a 4-byte null tag to mark the end of valid
records (where size =3D 0), this check for a full 12-byte struct pucan_msg=
=20
will evaluate to true.=20

This breaks the loop with err =3D -EBADMSG, which triggers the fail path and
calls pcan_dump_mem(). Because pcan_dump_mem() uses un-ratelimited logging,
could this result in severe kernel log spam for every receive transfer that
ends in 4-byte padding?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D12
