Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795878733;
	b=EsUCzb1h+8GIHMCkc3xWRU/bz8Nn7udQfrnYDkO4RvYbFTGiF0o0tgvM1ygpgnCdMRe/
	 CGvwViFe+eCfXcp7upycHo+kKOpA7J1et4fpmsbOElrF/BG2udGpiyzahrgv2sbuN4dhN
	 rTm2leg9aXfUhVTUVNKILn9zwdw0THqDWev5XPdJ/HqAOc3FOcDnHyDaa614iW5bxG2Zg
	 Oa+KFNTb1x8uKEIwFY6szfqceWt1gsQTdo9erejpnaGs5Qw/a6fzs30u2KHcpzEZJYfiT
	 6N5rBpg6cSW5SWf2CLk+qYDkiQaQmXrnlVlQWTWB2WDNalOikl/ggxaOrcXwuqFQJZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795878733;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=KzpQmGmE+jszsoEabJeSdvkUq26Loxj6wELAY0xZ6gU=;
	b=5EBh3AHyoHpnYLVqKpxxiHjXQXS7IFOsot0JlF5Q5/bpFmhkf2exQZXr2xaLuvyeaClU
	 t0HVPdW+dVzAgBYBPGt7ZTZPnMaNXyMmAZ7x2uHhiVsrEqaBiheVpDBf+pjp8jgurK/cO
	 jIQA37pw6vj9wjGBd9mDf55td8+0qtZM0hz4kGVZqgdUyQvssdJOVgKTTow2uTW/dkUsU
	 yAB1aC1Hays8TnqZoUOiVNnCWC56b0vOYZx7aQmExTs2TRdcpwsclpgriyvPygBsT9OP0
	 4ns6o2nHoPEzOzrVjdPybNWwbQRwJOig26Bk3SDMoNz1X0Mdbpf4S8/iALdeVupt/NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmOUBKqW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F198606A31C
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmOUBKqW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E17F1F00897;
	Sat, 28 Nov 2026 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795878732;
	bh=KzpQmGmE+jszsoEabJeSdvkUq26Loxj6wELAY0xZ6gU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EmOUBKqWyQjT7uq+2QtYzeR49Y4vYm181mxX+Ogiajc9zD8lqRoM22A5Zs/5Xs2qA
	 gx3bTHd3oMAO4xDN2iQuLXscUgLdbDr/cUm/l5UG8gvvmUbLVogSAqOuMAoNZvGK19
	 0AwNuOlIdFV/VKRvnBMxzd2vFRSVvfJm77BKwBUPzredC5xdyLGDwGnK3t+YloxyFB
	 gTXoTOQ/eHOudrBPt2mvgKuv0NycsEz4UBf/BxB7HfBtZBd1EtXlG0QyRC219kezQg
	 0fEzF3ZCmzowRSvNq1AHJoYVnvJ3bocYou2ktyJCi9cu5D1TqbvEHEs3MEzuYj+Yg/
	 OR3o4IbaHL47Q==
Message-ID: <fe075533-2dc6-44c3-8226-491aedc21866@kernel.org>
Date: Sat, 28 Nov 2026 16:12:09 +0100
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
Subject: Re: [PATCH] can: etas_es58x: fix devlink leak on probe failure
To: Haoxiang Li <haoxiang_li2024@163.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org
References: <20261128135423.1298105-1-haoxiang_li2024@163.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBAhsDBQsJCAcC
 AiICBhUKCQgLAgQWAgMBAh4HAheAFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmrTM8wFCR1O
 HxcACgkQq1/riG27mcJ2KAEAhG19xBSkjiA9dtatvq2WJnGaes4SUmY+LSn7dh1Lf7YBAIwB
 lsMMmigMTk3Qgwymg1nT+Z8z1Owc/TGtRlo4ZcwMzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmAhsMFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmrTNKcFCRUFdT0ACgkQq1/riG27mcLEVwD/VmnQtTf6yhowaIFj
 AjUtwiyQz9ja4NRu9GOvz/pb2L8A/3QcADR0dcxADGsmOiBpN2M9KI7nqdNIq3VPM/3/5fcB
In-Reply-To: <20261128135423.1298105-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2026 at 14:54, Haoxiang Li wrote:
> If es58x_init_netdev() fails, es58x_probe() frees the CAN network
> devices but leaves the devlink instance registered and allocated.
> Unregister the devlink instance before removing its ports, then free
> it and clear the interface data before returning the probe error.
> 
> Fixes: 2c4a1efcf6ab ("can: etas_es58x: add devlink support")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index e1724ae79c5a..36ec4cd87434 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -2238,7 +2238,10 @@ static int es58x_probe(struct usb_interface *intf,
>  		int ret = es58x_init_netdev(es58x_dev, ch_idx);
>  
>  		if (ret) {
> +			devlink_unregister(priv_to_devlink(es58x_dev));
>  			es58x_free_netdevs(es58x_dev);
> +			devlink_free(priv_to_devlink(es58x_dev));
> +			usb_set_intfdata(intf, NULL);
>  			return ret;
>  		}
>  	}

The fix looks correct, but with this, the if branch looks nearly
identical to es58x_disconnect(). Couldn't the clean-up logic be
factorized in one location? For example by moving those three lines:

	devlink_unregister(priv_to_devlink(es58x_dev));
	devlink_free(priv_to_devlink(es58x_dev));
	usb_set_intfdata(intf, NULL);

from es58x_disconnect() to es58x_free_netdevs()?


Yours sincerely,
Vincent Mailhol

