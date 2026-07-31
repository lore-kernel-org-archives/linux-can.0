Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A04207A
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505548; cv=pass; b=FghRw77dkfLaV9r/X38viORhp7zAYS/0Wf8BhqB6SvhV7DJ/S/M2zKdEnp1fm+HNUUvsWyEv0AHdyL1vgxC4jWNcTve9fvVUZhfDxqgpqsrt4aSWu67jGrc7mMir7HJcwjc9cWEPdJsM/hHaeOTn6vxul2C8kzSQOmp5foUGisE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505548; c=relaxed/simple;
	bh=agHYCWcCouKns3CHtLAmDajVSJ+/iTjyQTcs/ZmfA8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+CNEIZFE+42j9qnjpJ97ICsVjvN1aSzlNGMxS+WURHXIAeHViuWgzqyseIQDN5zGfBMVWuhkAVWzU7rSZ8dmXG4hMfN2vldzO3x0v+f55DZfpgDnO/XFabV8C/NaSNH6Pni4WDXCuGe1i+dtCRJMx5Qg62/ul711kEQ7z9UA3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pX6W4ype; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=AXyld4Vj; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pX6W4ype";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="AXyld4Vj"
ARC-Seal: i=1; a=rsa-sha256; t=1785505356; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GuWIk2ECGEm7dMgFx0jVyu7+FXYmPKv0v71IiEYAl+hRxO0xNXS4jmOdUlSaCIXDZi
    ngKTWgYNoQW852V0uQdqr37cRjw2kAxEQvSz0TAq7+8TWaIIvGVDSDeY6A4q8ACBsQnN
    N4ZKzaHtHc6hsAUzIBST9ULJDsTUqoHdPrDMkiP8hpg/gilJQjqW98aqA22zgb6A41iQ
    xICYo6dKO6I7yomWN5FKszRk6TN7idcC31ROMkxvacYxvr4QqnKCc6ulYE21TOyAj6iM
    Jkjmd0xyYObomXD1f4ug0uMbR2SPEBL8qK7f9Ma3XBe+O3UtQ9LhIrJvgsHD4zxrWPsZ
    lv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785505356;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EWsGH3flhE+ZsL/3i2AStUGtcV55DX55v0TudkVweUo=;
    b=C0cexKXpeQ4g9PG+1dVad1MR5Wq7QjNwwQuf06wn6cqQIt//QWq6hPc3fY90xte/hH
    KVZ0d6jBwXg2O3HhSs8Zk51Umw+IsOzh2liyNx58MT6iKEa0sjt6QCYmqzeFZla+6Yr/
    KvXDnYjh/loLNXDtSjCdcMe6R1rBThlDPr4u4z8rS8munIH7o5XktOUGgEs5vt/nVGwt
    50m8gxKz7y4GRUFewZSm2tD5+F5pWgIicjJbWpHwhyeNnwbcqG2J81gRYJ79Ak3gbV/D
    IjAHo+UN03uRY9njjs5VP6bfHrQu1Vdsnem/bX66vvdhYLxCI/4gjI4lJBwzIcgCN4U/
    /ilQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785505356;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EWsGH3flhE+ZsL/3i2AStUGtcV55DX55v0TudkVweUo=;
    b=pX6W4ypeDuKuBh6KzGGzuSMl6d+eU3XUX1S4oCirc65V6DA5knODI4t/CUuTKex+Bb
    xMVjK0CfhiEPKczspruL/2XvBE27xsotDYENeqvN7Svb2POC8Q4Owk02MyHHCAQfDErc
    N5OTQN7doWvukgWdwkl6AAtIc5KRIW9sEixDmqzIoJudS9F4fH42pTR/vFVr1CqzJsdX
    Rmb910rLBXMPYEz73ZsF+NOGwyPqssN12tYeqcMuSll0dK0trb5NuLdd7aOfxoW96zzZ
    zXxhIVHY/TpKpc4dEcj6ZK2NcPYD+MGz5TUL19Go8TlGBEq2feIRYVrxVfcXt/iIePAK
    1h6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785505356;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EWsGH3flhE+ZsL/3i2AStUGtcV55DX55v0TudkVweUo=;
    b=AXyld4VjBBOR0spt/uPaQdcRLz9mOGEov0m8/jiU6Oja+Dtt0w6V12gI3Rp0YM9/Yr
    2oj1tJ/AZGkm+7dzcoCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K5281926VDgaeTL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 31 Jul 2026 15:42:36 +0200 (CEST)
Message-ID: <bb341c52-0370-4816-a2d0-2a67c34d8d34@hartkopp.net>
Date: Fri, 31 Jul 2026 15:42:31 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CAN-XL frame to not CAN-XL enabled interface
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 sashiko-bot@kernel.org
References: <20260731-agile-electric-cockatrice-295bb8-mkl@pengutronix.de>
 <345456c4-907e-4d2f-bb24-4023d2898c94@kernel.org>
 <eef5b125-b229-4579-aec5-026755c60132@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <eef5b125-b229-4579-aec5-026755c60132@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31.07.26 15:28, Vincent Mailhol wrote:
> On 31/07/2026 at 14:55, Vincent Mailhol wrote:
>> On 31/07/2026 at 13:02, Marc Kleine-Budde wrote:
>>> Vincent,
>>>
>>> does the current code check if you send a CAN XL frame to a CAN XL
>>> enabled interface?
>>>
>>> On 31.07.2026 10:54:02, sashiko-bot@kernel.org wrote:
>>>> This is a pre-existing issue, but does this code properly handle CAN XL frames?
>>>>
>>>> If an ETH_P_CANXL frame is sent via AF_PACKET, can_dev_dropped_skb() currently
>>>> lacks a check to drop CAN XL frames for devices that don't support CAN XL.
>>>> When such a frame enters rkcanfd_start_xmit(), can_is_canfd_skb() returns
>>>> false, causing the driver to treat it as a Classic CAN frame.
>>>
>>>> Sashiko AI review · https://sashiko.dev/#/patchset/20260731-master-v5-0-5b27029dee20@qq.com?part=1
>>
>> The logic is for checking an ETH_P_CANXL frame is:
>>
>>    - When sending a packet (even with PF_PACKET) the only check which
>>      is performed is to check that the skb len is not above
>>      net_device->mtu. So, if the device is not CAN XL capable, anything
>>      about CANFD_MTU (72 bytes) is dropped.
>>
>>    - In the driver, can_dev_dropped_skb() calls
>>      can_dropped_invalid_skb() which then call can_is_canxl_skb() which
>>      validate that the skb length is within the range
>>
>>        [CANXL_HDR_SIZE + CANXL_MIN_DLEN, skb->len > CANXL_MTU]
>>
>>      that is to say 13 and 2060. But we already establish that the
>>      maximum length is 72 at this time.
>>
>> So, yes, it seems that an ETH_P_CANXL frame with a length between 13
>> and 72 will pass the can_dev_dropped_skb() check. And because
>> CANXL_XLF must be set at this point, the driver sees a can_frame->len
>> of at least 128 bytes (and up to 255).
>>
>> Until now, I was convinced in my mind that can_is_canxl_skb() rejected
>> frames with a length below CANXL_MIN_MTU which would have prevented
>> the issue. And I wrote the implementation under this false assumption
>> without double checking.
>>
>>
>> Here is a potential fix:
>>
>> ---8<---
>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 6d0710d6f571..88dec0f91d71 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -152,6 +152,7 @@ static inline bool can_dev_in_xl_only_mode(struct can_priv *priv)
>>   /* drop skb if it does not contain a valid CAN frame for sending */
>>   static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
>>   {
>> +       const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
>>          struct can_priv *priv = netdev_priv(dev);
>>          u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
>>                                              CAN_CTRLMODE_RESTRICTED);
>> @@ -167,6 +168,11 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
>>                  goto invalid_skb;
>>          }
>>   
>> +       if (!(priv->ctrlmode & CAN_CTRLMODE_XL) && cxl->flags & CANXL_XLF) {
>> +               netdev_info_once(dev, "CAN XL is disabled, dropping skb\n");
>> +               goto invalid_skb;
>> +       }
>> +
>>          if (can_dev_in_xl_only_mode(priv) && !can_is_canxl_skb(skb)) {
>>                  netdev_info_once(dev,
>>                                   "Error signaling is disabled, dropping skb\n");
>> ---8<---
> 
> On second thought, maybe this is an even better fix:
> 
> ---8<---
> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 95fcdc1026f8..9846989d4960 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -384,7 +384,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
>                  break;
>   
>          case ETH_P_CANXL:
> -               if (!can_is_canxl_skb(skb))
> +               if (!can_cap_enabled(dev, CAN_CAP_XL) || !can_is_canxl_skb(skb))
>                          goto inval_skb;
>                  break;
> ---8<---

Yes! I really like the can_cap stuff ;-)

> 
>> The cxl->flags & CANXL_XLF doesn't catch everything by itself, but
>> once we know that this flag is off, can_is_canxl_skb() will reject the
>> frame later on. So this should be the minimum fix
>> (can_dev_dropped_skb() is an inline function in the hot path, so any
>> trick is welcome here, I think).
>>
>> Does this make sense?
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 
> 

