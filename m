Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640200;
	b=LEFWktJw9HY7DMrk4q7lsr95m+hCZKTGQ6DgJd5H9BLlAdwmsGoPHV19MnS+3/Bmo4BY
	 DPX9CCG40Wc0IyGloYUTvRtyc2yGZMyh5yQ2NfFcN+SNAgZPGZkty2+derCB9XPG4cC+u
	 /B44IlsjoxnO8HRo40qi68GXFZZJTWBdY3lbMOwdTCm48fY6/R1+XNSeTRQpl8CnKl+j7
	 ckdZu2i6w2hTqqP5Jv5bbxZIFSL6swG1SUkGyKD6T6u0v20mN0jXfq4C0DGT3xL0wDSJ9
	 TmA2JXJP8/IY9cMyE1ZiQLPHuwtFY7+DNtYCPGgf9ErdwxcU0hg3Ui1yJkaMmEUUWnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640200;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ieIQfA4sCRRbJqIhDZWmmkGRjOteS/0ON3f7FeFQ4mg=;
	b=d/aSCQgmdS0FOcSS9cHY5rFR/myOr7v65VasJ1Pv2vFsPwoBv3L2c7ONgAbt34u7rLjN
	 xA/uv4TIA+R1ZeH72V6CjkPZ5q/2mzcIIWXM4kmHp6VZFBEf3NGdhbcE2Y4WdNnQMkBDL
	 T2bikqGwU6q8RfNhNhNvSp32M21RkfHV89N6t4LXI53BYhEVid57KKLd7NeezX8oSpkvT
	 guqANjma94NtFtxLzNzJ5kR7gzzh1W4iZ849DLG34FXp+BXzcmq7CtXYucfuyZJoqgVIn
	 DO6FR5yR0+xRF75v7shsqC4sw15tc0jxMsqKl1ynk6kb0HRsGV7ql7uhX5mhYAE4XpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6bE+ZZJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0B606A31D;
	Thu, 22 Oct 2026 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6bE+ZZJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EA61F000C2;
	Thu, 22 Oct 2026 03:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792640200;
	bh=ieIQfA4sCRRbJqIhDZWmmkGRjOteS/0ON3f7FeFQ4mg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=g6bE+ZZJ3sL520yq3Cfezx5I8o9jzMGgEZ7WlfNbSxMJwkx5wuaqEeUrRlWWpb5z+
	 r7D5UvBVbR1y3pBPfaiNqbxYSHbMgp/7tiGoYxX6uQRPtrN/+NUn55wAh7nLYyuY0u
	 Y5ojHtjLSfZGfo1aS1336+F1z05kBDkczmj1CwVlIu+3L3xxnX+VmKbZ9ubiGncGGN
	 c+8z9Mafzvbb+gGuFrA+1j48itnsK9PPD0gGQNBV5fqosSh4SQxsL93qSMMa5QDl47
	 XdjZCjA7gOaK+Gt3Hk1PEZkAVmh8FA473FDdMsrrgPjoSZsnwcBCyoJMqo81/XNEsN
	 jh+XPwe9Je0PA==
Subject: Re: [PATCH v5 08/10] can: peak_usb: reject records for unset channels
 in PCAN-USB Pro
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 22 Oct 2026 03:36:39 +0000
Message-ID: <179264019905.3131.17443314322038603114@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v5-8-a62b35b867f0@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v5-8-a62b35b867f0@peak-system.fr>
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

- [Low] In pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error()
  (drivers/net/can/usb/peak_usb/pcan_usb_pro.c), a well-formed record…

Pre-existing issues:
- [High] At this commit, if channel 0 is opened by userspace while still
  in peak_usb_create_dev() (register_candev() runs before dev_init() and…
- [High] pcan_usb_pro_handle_canmsg()
  (drivers/net/can/usb/peak_usb/pcan_usb_pro.c:559-567) takes the…
- [Medium] pcan_usb_pro_decode_buf() reads pr->data_type for the next
  record before checking that rec_ptr < msg_end.

--

can: peak_usb: reject records for unset channels in PCAN-USB Pro

This patch changes the PCAN-USB Pro record decoders so they reject CAN
and status records whose channel slot in usb_if->dev[] is NULL. It also
clears the channel slot in pcan_usb_pro_free(). Slots are published with
smp_store_release() and read with READ_ONCE().

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
Should a well-formed record for an unset channel cause the rest of the
transfer to be dropped?

pcan_usb_pro_decode_buf() treats any negative return from the handlers
as fatal:

		case PCAN_USBPRO_RXRTR:
			err = pcan_usb_pro_handle_canmsg(usb_if, &pr->rx_msg);
			if (err < 0)
				goto fail;

Suppose channel 0 is open while channel 1's dev_init() is still running.
A channel 1 record then makes the decoder skip every later record in the
same bulk-IN transfer, including channel 0 frames and RXTS records.

The buffer is then dumped twice: once in pcan_usb_pro_decode_buf() and
once in peak_usb_read_bulk_callback(). Neither dump is rate limited at
this commit.

Would it be better to skip just this record, for example by returning 0?
The same applies to the new check in pcan_usb_pro_handle_error().

Later in the series, "can: peak_usb: register the netdevs only once all
channels are set up" moves register_candev() into peak_usb_probe(),
after all channels are initialized. That seems to make this branch
unreachable by the end of the series. Also, "can: peak_usb: only dump
received bytes on decode error" rate-limits the dump in the core.

> +
>  	netdev = dev->netdev;
>  
>  	skb = alloc_can_skb(netdev, &can_frame);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Since
this function is being changed anyway: can the payload memcpy() further
down in pcan_usb_pro_handle_canmsg() read past the record and past the
RX buffer?

pcan_usb_pro_handle_canmsg() {
    ...
	can_frame->len = rx->len & 0x0f;
    ...
		memcpy(can_frame->data, rx->data, can_frame->len);
    ...
}

The length comes from a nibble set by the device (0..15). The only check
in pcan_usb_pro_decode_buf() is that the record size chosen by data_type
fits in the transfer:

	[PCAN_USBPRO_RXMSG4] = sizeof(struct pcan_usb_pro_rxmsg) - 4,
	[PCAN_USBPRO_RXMSG0] = sizeof(struct pcan_usb_pro_rxmsg) - 8,

An RXMSG0 record is 12 bytes, so its data[] lies entirely after the
record. An RXMSG0 or RXMSG4 record with a length nibble of 8 would copy
bytes from past the end of the record.

Those bytes are stale or uninitialized parts of the 1024-byte RX buffer
that peak_usb_start() allocates with kmalloc(). If the record ends at
exactly 1024 bytes, the bytes come from beyond the allocation.

The frame passes can_is_can_skb() because len <= 8, and it is delivered
through netif_rx(). Can those kernel bytes then reach CAN_RAW sockets
through raw_recvmsg()?

With a nibble of 9..15, the memcpy() writes past the 8-byte
can_frame->data field into skb tailroom. That would trip the
FORTIFY_SOURCE field-spanning write check.

The issue is still present at the end of the series. Could the code
reject len > CAN_MAX_DLEN? It could also reject any length larger than
the record format provides: 0 for RXMSG0 and RXRTR, 4 for RXMSG4, and 8
for RXMSG8.

[ ... ]

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
> +
>  	netdev = dev->netdev;

[Severity: Medium]
This isn't a bug introduced by this patch, but does the caller,
pcan_usb_pro_decode_buf(), read pr->data_type before checking rec_ptr
against msg_end?

	for (; rec_cnt > 0; rec_cnt--) {
		union pcan_usb_pro_rec *pr = (union pcan_usb_pro_rec *)rec_ptr;
		u16 sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];

rec_cnt comes from the device. Take a 1024-byte transfer holding the
4-byte header and 51 complete RXMSG8 records (4 + 51 * 20 = 1024), with
rec_cnt set to 52. After the last record, rec_ptr points to the end of
the allocation, and the next iteration reads one byte past it.

The byte is only used as an index into the 256-entry table, and the
result then fails one of the checks that follow. The effect is a 1-byte
out-of-bounds slab read that KASAN would report. This code is unchanged
at the end of the series.

[ ... ]

> @@ -981,6 +992,9 @@ static void pcan_usb_pro_exit(struct peak_usb_device *dev)
>   */
>  static void pcan_usb_pro_free(struct peak_usb_device *dev)
>  {
> +	/* clear this channel's slot: dev is going to be freed */
> +	WRITE_ONCE(pcan_usb_pro_dev_if(dev)->dev[dev->ctrl_idx], NULL);
> +
>  	/* last device: can free pcan_usb_pro_interface object now */
>  	if (!dev->prev_siblings && !dev->next_siblings)
>  		kfree(pcan_usb_pro_dev_if(dev));

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
can usb_if still be used after this kfree() for channel 0?

At this commit, peak_usb_create_dev() calls register_candev() before
dev_init() and dev_set_bus(). Suppose userspace opens can0 in that
window, and dev_set_bus(dev, 0) then fails. The error path runs:

adap_dev_free:
	peak_usb_stop_rx(dev->prev_siblings);   /* NULL for channel 0 */

	if (dev->adapter->dev_free)
		dev->adapter->dev_free(dev);        /* kfree(usb_if) */

lbl_unregister_candev:
	unregister_candev(netdev);

peak_usb_stop_rx(NULL) stops nothing, so channel 0's own RX URBs keep
running. pcan_usb_pro_decode_buf() keeps using the usb_if returned by
pcan_usb_pro_dev_if(dev), and clearing the slot does not cover that
access.

unregister_candev() then closes the netdev, and ndo_stop reaches
pcan_usb_pro_stop(), which runs this on the freed object:

	pdev->usb_if->dev_opened_count--;

Later in the series, "can: peak_usb: register the netdevs only once all
channels are set up" removes register_candev() and the
lbl_unregister_candev label from peak_usb_create_dev(). After that, no
netdev can be open when adap_dev_free runs, which seems to fix this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v5-0-a62b35b867f0%40peak-system.fr
