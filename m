Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB5190473;
	Mon, 12 Oct 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824350; cv=pass; b=qyWDdjL3fuUADvOC8o5nV3SyXatQCslpVG29RQiPtz6BxBPZbM6TPTqw5b1VKomablsC7vzCdMYrzDKw89dT8hQBhtqBKONEe8JnusU+bZDhu9sQ35tkOKQ+bPt5i9j1R1IrFc8y51jqT4HHzs6VAYetVnP8oz/+Lub2ymJudu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824350; c=relaxed/simple;
	bh=yqFSCRZNjVlGfAyTQ0FmdQdbn/SaJ4SVEkyO2LG6mWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6PJbtSgaisbdjvnGzYPXUpHGGgwoh+1JKu7XLGIqTDg0AICJN4E/vD89CsD8kqczXvf6zCpgmsipzJ0PUqQZ6/vNGZ1CnvCYq/nI7gk8hIVgC1T6qf/EW4Gtmj8uFgv350JwYoXhP+rL24Phd/NtO3lbFB4njnss+ImRTr2Xbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=AXmE5Vdu; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RRpsf6ds; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="AXmE5Vdu";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RRpsf6ds"
ARC-Seal: i=1; a=rsa-sha256; t=1791824342; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=THVj9wLscJMeKtqjE7daqghbwHIRRBoHwrBazu9h1d4yDI0IV5MXE/MM/baQmp/cCo
    iO/oF+bzk4WTmPpA2lT+0ASHs+4Ov53iH3+SXz2J7C3AIsU9zwhPPWB4OeOb3bfCJglm
    isDnRLsgiJOmoDwobHze21xeTLHaLeT5CiwvbH0cZEX1WKLGGNn/vzNHIaBF6LMhr9F0
    Oar3/mLObp3npfHabAFhnA0xQ3vRj0mt17G3Su1ljXONj/QTdpmkQQIH7H5YOTZESD8H
    V8oh2fIevan9XOEMm8thtevvGRqYw8voVAco9aW1n8PbIhpRhVEFIQhvgaTdD10x4pTc
    +yDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791824342;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aA+U9eHyMpzg8/BD0pL+ZX/wNUx1vYbNDbLfoh9BV+0=;
    b=h227hTf9xgS4rx2QfL/O/WrwK41uMaXcTiKHzIFJI0274wyv/Bfj8Umqa/lDRKMaYw
    Nn1O9NEdsCFB3fJ0cdSUP8eYlkRWxFUqitW7+N5r3GYnFeHwtw2/fcTHlGbtdZeuHFCf
    kvBANHWG8gfaCkgilJ66K+uCmjh2WBMTlA4VVVDBRfye4v1CxG3TkcgSIGRFrqgdpVLw
    kolAWFKZalwa4li8zqRSnn6QPvZrmakOxlzgtOEzj7boz45wgsZzVhn+LqB9AFblKdJd
    cZTWm8FXl4wgwhm7XvnCJwOsQL+E0uEjPRrVEV3MFVMGGV8Ja48pQq8wpr+g/fJfsKjX
    4vRg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791824342;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aA+U9eHyMpzg8/BD0pL+ZX/wNUx1vYbNDbLfoh9BV+0=;
    b=AXmE5Vdu1njTJq/VejAMNLH1OLooeFDXndDPhP87MLAgxhVajaOcElix9SZaBENEtF
    wd+O/ybqTBgMLVCmYyrscqCVG4UwcHbXem+m7OXkfs087k6hLaXo233hdHYV7RbPYPt1
    dIFrGj4gWDDD47QZQ+68M3Y/g7p4NSvZWeGNT9EBBxqMugmHPEPMhXS6U4dbEAtL1Gaj
    rEcMEpXC+rziazx9kvp4xJbK7GB1B8+OpBtL0Bepl/KGryErsaT35JPtKpqikvIGdpBc
    7e4TwfJww1BnElWQUiY6TgHf0G25O9Vwv3AdQ1dOWv4tYttV1nuguiiVVVgdKmGLpXNZ
    lwZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791824342;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aA+U9eHyMpzg8/BD0pL+ZX/wNUx1vYbNDbLfoh9BV+0=;
    b=RRpsf6ds5jce2DIei9xhpRZnSHGm4H+uS8TD6AsNzjFGjYZFFjjWIXO4ILPSljhBxv
    vCBRbr4fjk0xKAxvRuCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29CGx11vf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Oct 2026 18:59:01 +0200 (CEST)
Message-ID: <ce295e92-9080-4886-b1e3-70d8efa8a2cf@hartkopp.net>
Date: Mon, 12 Oct 2026 18:59:01 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/37] can: convert unreliable ARPHRD_CAN type
 checks to robust can_get_ml_priv()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, hemanth.selam@gmail.com
References: <20261009134323.64064-4-mkl@pengutronix.de>
 <179164096840.434549.11863787117718202775@kernel.org>
 <135a3c74-078a-48eb-9c2a-ef1abe55cb5a@hartkopp.net>
 <20261012-victorious-sponge-of-progress-f32376-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261012-victorious-sponge-of-progress-f32376-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.10.26 15:09, Marc Kleine-Budde wrote:
> On 12.10.2026 14:58:09, Oliver Hartkopp wrote:
>>
>>
>> On 10.10.26 16:02, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found more severe
>>> issue(s) in other patches of this series. This mail is only an FYI, in case
>>> you want to address the nit picks below when you respin.
>>>
>>> Low priority / nit picks for your consideration:
>>>
>>> - [Low] The commit message calls the change a conversion of 'unreliable'
>>>     ARPHRD_CAN checks to 'robust' can_get_ml_priv() checks.
>>>
>>> Pre-existing issues:
>>> - [Medium] This problem wasn't introduced by this patch, but isotp_bind()
>>>     in net/can/isotp.c ignores the return values of both can_rx_register()…
>>>
>>> --
>>>
>>> can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
>>>
>>> This patch replaces the remaining dev->type != ARPHRD_CAN checks in
>>> af_can, bcm, gw, isotp and raw with can_get_ml_priv(). The reason given is
>>> that TUNSETLINK can switch a down TUN/TAP device to ARPHRD_CAN while its
>>> ml_priv stays NULL.
>>>
>>> Link: https://patch.msgid.link/20261009121115.61012-1-socketcan@hartkopp.net
>>>
>>>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>>>> index 34fe3b28d576f..dc27ace43719d 100644
>>>> --- a/net/can/af_can.c
>>>> +++ b/net/can/af_can.c
>>>
>>> [ ... ]
>>>
>>>> @@ -519,7 +519,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
>>>>    	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
>>>>    	struct can_dev_rcv_lists *dev_rcv_lists;
>>>> -	if (dev && dev->type != ARPHRD_CAN)
>>>> +	if (dev && !can_get_ml_priv(dev))
>>>>    		return;
>>>
>>> [Severity: Low]
>>> The commit message describes this change as replacing "unreliable" checks
>>> with "robust" ones. Should it also say that the change closes a NULL
>>> pointer dereference that a user can trigger?
>>>
>>> Before this patch, the sequence looks like this:
>>>
>>>     ioctl(TUNSETLINK, ARPHRD_CAN) on a down tun device
>>>       tun->dev->type = (int) arg;      /* ml_priv stays NULL */
>>>     isotp_bind()
>>>       old dev->type != ARPHRD_CAN check passes
>>>       can_rx_register() returns -ENODEV, return value ignored
>>>       so->bound = 1; so->dev = dev;
>>>     isotp_release() or isotp_notify()
>>>       can_rx_unregister(net, so->dev, ...)
>>>         old dev->type != ARPHRD_CAN guard passes
>>>         can_dev_rcv_lists_find()
>>>           can_ml = can_get_ml_priv(dev);   /* NULL */
>>>           return &can_ml->dev_rcv_lists;
>>>         hlist_for_each_entry_rcu() walks the near-NULL pointer
>>>
>>> dev_rcv_lists sits at offset 0 of struct can_ml_priv, so the returned
>>> pointer is near-NULL and the list walk oopses.
>>>
>>> Triggering this only requires owning a tun device, or CAP_NET_ADMIN inside
>>> an unprivileged user namespace.
>>>
>>> The patch carries a Cc: stable tag. Could the message name the oops in
>>> can_rx_unregister() (reached through isotp_release() or isotp_notify()) and
>>> the privilege needed to trigger it?
>>
>> Hi Marc,
>>
>> do you want me to rephrase the commit message?
>>
>> The referenced "Fixes" commit from Oleksij
>> 4e096a18867a5a989b ("net: introduce CAN specific pointer in the struct
>> net_device") was introduced in Linux 5.12 but is available in stable 5.10.
> 
> please go ahead!
> 

done!

https://lore.kernel.org/linux-can/20261012164802.94113-1-socketcan@hartkopp.net/

Best regards,
Oliver
