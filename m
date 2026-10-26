Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.160
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793016237;
	b=a5pTb5ggQDmXuUUaH/HSlXBugz/82C+dQHDE7IzWqJ1GIlqmrKdhesOIF3YZsnT9eyuX
	 kB/QdvIF9v3ccrkxc2kl8qV+GbwWVzgb31n561D3cWoMu3drpeZ3IYtCcPZ9C9/BYJfrQ
	 xjGtPhQUfXR1poVDzS3yW3bPi4A0mwue6/f3B00SFMw+1E+xDReTbg6pReDTGEBgrF7zj
	 9cNO+NT7pOXSqPyTPnhRoYtHCc/ivE3vZA7DOz+8gBvplhfQ1ou6VoIYJQWGAubj6r7hT
	 oMh6mtbEXh5QkY9eEmwS4whqr46ncO77aXpjzfS6uzJ46NhCM1b+0j3qb815AZ2r3FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016237;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mfcpd1CPtNrlIK22YiULCL5YwfaxtcpMDTOiNzZ+lYA=;
	b=dwvjcW3YiP5BQBlwHye0Ry0Hgy80UX/fSpoZr/2efRP/TrYCet40sOMN2DXtOkPRlqYt
	 3fwikAIXhpOPFvSYKUfGiQtg0vLUADSrnHFnWhfYI56BtlwO5ID9G9w6hJGbhcMsGVCcF
	 fsXSRYETCiaqWQdmd797ys2MLcqg5auPRCt8qvbfNyt/dWSlPNIVrtEok2wDFk6KfUSlR
	 De/G6kzJXznl/4Fr9QKsYBrrifmcG+j8JRIJwrvri4qRZB+yA3XvEHE+/ayVni+1+9ETd
	 AiClBWowSZv0l3ZvYu6aGvWGFAT/+VwdOkfjZt1WrITd7jVkKt6A1dvLtI6/v9P6/Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=iaQN9LZa;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rUbk313v;
	arc=fail smtp.remote-ip=81.169.146.160
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904F606A31E
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 12:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9904F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=iaQN9LZa;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rUbk313v
ARC-Seal: i=1; a=rsa-sha256; t=1793016229; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qBk0lRNJYaIjqIfSjMXSVfYWnJGiDGsTo7b/lQOC7zO0eLrynneLHfvIS7WXYVJ0Ad
    /gLwWr0k/wc3VXsZv0NxsAjG2z3KE+kv5vd6hSGtl4WWmFvgPt0omm8Smvrl4mC/kTgS
    X8KNkjcfkSEWQU1+Qtv4qbid4nJvktnqePFxFB8RtXSbjFLB4aPcHPNsXx2fli5SE8/i
    U6XyZDdE8qHaHOW5PMJ0h/K4QGXp+P2txBtGZHmgjMDN8WRu/CXVgTw/07E/ToJ2LJMr
    CAAx8CiPaXqGBoIP4GKiqszDYtsjZl/EoV1e8asnU1P+rUpYIWp37EHBUihckfoxLjUC
    jnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793016229;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mfcpd1CPtNrlIK22YiULCL5YwfaxtcpMDTOiNzZ+lYA=;
    b=OaNd5Gg6Mz1hmat+4CJm2lLyhDFj53NxlglS2VQNJipGEF0KI4yxgcAknI9vzo3kD9
    RJRYr9Jf/K2L93KvoDncWdIhUo91khTvkmhbC2hwQmNQZ8KaJ8bnutgoRIrBOBZAbgF/
    3pc02BmK5o/gVGl1dzjH7g6ICNNUA/rQl8cPqJF3F+g3qvmMR4cTYLbx8nub00R1wWTl
    Ypj2gBSuEmeebtE51He8nvyWbu2XTKqzmZd4QBea0K0v8A5sp74l6T0RSVvGZO23sqsH
    iNabLmAvZdUrUfooh6wG82uNGORZ/bUsM0ZgVhMiyrRTw61uzSh9AhZK4zv/IqBY6xsw
    mE1A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793016229;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mfcpd1CPtNrlIK22YiULCL5YwfaxtcpMDTOiNzZ+lYA=;
    b=iaQN9LZazQDdK0xQu4IVG+Jqt6tXdqTpkU24cuE/mRplGtrKklCaew3FpasJ45hcVZ
    ria2KLh2aNGFif5p8yCnJnoeTu97bLkS8a4XcN+q/RaWq7eW9GefX5BDtfwGlXZclqvc
    f0x83ojcWAkoB6CChlxy177+OzY+nuxohVhfE5c23+ogkDc0/L6rf1vxS7yjeo6OdvYB
    r0BOKQV8klnHuY1TQbC15D5u166W7ueNsH59XiJbt7sNjUJzIAS0UUpRSJZO3hQEnDvI
    GBN6Vb4nZl2EQW0GHyaxUPCYXB2BvOVL8K6O8q6hcagxyFn1yAH76jadwCgx935OUM9u
    zM8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793016229;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mfcpd1CPtNrlIK22YiULCL5YwfaxtcpMDTOiNzZ+lYA=;
    b=rUbk313vo988VggN1na3Qxhi5s0Xm4uPrgyPUp3Veu2PazFyds9cTrrChWQnqr7p90
    HzrYZWIRQw+KEDysSoAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29QC3n27z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 13:03:49 +0100 (CET)
Message-ID: <c270fdfd-79b3-4f27-93bf-84d51b48c21a@hartkopp.net>
Date: Mon, 26 Oct 2026 13:03:42 +0100
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
Subject: Re: [PATCH v9 0/7] can: protect the receive lists with a per-device
 lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
 <89bb8afb-dbe5-4c8a-a6f8-66f9b0489924@hartkopp.net>
 <20261026-belligerent-labradoodle-of-beauty-b07263-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261026-belligerent-labradoodle-of-beauty-b07263-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26.10.26 12:51, Marc Kleine-Budde wrote:
> On 26.10.2026 12:31:09, Oliver Hartkopp wrote:
>> Hi Marc,
>>
>> On 25.10.26 22:32, Oliver Hartkopp wrote:
>>> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
>>> triggered when a CAN device is moved to another network namespace while
>>> a socket bound to this device is released [1].
>>
>>> ---
>>> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
>>> change-id: 20261025-can-rx-lock-cecab2ad832f
>>> prerequisite-message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
>>> prerequisite-patch-id: 20f07b0b0e4dbbdb1263e9bae3b652ec5709d87c
>>>
>> also with b4 and your suggestions this v9 patch set failed to apply:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025-can-rx-lock-v9-0-7ef2a2b5c2b4%40hartkopp.net
>>
>> As v10 has the same base commit settings it will likely fail for the same
>> reason :-(
> 
> But it worked on https://sashiko.dev/:
> 
> | https://sashiko.dev/#/patchset/20261025-can-rx-lock-v9-0-7ef2a2b5c2b4%40hartkopp.net
> 
> Sigh. Seems the netdev sashiko cannot handle prerequisite-message-id
> and/or prerequisite-patch-id.
> 
> | https://netdev-ai.bots.linux.dev/sashiko/#/log/baseline/8711/0
> 
> Can you ask Jakub if they can update?
> 
> On the other hand. As Paolo Abeni mentioned this series could go in via
> net/, it should better be based on "net/main" (without "can: raw: remove
> redundant NULL check before netdev_hold()"), as that patch will _not_ go
> into net/main.
This is really annoying!

What is your plan with all the patches/fixes in linux-can-next/testing 
then when I would re-post my series against net?

Will they be a follow up to my series then?

Or should I post it against your linux-can tree?

Best regards,
Oliver

