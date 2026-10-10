Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743223B14B6;
	Sat, 10 Oct 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614898; cv=none; b=u8K1gvycgCapd7SjE9dpLqoV4eXZq3RFefou+M0SFi5CRcgBULWS9FRF1nbAMvxdXW0hMR/TxEVbmO1j8t613ep+e23XS6rAMR7A7y9gbHQ9NR6JCaYqXXhQEG7wEvw9wkhafUzYhdb/8QPn8HpTjMTI6h02PYdzuUveaDP52go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614898; c=relaxed/simple;
	bh=VRTb/pYULEEHCdxIZg0gT4jHoQ2nPNlXSNgYfoqLwMM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9MpAMMgTbdvjkY5bawaR90eOiq34E+fxxMZuPYkOnvY14IWOsRW9Be+KUL83eCeTqPaFLUfQEa4mxu1TbflczgQJElPL7my9lbTWMvNYE9LI1D1HtAe2frWdHlwu46D2Rie8133ZaETNVS9qhCE0nepvXG2z8hh2ZxOrpnVbt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoRb4pkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoRb4pkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8748C1F00893;
	Sat, 10 Oct 2026 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791614897;
	bh=/U6g6SLBamN5FG+y379vxnXGyZrvnoBRGRp9Or64MF8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KoRb4pkU4mUN3M9ojpRZ8uSRAr7FC1gGbHXIG9rkB/EoPQgUBXnjK05bUavk738Mv
	 4blwo+su9Y2w0TuSLjkfVd3dmq+kArWy29M/So7imfqXAPGELywhAixee5/yBsFrVR
	 orjZojDQcZizB4tPsY9Y6DvjA0EQXwbUaaOXj52oCDEtp/F+Z/D3bCf8HDyg8UIL3G
	 lotRdBnpTDuWjcu7j/8XWPsJxI8PK51CB7+FGGr4O2lHFPAf6iHuoQaPZanRxjZffK
	 yHLXsOwweU+EVZa+R9u77rmdaz4i5ZIToBKXAm+/SOCsBIouDh2FABktYxB0MVSO16
	 ipVkjvlTJ4j1Q==
Subject: Re: [PATCH 5/5] can: peak_usb: harden PCAN-USB message validation
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 s.grosjean@peak-system.fr, kuba@kernel.org
Date: Sat, 10 Oct 2026 06:48:16 +0000
Message-ID: <179161489603.1406898.16835414270803468559@kernel.org>
In-Reply-To:
 <20261008-canfd_check_channel_idx-v1-5-0a3bb82f4e09@peak-system.fr>
References:
 <20261008-canfd_check_channel_idx-v1-5-0a3bb82f4e09@peak-system.fr>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the PCAN_USB_REC_BUSEVT status record
  still allows an out-of-bounds read.

Pre-existing issues:
- [Medium] The encoder and decoder disagree about the SRR 'client private
  id' byte on RTR frames.

--

can: peak_usb: harden PCAN-USB message validation

This commit adds bounds checks to the PCAN-USB RX parser. In
pcan_usb_decode_data() the SRR client private id byte is now checked
against mc->end before it is skipped. In pcan_usb_decode_msg() the
status/len byte is now checked against mc->end before it is read.

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
This is a pre-existing issue, but do the encoder and decoder agree on the
SRR private id byte for RTR frames?

When CAN_CTRLMODE_LOOPBACK is set, pcan_usb_encode_msg() sets
PCAN_USB_TX_SRR. It then appends the writer id outside the non-RTR data
block:

	/* can data */
	if (!(cf->can_id & CAN_RTR_FLAG)) {
		memcpy(pc, cf->data, cf->len);
		pc += cf->len;
	}

	/* SRR bit needs a writer id (useless here) */
	if (can_id_flags & PCAN_USB_TX_SRR)
		*pc++ = 0x80;

pcan_usb_decode_data() only skips that byte, and now checks its bounds,
in the non-RTR else branch.

Suppose the firmware echoes a self-received RTR frame with the private id
byte, as the TX layout suggests. Could the RX cursor then fall one byte
behind? In that case the private id byte would be parsed as the next
record's status/len byte, and the rest of the URB would be misparsed or
rejected with -EINVAL.

The code doesn't document whether the firmware includes that byte for
RTR echoes. This dates from the earlier SRR handling (3a7939495ce8) and
is not an out-of-bounds access.

>  
>  		/* update statistics */
>  		mc->netdev->stats.rx_bytes += cf->len;
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
>  		} else {
> -			err = pcan_usb_decode_data(&mc, sl);
> +			u8 sl = *mc.ptr++;
> +
> +			/* handle status and error frames here */
> +			if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
> +				err = pcan_usb_decode_status(&mc, sl);

[Severity: High]
The commit message says the patch rejects malformed buffers "whose
contents would otherwise lead to accesses outside the received USB data
area". Can a PCAN_USB_REC_BUSEVT status record still read past mc->end?

Before dispatch, pcan_usb_decode_status() only checks that the f and n
bytes are in bounds:

	if ((mc->ptr + 2) > mc->end)
		return -EINVAL;

	f = mc->ptr[PCAN_USB_CMD_FUNC];
	n = mc->ptr[PCAN_USB_CMD_NUM];
	mc->ptr += PCAN_USB_CMD_ARGS;

After this, mc->ptr can equal mc->end. Now take a record where:

  - PCAN_USB_STATUSLEN_TIMESTAMP is clear
  - f is PCAN_USB_REC_BUSEVT
  - n is PCAN_USB_ERR_CNT_DEC or PCAN_USB_ERR_CNT_INC

pcan_usb_handle_bus_evt() then reads two bytes with no check against
mc->end:

		pdev->bec.rxerr = mc->ptr[1];
		pdev->bec.txerr = mc->ptr[2];

pcan_usb_decode_status() does have a later check:

	if ((mc->ptr + rec_len) > mc->end)
		return -EINVAL;

But that check only runs after these reads. It also uses the DLC nibble
supplied by the device, which can be 0.

peak_usb_start() allocates the RX buffer as
kmalloc(dev->adapter->rx_buffer_size), and PCAN_USB_RX_BUFFER_SIZE is 64.
Say a 64-byte transfer ends with the 3-byte BUSEVT header
{0x40, 0x05, 0x00} at offsets 61 to 63. Wouldn't mc->ptr[1] and
mc->ptr[2] then be buf[65] and buf[66], past the slab object? For shorter
transfers, the same reads would return stale bytes from earlier URBs.

These values are stored in pdev->bec. pcan_usb_get_berr_counter() returns
them to userspace, and pcan_usb_decode_error() copies them into error
frames:

			cf->data[6] = mc->pdev->bec.txerr;
			cf->data[7] = mc->pdev->bec.rxerr;

Does the fix also need a check like this in pcan_usb_handle_bus_evt(),
before the reads?

	if (mc->ptr + 3 > mc->end)
		return -EINVAL;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09%40peak-system.fr
