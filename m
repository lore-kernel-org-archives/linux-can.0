Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88136DA0D
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502526; cv=none; b=Ck5/fwzXiSNWu+9foDAtVKeTDWaZnv4XdbMQB6x2dzDMpk+bhC2b2xfXVzuCWcqy+0UE8CyjLtimmIHFORf96yfvVdG7SeG9s/db8K76tEnBhfsKBl34Ea5QF2UprLfTy3EC+BqaHWp/WQAaIdcSJC414g+yB6OwyljB8HhSBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502526; c=relaxed/simple;
	bh=F+tKEFJC0dv9jG51XtVyQaaugiIE6kbWNydheg/3lGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvDsvFt0mMGSsUD6KmzbEhoh2dTuaImSFx2Pyulb9AiK8+NM94T66mwmR9q0Jlpnao1r6oqErcFD2QbVWcJt9OslnH5xAqHaJaN+XfPntJwaZedwuiVFfk4fcXf7IaEPpo2oTt49USDt0eI9E4DIRRolmtT1tLJJkWERhC/+xuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPsPUNwS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPsPUNwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB15A1F000E9;
	Fri, 31 Jul 2026 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785502525;
	bh=914+763znVo1lZmKsiUxAcJM+iGTUnnqD574zLTWtGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BPsPUNwSuAnWSgcCkrghd5fKvsvHV5Z37i5lq0DaD1KMTAJW/CU8XVALiPNRwXTGO
	 WqxSUQO/6f903F+XdEE7nU2lzP/mqXQ3Yak2GyWDmy+xhsFoGhK6vGOF74flCx0feq
	 PHBLxKg6CCiIcKwbydwabSzKsnxgzaAplw4qw/L3tjGyWsQmEgBTPzbJ48AYs4zkZ5
	 mg33xokgVoCC9gyKmjPKtMRZtI0jkdMwL2z12HGQFRZhgQEx0cWdmSnOuryaXf86aw
	 FXTRibKcgF6/OQwTogtcbvtRjUH0KUMRlXDXZwoHJEBiH164XOn+B9UjFgjvaUI3Cf
	 ileHKDuojOXYw==
Message-ID: <345456c4-907e-4d2f-bb24-4023d2898c94@kernel.org>
Date: Fri, 31 Jul 2026 14:55:21 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CAN-XL frame to not CAN-XL enabled interface
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>, sashiko-bot@kernel.org
References: <20260731-agile-electric-cockatrice-295bb8-mkl@pengutronix.de>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260731-agile-electric-cockatrice-295bb8-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/07/2026 at 13:02, Marc Kleine-Budde wrote:
> Vincent,
> 
> does the current code check if you send a CAN XL frame to a CAN XL
> enabled interface?
> 
> On 31.07.2026 10:54:02, sashiko-bot@kernel.org wrote:
>> This is a pre-existing issue, but does this code properly handle CAN XL frames?
>>
>> If an ETH_P_CANXL frame is sent via AF_PACKET, can_dev_dropped_skb() currently
>> lacks a check to drop CAN XL frames for devices that don't support CAN XL.
>> When such a frame enters rkcanfd_start_xmit(), can_is_canfd_skb() returns
>> false, causing the driver to treat it as a Classic CAN frame.
> 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260731-master-v5-0-5b27029dee20@qq.com?part=1

The logic is for checking an ETH_P_CANXL frame is:

  - When sending a packet (even with PF_PACKET) the only check which
    is performed is to check that the skb len is not above
    net_device->mtu. So, if the device is not CAN XL capable, anything
    about CANFD_MTU (72 bytes) is dropped.

  - In the driver, can_dev_dropped_skb() calls
    can_dropped_invalid_skb() which then call can_is_canxl_skb() which
    validate that the skb length is within the range

      [CANXL_HDR_SIZE + CANXL_MIN_DLEN, skb->len > CANXL_MTU]

    that is to say 13 and 2060. But we already establish that the
    maximum length is 72 at this time.

So, yes, it seems that an ETH_P_CANXL frame with a length between 13
and 72 will pass the can_dev_dropped_skb() check. And because
CANXL_XLF must be set at this point, the driver sees a can_frame->len
of at least 128 bytes (and up to 255).

Until now, I was convinced in my mind that can_is_canxl_skb() rejected
frames with a length below CANXL_MIN_MTU which would have prevented
the issue. And I wrote the implementation under this false assumption
without double checking.


Here is a potential fix:

---8<---
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6d0710d6f571..88dec0f91d71 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -152,6 +152,7 @@ static inline bool can_dev_in_xl_only_mode(struct can_priv *priv)
 /* drop skb if it does not contain a valid CAN frame for sending */
 static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
 {
+       const struct canxl_frame *cxl = (struct canxl_frame *)skb->data;
        struct can_priv *priv = netdev_priv(dev);
        u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
                                            CAN_CTRLMODE_RESTRICTED);
@@ -167,6 +168,11 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
                goto invalid_skb;
        }
 
+       if (!(priv->ctrlmode & CAN_CTRLMODE_XL) && cxl->flags & CANXL_XLF) {
+               netdev_info_once(dev, "CAN XL is disabled, dropping skb\n");
+               goto invalid_skb;
+       }
+
        if (can_dev_in_xl_only_mode(priv) && !can_is_canxl_skb(skb)) {
                netdev_info_once(dev,
                                 "Error signaling is disabled, dropping skb\n");
---8<---

The cxl->flags & CANXL_XLF doesn't catch everything by itself, but
once we know that this flag is off, can_is_canxl_skb() will reject the
frame later on. So this should be the minimum fix
(can_dev_dropped_skb() is an inline function in the hot path, so any
trick is welcome here, I think).

Does this make sense?


Yours sincerely,
Vincent Mailhol

