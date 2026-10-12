Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB2448B84
	for <linux-can@vger.kernel.org>; Mon, 12 Oct 2026 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824505; cv=pass; b=N6Ajx6MubNxIYRlafjYOCYbEt0TVnmUhcHTI7bCNbthDtLApqFVVtM7Y3mtCL3HcQ4Yc/hrRxTZtScNTsCTPCDLgTN3WoP3pVskkzZcthKLubTX/sWl+i3GaXYd2Euak6Dw9qdh8aHU1tFrCRFvmS2cEzs8ZMnkHidzzqVQZpYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824505; c=relaxed/simple;
	bh=1JaUqE0BIXVdwJ+pOEtdXO5TMmFn/29y7fnq9sJMcwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJD8cp+oem+I7CH5KdPkb66GR7O6u03nnh0pn3jJe46QnkkQur0c7qo0OPBqgQsxFlrhrja9LIACuoGp/WDWIxEbmCWZHmTXE/k0ExVRpaj0I4twW3iNP9HjoVQLLYVB45xWnNBjh0MPiNOSorLBsFoztSN6syf5Tz7SjOEf9Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=M3omISVW; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LOGfxW6p; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="M3omISVW";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LOGfxW6p"
ARC-Seal: i=1; a=rsa-sha256; t=1791824314; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Cb6nR4pFVZH6nF62Tx7S69EQ4XLhnqOyy2a0XUDdLGQersr3ZGVvAfCoz7txaUJOLs
    5mG3t9BOcENbn9pTbCQBpDaiMcCQVkFydIfalvRvt6YIE3SIw0pmZhBrCJDxUIDz5fc3
    EAK61vBMMUqchMfOKVWsbcE4m2rASkGH+jSr0vUlyEECxSYIctMYg2MIjHm7dnFVloZy
    eDzEJ50Kux9aSjmuAu+JuqIxgGiHffSR4q5ejcokk9x7tELPaInJzV7SBaE9vRaFf0HQ
    PTG+QuqAPuevwx6B7Y2RYzZIYmNXiLwPsq/nxo6F+Htvq9aIpNvY1Ez8yGE/2RC114RS
    oi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791824314;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zJASvIU8iuERjTtBwNFw1UGzs5hhmUwu7w3pQHSQmfs=;
    b=RfNlFzJ7FtBAH8UNrwKnvpefKfEQmNR4Nn4LMVHFJyvKZvR945ABlKnaCCnhEY3O31
    BJVMS1iRuMDwDXZ+en94gC9oV5uqvOvjxf76Yiox5Psc4TGAmRq4HG8r/wgyyxJUExNe
    z+Dfg6UM5S6IygOcYYH9dvm60kxOrjySKZCE+ggsZdYlk1/8HL6bpiAbQrkC/a+z6RrH
    ZTGu6QcIquKUDmMSj7y4eztoxkCkR3eHQgNvF98TOWqqw5Z8shqSSlGNNT0GQ0UnyztX
    cqQy0lNIW4zZ7CjpsnX5CCVLZasM4ql72FEH8MlH0AwBD/qNdnoE1yTWCnCYKsUBRVls
    rmiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791824314;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zJASvIU8iuERjTtBwNFw1UGzs5hhmUwu7w3pQHSQmfs=;
    b=M3omISVW3VRsc/zhYZZBZlnTE1kT33Kq15WcBKSjfJMX50NJMI6waqFlDKFZ9jrRTn
    gK9GvQWU6aokvASPS8SpnNh25DL1iqO3thbSRwXTwEPQ3YvAt3XqeuZBzjgkP3VOrd5M
    9SYw37Cm1EXcEhEfEXE0aZSurD/ELa/geh4ho2t80+Ky0hj1hNaqNbui+NKtkERFk6E/
    rfRDYul5yAmHSQ+pG0r7qvIav2LN85ykZ24pFV6N11TU0arP3v3uZ5352XVZQe43ogE+
    AOC6NUv1jpzxO5kYPLU33TT6pwUh7RwA+/Dik9LlRr4BsiYVmukA6x+Ds0GlOBBEfc0X
    KI5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791824314;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zJASvIU8iuERjTtBwNFw1UGzs5hhmUwu7w3pQHSQmfs=;
    b=LOGfxW6plwWPPvEow7BqcpM82193pvwMujnpISGcGASmiI6pJqQT1w9+EavqmromHP
    6wHZXweKkTD5NkwfPCAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29CGwY1va
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Oct 2026 18:58:34 +0200 (CEST)
Message-ID: <4d1bada6-03d5-4f84-b675-984333e2a841@hartkopp.net>
Date: Mon, 12 Oct 2026 18:58:28 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/37] can: isotp: check the frame type, not just
 the length
To: sashiko-reviews@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009134323.64064-8-mkl@pengutronix.de>
 <sashiko-outbox-166595@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <sashiko-outbox-166595@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10.10.26 15:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] can: out-of-bounds read and info leak due to missing pskb_may_pull()
> --
> 
> commit 4554c7ecb146245b9cdb1ec3080629015d6b848e
> Author: Kaixuan Li <kaixuanli0131@gmail.com>
> 
> can: isotp: check the frame type, not just the length
> 
> This commit updates isotp_rcv to check for correct CAN CC or CAN FD frame
> content, rather than relying solely on the skb length. This prevents CAN XL
> frames from being misidentified and processed improperly.
> 
> Link: https://patch.msgid.link/20260920035626.2581040-1-kaixuanli0131@gmail.com
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 1a272ce6a2bde..5e1c3971ebfce 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -756,6 +756,14 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
>>   	if (skb->len != so->ll.mtu)
>>   		return;
>>   
>> +	/* check for correct CAN CC/FD frame content */
>> +	if (so->ll.mtu == CAN_MTU) {
>> +		if (!can_is_can_skb(skb))
>> +			return;
>> +	} else if (!can_is_canfd_skb(skb)) {
>> +		return;
>> +	}
>> +
> 
> [Severity: High]
> Could this lead to an out-of-bounds read and information leak if the skb is
> fragmented?
> 
> If a local user with CAP_NET_RAW sets up an AF_PACKET socket with a
> memory-mapped TX ring (PACKET_TX_RING) and sends a CAN or CAN FD frame,
> tpacket_fill_skb() can place the entire payload into page fragments, leaving
> the linear portion empty.
> 
> Because there is no call to pskb_may_pull() to ensure the header is in the
> linear area before accessing it, when the new code calls can_is_can_skb()
> (or can_is_canfd_skb()), it casts skb->data and reads cf->len:
> 
> include/linux/can/skb.h:can_is_can_skb() {
>      struct can_frame *cf = (struct can_frame *)skb->data;
>      
>      /* the CAN specific type of skb is identified by its data length */
>      return (skb->len == CAN_MTU && cf->len <= CAN_MAX_DLEN);
> }
> 
> This reads uninitialized memory and beyond skb->tail into skb_shared_info.
> Later in the receive path, isotp_rcv_sf() copies this out-of-bounds memory
> into a new skb:
> 
> net/can/isotp.c:isotp_rcv_sf() {
>      ...
>      memcpy(skb_put(nskb, len), &cf->data[pcilen], len);
>      ...
> }
> 
> This delivers potentially sensitive kernel memory to the receiving socket.
> 
>>   	cf = (struct canfd_frame *)skb->data;
>>   
>>   	/* if enabled: check reception of my configured extended address */
> 

I believe sashiko produced a false positive here.

1. The patch does not introduce a new access to skb->data.
    isotp_rcv() already casts skb->data to struct canfd_frame and
    reads cf->data[] right after the added check. The new
    can_is_can_skb()/can_is_canfd_skb() calls only read cf->len,
    which is within the range accessed by the existing code anyway.

2. The same checks are already performed earlier in the receive
    path. Before a frame reaches isotp_rcv(), it passes
    can_rcv()/canfd_rcv() in net/can/af_can.c, which call
    can_is_can_skb()/can_is_canfd_skb() on skb->data as well.
    If a non-linear skb could reach this point, the issue would be
    located at the entry of the CAN stack, not in isotp.

3. Non-linear skbs do not reach CAN devices in the described
    scenario. Frames sent via AF_PACKET (including PACKET_TX_RING
    and PACKET_QDISC_BYPASS) go through validate_xmit_skb(), which
    linearizes the skb via __skb_linearize() if the device does not
    advertise NETIF_F_SG. No CAN driver sets NETIF_F_SG
    (grep -r NETIF_F_SG drivers/net/can returns nothing), so the
    frame is linear when it reaches the driver and when it is
    echoed back via netif_rx() into the CAN stack.

Therefore no pskb_may_pull() is needed here and the patch can stay
as is.

Best regards,
Oliver
