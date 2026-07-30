Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7403F822B
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407393; cv=none; b=AuXVwdpEto3Zl8V9QJFsBC5rYHp16GzalnPDMH0h9P7lk2MY9ajoozMdGrJcRFe41Hg9Du7RyLFN7nhCSNIt/KoClNMLtlwPhsjsrlvTb/1pW5DTbJQxeKlMbkjpUDoeznv8Esky+UEoh+mmq1L5F3HPw0GintTR7DN8+IK2CGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407393; c=relaxed/simple;
	bh=1WGt0JIlf0i6dygolFGVsjtZh3HOA0YI8lQVdUUQE+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rf8jQFdQg+9778oBkejdNEYPYBGg3s+jMIc/TAVPpkyxCL+6kRrc9R6OQc7c3f1/j/k3P4uA/iT0FvbCROm9+9vS5yzZHsr4HHQNjTusDpF4vd1LMldjlfceRO3W1NF+rNZH69oeHl60pfZslr0crbilsCwjT/VUn7PCOREaHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNtw+RAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNtw+RAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF481F00A3A;
	Thu, 30 Jul 2026 10:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407392;
	bh=+9uGFadWFevcn4o6OMNdTtunvNS80NaIO904twLnMwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hNtw+RAGRwjRxl3buXIKHqdbUxMxyviZH7lGjgf0sG9RUV+NtOJP++NENoBlEq0jf
	 61UGcEKM3ZBP8MB7J3nI8wTrgZc7W33j76TQRjMxMnEmXqzKxUDeP4DQwfyMRauas2
	 fQQ/zpTAKsigMBvzDz4VY3c9yXxDxvAj+6BpCpvrSdilNcdYayVoQxLTyzCcZuhxDi
	 YuGKoDJVHFn5oukIqBcvG42SfVCw3oqcqxxmSI0DJglHO1uc5yuLgwEQYgd4pI6vL8
	 JXbXre7AyuxxXJF3hiN6yY5T+SkIdmExl5Stq/eIFGyGa3JdKkO3Oxp8806XhW3xEJ
	 Yp/XLuCMi1yGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 10/20] can: peak_usb: add bounds check for USB
 channel index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260729102802.505168-11-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-11-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:51 +0000
Message-Id: <20260730102952.3DF481F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated CAN payload length from the USB packet causes a heap b=
uffer overflow when copying data into the SKB and reading from the URB buff=
er.
- [High] Inadequate bounds checking allows a NULL pointer dereference of un=
initialized channel device pointers.
- [High] Race condition during probe exposes the network interface before d=
river initialization is complete, leading to a NULL pointer dereference.
--

--- Patch [10]: [PATCH net 10/20] can: peak_usb: add bounds check for USB c=
hannel index ---
commit bda9ca94a61ede6bd59945cb6b8e4a5d2a8b5017
Author: James Gao <jamesgao5@outlook.com>

can: peak_usb: add bounds check for USB channel index

The channel control index ctrl_idx is derived from rx->len which comes
directly from a device USB payload. The mask 0x0f allows values 0-15, but
the array size of usb_if->dev[] is only 2. Values 2-15 cause heap
out-of-bounds read, eventually causing kernel panic in the IRQ context.

Link: https://patch.msgid.link/TYWPR01MB8559DBAAAA6A7F410400329CF0012@TYWPR=
01MB8559.jpnprd01.prod.outlook.com

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/ca=
n/usb/peak_usb/pcan_usb_pro.c
> index aefcded8e12a8..b6be8c19e537f 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -534,12 +534,18 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_u=
sb_pro_interface *usb_if,
>  				      struct pcan_usb_pro_rxmsg *rx)
>  {
>  	const unsigned int ctrl_idx =3D (rx->len >> 4) & 0x0f;
> -	struct peak_usb_device *dev =3D usb_if->dev[ctrl_idx];
> -	struct net_device *netdev =3D dev->netdev;
> +	struct peak_usb_device *dev;
> +	struct net_device *netdev;
>  	struct can_frame *can_frame;
>  	struct sk_buff *skb;
>  	struct skb_shared_hwtstamps *hwts;
> =20
> +	if (ctrl_idx >=3D ARRAY_SIZE(usb_if->dev))
> +		return -EINVAL;
> +
> +	dev =3D usb_if->dev[ctrl_idx];
> +	netdev =3D dev->netdev;

[Severity: High]
This isn't a bug introduced by this patch, but does checking against
ARRAY_SIZE() fully protect against NULL pointer dereferences here?

If a single-channel adapter is used, usb_if->dev[1] might be left
uninitialized (NULL). If a device sends URBs for channel 1, wouldn't it
bypass the ARRAY_SIZE() check and cause a kernel panic when dereferencing
dev->netdev?

There appears to be an identical inadequate bounds check in the FD variant
of the driver at pcan_usb_fd_decode_canmsg().

[Severity: High]
This is a pre-existing issue, but does this code overflow can_frame->data[]
when copying the payload?

Looking further down in pcan_usb_pro_handle_canmsg():

    can_frame->len =3D rx->len & 0x0f;
    ...
    } else {
        memcpy(can_frame->data, rx->data, can_frame->len);
    }

Since rx->len & 0x0f allows values up to 15, and can_frame->data[] is only =
an
8-byte array, could a malicious device send an oversized payload length and
overflow can_frame->data[]?

> +
>  	skb =3D alloc_can_skb(netdev, &can_frame);
>  	if (!skb)
>  		return -ENOMEM;

[ ... ]

> @@ -573,14 +579,20 @@ static int pcan_usb_pro_handle_error(struct pcan_us=
b_pro_interface *usb_if,
>  {
>  	const u16 raw_status =3D le16_to_cpu(er->status);
>  	const unsigned int ctrl_idx =3D (er->channel >> 4) & 0x0f;
> -	struct peak_usb_device *dev =3D usb_if->dev[ctrl_idx];
> -	struct net_device *netdev =3D dev->netdev;
> +	struct peak_usb_device *dev;
> +	struct net_device *netdev;
>  	struct can_frame *can_frame;
>  	enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
>  	u8 err_mask =3D 0;
>  	struct sk_buff *skb;
>  	struct skb_shared_hwtstamps *hwts;
> =20
> +	if (ctrl_idx >=3D ARRAY_SIZE(usb_if->dev))
> +		return -EINVAL;
> +
> +	dev =3D usb_if->dev[ctrl_idx];
> +	netdev =3D dev->netdev;
> +
>  	/* nothing should be sent while in BUS_OFF state */
>  	if (dev->can.state =3D=3D CAN_STATE_BUS_OFF)
>  		return 0;

[Severity: High]
This is a pre-existing issue, but is there a race condition during probe
that could expose the network interface before driver initialization is
complete?

In peak_usb_create_dev(), register_candev() is called before the interface
is fully initialized:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_create_dev() {
    ...
    err =3D register_candev(netdev);
    ...
}

If userspace immediately brings the interface up (e.g., via udev),
pcan_usb_pro_start() is called and dereferences pdev->usb_if:

drivers/net/can/usb/peak_usb/pcan_usb_pro.c:pcan_usb_pro_start() {
    ...
    if (pdev->usb_if->dev_opened_count =3D=3D 0) {
    ...
}

Since pdev->usb_if is only allocated and assigned later in
pcan_usb_pro_init(), wouldn't this cause a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D10
