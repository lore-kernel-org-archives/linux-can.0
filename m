Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0E442FA5
	for <linux-can@vger.kernel.org>; Wed, 29 Jul 2026 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321825; cv=pass; b=ungDBwWvpLitRq7kLzusWP3qYvKtXN0t6B4rtq3qWFvZulaaiGBDAMVbLO1JzMszx96LC4iIIEnBSk71ClEaaiIM16XKHFh6LMQo4hGVGOXySaiV4Eh9yyYN4TSIk2Oki6WGXp2EmDj6BUNh2YQgAcIw6Dl7T0FR7vXxfXj7O40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321825; c=relaxed/simple;
	bh=H5lwq1oDEpa4sld+Hs/ce4HU0QxMDVpzY28UOYXucyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HJq2uXUseViu4det0lLu97BRcgbvzDULbygBCVDwzDsYIeWML6E0WHgINrIoe+CF7vEKQh87PFQ9YzW/ZLtcOIazTz5In/CDiImw1y6GfLiTNprGtCl/Oh1yLal+Ren5G+yzWngAZHgRNGfJfIfKYhpE17BhCIqIusJ3It7rNag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nibgU5Rh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Vciv6U7K; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nibgU5Rh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Vciv6U7K"
ARC-Seal: i=1; a=rsa-sha256; t=1785321808; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WLRpRB/pvlgCx5xLdR5lvDpswXHtJ6CaWdZ6sSemxjMWwJYkM2n9DCpI/W+TAXFIxW
    mU4RJ0shHdNDebGy5bREepT2rscMpBu52Cl4/F9fSC37ZK4sLJY0BL/kNYzVn1kfFH/1
    vBNzK4V2WTQplL6QGUGhyWpWFUB3R4mKIAx0kRnlA4IKKpond+X7QauKyg4GxUIVsijh
    R1kxVMGADj/gW9M5S/Fqavluyze9TY7UeOA1rEKEtT/1IUpxWVtAJD08qgFPTEG7FgSp
    w0Ypzf1CFK5LDtxJrCmlME6HeQgutt519aYdc+lF1+q8LGLZh1FQ2PgAIgsz6ZvjKRsy
    qtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785321808;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=i6wvaj5d79NBjEZxt2SlC53ju7ZDAvR7eTCcdn5ucZM=;
    b=ZzNGJ+ldfk+MPh6WZWrmu7kXWrWcm+ltsUK8kWhhj1U50CuGf+FlNokZ6s8igl2S4M
    +Ie0OTg3r9/b5VKY2XREptTmjrNGfe/YHLQZ4hec8MYYdi5V7l1Gs3U4lVYkMvczjlda
    F8L3lIf3sIWYOEXOLdVy/5oDKCqc9Dia891O+o0/Wisbol1fDD92/vU4Tx6HJu2ei6ET
    4FCCUbZ0mPoCT8e062B54jcBKWrKyXyPf+NhTpySqq/JqJYhaX4071jGa5mD3ASe5lej
    PJVPEOfu7a3sKpXiCcZ2qA9ZeCJUYu21L1x43K3HIaNCA+wtGSGV2HnzVZFHz3RxyjXr
    g+aA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785321808;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=i6wvaj5d79NBjEZxt2SlC53ju7ZDAvR7eTCcdn5ucZM=;
    b=nibgU5RhZQQ+K5EHh4piXftQUlkFdVWF9mWFxKBIVXZk+skfGjJw6xdTb38pZSJNX9
    zhiCGKgMblS7a3cxwHgCrR0NWqNuAWpHQW22mG140rFPzhu7DzelSRx/Y3AML38WQrCk
    seP5SEfYNIXzkz1yuQ+FColWu+7xnT6KGSdFbYdIh+QvM2ypB1ngKuCtg+IDg+GooVL4
    P/WtM2rY3Xvse5AS7dXG6NJCADFMNi4//XJcnSaTwNhcHpXzXZHkpe0uM1CatNI5vwgO
    n55Gl3XF4T0xhGtjShB1WTw1qm0u6pLZPX7NyYpmmo/LEu/ik07B8r+lFuUNbBI0mCQp
    bvmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785321808;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=i6wvaj5d79NBjEZxt2SlC53ju7ZDAvR7eTCcdn5ucZM=;
    b=Vciv6U7KZAq7I+Om8nHylaVQrFBP2GZsNZtDDXNKDFHMVKAx672rUxIH5WTMWX+ijR
    oHrOGYTJI9USroflOxAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926TAhRRCp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 29 Jul 2026 12:43:27 +0200 (CEST)
Message-ID: <23288578-cd7a-46c9-8762-10e1fc95cf8d@hartkopp.net>
Date: Wed, 29 Jul 2026 12:43:21 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] can: isotp: check register_netdevice_notifier()
 error in module init
To: sashiko-reviews@lists.linux.dev, Minhong He <heminhong@kylinos.cn>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260728031038.76524-1-heminhong@kylinos.cn>
 <20260729085656.134523-1-heminhong@kylinos.cn>
 <20260729091346.D865D1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260729091346.D865D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29.07.26 11:13, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing error checks for can_rx_register() in isotp_bind().
> --
> 
> --- Patch [1]: [PATCH net v2] can: isotp: check register_netdevice_notifier() error in module init ---
> commit 059042597b87e317cf8905dce3a8140167d9528a
> Author: Minhong He <heminhong@kylinos.cn>
> 
> can: isotp: check register_netdevice_notifier() error in module init
> 
> This commit registers the netdevice notifier before calling
> can_proto_register() and checks its return value. If the protocol
> registration fails, it properly unregisters the notifier before
> returning the error.
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 54becaf6898f1..ae6260e98a7a6 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> 
> [ ... ]
> 
> This is a pre-existing issue, but I noticed a potential problem in
> isotp_bind() when reviewing this file:
> 
> net/can/isotp.c:isotp_bind() {
> 	...
> 	if (isotp_register_rxid(so))
> 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
> 				isotp_rcv, sk, "isotp", sk);
> 
> 	/* no consecutive frame echo skb in flight */
> 	so->cfecho = 0;
> 
> 	/* register for echo skb's */
> 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
> 			isotp_rcv_echo, sk, "isotpe", sk);
> 
> 	/* switch to new settings */
> 	so->ifindex = ifindex;
> 	...
> }
> 
> [Severity: High]
> Does this code silently ignore the return values of can_rx_register()?
> 
> If an unprivileged user inside a container calls bind() under memory
> pressure, can_rx_register() could fail and return -ENOMEM. Because the
> error is not handled, the socket would proceed to be marked as bound.
> 
> Later during close, isotp_release() calls can_rx_unregister()
> unconditionally. Since the receiver was never successfully registered, this
> would trigger the pr_warn("can: receive list entry not found...") inside
> af_can.c.
> 
> Could a user repeatedly trigger this to generate unbounded kernel log spam,
> creating a denial of service vector?
> 

Ok, so no crashes, no memory leaks just spamming the log in the case of 
ENOMEM as the device existence and the fact that it is a CAN device has 
been checked some lines before?

I think when we have a real ENOMEM problem the log output will be our 
smallest problem.

But properly returning -ENOMEM in this case is a good improvement for a 
later patch. I will prepare one when the CAN XL support for ISO-TP patch 
set is discussed. Nothing urgent for now.

Thanks for the review,
Oliver

