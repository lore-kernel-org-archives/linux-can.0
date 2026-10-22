Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792628968;
	b=Y/Qs4mPUn+Xubc8a4agPVA2vrQJ5Yst0blLb0UgKG4gMk0yGvnVZ5yv8lPlg80/G5zDN
	 wdP48P3c/TkTPLKFtVPL/x8WB4QvwEvl8czU9bZYpEImzHr6ZJ4VCC3++jY+l7JM/8Gqn
	 Y+f8v3xahGugwxLFf2b+15kwZ2FLDKrFqGeqFxB6jxOg3CUgDQNjqve3v1lqzKM/ON5hn
	 Ik6PwNmk5FcpM7OhTclnlCBsGEbh54UdsGu5NBZ9rzNO7vtDcmFFj2jOJGq9hP6RRGCzR
	 AMBlPEpWqX/57/6Z0bKO6OR3bS10O3bqIYIR5GKCMhMsbeH/qwty4FJ6qp3NY1oWh7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792628968;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cWxFRUTcb/IyV74W9WQGkYLCYb/7xRti8tWVl0En80M=;
	b=zh3GPeekzFmD5YWfWli4nFivGCZKn0/7eN4JoGD1ZfcwARxIBvL2Upi2eFq8pF5ZqDFO
	 DeNP6Ft3VMcUHK1QGF9bQj+6YSQzbfLAqzexYUNPHW8ChlX3BEKldW0tZGaK1F4PT+eP9
	 /77IHkJdI8kgJmZnWwzJ5VNLT29JwwA5WnP29Dhlq8NdSbQP0fpKzXHFieNZGKBWpw/xb
	 f0MkVlvT8Nhq3O5Q3pDnSa0BVnviyKOrgpJyX98ZVxVh3n6ozKoj+UxPEin3Czg8Do2Rx
	 5AOZvP9VqwWVS/Xb3yy0MfCL7qOXuIIpmOrxT70irQFcY7Aax3fXXJh5xc0QbkcWQlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QC0nRbpU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A8606A322;
	Thu, 22 Oct 2026 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QC0nRbpU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C7C1F000C1;
	Thu, 22 Oct 2026 00:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792628967;
	bh=cWxFRUTcb/IyV74W9WQGkYLCYb/7xRti8tWVl0En80M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QC0nRbpUZSTOe+CDu+Xclaz0FMpE11MH3SLEhEOr8kfyaIQHABsfPa63qy45ij0LQ
	 bKnrJR+aXdqUMh49+vHjwdWOh/FYecTPqhDh2LtZ5kSziO6S5RgdMovrMqNDB3Z2NF
	 Iv6ta2R+KvG0fu1L9wyQ6DKi8bQgzQIWJAGeurbxKQ40YAvprMx+f+t56mjVPV0oRW
	 td/BVyH5y4HtHnIp5DZYLD0+x/IjshA81bqTi9xfEeWf3VBvIo+6WBSnJa59Ptt//P
	 n7pDLdYTyzQ1rut8f3NtUE4/YhOYIcwHOkGS27tsRCqDuzQAr5CFsykq5ZpUQRIFnC
	 tOLHm6i2V5g1Q==
Subject: Re: [PATCH v4 08/10] can: peak_usb: reject records for unset channels
 in PCAN-USB Pro
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 22 Oct 2026 00:29:26 +0000
Message-ID: <179262896688.3131.17836055210871710516@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v4-8-bfbde81f8bab@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v4-8-bfbde81f8bab@peak-system.fr>
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

- [Low] pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error() now
  return -EINVAL when usb_if->dev[ctrl_idx] is NULL.

Pre-existing issues:
- [High] At this commit, peak_usb_create_dev() registers the netdev
  before dev_init()/dev_set_bus().
- [High] At this commit, peak_usb_create_dev() calls register_candev()
  before dev->adapter->dev_init().
- [High] pcan_usb_pro_handle_canmsg() takes the payload length from the
  device (`can_frame->len = rx->len & 0x0f`, so 0..15) and runs…
- [Medium] pcan_usb_pro_decode_buf() loops on the device-supplied rec_cnt
  and reads pr->data_type (`pcan_usb_pro_sizeof_rec[pr->data_type]`)…

--

can: peak_usb: reject records for unset channels in PCAN-USB Pro

With this patch, the PCAN-USB Pro decoders reject CAN message and status
records for a channel whose slot in usb_if->dev[] is NULL. The slot is
now published with smp_store_release() in pcan_usb_pro_init() and
cleared in pcan_usb_pro_free().

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
Is -EINVAL the right return value here? pcan_usb_pro_decode_buf() treats
any negative return from the record handlers as fatal for the whole
transfer:

pcan_usb_pro_decode_buf() {
    ...
		case PCAN_USBPRO_RXRTR:
			err = pcan_usb_pro_handle_canmsg(usb_if, &pr->rx_msg);
			if (err < 0)
				goto fail;
			break;
    ...
fail:
	if (err)
		pcan_dump_mem("received msg",
			      urb->transfer_buffer, urb->actual_length);
}

Both channels share the PCAN_USBPRO_EP_MSGIN bulk-in endpoint, and their
records sit back to back in a single transfer. Suppose one channel 1
record arrives before pcan_usb_pro_init() has published dev[1]. Then
every later record in that transfer is dropped, including valid
channel 0 CAN frames, channel 0 RXSTATUS records, and the RXTS records
that feed usb_if->time_ref.

pcan_usb_pro_decode_buf() also hex dumps each such transfer without rate
limiting. At this commit, peak_usb_read_bulk_callback() dumps it a
second time. A later patch in the series, "can: peak_usb: only dump
received bytes on decode error", rate limits that second dump. The
dump in pcan_usb_pro_decode_buf() and the dropped records are still
there at the end of the series.

sizeof_rec has already been computed and bounds checked for this record.
Could the handler return 0, or the loop skip just this record? Only the
record for the unset channel would then be rejected, which is what the
commit message describes. The same question applies to the new check
in pcan_usb_pro_handle_error().

> +
>  	netdev = dev->netdev;
>  
>  	skb = alloc_can_skb(netdev, &can_frame);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Since
this function now validates the channel from the device, should the
payload length be validated as well? Further down in
pcan_usb_pro_handle_canmsg():

	can_frame->len = rx->len & 0x0f;
	...
	} else {
		memcpy(can_frame->data, rx->data, can_frame->len);

The device sets can_frame->len to any value from 0 to 15. Nothing checks
it against CAN_MAX_DLEN or against the payload the record type actually
carries. pcan_usb_pro_decode_buf() checks record bounds only against
the fixed size for each type:

	[PCAN_USBPRO_RXMSG0] = sizeof(struct pcan_usb_pro_rxmsg) - 8,
	[PCAN_USBPRO_RXRTR] = sizeof(struct pcan_usb_pro_rxmsg) - 8,

A device could end a transfer with a 12 byte RXMSG0 record carrying
len = 8 (or an RXRTR record with PCAN_USBPRO_RTR clear). That record
passes the rec_ptr + sizeof_rec > msg_end check. Can the memcpy() then
read 8 bytes past urb->actual_length?

If the record ends exactly at the end of the 1024 byte RX buffer
kmalloc()ed in peak_usb_start(), the read runs past the slab object.
With a shorter transfer, it reads stale bytes from the buffer, which is
not zeroed. In both cases those bytes reach CAN sockets through
netif_rx().

Lengths 9 to 15 also write up to 7 bytes past can_frame->data[].

Could the length be clamped to CAN_MAX_DLEN and checked against the
record size? This code is unchanged at the end of the series.

[Severity: Medium]
This is another pre-existing issue that this patch did not introduce.
pcan_usb_pro_decode_buf() reads the type byte of the next record before
it checks that the record is inside the transfer:

	for (; rec_cnt > 0; rec_cnt--) {
		union pcan_usb_pro_rec *pr = (union pcan_usb_pro_rec *)rec_ptr;
		u16 sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
		...
		if (rec_ptr + sizeof_rec > msg_end) {

rec_cnt comes from the device. Suppose it overstates the number of
records and the previous record ended exactly at msg_end. Then
pr->data_type reads transfer_buffer[actual_length]. When actual_length
equals PCAN_USBPRO_RX_BUFFER_SIZE, is that a 1 byte out-of-bounds read
of the RX buffer?

The value is only used as an index into pcan_usb_pro_sizeof_rec[], so
nothing is passed on. Would a rec_ptr >= msg_end check at the top of
the loop be enough? This is still present at the end of the series.

[ ... ]

> @@ -933,7 +943,8 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
>  	}
>  
>  	pdev->usb_if = usb_if;
> -	usb_if->dev[dev->ctrl_idx] = dev;
> +	/* publish dev to the decoders */
> +	smp_store_release(&usb_if->dev[dev->ctrl_idx], dev);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Does
the new !dev check get reached at all while pdev->usb_if is still NULL?
At this commit, peak_usb_create_dev() calls register_candev() before
dev->adapter->dev_init():

	err = register_candev(netdev);
	...
	if (dev->adapter->dev_init) {
		err = dev->adapter->dev_init(dev);

So the channel can be opened before pcan_usb_pro_init() sets
pdev->usb_if. In that window, pcan_usb_pro_start() dereferences the NULL
pointer:

	if (pdev->usb_if->dev_opened_count == 0) {

An RX completion that reaches pcan_usb_pro_decode_buf() in that window
also gets usb_if == NULL from pcan_usb_pro_dev_if(). The record handlers
then dereference usb_if->dev[] or usb_if->cm_ignore_count before the
new check runs.

This looks fixed later in the series by "can: peak_usb: register the
netdev only once the channel is set up". That patch moves
register_candev() after dev_init() and dev_set_bus().

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
This is a pre-existing issue and was not introduced by this patch. Can
this kfree() still race with channel 0's own RX URBs and with its
ndo_stop? At this commit, peak_usb_create_dev() does the following when
dev_set_bus() fails:

adap_dev_free:
	...
	peak_usb_stop_rx(dev->prev_siblings);

	if (dev->adapter->dev_free)
		dev->adapter->dev_free(dev);

lbl_unregister_candev:
	unregister_candev(netdev);

For channel 0, dev->prev_siblings is NULL, so no RX URBs are stopped.
There is no sibling yet either, so pcan_usb_pro_free() frees the shared
pcan_usb_pro_interface.

If channel 0 was opened after pcan_usb_pro_init(), its RX completions
still reach pcan_usb_pro_decode_buf(). That function reads
usb_if->dev[], time_ref and cm_ignore_count from the freed object.

unregister_candev() then calls ndo_stop, and pcan_usb_pro_stop() writes
to the freed memory:

	pdev->usb_if->dev_opened_count--;

This also looks fixed later in the series by "can: peak_usb: register
the netdev only once the channel is set up". In that patch,
register_candev() comes after dev_set_bus(), and the adap_dev_free path
no longer calls unregister_candev().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab%40peak-system.fr
