Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A23FB077
	for <linux-can@vger.kernel.org>; Tue, 28 Jul 2026 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231212; cv=pass; b=ltPxinv9KFAJpQXfoFRuEuBj66egK9fJsMHAXz6s88Mq8roWOL5i0iICc/hr6BhaxAu7zd8f9TRfg6/rNtTsnKZXXOIAQtRfhX9n6l9IReVu1t3skZ9oJCy1cPZ8sAuXMmAvpJ1Sp1K/CBHaEbHabjHfbux3ebuoIyWSs5odAA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231212; c=relaxed/simple;
	bh=3nPu7GA4VDAdbYK1fhB91miWBo4gyx0aNbjSVvZ4pSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXNDgbQCs4P7S4LUuUYbRfU8IHWJEEC1klyArX7TVYzBSB2Hh7sbKJLt0XpFZz3xBkJ4DyHD+k01k9m+Q6ww7EOLfg1ivtuCD+7mLPhFjYyknQvK4UhYWKVkz3lDxYmf2oB8PXz2x5qxlC0bUZDOsz5NFBAlYW1KZu+VntgpsKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=V2QdBcAm; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RXoEyNXb; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="V2QdBcAm";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RXoEyNXb"
ARC-Seal: i=1; a=rsa-sha256; t=1785231190; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J9yLpjJKMsdVvhhr7XyrC7su+IAQiACv5u9Yh+ESK7KyCwEjzJlGqPfo0OXBQMmJsL
    Xan6U3CVoxDTE6OG10yPgSN66fLG0Vafwf5twNzuZ6eRc5tOwFizMaOEmErxgGWRcSBh
    N7d7/Hw+8lXu+5yfXEdAyLLAVQaNln4fjbp4P4CW+VmoC+As2eXlLaoD+K5cPAk2sSqq
    RRVA9m67m6L5rVXA5usCZCBdUbWlCUVU7zuzyD3fgzxBpoJU2nAxbcRtqaRKBYb5mxRx
    ScXknySRpRobFD9rGZU25b6ZKZ/0gSv47lSJbAi+F83rR2J2+hrJ+A4ZreLHGJGHBN8M
    ugGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785231190;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q2CAZeSMQU2bF5QQ8Hvs0h4+csE+728wrITaolRe0nE=;
    b=odd+NzaA7mKxyByrITTt/WPG5vs5C2LlretZIX3ZPoQf96zyGOnNGlx9uqvEIoKLYL
    o2tPbZjIgg8WD4yk6Us+FJx12ny3VNrhhwJbp3Ptb0+hsRAyX8doZ5gvDnHJKtZhIo8G
    9rtB9+7RiEEq1jMyeIhcaWE6uDLy83nS60KSerTH0pP1BG9DFKnU7D9gcbD4VB7TiMMI
    F4r/htGE6ZHkO6+1XdkQhmS7sOeNITSaxdUfTGeFT/HXvhD96VM/DFITvrNBgyJJZ1f9
    iih/C/MprGCeeb+wVRQPxc0IcQCfenx/l0UaF6VcVby41SYwy31gKSbWMGKiGzl2jO4i
    lZkA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785231190;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q2CAZeSMQU2bF5QQ8Hvs0h4+csE+728wrITaolRe0nE=;
    b=V2QdBcAm19ntY2VD09LGo3iI42cw3LIdJH9Plovim9PqkmnwfG/2Yb4q7rzDnXiN3/
    A06VCSaR3Knm8K/DmnOc52frqfU9YiZ8vyf/vVHi4lE+N+jteyZYTVKS6VaeQXFbj59M
    SFPVKSIiXMMbzKVh99y8JjApcEEJRnHzrc6dr++/tPh7I+Yw491yu3v7gzHcAUi19xtf
    IM1r+eTrQNEFrZCTaZIYpNm5CaAJAY//5mSw3sS0UTma3toE+Ofs2K2vN0iLlXab4ZQx
    X8o7mHYPLh2FbKDNpTB0nqkuUybsLSSesKfH80onrmbFETfE5WGulglKQcYvEiJKutGN
    SuBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785231190;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q2CAZeSMQU2bF5QQ8Hvs0h4+csE+728wrITaolRe0nE=;
    b=RXoEyNXbI5beJXxpQwnYtIlpmmov+2z0SwKmJuO7hu+we1cKl+BMtMHvN1khnhLK5A
    vIKdiY6fhNnSX5HB/0BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 SBL|AUTH)
    with ESMTPSA id K5281926S9XAIpy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 28 Jul 2026 11:33:10 +0200 (CEST)
Message-ID: <6b4b69b1-ae54-4a20-b33a-cd1dea622445@hartkopp.net>
Date: Tue, 28 Jul 2026 11:33:05 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: isotp: check register_netdevice_notifier() error
 in module init
To: sashiko-reviews@lists.linux.dev, Minhong He <heminhong@kylinos.cn>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260728031038.76524-1-heminhong@kylinos.cn>
 <20260728032011.CF7241F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260728032011.CF7241F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Minhong He,

thanks for your improvement - but sashiko-bot is right too.

Currently isotp.c is the only CAN module that misses the error handling 
and the rule of thumb to expose the userspace visibility as a last step.

bcm.c and raw.c are already correct in this matter.

Please send a V2 which also references the bcm.c/raw.c init functions:

"Align isotp_module_init() with the reordering already done for raw.c 
(commit …) and bcm.c (commit …)."

Best regards,
Oliver

On 28.07.26 05:20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Registering the CAN protocol before completing all fallible initialization steps creates a race window leading to a Use-After-Free crash if initialization fails.
> --
> 
> --- Patch [1]: [PATCH net] can: isotp: check register_netdevice_notifier() error in module init ---
> commit 5f2f7a58360e9a2c18b5d6a9a724f468f79227d1
> Author: Minhong He <heminhong@kylinos.cn>
> 
> can: isotp: check register_netdevice_notifier() error in module init
> 
> This commit adds a check for the return value of register_netdevice_notifier()
> in the isotp module initialization. If the notifier registration fails, it
> now unregisters the CAN protocol and returns the error.
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 54becaf6898f1..65e890cafd7a9 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
>> @@ -1908,12 +1908,18 @@ static __init int isotp_module_init(void)
>>   	pr_info("can: isotp protocol (max_pdu_size %d)\n", max_pdu_size);
>>   
>>   	err = can_proto_register(&isotp_can_proto);
>> -	if (err < 0)
>> +	if (err < 0) {
>>   		pr_err("can: registration of isotp protocol failed %pe\n", ERR_PTR(err));
>> -	else
>> -		register_netdevice_notifier(&canisotp_notifier);
>> +		return err;
>> +	}
>>   
>> -	return err;
>> +	err = register_netdevice_notifier(&canisotp_notifier);
>> +	if (err) {
>> +		can_proto_unregister(&isotp_can_proto);
>> +		return err;
>> +	}
> 
> [Severity: High]
> Does this error path introduce a use-after-free risk if userspace creates a
> socket before the module initialization completes?
> 
> If can_proto_register() succeeds, the protocol is immediately exposed to
> userspace. If a concurrent thread creates an ISOTP socket before
> register_netdevice_notifier() fails, the socket will hold pointers to the
> module's protocol operations.
> 
> When the module initialization aborts and returns an error, the kernel will
> free the module memory. While can_proto_unregister() removes the protocol
> from the registry, it does not revoke already-created sockets. As a result,
> any subsequent operations on the existing socket will dereference freed
> module memory.
> 
> Would it be safer to move the fallible register_netdevice_notifier() before
> can_proto_register() to avoid exposing the protocol before initialization
> is guaranteed to succeed?
> 

