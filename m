Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A014E36C0
	for <linux-can@vger.kernel.org>; Thu,  1 Oct 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849628; cv=none; b=vEHfn6p9yjU3EiANMZ/4QBVPpn0kMR1nigFIGHnN0YTEI1H/2p6k7/309I1fNDiCBv40JHjGfeu//HGEEFNaU9nXoQz1dUHB+xEu6Bl44Ja8Gd7xoodpng9YbDmy7TlKSYhOUAioVKNfA7H0ZLHvHqwiDnF2d4BHahW9965r8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849628; c=relaxed/simple;
	bh=50JGTUVDiZ54RyunCgZ0biiNlTO/Fu2dABj0kp0XMDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgNxStKXmV0ImR8lHdH1Wp1Gqauna8I+wry4N4q+vL2Mm8rVg9IFhdYXQHsGXK4HBdaD/XSZuK9ClyexCQMSa4Qoh0JP014PiQ5pncgkNdVPWKnT/BeE3A5etBVuBtKvXG/ZnLWtTBc3fbmANgKvL6Jj1h7yHSqx4ENo8NqKdv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYCRSut+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tblD1jkS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYCRSut+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tblD1jkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790849616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87PF7S19ZaWbmkdk+plN0/ccRIDfLs5yUwiFur7F70o=;
	b=XYCRSut+b4kYwmIDBbAE0QsDfIgO6FBjB8uy1pBq+gjS+zFmOhGtBKaHiinGJeRP7rPmPX
	oBvs86dfVaU0C+uujx3y2ykVegaIthZ5Ljty/Tu78IldnB0b1fDWvbYZ0gXnBRH0q1DzbQ
	EV8UMejftQfEmD5Or8m4MuT/4aUm6Fg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-KdomBseuPNKm9Y5xkmhFdA-1; Thu, 01 Oct 2026 06:13:35 -0400
X-MC-Unique: KdomBseuPNKm9Y5xkmhFdA-1
X-Mimecast-MFC-AGG-ID: KdomBseuPNKm9Y5xkmhFdA_1790849614
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0228f4a1bso2991125e9.1
        for <linux-can@vger.kernel.org>; Thu, 01 Oct 2026 03:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790849614; x=1791454414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87PF7S19ZaWbmkdk+plN0/ccRIDfLs5yUwiFur7F70o=;
        b=tblD1jkSdzEsgHKEgAZBdvUw5rlF5B3HDo0H4jNbuJcIYhw5Kt7RhWkAmzPdIjlrJ7
         6Os7mq1ldEoN62HrLmtuDg3vmD/i9WBCEgMXTbqTaUYL4HZlaUi/Gwo3ctzD0oREERIy
         Myhgp3DNfcc6wzS7gVnr/o1bVCFnn+Xo6ItA+56dT+IOAPedkb4pl1TwBgt3w3EOmNMO
         yiyebE92cvv3qMacBU2jvLkiy+KGh2TXV9l9cR98zXMMrktoQ3KqPwLDHtsdFRlFD/Rr
         /uTbo3DN2GksqRlsMx+4h+HPk3xgyhkucAo+xhZ2kRN7CNM8XzNID7XUL56ZoLzVAkyK
         LG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790849614; x=1791454414;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87PF7S19ZaWbmkdk+plN0/ccRIDfLs5yUwiFur7F70o=;
        b=wyQWmSF02hPcmJwKE5vtjJjC8Qmc8ilTEuqYLMJKUbnedi1ciud8z7bbU4DhM+uBw8
         tMAmE2sBFvdNw6VHaSHw5H3jhj/lkcXPdYRNaXEEiFyK7BQjd0IyOrCxF3GTWZVtarjv
         0niSLu0nTxyp5YtXBnTiktmv3WiRPcw/mkTT0tBvH9C3y7xiiQoudTyRK3s7rr03u9vk
         /5McoROclY5iE5DOBoqZFy3mqHzsb7Dwr5w1cv96X3QkumYtFBmG1EfR0gXgbQOp3yVF
         qpae6I752b10RkDrQaaU6beicy6cUv3JGeHevUokq5yk6mwgtGX+oqNWOvX4mjgp2XFq
         n9Ow==
X-Forwarded-Encrypted: i=1; AKwUvBz06rvXRIUZ3mDGNWKRo1EmDWJPfdvHnf7/+gn7nHFFY5NRPNa+wzXF/0+CY/IBR3GZG1GR1caXjWY=@vger.kernel.org
X-Gm-Message-State: AFuF++nK3RZ4vrcSRYhZcPqBqWdQMDYD52SmGzwSKHKfG7tIFUzoWVw9
	fliiWJNv4hk3QNnKdEYAjp3IThR5dWIibS2mjW/lJZMjPH26Qq50l9lB45tt4jaE3UGGZ59PXi3
	0aSPCxDlOnlXR1LF+ErEsRuVftwlwovQWWfBKPK07TmYmCtNN0oAdBXfuO6oTug==
X-Gm-Gg: AYBFou1hB10rRT3SfX/QU2K27J+Bx5CEu/8gcvgipHWdKm10pZLari9PsX9JQ/9I7kG
	dHMlnczOjm4YRYFqVZkDrYNHRu7VdsDQGxxFGHvlo5sLStclxl9HforpHgFhI8l2w3Gt3os+mCL
	1S6P9o9aziwHfehEtGzE+N9hiTlOrBYRiC+l8uYR9rdwE5csUyG585BVWxpshPlWISZ3/5T5zis
	TNl7HoPlhy9PS/aM0gmqmCXZjvRSpHkIaENd1V9iwKt4hphoYAHuhK2nzcObRN2xnl2ZEOo7U4m
	nRxBRHZhIh23q+ZosDZzjz7ZDNTe3Rz2E2MEc7GetVT1GfXBm7oXuLuNlLTwPpuakdqz4moS0gB
	lq0SUB11YIPPnsMXtruH4wBMNBW4qCVsioUCBCop2NKFjd0XDiCGf5um+jcLJQv/BMKGARR8uLw
	==
X-Received: by 2002:a05:600c:c3cd:10b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-4a01b131337mr52101075e9.31.1790849613834;
        Thu, 01 Oct 2026 03:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:c3cd:10b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-4a01b131337mr52100675e9.31.1790849613350;
        Thu, 01 Oct 2026 03:13:33 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f949709sm86352365e9.12.2026.10.01.03.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 03:13:32 -0700 (PDT)
Message-ID: <19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
Date: Thu, 1 Oct 2026 12:13:31 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20260929210700.1183036-1-mkl@pengutronix.de>
 <9956662e-6001-413d-864d-d8d048a93819@redhat.com>
 <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/26 11:23, Oliver Hartkopp wrote:
> On 01.10.26 10:40, Paolo Abeni wrote:
>> On 9/29/26 22:43, Marc Kleine-Budde wrote:
>>> this is a pull request of 16 patches for net/main.
>>>
>>> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
>>> CAN-XL devices.
>>>
>>> A patch by zjamg restores the skb header initialization lost during
>>> the v7.0 release cycle.
>>>
>>> Oliver Hartkopp contributes 3 patches for the CAN net layer, the first
>>> one fixes the net namespace integration for BCM, ISOTP and the CAN RAW
>>> protocols. The second one converts the unreliable ARPHRD_CAN type
>>> check to the robust can_get_ml_priv(). The third one fixes the unique
>>> skb identifier regression under RPS, introduced in the v7.0 release
>>> cycle, which causes lost packets.
>>>
>>> A patch by Joshua Crofts adds a missing
>>> pm_runtime_dont_use_autosuspend() to the m_can_pci driver.
>>>
>>> Maximilian Zimmermann's patch for the xilinx CAN driver adds the
>>> setting the ESI and BSR flags in the receive path if they are active.
>>>
>>> Jiale Yao's patch for the mcp251xfd driver rejects devices without
>>> match data.
>>>
>>> Ji-Ze Hong fixes a struct size mismatch in the f81604 CAN driver.
>>>
>>> The next patch is by me, targets the gs_usb driver and adds
>>> workarounds for the HScanT USB to CAN adapter.
>>>
>>> Cen Zhang fixes a slab-out-of-bounds read access in the kvaser_usb
>>> driver.
>>>
>>> A patch by Stefan Günther targets the peak_usb driver and fixes the
>>> CAN-ID when reporting CAN errors.
>>>
>>> Chris Strong contributes 2 patches, to fix an out of memory and packet
>>> loss problem in the mcp251xfd CAN driver under sustained receive
>>> traffic.
>> Linus has started pushing back on the ever-increasing net RC PRs:
>>
>> https://lore.kernel.org/netdev/CAHk- =wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com/
>>
>> We are trying to defer things to 'next', especially this late
>> in the cycle.
>>
>> I think there are a few patches here eligible for that. i.e.
>>
>> can: gs_usb: add workarounds for HScanT USB to CAN adapter
> 
> 
>> can: remove CAN filters independent from namespace
>> can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
> 
> I would be fine with those two patches.
> There was unfortunately some new(!) feedback by sashiko-bot on the 
 > namespace patch and the ml_priv patch is not that urgent.
FTR I mentioned the HScanT patch because if feels more additional H/W
enablement than a fix and is also quite largish/invasive. Feel free to
disagree!

Also, not sure if it's already clear, but the main/more relevant sashiko
instance for netdev is the nipa one:

https://netdev-ai.bots.linux.dev/sashiko/#

It uses more models, and cross-correlates among them and sashiko.dev
feedback.

/P
for

