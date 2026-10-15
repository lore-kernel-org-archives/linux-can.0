Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37A4A0127
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053868; cv=pass; b=QzjZgZtE66oEEn07Mr/LKgywCNLxMq42Vms+4ig4AnpiEeO1Ss8pxx+6DxK5sZ61Ll0T+kGK5jE7Nou5ph+JrZ4F3coGFCmo797ex+lbUXBUaw1kY6JvtdPkB/n/zDMAGxjxNKbbpzWNbs1evIS+efGgofdFp1FWAks6otszEkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053868; c=relaxed/simple;
	bh=PlfNwfS3YYKGbMK9Pb0VEaeR1Tupxr/UECMlTBedPCU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xx3NlEGLPGNkLfRh4vjdSzA5RFBAUmD31AePa5mQBtYJhFc3hcoYBlTE8acV8xIBiG2AZrtdECWBj+Fs6Eyon5Pqt0Sg8YOOeqzfenB8t1krHR3OuewIFLJDw5yUyrRUWuLJ4sVaryk0fiqWiRB0u04mGPkoU/HDlDAMC+Q3cmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WKjpx0GJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=f6h0vBO9; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WKjpx0GJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="f6h0vBO9"
ARC-Seal: i=1; a=rsa-sha256; t=1792053857; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kag2qALiNuH9dpLD9VpgobiMwATSHwTjv3oEHW1HjimVggygzae1+B2jij3/zmhCpd
    QaQtPDJQv2tVSaAIt6YPFBssrCR/4jzftjCeqY8sMousp0JbY3Udqstj/3nf3H3HGu3e
    GN4Tmx7QX7Tw4WchU/JxpGJsQGlBJuWZPkzsNDKDzWgSLcnqt8xRTgYdl3vQX8q+1aqv
    seAEEIqQhvDKPgtSbTef5Zpm3IEB6PLWh8d7lX3DAEhayo0ij/WL1bTtm4ifN7BwEUdt
    dZPFZ7+LXVqB95u//ylijzZObuKsG3Taae4E3g76De8c6UHs5IJmB1ZvS2Ov7z19mp0j
    +d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792053857;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JjUzFRjjiy+QUzISVmeHUp7khFptOhjI45b7kz65njI=;
    b=j8l2G7bu6wmzVqUY8CbHB0RxodwG/9N7P7dZfKZOX9CkSW99MoMMF6zMgcFGqTqLcN
    iMcdmq0CqDA6C3YruubtIc2mPcoRmhyLJzZuJ2e1H51+bTXvtPXOZzo3ID3EX01y8S1I
    Z+q7LryVg2UmVBMvovBKlWNdvlSMfByODoFRzigdKQi0vrc2huUJJFlkJNys/4G16V51
    9vcot4sK9SKf6tkblVVjWDfjnv3JDgeBNtyEvUMr9h1X1JFqGJX5PjUvZ6F5yk1ieH+z
    fWDoLU7QINWK8D1NppvE1h6KZzPe1gG83o/U7fWRH/8s/zs8kIvLVSL3NiuNkOq+aI4n
    vv7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792053857;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JjUzFRjjiy+QUzISVmeHUp7khFptOhjI45b7kz65njI=;
    b=WKjpx0GJDsjqacHge2d0348iErFR/F4ED5b42XcJ2cV4y3pU0l99zCePIfUZnWmjY4
    YlGlwRIhyp3KfnzAsHmGRSJwf+QNOBSaSZZOjq0I3xYft7Gbt4zfkpcYlZJ6fR2N6Npl
    oD49UQzu1nij/p/kzQMCM3t8zc88IJCau5p4wLf+MHpR02U0mno2taNhUhy9YIIXv9G5
    Gi1i9WiI/dmGWsNR5ua5SlwkQkgpA9IEKw/mL3v1Cajh0zqJ1Lej+lLqlg+1k2aFjKgd
    YtDWooU7RcXWieR3lIlW7N714oD3ErhhFpLEtlhsqIi1F08I4mpOca4I418tmvE/xm/o
    pzcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792053857;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=JjUzFRjjiy+QUzISVmeHUp7khFptOhjI45b7kz65njI=;
    b=f6h0vBO9MibbRp3LoDOTSusZ5zv3JVpwih1YaQKmpoYofYZn53yXro7mvBPDCa/nm+
    XDteGsZ124vs/v1U/VDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29F8iHGk0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 Oct 2026 10:44:17 +0200 (CEST)
Message-ID: <c03a99d4-5ae1-415c-9f3d-de6855755f93@hartkopp.net>
Date: Thu, 15 Oct 2026 10:44:17 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Lee Jones <lee@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20261014-hilarious-bold-jellyfish-f47b11-mkl@pengutronix.de>
 <20261015073410.GD1182143@google.com>
 <310d797e-00d8-4737-a308-1aecbeac4c75@hartkopp.net>
Content-Language: en-US
In-Reply-To: <310d797e-00d8-4737-a308-1aecbeac4c75@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Answering myself:

This patch from Lee with READ_ONCE() and WRITE_ONCE() had been 
completely reworked to use a workqueue:

"can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68973f9db76144825e4f35dfdc80fb8279eb2d57

which is also from Lee and upstream as said.

So THIS patch here is obsolete.

Best regards,
Oliver

p.s. And the READ_ONCE() and WRITE_ONCE() in this patch also became 
obsolete. It would have no effect for race conditions only for KCSAN 
annotations - which we do not have. So we are completely done.


On 15.10.26 10:03, Oliver Hartkopp wrote:
> 
> 
> On 15.10.26 09:34, Lee Jones wrote:
>> On Thu, 15 Oct 2026, Marc Kleine-Budde wrote:
>>
>>> On 19.05.2026 13:38:05, Oliver Hartkopp wrote:
>>>> From: Lee Jones <lee@kernel.org>
>>>>
>>>> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
>>>> synchronize_rcu()") removed the synchronize_rcu() call from
>>>> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
>>>> timers from being rearmed during deletion.  However, it only applied
>>>> this check to op->timer via bcm_rx_starttimer().
>>>>
>>>> It missed the fact that op->thrtimer can also be rearmed by an
>>>> in-flight bcm_rx_handler() (which runs as an RCU reader) via
>>>> bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
>>>> bcm_remove_op() has already cancelled it, leading to a use-after-free
>>>> when the timer fires on the deferred-freed struct bcm_op.
>>>>
>>>> Address the omission by checking the RX_NO_AUTOTIMER flag
>>>> in bcm_rx_update_and_send() before starting op->thrtimer, effectively
>>>> preventing it from being rearmed concurrently with teardown.
>>>>
>>>> [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to 
>>>> bcm_release() before
>>>> removing the CAN filters following the bcm_delete_rx_op() approach.
>>>>
>>>> Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
>>>> the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
>>>> potential code reordering of RX_NO_AUTOTIMER setting after CAN 
>>>> filter removal.
>>>>
>>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>>> Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>> Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly 
>>>> synchronize_rcu()")
>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>
>>> This patch is obsolete, right?
>>
>> No, I don't think so.  I thought it was applied to the maintainer tree?
>>
> 
> I think it became obsolete through all the recent (and stable) changes 
> that addressed multiple races. The UAF problem is solved today.
> 
> Btw. the use of READ_ONCE() and WRITE_ONCE() can be seen as some 
> addditional hardening but the entire patch does not fit to the current 
> bcm.c code.
> 
> The READ_ONCE() and WRITE_ONCE() may be added for the 7.5 net-next 
> window cycle. No pressure here.
> 
> Best regards,
> Oliver
> 
> 

