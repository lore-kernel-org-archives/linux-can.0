Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135240F756
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850133; cv=pass; b=SvWjKMJZ7SCW/WOQyyolPBqFlN96G6hnj43ib1RlWiLEbU961IsPAvkUdOfN5DYFjbBX6PhCwziZN+pRIR2hazkUZKjQRit3v4hu6+a4wVvKo3MWws4dMstfC4RJX34Aq4M6x/XiP857GfXhqgtdZN6acR+CSm1vrgzCFR16jm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850133; c=relaxed/simple;
	bh=0rsCnwel9LvZsUcpCHlRHr/3V7TF2eV7fdDbCyrMo/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eo3Jf/rT8DSZqH0KwqcxbrxFZ3EX/HvZXwnhceUk9XrFK9GL0b5KZT1XOU6h0F9auB8dNan7aKIqNtalqhvj4J0SUdnePHfRuhRR6xSpK4nNiNGnZ77vHbOfMg2DBopZpdrrlvNS1PcSKF6qH6UCIB/2OYBom4U2VbZ22hWMAAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sCMpVgU3; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cyruwPtr; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sCMpVgU3";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cyruwPtr"
ARC-Seal: i=1; a=rsa-sha256; t=1787850112; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XHWpSsyhHCJR7wmYNCnaR8uTYKLYXs5z0RBjFid5DpawJEuPfS1P6Ca/DBKY3SSAtA
    KW/QQAf9UOT5ECVYTTkVgReXevrgT6nReH/qzWWJvUbsAZHADiZkHmlp1TdonH14G1yZ
    o/Bv+lhu9EWxw0TgJucRJ7URVQmPwbzbDumfAjg+uUiBn1CBiCgPHCq4dCLrPGXYgzkT
    SDltOARdBKD8+8Rz+bTBHpMmYP5ajezD32AIixkaWC4yAT9Zu15PkqV47WW5JSxqtCFi
    uAMkNdUxezB3w0jpF4z30Sjk3Pzk8xC1BHNy3a7zv9Os5Y75F/ChU3jtcN1m8G5AgNPv
    0UUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787850112;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BlR77JsNVZOZaqMIIuyfx4w9MoUhgUy42ggcI/AkgR0=;
    b=HvKw+UrrCG4kGv2EG9hQPi9BUUpnCluvrFayREUjTYF3WM3yAIUNN901NARP5HWoxP
    rlvebQrHGoebBj+9yDjy7wRYSMdXQsW14ljgSAOn8I1e2smFsfc+uRbdf8nZOkAWR9VR
    NYo1B0Hi4FwAyrJmwVu+80HiaLTWurZWAWbxfdE+H4Zoxc3s1Okh5H96+AKNNsz4PEIi
    YhJf3hOwdlOmx9VlGWKiIbIKjyuV8L+KDjYYVtnnHbugQqnAMc+gq5Rv1Z8Ybmzi8++w
    ixurXck5VckxUgHlAdcDEbFZQ3YN85QabZ1M4JnE+ancweg1pEgF4LnTgvyC+tHEJCDR
    QDIA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787850112;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BlR77JsNVZOZaqMIIuyfx4w9MoUhgUy42ggcI/AkgR0=;
    b=sCMpVgU3Ulhi1afGB3lLMfeYV5eaBeh8k2wn4lOgAkRf0Do82ciXyKHnw33eoqKgPj
    +OwdlzpkFB2fQUeSvopbr6mz/snG3td/tfU14Vnb71oFc3X4GFvjfcHga3vlhZtyzhlg
    3yAfmYLT8zpYh5PtrMPxonSZO8k/FrPvcKTB1SdNyTwVM6da0FxVq/AyFPd/5FvUMTEo
    W+HcjEjDVqlfpi9lgDWZnz/bW6GP4a/PjkmFHlX/ZXsYtY4cdWbXhgttwF894ThkpBhe
    nA418KzTi3vZFqopNWhL1+xIhEJghI2P8U3dQtBIbHAmUr19+0jni5rETXrsHLCd+txl
    HUeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787850112;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=BlR77JsNVZOZaqMIIuyfx4w9MoUhgUy42ggcI/AkgR0=;
    b=cyruwPtr1xfq+XqZSVYKWlABN8z9yeQ8yXdmwYYcu1NZDL+JOKyR2jZY1jD3CZlVsd
    SfnY/L7sucTamFMSqiDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727RH1q2IS
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 27 Aug 2026 19:01:52 +0200 (CEST)
Message-ID: <54a3cc01-abcf-4a33-b932-39bb1f68cdd5@hartkopp.net>
Date: Thu, 27 Aug 2026 19:01:46 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 10/14] can: dev: can_put_echo_skb(): free skb on
 invalid echo index
To: sashiko-reviews@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-11-mkl@pengutronix.de>
 <20260827121052.975831F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260827121052.975831F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27.08.26 14:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Modifying SKB payload in can_skb_init_valid() without unsharing causes data corruption for concurrent observers.
> --
> 
> commit 6a48fe2d96b6f1ca706da34b2f7bdd872d06941f
> Author: Cunhao Lu <1579567540@qq.com>
> can: dev: can_put_echo_skb(): free skb on invalid echo index
> 
> This patch fixes a potential leak in can_put_echo_skb() when the echo index
> is out of bounds. It ensures the socket buffer is freed before returning
> -EINVAL so that all error paths correctly consume the SKB.
> 
> Link: https://patch.msgid.link/tencent_683AA16E643DE00211CD2FB62991264DC605@qq.com
> 
>> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
>> index c7be21ed70ddf..faafb1033d423 100644
>> --- a/drivers/net/can/dev/skb.c
>> +++ b/drivers/net/can/dev/skb.c
> 
> [ ... ]
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but already existed in the
> codebase. Does can_skb_init_valid() in this same file modify shared memory
> without unsharing it first?
> 
> drivers/net/can/dev/skb.c:can_skb_init_valid() {
>          ...
>          /* set CANFD_FDF flag for CAN FD frames */
>          if (can_is_canfd_skb(skb)) {
>              struct canfd_frame *cfd;
> 
>              cfd = (struct canfd_frame *)skb->data;
>              cfd->flags |= CANFD_FDF;
>          }
>          ...
> }
> 
> If a user with CAP_NET_RAW injects a CAN FD frame via an AF_PACKET socket,
> the packet goes to dev_queue_xmit() where it may be cloned for packet
> sniffers like tcpdump.
> 
> When the original SKB reaches the driver's transmit function and calls
> can_dev_dropped_skb() -> can_dropped_invalid_skb() -> can_skb_init_valid(),
> it modifies the payload (cfd->flags |= CANFD_FDF) without verifying
> skb_cloned(skb) or calling skb_unshare().
> 
> Can this cause data corruption for concurrent observers receiving the clones?
> 

No.

https://lore.kernel.org/linux-can/ac22b59e-129b-4883-b9c6-da5e69e4078d@hartkopp.net/


