Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623535;
	b=IDLdq6egtACanemE+e2pIfNHnrLrXILkvCP7YV9A8RuulBLarJP9PpPBLOKEKfGdz05N
	 QETN8LuZG4YrRaBcbwYLvtThe5b0HSs7gAn+WeTY/HdauKLgvzrBTnrt5xsjRNduA7oMB
	 Fp99Zxzdp62yoFy9bdfZl9UFSXz95zDQs6ZoF9/aT7/4OWrbxSh2NMY8qihX7AE9hJ/w5
	 eod+GWvLJgGjVHynRUAx3DCUcAUAHXOL4k7JMnhfew4b14rBGpn2YXJpU3NOSGbRGssvs
	 T38N4mBh9s/cjMVsnG/nO5n7av1Nz+ld6rg4sOBgNrWgFgmJmZrLWOk4SvaeRviXUjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623535;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tlSKJT8HzkuZ0adk32vyh7qjQd77kLOszqukCnHcIyg=;
	b=q1+090tRwDwp+wWQFKbAEIuxhnF4hSyUhhMCp2W0bz33tOHaG5sfPufZe7O1Pu1clrM+
	 WiiBodcHqCdQ8PNP2OyqCr8AdwWlVHvwhFmwMhQkCV6+ood+JomIyXtnR6GN2B2faJApm
	 zAZeki8qgRoBifbjvZgOwD/5PNbFBmir0z7MiBBM16GHEknLiQsTsD+GTEbzqJh1cu4/e
	 bhobZXZvkXS+XiBeQE3m/Bk50wxwYFHBxsPnPcG0asYJm5mzjCIg6J5igNvlnEiyREb9k
	 wNREP09N8l6FGfoBM3ls2ZW5rPmaM6H8kGk+dvPSiNxbe+Ngqfa9fYVTgDSCu6gqTQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ia7HUW87;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4CC606A31A;
	Wed, 21 Oct 2026 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ia7HUW87
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A351F000C2;
	Wed, 21 Oct 2026 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792623535;
	bh=tlSKJT8HzkuZ0adk32vyh7qjQd77kLOszqukCnHcIyg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ia7HUW879PmbASSejt/wI4JhGygvjkg4/q2mEtLzMULkmafQizrYwbbLJniGimDbb
	 UsV7oYpgYtQOG+jj0wNH0qbvMMONNu49MxbzDpz8exFVyrQId3S1tPgmQuvgFMWNEa
	 O8sImoq70d8WC68cBClwvjmJ8a5Q1EIco+TAg2eaQHM5RaI+rXoDrOPtFZWej6pGO3
	 yBkN53FTlQk1dLULSt4wn/JXsPY6jmWSPh4aqgPnA6aK6tbwgHWmxyl4uhVKkA+BZd
	 MNupLWb1d15eeHFRx9yYHRLS66QUUUEfSuXuD8l35MaV3V9SIW5ueTJJNMw5xDBIDL
	 vZaFi/kufMSlQ==
Subject:
 Re: [PATCH v3 10/10] can: peak_usb: only dump received bytes on decode error
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Wed, 21 Oct 2026 22:58:54 +0000
Message-ID: <179262353431.3131.13190579092278457529@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v3-10-74d17c5a599e@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v3-10-74d17c5a599e@peak-system.fr>
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

- [High] The patch only partly does what it says.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  pcan_usb_pro_decode_buf() (pcan_usb_pro.c:737-758) runs its loop on…

--

can: peak_usb: only dump received bytes on decode error

When decoding fails, peak_usb_read_bulk_callback() now dumps only the
urb->actual_length bytes received from the device, not the whole RX
buffer. That dump is also rate limited with net_ratelimit(), because a
faulty or malicious device can make every transfer fail to decode.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 981168fead927..a58317cdde4eb 100644
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
Does this rate limit cover the case the commit message describes? The FD
and Pro decoders dump the same buffer themselves, with no rate limit,
before they return the error to this callback:

drivers/net/can/usb/peak_usb/pcan_usb_fd.c:pcan_usb_fd_decode_buf() {
    ...
fail:
	if (err)
		pcan_dump_mem("received msg",
			      urb->transfer_buffer, urb->actual_length);
	return err;
}

drivers/net/can/usb/peak_usb/pcan_usb_pro.c:pcan_usb_pro_decode_buf() {
    ...
fail:
	if (err)
		pcan_dump_mem("received msg",
			      urb->transfer_buffer, urb->actual_length);

	return err;
}

Device-controlled data reaches these paths: "got frag rec", "got short
rec", "got unsupported rec", and errors from the per-record handlers. The
URB is resubmitted right away.

Can a faulty or malicious device that presents as an FD-family or Pro
adapter still flood the log on every bulk-IN completion? Each dump can be
up to rx_buffer_size bytes, which is 2048 for FD and 1024 for Pro.

As far as I can tell, only pcan_usb_decode_buf() gets the benefit of the
net_ratelimit() here, since it has no dump of its own. For FD and Pro
adapters, whenever net_ratelimit() allows it, the same bytes are printed
twice.

The netdev_err() messages on those failure paths aren't rate limited
either. One example is in pcan_usb_pro_decode_buf():

	if (!rec_ptr) {
		netdev_err(netdev, "bad msg hdr len %d\n", urb->actual_length);
		return -EINVAL;
	}

Another is the "usb message length error" message in pcan_usb.c.

One option is to drop the decoder-level dumps, so this rate-limited dump
is the only one. Another is to put them behind net_ratelimit() too. In
either case, the related netdev_err() calls could be guarded the same
way.

[Severity: Medium]
This is a pre-existing issue and wasn't introduced by this patch. While
looking at the decoder dumps, though, is there an out-of-bounds read in
pcan_usb_pro_decode_buf()? The loop count comes from the device, and
pr->data_type is read before rec_ptr is checked against msg_end:

	rec_cnt = le16_to_cpu(*usb_msg.u.rec_cnt_rd);
	for (; rec_cnt > 0; rec_cnt--) {
		union pcan_usb_pro_rec *pr = (union pcan_usb_pro_rec *)rec_ptr;
		u16 sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
		...
		/* check if the record goes out of current packet */
		if (rec_ptr + sizeof_rec > msg_end) {

Suppose the records exactly fill urb->actual_length and rec_cnt claims
more. Then rec_ptr ends up equal to msg_end, and the next iteration reads
transfer_buffer[actual_length].

If actual_length is PCAN_USBPRO_RX_BUFFER_SIZE (1024), that byte is one
past the kmalloc() buffer. KASAN would report it as slab-out-of-bounds.

pcan_usb_pro_wait_rsp() has the same pattern, and it has no
end-of-buffer check at all:

		rec_cnt = le32_to_cpu(*rsp.u.rec_cnt);

		/* loop on records stored into message */
		for (r = 0; r < rec_cnt; r++) {
			pr = (union pcan_usb_pro_rec *)pc;
			rec_len = pcan_usb_pro_sizeof_rec[pr->data_type];

With a u32 rec_cnt supplied by the device, can pc walk past
actual_length here? If so, the out-of-bounds bytes could be printed by
the "got unwanted rsp %xh" and "got rsp %xh but on chan%u" messages.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v3-0-74d17c5a599e%40peak-system.fr
