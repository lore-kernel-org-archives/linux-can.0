Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5560F1F2B88;
	Sun, 11 Oct 2026 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791694412; cv=none; b=VP5HmQr20UehwaCtGqnul5B9MFOB5vau6Pm19cB6woZkzxfQntV73LWbKnQYNISRzxOKKCeC5yyIWD17JT8PrmoMp28l+ZkvCWS2JSYL8wYOYoMsn62SecN+VeX4mfqIbzEygu8lzA7H7mepLoF0rAFkKsD4qStdkw3KHqbl3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791694412; c=relaxed/simple;
	bh=mZgh9yI9OmbLyL8eNP9eoqhiPa87bzFuEH5j5Rftmw8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R+JfP7+9KnqV3QfqiJmQen+M8vA3+c/qUq5XtDh12wbrp7PBmJjT6gqEEnFziywjV27EANLu+ksKzb4r5yNNWFA8KIhdFkv+HlFTGDrsDvh6N4/ol3q0yZVrthYoiPjkdn1Wyf8ghIvSznFnjA6NQVy9r5HIckRxETb7ZBnB1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx5c1zyG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx5c1zyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735141F0089C;
	Sun, 11 Oct 2026 04:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791694410;
	bh=LGeO6ksy8VCKxkWaQ9ktRuRkxQmiG9bQPiNztI5zaq8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wx5c1zyGcV0jyBEo9pB34kzcvkcs8V7FFTx32cXipt6m7pIpAAJuTIlUb6ojbQ9kU
	 6MypevsYsyfTGGbBM7uiItP/WcBf9UNBsvMrzUNwIVYbrw7875RDstStvnyTk1ZR+v
	 4js0n7Ac/UGEDwwYX2x4EGr/M8bUinUvlqGSV/dGIRL+eNbJ9T+dvIPFxbyCjECif9
	 s01BDsY0bEHxU3d7NLkv67Vt6He8xKTP9H5zKrzartIA1WyzOyNS/n2awW8Qa/Mya2
	 PsHkTxMXqr4+7/GQ0FUSE542KVxH4ow5MalQ94cwLkbVVWej0FxQ1SIVlPklWSLdYj
	 DK9OaRcC594hg==
Subject: Re: [PATCH v2 5/5] can: peak_usb: harden PCAN-USB message validation
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sun, 11 Oct 2026 04:53:30 +0000
Message-ID: <179169441005.1406898.14224990493927376539@kernel.org>
In-Reply-To:
 <20261009-canfd_check_channel_idx-v2-5-f7b772929791@peak-system.fr>
References:
 <20261009-canfd_check_channel_idx-v2-5-f7b772929791@peak-system.fr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch says it rejects PCAN-USB messages that would cause
  reads outside the received USB data, but one path is still unchecked:…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the encoder
  and decoder disagree on the wire layout for RTR frames with SRR set.
- [Medium] This problem wasn't introduced by this patch, but when the
  decoder rejects a message, the diagnostic dump prints the whole rx…

--

can: peak_usb: harden PCAN-USB message validation

This patch adds bounds checks to the PCAN-USB rx decoder. The status_len
byte at the start of each record and the SRR private-id byte after a data
frame are now consumed only if they fit inside the received USB buffer.
Malformed messages are rejected with -EINVAL.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 169c00d93463c..56ddd134bae0f 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -696,8 +696,11 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
>  		mc->ptr += rec_len;
>  
>  		/* Ignore next byte (client private id) if SRR bit is set */
> -		if (can_id_flags & PCAN_USB_TX_SRR)
> +		if (can_id_flags & PCAN_USB_TX_SRR) {
> +			if ((mc->ptr + 1) > mc->end)
> +				goto decode_failed;
>  			mc->ptr++;
> +		}

[Severity: Medium]
This is a pre-existing issue, but is the private-id byte also present for
RTR frames?

In pcan_usb_decode_data(), this skip and the new check exist only in the
non-RTR branch:

	if (status_len & PCAN_USB_STATUSLEN_RTR) {
		cf->can_id |= CAN_RTR_FLAG;
	} else {
		...
		if (can_id_flags & PCAN_USB_TX_SRR) {

But pcan_usb_encode_msg() appends the writer id for RTR frames as well:

	/* can data */
	if (!(cf->can_id & CAN_RTR_FLAG)) {
		memcpy(pc, cf->data, cf->len);
		pc += cf->len;
	}

	/* SRR bit needs a writer id (useless here) */
	if (can_id_flags & PCAN_USB_TX_SRR)
		*pc++ = 0x80;

SRR is set whenever CAN_CTRLMODE_LOOPBACK is enabled. Suppose the firmware's
loopback echo of an RTR frame includes that byte. Then mc->ptr is left
pointing at it, and pcan_usb_decode_msg() reads 0x80 as the next status_len
byte.

PCAN_USB_STATUSLEN_INTERNAL is clear in 0x80, so the byte would be decoded
as a bogus standard-ID data frame. Every later record in the URB would then
be parsed out of phase. That gives phantom frames, or an early -EINVAL that
drops the rest of the URB.

The real RTR echo format can't be confirmed from the source. Both the
encoder and decoder lines came from the same commit 3a7939495ce8, so the
difference may be intentional. The later reads are bounds-checked, so no
out-of-bounds access results.

Could the firmware behaviour be checked either way?

> @@ -733,14 +736,19 @@ static int pcan_usb_decode_msg(struct peak_usb_device *dev, u8 *ibuf, u32 lbuf)
>  	int err;
>  
>  	for (err = 0; mc.rec_idx < mc.rec_cnt && !err; mc.rec_idx++) {
> -		u8 sl = *mc.ptr++;
> -
> -		/* handle status and error frames here */
> -		if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
> -			err = pcan_usb_decode_status(&mc, sl);
> -		/* handle normal can frames here */
> +		/* check if status_len byte can be read next */
> +		if (mc.ptr >= mc.end) {
> +			err = -EINVAL;

[Severity: Medium]
This isn't a bug introduced by this patch, but this new -EINVAL path (and
the truncated SRR one above) leads to the diagnostic dump in
peak_usb_read_bulk_callback():

	err = dev->adapter->dev_decode_buf(dev, urb);
	if (err)
		pcan_dump_mem("received usb message",
			      urb->transfer_buffer,
			      urb->transfer_buffer_length);

Doesn't this dump the full rx_buffer_size allocation instead of only the
urb->actual_length bytes the device sent?

The rx buffers come from kmalloc() in peak_usb_start() and are not zeroed.
After a short malformed transfer such as [00 01 00] (truncated CAN id), the
bytes past the received data are uninitialized slab contents.

pcan_dump_mem() prints them at KERN_INFO with print_hex_dump(), with no rate
limit and no debug-only guard. Earlier decode failures could already reach
this dump.

Would it make sense to pass urb->actual_length here instead?

>  		} else {
> -			err = pcan_usb_decode_data(&mc, sl);
> +			u8 sl = *mc.ptr++;
> +
> +			/* handle status and error frames here */
> +			if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
> +				err = pcan_usb_decode_status(&mc, sl);

[Severity: High]
Can a truncated bus event record still cause an out-of-bounds read here?

pcan_usb_decode_status() only checks that the function and number bytes
fit, and then advances past them:

	if ((mc->ptr + 2) > mc->end)
		return -EINVAL;

	f = mc->ptr[PCAN_USB_CMD_FUNC];
	n = mc->ptr[PCAN_USB_CMD_NUM];
	mc->ptr += PCAN_USB_CMD_ARGS;

At this point mc->ptr can equal mc->end. Suppose the timestamp bit is clear,
f is PCAN_USB_REC_BUSEVT, and n is PCAN_USB_ERR_CNT_DEC or
PCAN_USB_ERR_CNT_INC. Then the call goes straight to
pcan_usb_handle_bus_evt():

		pdev->bec.rxerr = mc->ptr[1];
		pdev->bec.txerr = mc->ptr[2];

These read mc->end + 1 and mc->end + 2 with no check. The later
(mc->ptr + rec_len) > mc->end check in pcan_usb_decode_status() runs only
after these reads. rec_len also comes from the device and can be 0.

For example, the 5 byte transfer [00 01 40 05 00] passes the new status_len
check. It then reads ibuf[6] and ibuf[7], past actual_length, and is
reported as successfully decoded.

Now take a full 64 byte transfer whose last record is a bus event header
ending at the last byte. The reads land on ibuf[65] and ibuf[66], which are
outside the kmalloc-64 rx buffer allocated in peak_usb_start().

Those bytes are stored in pdev->bec. Userspace can read them through
pcan_usb_get_berr_counter() (IFLA_CAN_BERR_COUNTER) and in the CAN error
frames built by pcan_usb_decode_error().

The commit message says the patch rejects buffers "whose contents would
otherwise lead to accesses outside the received USB data area". Should
pcan_usb_handle_bus_evt() check something like (mc->ptr + 3) > mc->end
before reading these bytes, rather than relying on rec_len from the device?

>  			/* handle normal can frames here */
> +			} else {
> +				err = pcan_usb_decode_data(&mc, sl);
> +			}
>  		}
>  	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-canfd_check_channel_idx-v2-0-f7b772929791%40peak-system.fr
