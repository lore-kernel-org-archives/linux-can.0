Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792628967;
	b=eXX+XiLcUxyPhn474OuXD8LygPHBhTSoqFEDNdYtt5XzIjrhmPy8Rudfme70GoKgKHwk
	 IbC4AgGS+ihWDt0BihMdDr7TLrEXH7hBQkM484puqUfyE+HyP694j421zb25ZsE0y1ymU
	 20s7A+rBbDZr+POlEWD4OT6i4X8K79aB1gC8NauZ6S8rEOSYcBfDvYBb3K7b1bXG5cH/E
	 IIq9SXMFgBlm4LWjz3+JFDdn0JwC6u41FpFuagYxVWXsJG/iT5sKL2BRVr8241XdaOi3h
	 v6UsLcFiPvC2YsprHZAMWYOgUENZxmbvHCILHV0upcNJJJqRRckhM4EAAS7ulzMhfXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792628967;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CgKfcya1TDpfRSv00Zk0JDK/xuGyB4xdHGwW8iYSyh4=;
	b=RVOKn9bsb1wuxofU9+VT4gWIT5OiYwfm+lOrkPnXBIt7SOd4OkZeb+9mdEJ7mrVK8Cg+
	 XOpY/ZYQ+l0dQHeSVcyYsp3lwEc6Z5XG1LfHU+tLpFSsWOtZfKOH+aVpnLbZPIiLIopkG
	 0vlWw+Tos0BbIokMtkGwcpyfTiA4JP/tITXl4pt2c5x+Q+Dd4Hu4Z0mIoubYmlCY5h+C4
	 AKDLL/kufpMv/nu/XnGvCIBndTegqIZ+cvzdmW0vckSke0JrWKVH/n3xC4zV//A7wRn35
	 dhmStOIsEqsUmaR4hLb6fomtcO74N4+PGxwl9uqVnjd1lH/ZrGOmQJ29trWBkyqFkMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GE+yzY+r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEE606A31D;
	Thu, 22 Oct 2026 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GE+yzY+r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1951F000C2;
	Thu, 22 Oct 2026 00:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792628966;
	bh=CgKfcya1TDpfRSv00Zk0JDK/xuGyB4xdHGwW8iYSyh4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GE+yzY+rPeJpJOshLFETtxiF6WxZAEjdNc4z4GKH05nrgcUg4t5qsOqZcq8OAJiz8
	 bNNZre/szwe2eoqTB9KJKpdC0nc4NQ0eqBPiUIEUx66S07CYWqe8p96rI+8bBEn4/c
	 vzgugGNwM9tlbdVni2gHjZnnT4GqbRjBf3jJicJfGidywenNfoJI8MgvBz/pbyWRDC
	 RdFDWDBTslUarUr65E06enHplvRXmfjq4jJTVlNioUXFgheIh8nCaTRlNOJAlB9Qn3
	 2WeyD5NTIKRRQPsNaXlkpcHRU6Oz+xrlEXfv0SU9563Uyw8g9oXn05GJJ/Crg/S5RT
	 oqh4IavVnxwTA==
Subject: Re: [PATCH v4 07/10] can: peak_usb: fix RX cursor desync for
 self-received RTR frames with SRR
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 22 Oct 2026 00:29:25 +0000
Message-ID: <179262896579.3131.4160814028534799667@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v4-7-bfbde81f8bab@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v4-7-bfbde81f8bab@peak-system.fr>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds an error-path stats regression in
  pcan_usb_decode_data() (drivers/net/can/usb/peak_usb/pcan_usb.c).

--

can: peak_usb: fix RX cursor desync for self-received RTR frames with SRR

This commit moves the SRR private id byte skip in pcan_usb_decode_data()
out of the non-RTR branch. The byte is now consumed whenever
PCAN_USB_TX_SRR is set, which matches the layout used by
pcan_usb_encode_msg() and stops the RX cursor desync for self-received
RTR frames.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 93da0fd4f10e7..4c8cfed31634a 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -697,16 +697,19 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
>  		memcpy(cf->data, mc->ptr, cf->len);
>  		mc->ptr += rec_len;
>  
> -		/* Ignore next byte (client private id) if SRR bit is set */
> -		if (can_id_flags & PCAN_USB_TX_SRR) {
> -			if ((mc->ptr + 1) > mc->end)
> -				goto decode_failed;
> -			mc->ptr++;
> -		}
> -
>  		/* update statistics */
>  		mc->netdev->stats.rx_bytes += cf->len;
>  	}
> +
> +	/* Ignore next byte (client private id) if SRR bit is set.
> +	 * Note: this test must be done even when the frame is an RTR frame.
> +	 */
> +	if (can_id_flags & PCAN_USB_TX_SRR) {
> +		if ((mc->ptr + 1) > mc->end)
> +			goto decode_failed;
> +		mc->ptr++;
> +	}
> +
>  	mc->netdev->stats.rx_packets++;

[Severity: Medium]
Can this leave rx_bytes counting a frame that gets dropped?

Before this patch, the SRR bounds check ran inside the non-RTR branch,
ahead of the rx_bytes update. Now rx_bytes is updated first, and the
check comes after it.

Take a non-RTR record that has PCAN_USB_TX_SRR set and a non-zero
payload ending exactly at mc->end, so the private id byte is missing.
In pcan_usb_decode_data():

    mc->ptr += rec_len;
    ...
    mc->netdev->stats.rx_bytes += cf->len;
    }
    ...
    if (can_id_flags & PCAN_USB_TX_SRR) {
        if ((mc->ptr + 1) > mc->end)
            goto decode_failed;

decode_failed frees the skb and returns -EINVAL. No frame is delivered
and rx_packets is not incremented, but the rx_bytes increment of up to
8 bytes is kept.

The device firmware controls this data, so a faulty or malicious USB
device could trigger it through:

peak_usb_read_bulk_callback()->pcan_usb_decode_buf()->
    pcan_usb_decode_msg()->pcan_usb_decode_data()

Would it work to do the non-RTR rx_bytes update after the shared SRR
check succeeds? For example, next to rx_packets++ and guarded by
!(status_len & PCAN_USB_STATUSLEN_RTR).

>  
>  	/* convert timestamp into kernel time */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab%40peak-system.fr
