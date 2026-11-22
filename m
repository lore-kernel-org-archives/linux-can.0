Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341062;
	b=drQ0MTCB2+0nstpN7XKZdXSCZfnD8KBHhyo2QbKUME4Lf+z4ytRMW6vMlLZ3+LcryOrO
	 RM0xHb+Wi9ZKpDGjJX380D/wBo+6u4tKCxj3nHOXzlgrXGFb6fukcXOiFwbqsfgQsKiNK
	 4NRb/gHd2EB+ejMpsiPU4+zx0OEgFc0jwIAWTVb2po2R4x67y9gcjQN7HjPapR9OCwpZM
	 thUzzWc8cOVCd+XvJau2cq3U2cjUFFpu+aDfvb8GhocHZ5htG0w9+yvWlmiyXz8O4ZJh1
	 LtoTqohg53RTVgLzNvqN8CuKVM2uiUUaS3NaB77xE7POJzIW1v3L0j9DKAVyOZ7c2XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=C/QI1b4vyHy9NWvjW7A46WXm9Va+yX7XVlOagVghD9E=;
	b=QzhHxvR5v/Bq5zWj+rX9YFn8CT8kgcJKjfFwCXR836Bk8E+g6sfN6TIe/UNBdWkY0SdI
	 bB1br/3GH0QAG2n9nHRB3Gsp9uUHjo44BlL5KtjDKS1fOjJ6TIo8oo9FH1iCkmT0pMcAe
	 9NyIWt9No1RdDqqP2N9BZan0BIbDTqbhaZ9imI2hxyJtll4HFIEJPRULWALLpAiFkwFhM
	 zHSk632DcGJJ5/2UArEkcjix4JC2ayE3ppu0yGCzWTfYzj6BAKeZYiPXUXJ/9BbyqBkH+
	 wgBIouDdB6H7snwaNm8AST4ifBwTtulWv/1Z5lcRublexyQZDyuyZ5UFxGYijTaNg9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4mHGkdM;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24245606A331
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 09:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24245606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4mHGkdM
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so24319085e9.1
        for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 01:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795341060; x=1795945860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/QI1b4vyHy9NWvjW7A46WXm9Va+yX7XVlOagVghD9E=;
        b=C4mHGkdM4E2iWACQdBEJRZrhywFUbEG5XgkzEXbPOc/EPsXt9DyUwaaA4ndxn5lndr
         qanHAuBkJjRyD1bY2WQH/WCbYveCu3obaaJ9evHDtrM7RSYLuJ47jteycziXvjaHJi1m
         s4pQuXS1cwzM8pC5/pcMg33U7iKYf60baafFbb6Y2A30XgUHX1IAkm54G1JU4utSpnPn
         MfRnQmUukKjo1IA5+3jiI7J89J1CtWpApmsCleLS1X2E0b7Wiu9kI7sMfQKtx6DH4OAb
         bBOs81043/e8PmjN4j6JsLk9vXgEC5D+m/PdGK5tHrzmI7s0Fo1AK2r7R4JAGwUuFF6B
         olOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795341060; x=1795945860;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/QI1b4vyHy9NWvjW7A46WXm9Va+yX7XVlOagVghD9E=;
        b=Z0sGgRbDwGo3r1AYhO/HHlcSKTKzWcthy+0T32zR1gIfoKO7QVRy01njkW7qUUIZrt
         aJ8qn2dK9qjPdtPR45MMeM/Pnk+okHNpNbl8QFg/6tTJ3qZSCLys9sAgwwGnO457qaMW
         JVBtZFD3Q4WqNyA1LdNJ9MHm94GTDCR5ZYvU5JwvDondseT9M0y5ZzCT26oacy6TDJOs
         M1jQiRUvHwhZuDftZesorsWWnuGlHWpnKjyk7H7n2MP2uYusFnAWPDA1UfzxHpHzSncv
         YZeOUdc8ZNsdWBQNgFWn4BUXQa0fLE2u/oX7SFzcuAfLWV2fWp/5t0hOm3CUjk0NlXKd
         T9rw==
X-Forwarded-Encrypted: i=1; AL+hErH73GhCSD+s8XxLmHeJrd/R1lTVxXoS5zMBJzBscxDtTQ+EnByYhydQu5p9K6w0+Q8StGbfVP8mCoE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IA0vSzwnUduipscpITeQXw18uC7KwhrafhZPnamsEXzKQYj3O
	am7WHLUeOm1+OdJeWCgSDUjl2kArYmY73kzfSL+lSOEaOvJ50vtpeLtk
X-Gm-Gg: AZFdTZdcbJK2pBaq4b/MlX8mmHP9RSnDkQDoCKc2+eERTjYfKzfn1uAuGVFDp8FYRjt
	GWtpJby4O6yf9KIe2Z0k0nK8IUJPSr+fuLIF5dKmL0syOAUQSr45DuEqWqmgNSMRcA3BoAXireb
	0ScDX/oxKiqSPhQkZ3vSbq6PVun7EwwGu32kOwYg8Z0SkBcx/VsM2oL7hvNaFv4KXAObPS3xFHY
	19WKMAxeeeZutn8QQ7in9TvDL0pqNcxtLYNEc9csqdFGC7cH1eS1x4QpTm1OKTv2y+64G0+JXkK
	0ec7qDrOQRwMV6cH38OyBQDl3W0E1mqACoFxNDxJrnysdO17WGoX9U+2cc9f+ZOp0M8VjzgugIt
	8BOlimEUE9jz2LCXexQzpkPp+rU4sJOAKcX70kQriR4jdPZBrY6yL+5jp3JgQngNG6fyXmQ1UBO
	NDJxBMGeVN7+lqPo7ZfeHS21Q7U03JFafNqIZs+/mdKNKKWMdj0vUVFMzCZ9GCyzgX6tJYhU7rg
	cQ7TEAxD6GP7jHd++AGd6HBb5U5oPgJsUs6xv0F1jdauZzvb+JWAR0G+3I8hYfgF/ueG6hEHfOy
	333wWl6zQa+IfUQFCL90y3eTC6Af5HY73+/ToTxc/WeVUtsxYOXHZV98IBFNqK2+Xf4zpujaCK4
	t2mrqLZow/wVj7JX5v0gxWA==
X-Received: by 2002:a05:600c:6290:b0:4bb:741d:eba with SMTP id 5b1f17b1804b1-4bb88824a5bmr179848445e9.13.1795341060240;
        Sun, 22 Nov 2026 01:51:00 -0800 (PST)
Received: from [10.138.96.21] (62-101-160-142.telecomgroupservice.com. [62.101.160.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm218208355e9.8.2026.11.22.01.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 01:50:59 -0800 (PST)
Message-ID: <5205f6b8-66a7-4869-bc94-1c8831b1ec24@gmail.com>
Date: Sun, 22 Nov 2026 12:50:56 +0300
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: mcba_usb: Fix double free of RX buffers in
 mcba_urb_unlink()
To: Alexandre Becholey <alex@becholey.ch>,
 Yasushi SHOJI <yashi@spacecubics.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: stable@vger.kernel.org, linux-can@vger.kernel.org
References: <20261119085329.539894-1-alex@becholey.ch>
Content-Language: en-US
From: Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20261119085329.539894-1-alex@becholey.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandre,

Alexandre Becholey <alex@becholey.ch> says:
> mcba_urb_unlink() frees the RX buffers but leaves the stale pointers in
> priv->rxbuf[]. It runs from both mcba_usb_close() and
> mcba_usb_disconnect(), so once the interface has been up, the buffers
> are freed twice: on unplug after "ip link set can0 down", on unplug
> while can0 is up, or on a second up/down cycle. No special device
> behaviour is needed; on a host controller without DMA the double
> usb_free_coherent() is a double kfree().
> 

Sounds reasonable.

I wonder, tho, did you test on real HW or used emulated one via usb gadgets?

What caught my eye is that mcba_usb_open() never reallocates URBs closed 
in mcba_usb_close(). So I'd expect device to not work properly after 
second "ip link set can0 up".

Maybe it shouldn't close them at the first place?

 > Clear each rxbuf[] pointer after freeing it, which makes the 
function> safe to call twice again, as it was before commit 91c02557174b 
("can:
> mcba_usb: fix memory leak in mcba_usb").
> 
> The bug was found, and the reproducer and this fix were written, by AI
> agents (Claude Mythos and Claude Opus models). The analysis and the
> patch were reviewed by a human.
> 
> Fixes: 91c02557174b ("can: mcba_usb: fix memory leak in mcba_usb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Becholey <alex@becholey.ch>
> ---
> An emulated adapter on dummy_hcd: "ip link set can0 up/down", then
> unplug, gives a KASAN double-free in hcd_buffer_free() on v7.3.1 and
> master 9d66f26fefac; the two other sequences as well. All clean with
> the fix, and a second "ip link set up" still works.
> Reproducer available on request.
> 
>   drivers/net/can/usb/mcba_usb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
> index 04170326dc7e..b40b323da9d3 100644
> --- a/drivers/net/can/usb/mcba_usb.c
> +++ b/drivers/net/can/usb/mcba_usb.c
> @@ -718,9 +718,11 @@ static void mcba_urb_unlink(struct mcba_priv *priv)
>   
>   	usb_kill_anchored_urbs(&priv->rx_submitted);
>   
> -	for (i = 0; i < MCBA_MAX_RX_URBS; ++i)
> +	for (i = 0; i < MCBA_MAX_RX_URBS; ++i) {
>   		usb_free_coherent(priv->udev, MCBA_USB_RX_BUFF_SIZE,
>   				  priv->rxbuf[i], priv->rxbuf_dma[i]);
> +		priv->rxbuf[i] = NULL;
> +	}
>   
>   	usb_kill_anchored_urbs(&priv->tx_submitted);
>   }


With regards,
Pavel Skripkin
