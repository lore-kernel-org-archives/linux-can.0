Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443A25B08A;
	Sat, 19 Sep 2026 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851808; cv=pass; b=bw5RBfJtaJuDJ8t+0xCYfkQtf7PkVejIhHLe1zj95/Q35n0lyb2UHl0+IxdUOoxFEjdbhZuM5CiQa37D+/pGmgb93EA42HP2dvT2ZFQjmGsu7jhK9FbMO6HD2MGG9/77b1F6IMTik1mTcLAUDOgCc+T1LRaHrFNXfxdJ8/+smn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851808; c=relaxed/simple;
	bh=2XbohxdqP1bAEi3Q9/52oWG68jF9mWF21OaSg7eWCuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDKmpcS2Tw7CNBkguVT+PzxktFUzGCr+BfLr6RjRbyz6NezkCQ482k0NXxKcGgGCRS6v2DRNo23Klv/yJQ4hiEdCeJK47GToWebQjMjGXcJvlWtHotDegE0hYFfDxaO4NIdFE6RCguZxQhQyFn/DtwgvTz03kOkSOVDhCBHEpCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=exDC+LCQ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Dg73tVY9; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="exDC+LCQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Dg73tVY9"
ARC-Seal: i=1; a=rsa-sha256; t=1789851434; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ofxxnL4668GsL74wlQPVlKLLMOUTYQQizj2lphIC8K7v2tznuIEuUWOKvDuHjsOFWm
    cOBfQss93gUC8qw3IPOsSLosKpiSILAvsjnw4/w46L0nvtj6MD4NDJWqRgPEB1Gu4sMM
    R/X97aKrpsDABG0nvxF82PrpJpCRABBv6FZr7pQ1q6Z4TiTN8i20L0w5mMhtTyMdfEYc
    9R7fAdv778GRuxA6lrFMIbI2gGr6/SG/qHGA8BzWT44Zaf0LXGDpWz/wTv/MPmQz31y2
    LrvHLJ7Yj1A4eGLJ6T0cX1nGqCmz5jkDi2w0sBiPUtu/oig1CGqimEVnOxpy/2MOAGIO
    pZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789851434;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FwuYQ7fDZ5/4eLzsbsrBN+Zv7zzrcX4MEhnrHMzd8rM=;
    b=rIjduFNIzLdf92/EyEitf9fs02jFA0u5cCUDFqZjAwv14cqaPgmh6SNkotkvFdHHWd
    qSumriAnIojTp1oUCes5KoEIZYcZLc6Kf7fj9nRwp8Xo8bCjGMhrHEumrkkSnyZt6+rO
    oe5F24r0DKOyS2XlSonAjPtllxtt2pS3tsGFIefmlsOLSq8tLTH4GEODVD+MOCeZ5AXr
    9kFESpp66SLB/B7QFvjGcF1Zu8VFVnP5F0cqB1rcN1r739ykQAjK+eiJEmxFeO2qyd21
    98BREJO+mHk7+PJp2BByP45EGUjn0I9uf93//oa0ErZV4TSbdCvXCsVqcwOnuQ7ptbSq
    LnAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789851434;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FwuYQ7fDZ5/4eLzsbsrBN+Zv7zzrcX4MEhnrHMzd8rM=;
    b=exDC+LCQPi3CDK+5DG6stVOlw321mTtcLjffTPoZ0hfuMY2bDOZLvKaJkRHOkZQx9v
    dHnUN/xa6YFrjrRl8pGrWZudzYWFLF9FgNyzH/7yOr4CN0oAEdXimC5pc6wptd+g9Fxb
    5LTC0Xt0pZ3YUeqQ3or7f4nUt+Q5QQyBGSOzfc7RDgSMeukWLE6+yhfNy2oBB2+IhwJE
    uEbvjL1OGbEC0kvxnUMmCXWh9j4DoS8q4eJQEuoOZE+QlNft/E47teGn/z59IlxH4pTO
    +/E7gePSXBG8S066+sEpVMX00IHSIaeYI+dJOHuqRUoS6EMsIwF55ZjxLyqqlAhAFzIE
    2qdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789851434;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FwuYQ7fDZ5/4eLzsbsrBN+Zv7zzrcX4MEhnrHMzd8rM=;
    b=Dg73tVY9/TBb0t5FdQTdeURg5ywFuFVaOisCwPD5jVP1GktM4Fp0OnWDn1+esUsfc/
    +FZYWz3WqxXLcNvMUEBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMr5phO3I3EfIHARZPajJb9uo9jcfLBzZK+IjFFTRtmjsBgASc"
Received: from [IPV6:2a02:3037:32c:790c:c5a0:f181:4878:3ab8]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b728JKvDogM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 19 Sep 2026 22:57:13 +0200 (CEST)
Message-ID: <39713d2a-79ce-4afb-8eba-5fe8e33af461@hartkopp.net>
Date: Sat, 19 Sep 2026 22:57:04 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: isotp: check the frame type, not just the length
To: Kaixuan Li <kaixuanli0131@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260919122852.1868961-1-kaixuanli0131@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260919122852.1868961-1-kaixuanli0131@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Kaixuan,

many thanks for your patch and your finding!

On 19.09.26 14:28, Kaixuan Li wrote:
> isotp_rcv() separates Classic CAN from CAN FD by skb->len alone:
> 
> 	if (skb->len != so->ll.mtu)
> 		return;
> 
> 	cf = (struct canfd_frame *)skb->data;
> 
> A CAN XL frame with cxl->len 4 is CAN_MTU bytes, so it passes, and is then
> read as a canfd_frame whose len comes out of canxl_frame.flags: at least
> 0x80.
> 
> Of the paths that follow, only the flow control one uses that length
> without bounding it first, so check_pad() walks to 255 over a 16-byte
> frame and the caller reports EBADMSG on an unrelated socket.
> 
> bcm_rx_handler(), j1939_can_recv(), can_can_gw_rcv() and raw_rcv() check
> the frame type here, and can_dropped_invalid_skb() switches on
> skb->protocol on the transmit side. isotp_rcv() is the gap.
> 
> Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
> Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
> ---
> Reproduced on v7.2.4 over vcan, one isotp socket per case bound rx 0x123
> with RX_PADDING|CHK_PAD_DATA and rxpad_content 0xAA, a first frame in
> flight, and one frame injected from a CAN_RAW socket.
> 
> 	case                            stock     patched
> 	A CAN XL, cxl->len 4, flags ff  EBADMSG   none
> 	B Classic FC, padded 0xAA       none      none
> 	C Classic FC, padded 0x00       EBADMSG   EBADMSG
> 	D as A, with CHK_PAD_LEN on     EBADMSG   none
> 
> C bounds the impact: a malformed Classic FC frame from any sender on the
> bus gives the same EBADMSG, so nothing becomes reachable that was not
> already. D differs only in which branch of check_pad() returns.
> 
> No memory safety issue. KASAN was on for all eight runs and reported
> nothing.

In fact the skb->len length check is not enough since CAN XL has been 
introduced. A good catch!

> ---
>   net/can/isotp.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -754,8 +754,19 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
>   	 */
>   	if (skb->len != so->ll.mtu)
>   		return;
>   
> +	/* skb->len does not separate the frame types on its own: a CAN XL
> +	 * frame with cxl->len == 4 is CAN_MTU bytes, and canxl_frame.flags
> +	 * aliases canfd_frame.len.
> +	 */

No need to duplicate the documentation provided in the patch 
description. Just describe what is done here.

/* check for correct CAN CC/FD frame content */

should be enough for the below code.

> +	if (so->ll.mtu == CAN_MTU) {
> +		if (!can_is_can_skb(skb))
> +			return;
> +	} else if (!can_is_canfd_skb(skb)) {
> +		return;
> +	}
> +
>   	cf = (struct canfd_frame *)skb->data;
>   
>   	/* if enabled: check reception of my configured extended address */
>   	if (ae && cf->data[0] != so->opt.rx_ext_address)

You can add my

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

in your v2 patch.

Many thanks and best regards,
Oliver

