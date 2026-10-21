Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623533;
	b=stkL/4XskZNObYi+Ebh834irqz4lzp0VLJERCnnbaNcjusxmZ6lYdQDdnmIQkAQ4mxcD
	 VHttVtZiDxT4Vs9eAkFEtfToMjN84QZ0SD/NVO2FcJkjcr+zuxUC6gr7JfB0fj1+NluQB
	 l2kF2Eed7ivo3ArqhCZlqFLxxdDRAgCKQra44Uj2d0Z3n4CQxG2uR8mpLRtIUDqSM1NIz
	 3SXlqPqHdKKBxdnO2sUpwM20USqr3Q/e0a0EvFQ4KOPsexqlk94nskfTNCr8yQzIB3mM5
	 84EQO1I/0lA/WUCN6VxdNDzwx37b4pl2ZSg2sEpV+39GTVnNef9kEuLokCXVY8AVmZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623533;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zhwllRRX2sUYTNO4VtuzaJQU7Au3DiF+92vgYmQFd5g=;
	b=QKFW2L2R39CNNXQ85HdGhYL+2M+aPmxpjQWuhb3sxjuRE94qd+CmdOWeJlRTbNQdvyG+
	 K1dqvcxWMmMmB78NBha+E2S/fDn1HwPz4J4sivLK5UE5SAHcfnzZgdvgC5sg7w6QakIRq
	 bz64+BNiWtB0yiy8srYEkAgEJZAdxQ31cbPlqSvJ6fVHRwifIs6Y8NLwrWaQPzTeJdgw5
	 w9b43WLZSaOClKqse5PPzK3Q+r4scULOr9ujpCzLuXVgwKSTx4n1HFIzCJ7gio0yP9jli
	 Tzwql7D6TFDEEUefQSeBdyM/MfNbA9B+yG5fmFGyQ4b9CX7o4gaG8lSQWoHSAsjn+5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oa+BWPwM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF5606A31D;
	Wed, 21 Oct 2026 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oa+BWPwM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DB21F000C8;
	Wed, 21 Oct 2026 22:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623533;
	bh=zhwllRRX2sUYTNO4VtuzaJQU7Au3DiF+92vgYmQFd5g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Oa+BWPwMhcrOa3HJraNQ4sX01st2Vl99BUM8jK/csC9GmSiFkzuE6GVVNqfnH+5pr
	 0dqRfBfIg29IkSGYAdoarYGkcF8knj2Hyj09MHlnb/ZPLRJOXA3+GTWU7ypWa4boz2
	 f2tg+ylh4V6nY6Sthv27ICSJQud4Ji+TznyVEDI8Ttz/moxh2taBAVw9BnFzhbm+5D
	 yI/fLPxWo3eawgfMSuNUMd8wjL/G+hJt+PKxEeewUJGQGjgsFET30AV21mgqk9qs47
	 0VUi92g4c3ekJLO5YCxPQXwNVmJyI1iQjnodu+C35w02bBZYlj0miIs1UkoW7C4GAr
	 i3A+KNKugP97w==
Subject: Re: [PATCH v3 08/10] can: peak_usb: reject records for unset channels
 in PCAN-USB Pro
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Wed, 21 Oct 2026 22:58:52 +0000
Message-ID: <179262353226.3131.5986483071938580034@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v3-8-74d17c5a599e@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v3-8-74d17c5a599e@peak-system.fr>
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

- [Low] The fix for the stale slot after a failed probe of channel 1
  relies on core code from an earlier patch, and the commit message does…
- [Low] In pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error(),
  a record for a channel whose slot is still NULL now returns -EINVAL.
- [Low] The header comment on pcan_usb_pro_free() still reads 'called
  when PCAN-USB Pro adapter is unplugged'.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  peak_usb_create_dev() calls register_candev(netdev) (line 1001) before…
- [High] At this commit, if dev_set_bus(dev, 0) fails while probing
  channel 0, the adap_dev_free path in peak_usb_create_dev() calls…
- [High] This problem wasn't introduced by this patch, but
  pcan_usb_pro_handle_canmsg() trusts the DLC nibble from the device.

--

can: peak_usb: reject records for unset channels in PCAN-USB Pro

This patch makes the PCAN-USB Pro RX decoders reject CAN and status
records whose channel slot in usb_if->dev[] is still NULL, instead of
dereferencing it. The slot is published with smp_store_release() in
pcan_usb_pro_init() and cleared in pcan_usb_pro_free(), so a failed probe
of channel 1 no longer leaves a stale pointer behind.

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
Should an empty slot count as a fatal decode error?
pcan_usb_pro_decode_buf() treats any negative return as fatal:

		case PCAN_USBPRO_RXRTR:
			err = pcan_usb_pro_handle_canmsg(usb_if, &pr->rx_msg);
			if (err < 0)
				goto fail;

The goto skips rec_ptr += sizeof_rec and leaves the rec_cnt loop. That
drops every remaining record in the same bulk-in transfer, including
channel-0 CAN frames, channel-0 RXSTATUS records (a BUS_OFF transition,
for example) and RXTS calibration records.

The fail path then dumps the whole buffer with pcan_dump_mem(), which is
not rate limited. peak_usb_read_bulk_callback() dumps it again. A later
patch in the series rate limits only that second dump.

Before this patch, -EINVAL here meant a malformed record (ctrl_idx out of
range). An empty slot is an expected, temporary state for a well-formed
record, in exactly the window the commit message describes. The default
case in pcan_usb_pro_decode_buf() skips records it does not handle.

This is still better than the NULL dereference it replaces. Would
skipping the record (returning 0) fit better, though? The same question
applies to the new check in pcan_usb_pro_handle_error().

If stopping is intended, could the commit message say so? It only says
"Reject records", while the sibling FD commit says the decoder stops
processing the rest of the URB.

> +
>  	netdev = dev->netdev;
>  
>  	skb = alloc_can_skb(netdev, &can_frame);

[Severity: High]
This is a pre-existing issue, but since this patch hardens
pcan_usb_pro_handle_canmsg() against untrusted channel numbers, what
about the DLC nibble from the same record?

	can_frame->len = rx->len & 0x0f;
	...
		memcpy(can_frame->data, rx->data, can_frame->len);

can_frame->len can be anything from 0 to 15 and is not checked against
CAN_MAX_DLEN. can_frame->data and rx->data are both 8 bytes.

The DLC is also not checked against the real record size.
pcan_usb_pro_decode_buf() only checks rec_ptr + sizeof_rec > msg_end,
using pcan_usb_pro_sizeof_rec[]. That is 20 bytes for RXMSG8, 16 for
RXMSG4, and 12 for RXMSG0/RXRTR, which carry no data.

So a broken or malicious device could:

(a) put an RXMSG0 record with the RTR flag clear at the end of a full
1024-byte transfer. It passes the bound check, and memcpy() reads up to
15 bytes past the kmalloc(PCAN_USBPRO_RX_BUFFER_SIZE) buffer allocated
in peak_usb_start().

(b) send a short record with DLC <= 8. This copies bytes from beyond the
record (stale kmalloc contents past actual_length, or a neighboring slab
object) into a valid CAN frame, and CAN_RAW delivers that frame to
unprivileged sockets.

(c) use DLC 9..15. This writes up to 7 bytes past can_frame->data, which
FORTIFY_SOURCE reports as a field-spanning write.

Should the DLC be clamped to CAN_MAX_DLEN and checked against the record
type's payload size? No later patch in the series touches
pcan_usb_pro.c.

[ ... ]

> @@ -933,7 +943,8 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
>  	}
>  
>  	pdev->usb_if = usb_if;

[Severity: High]
This isn't a bug introduced by this patch, but pdev->usb_if is only set
here, and pcan_usb_pro_init() runs after the netdev is registered. Can
pcan_usb_pro_start() dereference a NULL usb_if?

peak_usb_create_dev() does:

	err = register_candev(netdev);
	...
	if (dev->adapter->dev_init) {
		err = dev->adapter->dev_init(dev);

Once the netdev is registered, a privileged process, or a network
manager reacting to RTM_NEWLINK, can set the bitrate and bring the
interface up. peak_usb_ndo_open() only checks PCAN_USB_STATE_CONNECTED,
and that bit is set before registration:

peak_usb_ndo_open()
  peak_usb_start()
    pcan_usb_pro_start()
      if (pdev->usb_if->dev_opened_count == 0) {

For channel 0, the window covers the synchronous USB requests in
pcan_usb_pro_init() (firmware info, bootloader info, drv_loaded). The
oops happens under rtnl_lock, so RTNL is never released.

The new slot check does not cover this, because the NULL pointer is
usb_if itself. The series does not fix it either.

> -	usb_if->dev[dev->ctrl_idx] = dev;
> +	/* publish dev to the decoders */
> +	smp_store_release(&usb_if->dev[dev->ctrl_idx], dev);
>  
>  	/* set LED in default state (end of init phase) */
>  	pcan_usb_pro_set_led(dev, PCAN_USBPRO_LED_DEVICE, 1);
> @@ -981,6 +992,9 @@ static void pcan_usb_pro_exit(struct peak_usb_device *dev)
>   */
>  static void pcan_usb_pro_free(struct peak_usb_device *dev)
>  {

[Severity: Low]
This isn't a bug, but the comment above pcan_usb_pro_free() still says:

/*
 * called when PCAN-USB Pro adapter is unplugged
 */

The slot clearing added here exists for the other caller, the probe
failure path in peak_usb_create_dev(). pcan_usb_fd_free() uses the same
slot scheme, and its comment was updated to "called when the USB adapter
is unplugged, or when probing a sibling fails". Should this comment be
updated the same way?

> +	/* clear this channel's slot: dev is going to be freed */
> +	WRITE_ONCE(pcan_usb_pro_dev_if(dev)->dev[dev->ctrl_idx], NULL);

[Severity: Low]
The commit message says this handles the case where "probing channel 1
fails after its slot has been filled". Is clearing the slot enough by
itself?

A channel-0 RX completion that loaded dev[1] before this WRITE_ONCE()
can still use the channel-1 peak_usb_device after free_candev().

What closes that window is the peak_usb_stop_rx() call in the
adap_dev_free path of peak_usb_create_dev(). It poisons channel 0's RX
anchor and waits for running completions:

adap_dev_free:
	...
	peak_usb_stop_rx(dev->prev_siblings);

	if (dev->adapter->dev_free)
		dev->adapter->dev_free(dev);

That helper and this call came from the earlier commit "can: peak_usb:
harden channel handling in PCAN-USB FD". Its subject only names the FD
adapter, and its Fixes: tag (a6921dd524fe) differs from the one here
(d8a199355f8f).

A stable backport that picks only this patch by its Fixes: tag would be
incomplete. Could the commit message mention the dependency?

> +
>  	/* last device: can free pcan_usb_pro_interface object now */
>  	if (!dev->prev_siblings && !dev->next_siblings)
>  		kfree(pcan_usb_pro_dev_if(dev));

[Severity: High]
This is a pre-existing issue, but what happens to usb_if when
dev_set_bus(dev, 0) fails while probing channel 0?

For channel 0, dev->prev_siblings is NULL, so
peak_usb_stop_rx(dev->prev_siblings) does not touch channel 0's own RX
URBs. pcan_usb_pro_free() then kfree()s usb_if because channel 0 has no
siblings. Only after that does the adap_dev_free path call
unregister_candev(netdev).

If userspace opened the netdev during probe, an RX completion in that
window would use the freed usb_if in pcan_usb_pro_decode_buf():

	struct pcan_usb_pro_interface *usb_if = pcan_usb_pro_dev_if(dev);

Then unregister_candev() reaches pcan_usb_pro_stop() through ndo_stop,
which reads and decrements freed memory:

	pdev->usb_if->dev_opened_count--;

It looks like the later commit in this series, "can: peak_usb:
unregister the netdev before dev_free() on probe failure", fixes this.
It calls unregister_candev() before dev_free(), so the final state of
the series is not affected.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v3-0-74d17c5a599e%40peak-system.fr
