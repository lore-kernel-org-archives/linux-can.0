Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E6432E6F;
	Sun, 20 Sep 2026 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789929839; cv=pass; b=ukBFFvPcCL8XLKlCBlHPSIDcxBFsFMUw0AwD6UJJb/Fgb1OsDxz/pBNvF7qkrcA3hdeuZ2cNwoz9FFaerCceI4rKxAtQy7qLcgwPSOy7PKeM11FM6b90YCbtBvnuIQHLFPm0GyL66SyvaJSw3WD/H0cG56oD8LMiFcLqYFmm65E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789929839; c=relaxed/simple;
	bh=BT3g3rtGJgWRF2h/MVXMezZ61pm7KorUXaKbHMqFGBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbSvxPvQasgI//6KpSx+OG4lolJmLn7KXgv23bqQZ945Z2k/oXC8ripm6ojvMBVc8KOoVcsxPFUqAoe6wKdQdylRdEs8Pdp72zJDnAV/B0uq20fuyROjh/eLYth3k/lb6Px6R7nd4rOGfTsKZ1kC41oVzoFlEYQ2PmyJgFUJxtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XfODKBwq; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nZiNGh+/; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XfODKBwq";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nZiNGh+/"
ARC-Seal: i=1; a=rsa-sha256; t=1789928039; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YN9JcQYR/R69tZXOVy1cRSIPoJrc20Hcq+aNFhVJeOCo1dv6jHOiIwqlDdXuc8tIQ9
    Jt/AZs08UruVp2DQtwBlFKpqsjhr6ZkHI3qYm8kScb/OeDBGV/s7teF1KeazZnGJUuXR
    hZzQC76DA9koeJwGccNspxudF9czTwUQgfQ0HlZJWDTFaz0qeE0AbT5fdvewavftXHYN
    qlexsoUni3F6HT8bBCj4/3BSk/PkArkFLBuQWQUDCdigteyBqxBRI06LS8u70ZfwIh86
    SOtDToFwUdH2ZsbQ5P/gB5yaB/7Y7qzbsz0FICoFFBnve6FW3bx3boa54HE8hXznXq6A
    eP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789928039;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lFF2t81/wUDIp+wv0zI2fQrWfIvzl86LKDwYEojYLGk=;
    b=dEqhtZjEPlKP0HWMjCWvPFOUb0gbPWvU0OIJiqYn6GpPWctmbxT8WgxnnDwSBrEovd
    4KNiGUt7L6My0zj+TEP7jyK+maKTwYYvHy+9b0yjx4mTUNaYVAXmoK9bZigpSAqMSUQT
    4EfrrKlDV6gI4Lsv4oAxqt5RmBt7aQMJIGYrabHX9xJr3YWt9KpFe8WQWWNm1TUKMjH7
    7rStMTA6JklLliXh4/eDFfSJ85FcLjigmnoTDWYbWH8IwFZgf89GOsoKzptP27T3uShz
    qb0Y3DFBBAoHrHm+7gDtX7NtRwfFtZhTBxvkLWUPQh2wgHrHFeSxDnkzYkgNV4xCtVS9
    Ef5g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789928039;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lFF2t81/wUDIp+wv0zI2fQrWfIvzl86LKDwYEojYLGk=;
    b=XfODKBwqvZ6qUeYaDsatBptNSfCFV5Z3VLdd1Rb6Sm9bSukWDovmp9cCIZxjCE6FQ3
    c4jEOL7p1/ru4meHg43VyBlrh4OY9YQBKl9ioYWcny/7x9obo0i2kUhg0CWSc0PDKwc2
    ILYcaBl6Na5GDfTv5Gr56TRwkPqd4aaecXfifohAO7oSBrgjKit5pTT9s4wmIty3iNIm
    ZoJy2UAvS2nV7BHGuz+mqv8D7eX3vpBvWVQA1za2i8+fbIV2gu+xsqBnWTbrfYBbdwZR
    a3Sp6eIot8gbthUvoniQbFpVarN6jrt54buxw8VMu2tehRe60egv7FUDbGXKHeugJWV1
    dkfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789928039;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lFF2t81/wUDIp+wv0zI2fQrWfIvzl86LKDwYEojYLGk=;
    b=nZiNGh+/7/HRaoquQZgP8gt5cc3KDXcpsL/aOgwT90lH2uW/tJFlcCRF+YpHcP4gU7
    QJz2nyFvbNy74pW1L4Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTnapWH91DJdQmULZkNQx"
Received: from [10.91.122.125]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b728KIDwt9H
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 20 Sep 2026 20:13:58 +0200 (CEST)
Message-ID: <d63c650a-5c78-440d-939d-e131ec5c2260@hartkopp.net>
Date: Sun, 20 Sep 2026 20:13:24 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: isotp: check the frame type, not just the length
To: Kaixuan Li <kaixuanli0131@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260920035626.2581040-1-kaixuanli0131@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260920035626.2581040-1-kaixuanli0131@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20.09.26 05:56, Kaixuan Li wrote:
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
> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
> v2: shorten the comment above the new check to say what it does; the
>      reasoning stays in the description (Oliver Hartkopp). Add Oliver's
>      Reviewed-by and Acked-by. No code change.
> 

Thanks for the fast update!

Awaiting upstream.

Best regards,
Oliver

> v1: https://lore.kernel.org/linux-can/20260919122852.1868961-1-kaixuanli0131@gmail.com/
> 
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
> ---
>   net/can/isotp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -754,8 +754,16 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
>   	 */
>   	if (skb->len != so->ll.mtu)
>   		return;
>   
> +	/* check for correct CAN CC/FD frame content */
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

