Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310263B6364
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666849; cv=pass; b=tpoNJ+/UoG8N3DAY4dJsViN226g++1FsPOf+198nmeg65HHfO0jJfLO7vykmX7tUPVRX9c+lBR2Nv64+3Vbf7th5t8pnm/vaMUWZzntPFlijCM1sElwnxSmaNO69RrtKlQDxAdN3VBS16iRyF2lgOockIDDD+yutO4DjGvHy97A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666849; c=relaxed/simple;
	bh=uEQzjm/roGkDpedhS8LNaUbm0fxgeQJgOjsZ4G0h3Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1uWOeJ5CUB+thVmcjnRa0w7w6kUMfgto51mszrtRrwMhCYb7ZwZoDPFxEj0gRrw5K5qNniMXpg7b1RtLlmvhF+5gGqU1kEv/GnDPKxDcVwUg02TLYaMr884m9e3+DepIZ0J5nHf4eouZ87JzZsTrEc2ZGZHg1woCT5/Z6hcYl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QaZPih9s; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BPR8dLNb; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QaZPih9s";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BPR8dLNb"
ARC-Seal: i=1; a=rsa-sha256; t=1783666824; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P4jNWZ3e23VcIvDtyPgic6DTg79a/k2S+9AUqyuHZkJZv2dRnqL824hurcmCFspQlz
    7WFDIS9rnN07n9D7LRIHlz1OHEOpKJ+YEUTB+9Q9tpU2DrRgmCMIt9EKWDqPG8g2ltQY
    odCpWD7sMAAmUKBL+Lhgj9F85HHRNaeHyhfCY6GoGKxCt1LDOwV5zAWx0KNDCjY4QcPm
    Igb89DH0Olxcyv4YAXhfLfrJ9/F5deYe3k/HG2vxiCDDiEWKIDO4O2ck1s0ac0V6k6vX
    +7nJhIwjehycOJPZhWece3wYI0UVwCs/IQUHMO2Zypa8nzmH6Lz6iv0g4+Jm151Flg8e
    1MYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783666824;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=czu3yM1Jla68x0oZHD55EKdQktA5LFwkug6sw/72vxo=;
    b=KgopI+MZ35kJpuoWug8Yk7MbF0p/v5MEixa4x3+1pEaQv7ILeXgufbe33XVGWLirj1
    nICIH+iaVosSoA/6llAnxm8E95/+vq3N4s2g8Ihn5EPrVSwr7oNHZMFFCFjA6dU8gCL2
    hbMFQD1DFUakM9FT07M31fBEVuOC+/RnPF3FTBQesThovBRjUtp188B3JIQlYbHV15iX
    akI7B9+DITOldxcsJFw/lU4CSQZZGIsFHwoLKfYKQRSWhllU6lWUpnTrrd5vG5chZLGL
    kyvfFEIMqgmQaCKTCkD2/o7K3m+IxKs2cVMckjIUo5ZqO0u6S9R4nfpO+CeBXIPJi10F
    IMhQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783666824;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=czu3yM1Jla68x0oZHD55EKdQktA5LFwkug6sw/72vxo=;
    b=QaZPih9sMrvejGP+V1klkklI3z0nVGjsCSo36ylli5A2yOXMKErJTY+2Jt7NV1/xOA
    edrPpj42B69g27oQz2L0gfulYEEGCnd5dekJUtn0bnvmTXRBGEqZksaOkt1XM+Tg5/8M
    MmI5AQEyzO5JIHA/UVrzVn0DvtorRJKK1BZUgZw5M395MkU9DIGacPv9y7eQtQn7oRQX
    YztPPKK2dbawaFXyAZdfhVqBpkKm0JFdc2IgnIIj2R9viWiDy+rqjq0EJPQCsdo/Y3Gq
    wtEC8htS3VgfNLzo12ZnfvY1GRs3ib1rufH4wCSva72vSLigsqVdscoAuv8iVe4KaCDP
    sadQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783666824;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=czu3yM1Jla68x0oZHD55EKdQktA5LFwkug6sw/72vxo=;
    b=BPR8dLNbn9VSuW1SClKhUYJaYJqbwf0/kRYwqmSYp3GNaoCk619BGToGfAZOBXO3R0
    dk4FTTFQQkED9uXmz+Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.236]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26A70O523
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 10 Jul 2026 09:00:24 +0200 (CEST)
Message-ID: <06ac5d34-e4bf-40e8-8d2c-2b361846cb74@hartkopp.net>
Date: Fri, 10 Jul 2026 09:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: isotp: use unconditional synchronize_rcu() in
 isotp_release()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Nico Yip <zdi-disclosures@trendmicro.com>, linux-can@vger.kernel.org
References: <20260707094716.63578-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260707094716.63578-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

do you consider to upstream this patch together with the BCM patch set?

I know sashiko-bot had again some "Pre-existing issue" remarked on this 
patch. But this simple fix should probably go into upstream, before the 
next "AI Pre-existing issue"-party starts with isotp.c and sashiko-bot ;-)

Best regards,
Oliver

On 07.07.26 11:47, Oliver Hartkopp wrote:
> isotp_notify() unregisters the (RCU) CAN filters via can_rx_unregister()
> and clears so->bound without waiting for a grace period. isotp_release()
> uses so->bound to decide whether it needs to call synchronize_rcu()
> before cancelling so->rxtimer, so when NETDEV_UNREGISTER runs first it
> skips that synchronize_rcu() and can cancel the timer while an
> in-flight isotp_rcv() is still executing and about to re-arm it via
> isotp_send_fc(), leading to a use-after-free timer callback on the
> freed socket.
> 
> sakisho-bot remarked a problem with rtnl_lock held in isotp_notify(),
> therefore make isotp_release() always call synchronize_rcu() before
> cancelling the timers, regardless of so->bound. This still closes the
> original race (isotp_notify() clearing so->bound without waiting for
> in-flight isotp_rcv() callers before isotp_release() cancels the RX
> timer) without adding any RCU wait to the netdevice notifier path.
> 
> Fixes: 14a4696bc311 ("can: isotp: isotp_release(): omit unintended hrtimer restart on socket release")
> Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.kernel.org/
> Reported-by: Nico Yip <zdi-disclosures@trendmicro.com> (ZDI-CAN-31764)
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/isotp.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297..d30937345bcd 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1235,15 +1235,22 @@ static int isotp_release(struct socket *sock)
>   
>   				can_rx_unregister(net, dev, so->txid,
>   						  SINGLE_MASK(so->txid),
>   						  isotp_rcv_echo, sk);
>   				dev_put(dev);
> -				synchronize_rcu();
>   			}
>   		}
>   	}
>   
> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();
> +
>   	hrtimer_cancel(&so->txfrtimer);
>   	hrtimer_cancel(&so->txtimer);
>   	hrtimer_cancel(&so->rxtimer);
>   
>   	so->ifindex = 0;

