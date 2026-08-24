Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC92C21E8;
	Mon, 24 Aug 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787594795; cv=pass; b=n/XrXnOuQu20W2AAJ3syEPIDTcPe91vCFvMAsfmOHsy9PCPwfTCTbuhwc4g7E0SJI094rIHnN8ewHaEBnthcZWmdOx3ZP6R1d7dOdxZWdD4gRgAXRAV/qqpVHmt08Kc7nVMvuVb/lkapKGoWjdH8GvaR8NTDLPXHnUVA4RmxOZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787594795; c=relaxed/simple;
	bh=ldPalkMUiTzed/ArCctDfWDSljguvOVjT6Ay7U4jMFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOR74gOyxCszCE7p9AQ92Q5Nqsmm2dP48jZvFlGbwlq6XnqR4xclKO6SE4y2uXyRUcMMzHahp3D8R7316Gs99P5vC8x+cYJW6JjvguF/+xDSVzPMMRQymN3bqBW2IHNWksOwhZTDJxeCBlfMF8f4aAhmvW+cnorw4WY++LtcrTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=kuq4DYac; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=l9KqQnu9; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="kuq4DYac";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="l9KqQnu9"
ARC-Seal: i=1; a=rsa-sha256; t=1787594604; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=R0aOA9pGJB0Pg6RKfmsBU3p/6Qms6z10KdaWHOs1QVxiNLe2IngI9mB0b4YHS9h1Ld
    OEXJ2fbAvig/zyEmfhbtBebxPsMi5v0f6hdg+VDcPgHpzi/smDE37YO7HGivrpxuNzGl
    2GVLAQKnDOWlR6mVkMsmqmt87z/lAssxO/a0OLUkwpsgwaWBMDJNFpf7aERxzh2JO284
    cGsyTADyXa2A+ONG427Sck0RaqvT25wwJ4k4oaUoHh1cYShHy4L5+j0h+D6O40lrQQEi
    lZL1aX1/qmKeT5JZcg9GvzaEjqla0zHI992MMxJCDPWZH6bYeowmNoh18FExbjRnfdp+
    YszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787594604;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nPSI7FVhJjJ8wcU8cNW73O2bqKDkC2BDO0XUflI5JOg=;
    b=hjEYE8oBck09l0Ake+Ep7oR/WDnlzr6j/18F7boFFGezpEtaC51S6bxs8kX5bhgx7E
    +MiML6b/ILZ8fgFENYmf8InNi0zyh/OxgSDGTz/xk2r9MrTGme0Dv1t0Ie5ERE48w0db
    lH4Ez4mB3IEJR45N7j5f4G57Vx/8EHqwIUI9nTTAzs2FXaW6PNmXGiC58RCIYTSZ9+Qn
    s0QnqWKXPpKUm6Bo7RO7kY+tI4N/k9e96S8mSCiqJHHqAqf88L1mjLMgwNwk4AUAfkCG
    RoGUxmFdWtQvFR/XapRJw88X0nyDMZltxx0SfyWzyVJuM1ObqpYh/Vh7YF45yeud3dg9
    TV+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787594604;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nPSI7FVhJjJ8wcU8cNW73O2bqKDkC2BDO0XUflI5JOg=;
    b=kuq4DYac8X/hYcf5eXtejhMq0F++xq6H2lo8EQNe1vxqnSmMSxGoccA8hUEqJjxBxG
    DDbZqZ49RNGB4VMQJLeLRdxqRdHv5/BtmbadqcIbgfB+4ESPhGj+24n9W8QVE+RGtC6A
    OvR9845mgINy+qiLyJzzsZzbHARlFnuQVebn6u6FpRtELc1eIsTxD9uwEdf+nwwWnkQa
    baoizr+P3tCKNyy6anVayb54Yq0O8FhBNeigukpALt1fuquta9lhMHaSZ33M/vrmIAL0
    wzVDrwYDL/AAKIGhl00Kkff+F6HLrQGDKLb0p3YUrhRToClQX2Uck45A8fGbPCt2ARWb
    JzMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787594604;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nPSI7FVhJjJ8wcU8cNW73O2bqKDkC2BDO0XUflI5JOg=;
    b=l9KqQnu99TZgZSQInuGckISGXaC1jG7WyQUUWavxlmEUR/IqpSn6xbqZ5d4iRN2Yot
    PR2OagOZwNL7PJ/Fq3Aw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727OI3OgsH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 24 Aug 2026 20:03:24 +0200 (CEST)
Message-ID: <eb5e9618-3dbf-42cb-a635-752ff9fbcb99@hartkopp.net>
Date: Mon, 24 Aug 2026 20:03:19 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcan: isotp: implement N_Ar timeout handling for FC
 transmission
To: yewentian395 <yewentian395@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260824125343.2700828-1-yewentian395@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260824125343.2700828-1-yewentian395@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.08.26 14:53, yewentian395 wrote:
> Add N_Ar (ISO 15765-2) timeout logic to detect FC frame transmission
> failures on the receiver side. Previously, isotp_send_fc() fired the
> FC and immediately started the N_Cr timer (rxtimer) without confirming
> that the FC was actually transmitted onto the CAN bus.
> 
> Introduce ISOTP_WAIT_FC_TX_CONFIRM state and fc_artimer to implement
> a two-phase approach:
> 
>    1. N_Ar phase: after can_send(FC), wait for local echo confirmation
>    2. N_Cr phase: after echo arrives, start rxtimer to wait for next CF

The kernel ISO 15765-2 implementation uses a simplified approach for As 
and Ar: You can specify the frame transmission time (N_As/N_Ar) in 
can_isotp_options::frame_txtime which covers the calculated time of the 
CAN frame on the bus (on the "wire"), e.g. for the tx path:

	/* add transmission time for CAN frame N_As */
	so->tx_gap = ktime_add_ns(so->tx_gap, so->frame_txtime);

In fact I don't know any active users of so->frame_txtime since the 
Linux ISO 15765-2 implementation went online in April 2014. It only had 
some value for testing.

Nobody cares about so->frame_txtime and therefore I will not add any 
extra complexity to check for Ar/As timeouts which have no real world 
effect.

> -	/* start rx timeout watchdog */
> -	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> -		      HRTIMER_MODE_REL_SOFT);

Btw. while double-checking the code I have seen, that I was missing the 
addition of so->frame_txtime when starting the rxtimer above.

Although this proves again that checking for Ar/As timeouts has no real 
world effect, I will create a patch that adds so->frame_txtime here to 
comply with the documentation in isotp.h:

   __u32 frame_txtime;     /* frame transmission time (N_As/N_Ar)  */
                           /* __u32 value : time in nano secs      */

I'll mention you with a Reported-by tag then.

> +	if (flowstatus == ISOTP_FC_CTS) {
> +		/* cancel rxtimer before entering N_Ar phase */
> +		hrtimer_cancel(&so->rxtimer);
> +
> +		/* enter N_Ar confirmation phase */
> +		so->rx.state = ISOTP_WAIT_FC_TX_CONFIRM;
> +		hrtimer_start(&so->fc_artimer,
> +			      ktime_set(ISOTP_FC_AR_TIMEOUT, 0),
> +			      HRTIMER_MODE_REL_SOFT);
> +	}
> +
> +	can_send_ret = can_send(nskb, 1);
> +	if (can_send_ret) {
> +		pr_notice_once("can-isotp: %s: can_send_ret %pe\n",
> +			       __func__, ERR_PTR(can_send_ret));
> +		if (flowstatus == ISOTP_FC_CTS) {
> +			hrtimer_cancel(&so->fc_artimer);
> +			so->rx.state = ISOTP_IDLE;
> +			so->rx.len = 0;
> +		}
> +		dev_put(dev);
> +		return 1;
> +	}
> +
> +	dev_put(dev);
>   	return 0;
>   }
>   
> @@ -447,6 +483,9 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
>   	struct isotp_sock *so = isotp_sk(sk);
>   	struct sk_buff *nskb;
>   
> +	if (so->rx.state == ISOTP_WAIT_FC_TX_CONFIRM)
> +		hrtimer_cancel(&so->fc_artimer);
> +
>   	hrtimer_cancel(&so->rxtimer);
>   	so->rx.state = ISOTP_IDLE;
>   
> @@ -481,6 +520,9 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
>   	int off;
>   	int ff_pci_sz;
>   
> +	if (so->rx.state == ISOTP_WAIT_FC_TX_CONFIRM)
> +		hrtimer_cancel(&so->fc_artimer);
> +
>   	hrtimer_cancel(&so->rxtimer);
>   	so->rx.state = ISOTP_IDLE;
>   
> @@ -554,6 +596,13 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
>   	struct sk_buff *nskb;
>   	int i;
>   
> +	if (so->rx.state == ISOTP_WAIT_FC_TX_CONFIRM) {
> +		hrtimer_cancel(&so->fc_artimer);
> +		so->rx.state = ISOTP_WAIT_DATA;
> +		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> +			      HRTIMER_MODE_REL_SOFT);
> +	}
> +
>   	if (so->rx.state != ISOTP_WAIT_DATA)
>   		return 0;
>   
> @@ -855,9 +904,22 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
>   	struct sock *sk = (struct sock *)data;
>   	struct isotp_sock *so = isotp_sk(sk);
>   	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> +	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
>   
> -	/* only handle my own local echo CF/SF skb's (no FF!) */
> -	if (skb->sk != sk || so->cfecho != *(u32 *)cf->data)

Please also note that your patch would not apply on the latest upstream 
isotp code, which does not contain "*(u32 *)cf->data" anymore.

Best regards,
Oliver

> +	if (skb->sk != sk)
> +		return;
> +
> +	/* FC echo handling: confirm FC was transmitted (N_Ar) */
> +	if (so->rx.state == ISOTP_WAIT_FC_TX_CONFIRM &&
> +	    (cf->data[ae] & 0xF0) == N_PCI_FC) {
> +		hrtimer_cancel(&so->fc_artimer);
> +		so->rx.state = ISOTP_WAIT_DATA;
> +		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> +			      HRTIMER_MODE_REL_SOFT);
> +		return;
> +	}
> +
> +	if (so->cfecho != *(u32 *)cf->data)
>   		return;
>   
>   	/* cancel local echo timeout */
> @@ -1225,6 +1287,7 @@ static int isotp_release(struct socket *sock)
>   	hrtimer_cancel(&so->txfrtimer);
>   	hrtimer_cancel(&so->txtimer);
>   	hrtimer_cancel(&so->rxtimer);
> +	hrtimer_cancel(&so->fc_artimer);
>   
>   	so->ifindex = 0;
>   	so->bound = 0;
> @@ -1563,6 +1626,8 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
>   					  isotp_rcv_echo, sk);
>   		}
>   
> +		hrtimer_cancel(&so->fc_artimer);
> +		so->rx.state = ISOTP_IDLE;
>   		so->ifindex = 0;
>   		so->bound  = 0;
>   		release_sock(sk);
> @@ -1639,6 +1704,8 @@ static int isotp_init(struct sock *sk)
>   	hrtimer_setup(&so->txtimer, isotp_tx_timer_handler, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>   	hrtimer_setup(&so->txfrtimer, isotp_txfr_timer_handler, CLOCK_MONOTONIC,
>   		      HRTIMER_MODE_REL_SOFT);
> +	hrtimer_setup(&so->fc_artimer, isotp_fc_ar_timer_handler, CLOCK_MONOTONIC,
> +		      HRTIMER_MODE_REL_SOFT);
>   
>   	init_waitqueue_head(&so->wait);
>   	spin_lock_init(&so->rx_lock);

