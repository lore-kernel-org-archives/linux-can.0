Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499331;
	b=qLE3vuQJ4qCqHisWW6GkuHOObcfsRF6bw6tKJMBuoQafw+hMW0t3GXDyCBD7efB/LWvP
	 Lfp20B5zPWs/gw8rjdjej4ImyIArWimRn/6v4bRSRV0rYXxoQ4VZDgWUIy9Hp/IhTeVHJ
	 7mJLHFN0tJibL6+EJa2VvxGAhKa9ptb2mseZZ3s3zKjWSPq9Nnivq6eS6IcCvm0I1+leS
	 hc8upqC8Pqm0mvVRLG+DVhiXRKhRglsLUIlPjXyoExuEczWA95fpOouI/lkNoB6P3nLsz
	 w9jvmer7n9r/9ooSvYyYu2yteyVOM3NQgP25RjtjsCdMsxRK5dJOn8yJDvWCNB+FjUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499331;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=19Uy1qjqiNsUaJT+95JxHHC1Mw70gT6UAn0fesJbQt4=;
	b=zSiphN7uK2rG9GKyKwprZY9IzgJ6ZseQO49QBO7PbRzt1tWAk4oJZRBz7cyBYYeVOc4I
	 tqVH8uUrmOy8WzaOO7r7Oxh+vccBZkIhWuuxAdHoXIpQsMeUS+9n7B/snbIX+0lhUbKR6
	 N7ZX24uQi5RoIyEf5dkdxNMQIUrAFNdyxQFybO1RE3CGUm3uBv4IcVmK5f/fCe7LCHS9x
	 c3daoKbiLWU4igaizW2xfeVp5gLbaz/Q5xRyM/ZYvkEJKDnCRLB29jMB3jXV3qyx8JNe9
	 zCS7Dg6U+Nw2hL/zk9x831/valhBYGDI1v7Zdb9KPxdIjdv3TzxzlbKmEFYapGI9dZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLkggQaD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5800E606A331;
	Sun,  1 Nov 2026 02:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLkggQaD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0C51F000C1;
	Sun,  1 Nov 2026 02:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499330;
	bh=19Uy1qjqiNsUaJT+95JxHHC1Mw70gT6UAn0fesJbQt4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iLkggQaDyrxu99qJQHyahTNmvp4Jf0/FlLPwEQHs0QFY/X96Rk5TRiinhXqmxTzs5
	 Y72/Z81RmXoZ6dUxmJynZKWru86DUh/2y2nzdOT+Nl1T1ZxscMAdeQjV/OO59RQjGi
	 gWJsldFVoDNUKLyI00QGwngCwFFpYcGDpi5egxfcQNuHrDe09uFGBxGCvNO1Bz5m68
	 o6wdXpQ+qUoVfcQWXIrcETod+0ZedNolfFd0LpeQgZQhEjD/awibIYKfJOiy0OQwIM
	 L9KU50TqEGx4xfLynxE1P7TREr61hQu4DVuFWA9Ll6maUgjBWBWyIJjo/MEv1fauJr
	 WWY/1h1Tqg4Cw==
Subject: Re: [PATCH v7 12/13] can: peak_usb: dump undecodable URBs once and
 rate limit decode errors
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, wg@grandegger.com,
 error27@gmail.com, lukas.magel@posteo.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristmd@gmail.com, kuba@kernel.org
Date: Sun, 01 Nov 2026 02:15:30 +0000
Message-ID: <179349933002.3127.4498885660427450789@kernel.org>
In-Reply-To:
 <20261030-canfd_check_channel_idx-v7-12-fc4a3faf3acf@peak-system.fr>
References:
 <20261030-canfd_check_channel_idx-v7-12-fc4a3faf3acf@peak-system.fr>
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

- [Low] For an undecodable URB, the decoder's error message and the hex
  dump of the same URB are now gated by two separate net_ratelimit()…

--

can: peak_usb: dump undecodable URBs once and rate limit decode errors

This patch limits the hex dump of an undecodable URB to the
urb->actual_length bytes received. It removes the extra dumps from the
PCAN-USB FD and Pro decoders so that only peak_usb_read_bulk_callback()
dumps the URB. It also puts net_ratelimit() in front of the dump and the
decoder error messages.

[ ... ]

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index e5198ec5c760d..1d306160fa354 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -266,10 +266,10 @@ static void peak_usb_read_bulk_callback(struct urb *urb)
>  		/* handle these kinds of msgs only if _start callback called */
>  		if (test_bit(PCAN_USB_STATE_STARTED, &dev->state)) {
>  			err = dev->adapter->dev_decode_buf(dev, urb);
> -			if (err)
> +			if (err && net_ratelimit())
>  				pcan_dump_mem("received usb message",
>  					      urb->transfer_buffer,
> -					      urb->transfer_buffer_length);
> +					      urb->actual_length);
>  		}
>  	}

[Severity: Low]
Can the decoder's error message and the dump of the same URB get split
up by two separate net_ratelimit() decisions?

Both calls use the single global net_ratelimit_state (5 * HZ interval,
burst of 10). For an undecodable URB, pcan_usb_fd_decode_buf() or
pcan_usb_pro_decode_buf() first calls net_ratelimit() for its own
message. peak_usb_read_bulk_callback() then calls it again for the dump.

For example, in pcan_usb_pro_decode_buf():

    if (!sizeof_rec) {
        if (net_ratelimit())
            netdev_err(netdev,
                       "got unsupported rec in usb msg:\n");
        err = -ENOTSUPP;
        break;
    }

Suppose the decoder's message takes the last token in the burst. The
dump in peak_usb_read_bulk_callback() is then suppressed. The "got
unsupported rec in usb msg:" line, which ends in a colon, gets logged
without the dump that should follow it. The reverse can also happen:
the dump appears without its message. The same applies to "bad msg hdr
len", "got frag rec" and "got short rec" in the FD and Pro decoders.

The per-record "unhandled msg type" and "unhandled rec type" messages
printed earlier in the loop for the same URB also use up tokens, and so
does other networking code. That makes it more likely that the dump for
a later fatal error in the URB is dropped.

Before this patch, the FD and Pro decoders always printed the dump right
after the message. Would making one rate-limit decision per URB, either
in the core or passed down to the decoders, keep each message and its
dump together?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf%40peak-system.fr
