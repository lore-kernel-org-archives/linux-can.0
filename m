Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640199;
	b=b9swiSRzvRu0reLDjyXj1G0WjP2d358RJWTdSuSy6nuDtHyjEze/vdoZ0txeP8SCvpAc
	 EKYHOdnf8HkhOanHvHuUzaYFtd2dnhnYwSXuiDiR2kk/j61UbNgpo56NXCaSdKsmkbhMu
	 mMELOZQ6+algnOpBjddJEfpEs0OJZfqd4ZW+a8cnjGgP80t8+m1eDgmc0Abvbd7SdFJmR
	 CdlILfkRVMDjbqwBUwDHm3uFVQ+cJP/qrnOd2TGw+WKg034Hftf8749/yvC/AmR2/ZvCr
	 5FpFjJ++X35M3v6mTWzDB63kF3RBlj7FTX8MxY3xDE37Ny1R7qykg+GdwD5Z4XDIWBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640199;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vTwjFkJmndk3mlNYXx1XFpeNqsXWpg5bEu6OmuCeeHI=;
	b=snf6js+1HGHcpSO0xDPLjLfubqotNW17U7SmcjY8f9SHVT1qqWLnh82AE/FsmZxw1Ucz
	 CwwKP6PPFWYxM3OMSW5YnvQbF+xaGxxYQI7hDPmKb++xvZ9Cmw6JFtaHkl7PcurNPBddQ
	 RBd4GCLFjt2q5GPgGsxR0KNGa20qNAQM1yWiwFlYv9DCPPR2n2sfm3zAzBgtqhvMwpGc5
	 IBI3LUAKOrJ4Hnj05GgPWjIp+fw8tBiJFQudlwkUHbr53ksFS6t+aMmF2tmbvrL3+X1KO
	 19zzzfWUXcPxv9+i2S1K8HyLlcx5nTJ19l3bzMB7EqUZ/Cz9/jpokVtg70ykWan4gaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlvoYhzU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D6606A319;
	Thu, 22 Oct 2026 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlvoYhzU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BC41F000C1;
	Thu, 22 Oct 2026 03:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792640198;
	bh=vTwjFkJmndk3mlNYXx1XFpeNqsXWpg5bEu6OmuCeeHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HlvoYhzUasRvyCQvNvAyCYgNLAn/qK2PmFYTCaH7EIFQEsjaGdXlRulL3yTu7r3oX
	 3hEIApQA2QZgRb6i09F7OjyzyYmjMiyl7/q6C45/F7lvRMFzx0libqjLMRqO063AVy
	 m8ugs7bJoN7XidAkSzEtSavaGzZnG8IKFhInp8ibScRwDQndHQnFlkZsn4PrFT+Ylm
	 TqT1cPkDGOXYFloG4noLLt+Ga5UXa+MONtKPDqnI3ed1JlCKdC2MCNnmUkHuocFwa3
	 /S9mTksWLa6kIB+DACvmFVKBKaglMzcv+GNS8ssh1T+PEIR1L0dm5xkmkDI+8CBFZW
	 CO1BoN+/BKsXQ==
Subject: Re: [PATCH v5 07/10] can: peak_usb: fix RX cursor desync for
 self-received RTR frames with SRR
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org
Date: Thu, 22 Oct 2026 03:36:38 +0000
Message-ID: <179264019805.3131.3239897056475962964@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v5-7-a62b35b867f0@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v5-7-a62b35b867f0@peak-system.fr>
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

- [Low] In pcan_usb_decode_data()
  (drivers/net/can/usb/peak_usb/pcan_usb.c), the patch moves the SRR…

--

can: peak_usb: fix RX cursor desync for self-received RTR frames with SRR

This patch moves the SRR writer-id byte skip in pcan_usb_decode_data()
out of the non-RTR branch. The byte is now consumed for RTR frames too,
which matches the layout produced by pcan_usb_encode_msg(). Before this,
self-received RTR frames with SRR set left the RX cursor one byte short.

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

[Severity: Low]
Can rx_bytes now be over-counted for a frame that gets dropped?

The SRR bounds check now runs after the rx_bytes update in the non-RTR
branch. Take a non-RTR record with PCAN_USB_TX_SRR set in can_id_flags
where the URB ends right after the payload, so the writer-id byte is
missing:

pcan_usb_decode_data()
    if ((mc->ptr + rec_len) > mc->end)    /* passes */
    ...
    mc->netdev->stats.rx_bytes += cf->len;
    ...
    if ((mc->ptr + 1) > mc->end)          /* fails */
        goto decode_failed;

The skb is freed, -EINVAL is returned and rx_packets is not incremented,
but rx_bytes has already gone up by cf->len.

Before this patch the SRR check came before the rx_bytes update, so a
rejected record was not counted. Nothing undoes the increment later,
because peak_usb_read_bulk_callback() only calls pcan_dump_mem() when
dev_decode_buf() returns an error.

Would it work to move the rx_bytes update below the SRR check, for
example next to the rx_packets++?

> +		mc->ptr++;
> +	}
> +
>  	mc->netdev->stats.rx_packets++;
>  
>  	/* convert timestamp into kernel time */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v5-0-a62b35b867f0%40peak-system.fr
