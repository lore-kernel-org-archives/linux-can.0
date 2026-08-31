Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878B3BB131;
	Mon, 31 Aug 2026 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159166; cv=pass; b=UrCKi7/9SQ9F5QuDgg9J4rzv2zLkE8BLcIU/1ZDq6rGMgzBwic2q6YP+DnztB5rETMBM2ajXJqWFYV4hgpOYLP7+pviShMpwSJanUfhmTiI/aRocvNe8JMbUHgqXeFOVU7AMj5SkMSDh12Uxp09rto/ZXsagDMye7RDlx48AaTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159166; c=relaxed/simple;
	bh=cXxhN4Nwn1C9sdeW2eE9csdr/Ab7cdI6H4x5ZyXGxsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzXe5Vz+eXpl/sixT4v/dl4KxkDwfnvuCAkf22HXLjVeDselHNKg1JfuKRKJMxFQiq7pFymUGss6rbkZCZaVfKittYoy1UZuBzkf6tXTVzmxSxyBrciMaH6MSwNVlK6/yX49+bA8QNe6hIcODxMP5oZh8aRa/JcP+2pcAEWPINA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ceocD0t8; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Iwv4ob8d; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ceocD0t8";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Iwv4ob8d"
ARC-Seal: i=1; a=rsa-sha256; t=1788159151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UximjvO1nu0vYk2soIVqHvk56GCkccxd55CM9pgRUjYDzJBV893ffZFGOxy5R86E7H
    k8+16etA1umQ9yutJ2oulsrBBQX6VPaPNVrjGwyHdBlM2paTVUJu/qOOkS4Fju9XhDey
    CZ1GS6ZiCFaAxIdF2EvW54aLbG6PWClSSRF7r+e6hTNkY1kP2UtOG2n+VSq3yZ3Q2k1n
    BUvc6JTBN8KUEvJ8Csjk6p+jRssJ4TF5qQt/QGnOJGW3v9nOswkiLrJNhrxyxNmRaQvw
    Di2rmIR3NLPB3ik0wggr2z8WPyXP+/NK/hlW+w5163kbKxePoNgHSCwZGutfWPLpsLKT
    chGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788159151;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wKF4l5SuUPdDxenPe6Ffz4Zakgr9CsMuQ+RHB47hAaM=;
    b=IDxwQPw0UIH6rV1ij9OaC4zUeqAJO/qfDfcsyJKJbZGQ93pIKCQIPCYsqve7waGMfD
    /5Zw9SAUGXjvC5Xf2g5eBcjc7zsS+9IKv55XulcM5+bFz7kQA1DjSfPOvAtZvz4zhTFx
    lLgGH85tAUDLN+2sMqD0B3tcFqK/1hcxbZ0cn1Hk5VBOeXaLDlMyldKoqsdlCxK4h8qU
    nZE7agWihZimP2srDfyi24VGOpxleSvk6s9eMgGzxRZ+KRAsp2CYv9EMKYhRw+9Jx7xb
    Pdui7swo3OW37C9l7Wu9Mb6OJPdnH3jJELQPC2SOIrZXzuHnhHZZFxj73c/dKm/ADOp/
    F7lg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788159151;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wKF4l5SuUPdDxenPe6Ffz4Zakgr9CsMuQ+RHB47hAaM=;
    b=ceocD0t8J4eqW0It4e5zV9zoqXd+wj0ueXva+oLQFHzAqCWBRqsS3SsI7Trhf4w7ym
    8fnS/JgqTPJxhBMPQiXofdGyRhmc+UNIQKW80Sz+rX2x1Li5wDM+9fMtB/y/6riGMmbk
    foANJlmuETFsDESYVL9o107iwEPV3NRRVjllai2CV1DJBNg8hM/CGvEwNUu9NQ+NDe28
    bDP7ei4bV+eoLPx324/3tW0kKbyFvHdW/JG72yaOHF//iQfNRHrLzwikgUApUkLIhEJJ
    cLscoP7EeJsGlpN80UouBNVcamZ+MPd7D3bguziM6bQ/bV/6ORuml7Qt9n70kxSx9tiV
    RqdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788159151;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wKF4l5SuUPdDxenPe6Ffz4Zakgr9CsMuQ+RHB47hAaM=;
    b=Iwv4ob8d/G8vPqrxAWo3j8nVvej0WABzyBph+MqZDpLrUM/f+EpgH8oR7b4VfKsfmu
    vVnwlFZ90Vag0tOpiHCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727V6qVI6Z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 31 Aug 2026 08:52:31 +0200 (CEST)
Message-ID: <f008dd7a-9883-42bc-89f4-07adcae58cf6@hartkopp.net>
Date: Mon, 31 Aug 2026 08:52:26 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next] can: raw: remove redundant NULL check before
 netdev_hold()
To: Sang-Heon Jeon <ekffu200098@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260831052031.902699-1-ekffu200098@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260831052031.902699-1-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31.08.26 07:20, Sang-Heon Jeon wrote:
> netdev_hold() does nothing if dev is NULL, so the check before the call
> is redundant.
> 
> So remove it. No functional change.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/free/ifnulldev_put.cocci after commit f83b8a58695c
> ("coccinelle: ifnulldev_put: update outdated helper names").
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Many thanks!

> ---
>   net/can/raw.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 82d9c0499c95..e1d05a0341eb 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -525,8 +525,7 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
>   		ro->bound = 1;
>   		/* bind() ok -> hold a reference for new ro->dev */
>   		ro->dev = dev;
> -		if (ro->dev)
> -			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
> +		netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
>   	}
>   
>   out_put_dev:

