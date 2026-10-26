Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.161
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793014284;
	b=C72DhWnZFpOKMHt+Byxj0qAlnOkGU3UJaljZuZX6utMnbQ9Vh0gI7oqYlj/XYtgNay1M
	 QYnt/q4eXbvmwIYPn1XkuVdqjWo0oNGw5NjTDd+grhbnDnRTrIfGzbO7SbblK3kabeiKj
	 PbZzzssHwtJw+BgYThAFD47S9Tyygx+7jLniDXjvddmRsqn4RaQ/P1UNcSraD6PCgZDWd
	 hACnnE5O6U9fdvdEqEC+dBgcxyV+K5GPpJ5Iyh2HSsU+42mezAA9kECx/JSLhyCWi8mp/
	 SVuIygxXYElBT3ldhrterd/8Pzb9MHBUMrQ4DJO8jjx705F7fbgk/9QrOpSroAnzmdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014284;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TiuH045KiLpK/k9PzatxMdRr7zTYcll1PBib6jwPSTI=;
	b=Pp2AUjRlIsoatNz6Qo1qrsUNPUyhUHfiuJ4b3bd82GKS8dkZeX2b86V5vJSTpYGtK624
	 cpwq0rmT+Cxl6hNIFBRvDdTszjL19JevUOnPEXRSfSxmwcctn0yILYn+rvhzDBZRkcX/a
	 wfWxkFpPscsu5miQYlLvIzNSQtCO/LVmUANgBkWJ9mboGbqacceocojbXzP8PrqKJXtZS
	 F9aERMSgyTvETyPQr9shD7tHV8p9QBKwj6LpGmLj9le0lOAor0TI4Xx3y4ni9VmMI7FMB
	 zlCyAc7WHBhHOI2GwKQgEigSpXvn6H8j3YV5SSwgxrdhcyGI+18uDYNq0xgTv7WSd0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=WZz9d9in;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=AKjbyfi1;
	arc=fail smtp.remote-ip=81.169.146.161
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115E6072C93
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 11:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E115E6072C93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=WZz9d9in;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=AKjbyfi1
ARC-Seal: i=1; a=rsa-sha256; t=1793014275; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XiduYZQl2J27hMAhH4rEzvm8x1y0vSNCfTAVSktQnwgmYxk1XNoxjZUkhcZ5h8h+uC
    kUOKGCa8cHIyc1RKgBHrrLYUpiJFeumiYfnv/SxD8XQEKYm8St8ULmsL4WMAobX2w4lu
    1jB0hwjwwabRpmLTxq3kF9Ae3FDXGvVU4zOQJ87wN+ly9hnb96GCvU/nF494S8U8N6a0
    MILQk2o4rTStWBLU1YFkjmiXFy2lpIOM3aXcLaoitt2n6SIVBP047r/1adL9oajeTMls
    n1x6WkgLL2l4QgN/FJFsMM8OW+nIitSEgxHspZvJIGCbvZQFvzyQTD3G/pVAReLg3rTj
    BUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793014275;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TiuH045KiLpK/k9PzatxMdRr7zTYcll1PBib6jwPSTI=;
    b=QEYdORB+dRs65hE8hK9v4aJfY30tj9PIHrYAfJejMMS16z4tXVgVcqEO8y8t4CKCU9
    rpPXM2SoKQA01CoO8F925fPW0P+m6ut2a6vUz2AlLimzlxoTaWkS/UUM9ddL6LM2508o
    ONnQtIoaED6HhC+Mv5C+S7Xl4NCEYSPw7cX35O+4Ut6EJ2N6IvBBDzlg8N76S2Yd/5lM
    KCD7stqUvTxNpvDpwp15Hxy0UqzJxQTOpBCvdCCGrgTOnczkpuHebQhgFizWxe5V3ksP
    Suu7gkLfo4bUrJGh4nxD3aXFjYGRQaP8UsVe7ECEXe28ZzEFbcCANt9ioMvPnHiyUXXN
    pULw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793014275;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TiuH045KiLpK/k9PzatxMdRr7zTYcll1PBib6jwPSTI=;
    b=WZz9d9inG1f3xDbBRgXw8gu+ekr3HDLbPF3nx4TAMoYH3W7+LVZx0pfjML9ZD2vtGQ
    XLg/FUAsVS0FrIvLhHstNOFdZkASaJF4Zc0/sDwTfD2Kukl1xr8bT4ZbZOF0bTPQAvKb
    aPHCSGOIMM94wqlY03/WkGmKGxvRo8pZze2WLit3sE1bRuhqT2ZX+eNn+MNo18bMkWer
    CY+evmlv5gceWqcnR+rad10TiUrcO4mL2JtSlL6LfCaP5SOOpjA0QdZ9sXt5M32YHcDM
    Tmo5yGwFa45MmtiO4DnF5Il72FZ/d4YpNYQKcR3hpB3XaOsyiynhBIybLshNy32MSdvi
    UxSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793014275;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=TiuH045KiLpK/k9PzatxMdRr7zTYcll1PBib6jwPSTI=;
    b=AKjbyfi1KCws5n8xlSi2rfG0Fs//sv62WzFvSB94uG+My19KOY+aakZo3FPNlZiOyA
    2oeLidBJ3tG/kq3ibMAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29QBVF1wl
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 12:31:15 +0100 (CET)
Message-ID: <89bb8afb-dbe5-4c8a-a6f8-66f9b0489924@hartkopp.net>
Date: Mon, 26 Oct 2026 12:31:09 +0100
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 25.10.26 22:32, Oliver Hartkopp wrote:
> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
> triggered when a CAN device is moved to another network namespace while
> a socket bound to this device is released [1].

> ---
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> change-id: 20261025-can-rx-lock-cecab2ad832f
> prerequisite-message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
> prerequisite-patch-id: 20f07b0b0e4dbbdb1263e9bae3b652ec5709d87c
> 
also with b4 and your suggestions this v9 patch set failed to apply:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261025-can-rx-lock-v9-0-7ef2a2b5c2b4%40hartkopp.net

As v10 has the same base commit settings it will likely fail for the 
same reason :-(

Best regards,
Oliver

