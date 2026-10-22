Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640202;
	b=WDQYcUUm2eX217H/ijomgc19BfYH3uqFsPkVGZzGPw17FlxjSmAWQwK6onBVfK6w50H5
	 uA9ZOaBmpJMqI7fN+RnT2Vp5Ls5JujGujkOGDdlJ9QjkivmnQHCeuq4RGR0vS5APieLin
	 FaUOlYaMJBviL02EWjcEh0w/uoFJ1tb6yR3qr5p+q1RKzpKsDUwnR+SGu83o+1dxl2igH
	 YZ0VcZlfBjiD8K9/vYMnEhpA8ehep3X02Bt0DWxk/sIKbG7TJPLcuNReM7BapxAaiGWIq
	 LN3HrfQOjlXOMHjgKiJKt+awikq/Lxi8W3pStaM+cqPRaXLb5eY/35yG4W14m7QipWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640202;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=F3JfWRCzE3FWNa6UoNIY/oLY0kfowHG+aLDTCRv5t4c=;
	b=b5UocRANDiNQjjhotoeI67Pxu7hcrwDG///wNCs9IGf9Rw18JT8kE6TNn0c4yHyN1jXc
	 zyQcgIaLAkz8FBPOYqNUFKGw2hJNl50TKpZ9H8ivP8w4KD8RMrU51T9x6+eVozOO2bwiT
	 jvDLtPr32kmG0kKdnktJZyI/7ZRCjZXwOhHKKnmQ7iAqcnzS5/fVfvbVHj9PDmK9qc5EN
	 GOErpCTIe3+xQX3/K52RaKVzinZahGPeU07yP762yJBo8DG7hm8mZZmDQnOhSSa5RUxzG
	 94aj9PjfdqczVnLiV1ynit2ESflYN6qAbGBbsruceXAUmM0Dkk6+YYWVUX9gNodttLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkUse7Da;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70003606A327;
	Thu, 22 Oct 2026 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkUse7Da
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6D31F000C2;
	Thu, 22 Oct 2026 03:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792640202;
	bh=F3JfWRCzE3FWNa6UoNIY/oLY0kfowHG+aLDTCRv5t4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HkUse7DalBszAOneI8x4wJSVSjOsitVP7SNCoV3/yRzRj1pz9ctWnjfpSQjEUOISo
	 ncwCqAZedYGb9OJDYiQ2YIG6BsxJ4SZ43jiwXgPaVSltl67Qf7azSdN+gfEMjFjzhu
	 g/qmpwIXZ9fjfCi220yZE1I82yRKQy2XMNrzlCkk8+sbMFJ4Zna5s6Hhsd37rgfB9t
	 7ldDmOlZGNOdDs/KPdV5J/D+FCtV7sP40NRXjvxEl6PLdoBhzfBcb9RDXfTWD9Kxs8
	 V3l3AuB3vJBQHoXpFUm64qp1EmmLSBbmysCiuXEcbhvesk3iN8vaud2X6CsjTu+bzL
	 NPR2pWRzar60Q==
Subject:
 Re: [PATCH v5 10/10] can: peak_usb: only dump received bytes on decode error
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 22 Oct 2026 03:36:41 +0000
Message-ID: <179264020123.3131.12155600294986434879@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v5-10-a62b35b867f0@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v5-10-a62b35b867f0@peak-system.fr>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the patch does not meet its stated rate-limiting
  goal for most of the PEAK adapters.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  pcan_usb_pro_decode_buf() reads pr->data_type at rec_ptr before…

--

can: peak_usb: only dump received bytes on decode error

When decoding a received URB fails, peak_usb_read_bulk_callback() now
dumps only urb->actual_length bytes instead of the whole RX buffer. The
dump is also rate limited, since a faulty or malicious device can make
every transfer fail to decode.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index a12ee6ec71e68..e146c8940420a 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -265,10 +265,10 @@ static void peak_usb_read_bulk_callback(struct urb *urb)
>  		/* handle these kinds of msgs only if _start callback called */
>  		if (test_bit(PCAN_USB_STATE_STARTED, &dev->state)) {
>  			err = dev->adapter->dev_decode_buf(dev, urb);
> -			if (err)
> +			if (err && net_ratelimit())
>  				pcan_dump_mem("received usb message",
>  					      urb->transfer_buffer,
> -					      urb->transfer_buffer_length);
> +					      urb->actual_length);

[Severity: High]
Does this rate limit cover the FD and Pro adapters? The commit message
says:

  Since a faulty or malicious device can make every transfer fail to
  decode, also rate limit the dump.

For the PCAN-USB FD family and for PCAN-USB Pro, dev_decode_buf() has
already dumped the same bytes before it returns the error, and that dump
has no rate limit:

drivers/net/can/usb/peak_usb/pcan_usb_fd.c:pcan_usb_fd_decode_buf() {
    ...
fail:
	if (err)
		pcan_dump_mem("received msg",
			      urb->transfer_buffer, urb->actual_length);
	return err;
}

pcan_usb_pro_decode_buf() in pcan_usb_pro.c has the same fail: block.

The device decides whether those paths run:

- In FD, a "got frag rec" or "got short rec" record returns -EBADMSG.
- In Pro, an unknown data_type returns -ENOTSUPP, and a record that
  crosses msg_end returns -EBADMSG.

Each of those paths also prints a netdev_err() with no rate limit.

A device that fails every URB would therefore still flood the log with
one full hex dump per URB (up to 2048 bytes for FD), plus the
netdev_err(). On top of that, the core dump in this hunk prints the same
buffer a second time whenever net_ratelimit() allows it.

Only the original PCAN-USB adapter (pcan_usb.c) gets the intended
behaviour, because its decoder does not dump anything itself.

Should the adapter-level dumps and their netdev_err() calls also be rate
limited? Or could the core dump be skipped for adapters that already
dump? Either way, each decode error would be dumped at most once and
always under a rate limit.

[Severity: Medium]
This isn't a bug introduced by this patch, but I noticed it in the Pro
decode path. pcan_usb_pro_decode_buf() in pcan_usb_pro.c reads
pr->data_type before it checks rec_ptr against msg_end:

	for (; rec_cnt > 0; rec_cnt--) {
		union pcan_usb_pro_rec *pr = (union pcan_usb_pro_rec *)rec_ptr;
		u16 sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
		...
		/* check if the record goes out of current packet */
		if (rec_ptr + sizeof_rec > msg_end) {

The device supplies rec_cnt. If a record ends exactly at msg_end and
rec_cnt is still non-zero, the next iteration reads *msg_end.

The RX buffer is kmalloc(PCAN_USBPRO_RX_BUFFER_SIZE), which is 1024
bytes. Take a 1024-byte transfer with a 4-byte header, rec_cnt = 86, and
85 RXTS records of 12 bytes each. The 86th iteration then reads
transfer_buffer[1024], one byte past the slab object. For shorter
transfers it reads stale bytes left in the buffer.

The byte only decides between -ENOTSUPP and -EBADMSG. Still, would KASAN
report this read as slab-out-of-bounds?

The FD decoder avoids this by checking msg_end - msg_ptr against
sizeof(*rx_msg) at the top of its loop. Could pcan_usb_pro_decode_buf()
use a similar rec_ptr >= msg_end check before the dereference?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v5-0-a62b35b867f0%40peak-system.fr
