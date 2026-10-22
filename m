Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792628970;
	b=CBlg2zQhzPJ6k6UtAf2M5Z7Q3uKgvI4T6uUh9m7/nxmwMuV1uoGqUFNyB4gRXtzkWjJ8
	 JEsShGQjcnliS0g+6UzyajmHtI2FgZj2TkCINrGrq/xSEo5yjx8ueOHKC9grEeSVmU/SG
	 pQvoHxXPDkZdFtVDfz1x41eDQ0mXHbszlP72sx+B/aMEC5tDWyIaQLxdJsDDgpUwQco8F
	 I+9KDyQy7RU+AthTgnT3OQu3VOKkYfPh81ovi6tkUvc8AxKs9ow7Qjc9aDqLBWLLpdJuq
	 hYPsRGOocunJa1X+oyViDGgd6fcNcF5iqRR/dFzVCoLmLu2FMK3d0EfhLQxQVn0FAJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792628970;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=St39qO/x9IS9K+zqaearH2V0C8qqdS0hqetmmfwcM2Y=;
	b=eWqg46LVDXugZrgF/BSO5ryab3Y/GdLjdYrhLto+ef6g/TRLrr6WP3lQEzipCbG+i2gV
	 gKzP55NfA6DUPqUptzok1Vs+A2DrLz/L7dpVXIsXdT0QMX9e3hLtVkUzXKaFKzLhkPfAz
	 Uee/DJkRtYErN9PSiQjUt0koPoxH4k5UCi6JrwwsJzwRR6SMdNEdOJPS1OtNWPMyqgj20
	 9TMFvk5RqbxaXEGcmUjZXXRPLiJEfGtc6V329ZXdIPNW8mvYAOhwsEIIhnxvGO+RPcnVT
	 vSan5iwxgoOrqIzfkcTR3oae80XkTi9tyfjQIcsjPgLRg+tYtgBwJ1ThwJtehOXoVTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbmlyaMq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC4606A323;
	Thu, 22 Oct 2026 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbmlyaMq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E051F000C4;
	Thu, 22 Oct 2026 00:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792628970;
	bh=St39qO/x9IS9K+zqaearH2V0C8qqdS0hqetmmfwcM2Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZbmlyaMqa8h+Ooh0/2pf/Z34B1SXhtNhFCeBKyjyNZsjXhMjler4y0e/RnOGgwVpG
	 nb0tRyYDQcm+mL1oN8mtxKSV4fv80xrdl0cJvowagMyQrPrBCQ3RHxPaBwJnURN1b5
	 aplS3oPi8BjuJeBfEcYrTZpRWQcnHKQJ43+bDmgIa7tPdG94k+gOOxNSHwEHzGN+GI
	 50HamyBj2rfkbIauWmWgEJMIAbTnzmhVGKC4dyM1n+flruXDfa/Zy79sm7kBj4t4/y
	 qZkx330J1z+xj+UMCh58NKhxivTLLc/bZIi1SYY2cDpuKAye0+ysZNOkCoxnzcMdEc
	 kK3ls7Bu61qrA==
Subject:
 Re: [PATCH v4 10/10] can: peak_usb: only dump received bytes on decode error
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 22 Oct 2026 00:29:29 +0000
Message-ID: <179262896908.3131.10244045343253209518@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v4-10-bfbde81f8bab@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v4-10-bfbde81f8bab@peak-system.fr>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch only partly achieves its second goal.

--

can: peak_usb: only dump received bytes on decode error

This commit limits the dump in peak_usb_read_bulk_callback() to the
urb->actual_length bytes the device actually sent, instead of the whole
kmalloc()'ed RX buffer. It also puts the dump behind net_ratelimit(),
because a faulty or malicious device can make every transfer fail to
decode.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index ccfc26d3e5a6b..b86ea6f6b07c6 100644
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
Does this rate limit cover the flood described in the commit message for
the FD and Pro adapters?

dev->adapter->dev_decode_buf() runs before this check. For the PCAN-USB
FD family (USB FD, Pro FD, X6, Chip) it is pcan_usb_fd_decode_buf(). For
PCAN-USB Pro it is pcan_usb_pro_decode_buf(). Both decoders already dump
the buffer on error, with no rate limit:

drivers/net/can/usb/peak_usb/pcan_usb_fd.c:pcan_usb_fd_decode_buf() {
    ...
fail:
	if (err)
		pcan_dump_mem("received msg",
			      urb->transfer_buffer, urb->actual_length);
	return err;
}

pcan_usb_pro_decode_buf() in pcan_usb_pro.c ends the same way.

The device fully controls the paths that set err here. In
pcan_usb_fd_decode_buf() they are a truncated header, an oversized
rx_msg->size ("got frag rec: should inc usb rx buf sze"), a short record
("got short rec") and sub-decoder failures.

In pcan_usb_pro_decode_buf() they are an unsupported data_type ("got
unsupported rec in usb msg:"), a record that runs past msg_end ("got
frag rec: should inc usb rx buf size") and handler errors.

Each of these paths also calls netdev_err() with no rate limit.

After each failure, peak_usb_read_bulk_callback() resubmits the bulk-IN
URB, so the cycle repeats:

peak_usb_read_bulk_callback()
    dev->adapter->dev_decode_buf()
        pcan_usb_fd_decode_buf() / pcan_usb_pro_decode_buf()
            netdev_err(...)
            pcan_dump_mem(...)    <- no rate limit
    if (err && net_ratelimit())
        pcan_dump_mem(...)        <- same buffer, dumped again
    usb_submit_urb(...)

On these adapters, can a device that fails every transfer still flood
the kernel log with up to rx_buffer_size bytes of hex per URB?

Only the original PCAN-USB adapter seems fully covered, since its decoder
in pcan_usb.c does not dump.

Should the adapter-level dumps in pcan_usb_fd.c and pcan_usb_pro.c also
be rate limited or removed? The other option would be to keep a single
rate-limited dump here in the core.

>  		}
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab%40peak-system.fr
