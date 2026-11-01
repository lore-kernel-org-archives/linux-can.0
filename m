Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499330;
	b=pXFkUauCdynnW7ee9iqG2zIRkqmxFIvngudEu5KlWaP+UsbEspj929y/DN3CR/OhXN38
	 EMgLuVPbrpzJPxlbVRGJDm2YfWlec4kxXS60kzq9JKw0cnTf3gnU40JDDFX0iPjrdaIcW
	 Woqy6J7IrdZLHAYkMLITcDCf8U3sL4kgnTwGREjHOEuNz4Wu0UbWyntPtJ4c1otkOjgXJ
	 6tBbfqwq+lKtWci1pV47RDTqtQbQFZkhvg4FzW9z3BRdmfDx8yMtHG+grBw65qayPfMVT
	 tU/qvbCLOMYmD+TLIsFB2rTg5TdDPPHzbU7zTxPVOkSDa3qVmlgZ6YgarvREX7QACiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499330;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FPhHvJ1/5lUsB8yPTn9dj9E18wFYCLeERnbfjblEZ30=;
	b=NP24zhg96CemoFaDaQmkH+gEwVI8pTwEl2/mOyJmHtfrVnnPKIwXfC5/yDXZNHJM4/mY
	 snEzKDw7nQsKQ2WQysH8T0yMS7I1HLjTa4xM9F95v7N9Y2eN+fw6itocElvZp5DpsDYCg
	 rnoC6+0ckiuRi1bIH9Q7FNzB7kKwa1WBqqMykaU3OvSjlIwPyleFlNY8sqK3ZkzGW/+Wu
	 1MajuvQ8arasU5nI4jDubGgHozICY16uCv1gYe14BBvobkJLlSGjpl0PyglkKQ5Epq8ob
	 oKk/OCtb2H/EoIjU56DSKkl+l6sry0bMhajR0/q9BvWH2pdVvH9Pk6oilAdIlwBUi8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0RfrCdb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02713606A327;
	Sun,  1 Nov 2026 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0RfrCdb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE4C1F00919;
	Sun,  1 Nov 2026 02:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499329;
	bh=FPhHvJ1/5lUsB8yPTn9dj9E18wFYCLeERnbfjblEZ30=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c0RfrCdbn4FmTr70v8+UiyCTNRxca6m4RBLduEANSpsWhqq9REPdYGOtOtbkP6uWD
	 +RCqN5MfMPpmiIXwbImktkqa0ch7fDnYJf7v16AT3MNP0obIVysGPDcjdKfSpVWFHf
	 dFIFYL/A0gMaRg5T/64YHvU/Rjy9rBkDGg5FLf0R55ggb3bYTNnQvCGAH8u5RVC72/
	 uzW02drDWkoy4aPexXiorwpp3HMRVCgJXD1PXrrxx/aM/jVUil5U7elu4zbqI20BIs
	 Nkl+jx5QBYWybV8LdX6S0wueJD99CwfovaeZSZKKYE1XQkasYCC82sOcSx6ak14sCd
	 fX7s6Qg8DZHXw==
Subject: Re: [PATCH v7 08/13] can: peak_usb: reject records for unset channels
 in PCAN-USB Pro
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, wg@grandegger.com,
 error27@gmail.com, lukas.magel@posteo.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristmd@gmail.com, kuba@kernel.org
Date: Sun, 01 Nov 2026 02:15:28 +0000
Message-ID: <179349932896.3127.17824384205890325119@kernel.org>
In-Reply-To:
 <20261030-canfd_check_channel_idx-v7-8-fc4a3faf3acf@peak-system.fr>
References:
 <20261030-canfd_check_channel_idx-v7-8-fc4a3faf3acf@peak-system.fr>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] When a record names a channel whose slot is NULL,
  pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error() return…

Pre-existing issues:
- [High] peak_usb_create_dev() calls register_candev()
  (pcan_usb_core.c:1009) before dev_init() (1023).
- [Medium] pcan_usb_pro_decode_buf() reads pr->data_type
  (pcan_usb_pro.c:741) before checking that rec_ptr is still below…

--

can: peak_usb: reject records for unset channels in PCAN-USB Pro

With this patch, the PCAN-USB Pro record decoders reject records whose
channel slot in usb_if->dev[] is NULL. A channel's slot is also cleared
in pcan_usb_pro_free(). Slots are published with smp_store_release()
and read with READ_ONCE().

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> index cbc23953ce610..151c5ea2859be 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -543,7 +543,12 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
>  	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
>  		return -EINVAL;
>  
> -	dev = usb_if->dev[ctrl_idx];
> +	dev = READ_ONCE(usb_if->dev[ctrl_idx]);
> +
> +	/* reject records for a channel that is not (or no longer) set up */
> +	if (!dev)
> +		return -EINVAL;

[Severity: Low]
When the slot is empty, pcan_usb_pro_handle_canmsg() returns -EINVAL.
pcan_usb_pro_decode_buf() treats any negative return as fatal for the
whole transfer:

pcan_usb_pro_decode_buf() {
    ...
	case PCAN_USBPRO_RXRTR:
		err = pcan_usb_pro_handle_canmsg(usb_if, &pr->rx_msg);
		if (err < 0)
			goto fail;
    ...
}

pcan_usb_pro_handle_error() does the same for RXSTATUS records. Channel
0 and channel 1 share the same bulk-in endpoint. Would one channel 1
record received while channel 1 is still inside peak_usb_create_dev()
cause the remaining channel 0 frames and RXTS records in that URB to be
dropped?

At this commit the URB is also dumped twice. It is dumped once in
pcan_usb_pro_decode_buf(), and again in peak_usb_read_bulk_callback(),
which dumps urb->transfer_buffer_length instead of urb->actual_length:

peak_usb_read_bulk_callback() {
    ...
			err = dev->adapter->dev_decode_buf(dev, urb);
			if (err)
				pcan_dump_mem("received usb message",
					      urb->transfer_buffer,
					      urb->transfer_buffer_length);
    ...
}

This is still better than the NULL dereference that happened before.
Later in the series, "can: peak_usb: register the netdevs only once all
channels are set up" registers the netdevs in peak_usb_probe() only
after every channel's dev_init() has filled its slot. That way RX
cannot run while a slot is NULL.

Also, "can: peak_usb: dump undecodable URBs once and rate limit decode
errors" changes this to a single rate limited dump of actual_length.
The FD sibling patch says that aborting the URB here is intentional.

> +
>  	netdev = dev->netdev;
>  
>  	skb = alloc_can_skb(netdev, &can_frame);
> @@ -590,7 +595,12 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
>  	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
>  		return -EINVAL;
>  
> -	dev = usb_if->dev[ctrl_idx];
> +	dev = READ_ONCE(usb_if->dev[ctrl_idx]);
> +
> +	/* reject records for a channel that is not (or no longer) set up */
> +	if (!dev)
> +		return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch, but it
is in the caller of these handlers. pcan_usb_pro_decode_buf() reads
pr->data_type before it checks that rec_ptr is still below msg_end:

pcan_usb_pro_decode_buf() {
    ...
	rec_cnt = le16_to_cpu(*usb_msg.u.rec_cnt_rd);
	for (; rec_cnt > 0; rec_cnt--) {
		union pcan_usb_pro_rec *pr = (union pcan_usb_pro_rec *)rec_ptr;
		u16 sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
    ...
}

rec_cnt comes from the device and is not checked. Suppose a device
fills the whole RX buffer with complete records and sends a rec_cnt
larger than the number of records. Can this loop then read one byte
past the end of the kmalloc'd RX buffer?

Later in the series, "can: peak_usb: don't read past the message in
PCAN-USB Pro decoders" appears to fix this by adding a
rec_ptr >= msg_end check before the data_type read.

[ ... ]

> @@ -933,7 +943,8 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
>  	}
>  
>  	pdev->usb_if = usb_if;

[Severity: High]
This isn't a bug introduced by this patch, but pdev->usb_if is only set
here. By that point peak_usb_create_dev() has already made the netdev
openable:

peak_usb_create_dev()
    register_candev(netdev)
    ...
    dev->adapter->dev_init(dev)
        pcan_usb_pro_init()
            pdev->usb_if = usb_if;

peak_usb_ndo_open() only checks PCAN_USB_STATE_CONNECTED, and that bit
is set before registration. A CAP_NET_ADMIN user could open the CAN
netdev between register_candev() and dev_init(). Can
pcan_usb_pro_start() then dereference a NULL pdev->usb_if?

pcan_usb_pro_start() {
    ...
	if (pdev->usb_if->dev_opened_count == 0) {
    ...
}

The RX path has the same problem. pcan_usb_pro_decode_buf() passes
pcan_usb_pro_dev_if(dev) to the record handlers without a NULL check.
The new !dev slot check does not cover this case, because the NULL
pointer here is usb_if and not the slot.

Later in the series, "can: peak_usb: register the netdevs only once all
channels are set up" appears to fix this. It moves register_candev()
into peak_usb_probe(), after every channel's dev_init() and
dev_set_bus(), and its commit message names this pcan_usb_pro_start()
NULL dereference.

> -	usb_if->dev[dev->ctrl_idx] = dev;
> +	/* publish dev to the decoders */
> +	smp_store_release(&usb_if->dev[dev->ctrl_idx], dev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf%40peak-system.fr
