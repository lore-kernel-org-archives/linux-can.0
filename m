Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A03175A8D
	for <linux-can@vger.kernel.org>; Thu, 16 Jul 2026 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784182871; cv=pass; b=t18Z6s4kMSjdFikuMdzp6hTGWS0SRTPwfYFpnAgO0bED+Z5gF7KzulrXNQZcqW3UzVZOwFzeZJDaB7YaRbWjrU1ApYHJhalNbwhIJdrEqrV97bBgegZndwEdwEn9HKAX3C/saxdxOZL5xjDMDh0CNI+By3Xj0GhYbzZQehY1x7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784182871; c=relaxed/simple;
	bh=1TfowDYYnSEUJOcg8/XAffNtOkl1RNC1yDqsdw75BLo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fVLokoGPlI/AjhjdtYV+LyzAbiHMQI12xLZQ8pQ64elLpsyveACmFo83OfrL4a66gsC6v5rFyCHtFeRr+7jwSesIUtbxVUHycm1L4cabIau0wIAOVjAkLJA0nVKoBNAGmLcMmhr1JxIpkVBPb6lD2auRoJD7Uwd7jl2CzbrAZ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=p9t7U4qe; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cEyKt1PC; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="p9t7U4qe";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cEyKt1PC"
ARC-Seal: i=1; a=rsa-sha256; t=1784182680; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JoWHQbZ9A6urS/MeToLglUacHLFJnJrl26ae7E0x6TfGD7xiJ8pxnJKCE+Tz674SSD
    BY3JYbkxKGuwgdwoD8yNp0+QH3YbKhPV3rwfeb8e4cGxKGy1xUv6NWW6k6d8JNFLa+rJ
    Xp9rH09slAY/XHGEjIO3XVU/+uN7/B8fnYIwlK953Sz6a03ZSN7vdpJ4hNGZgfuksj3x
    8rpHKLvMKAXndL/6ag6ZwBROl/FIwBQBROtOcxU0dTEzKZbAVd2Q9bbTW3hQStaKd37a
    XX5lYZXFvMghHIpkC21jTmQ/Ap6y7sbaqDzQ2PFzHytoySpl5gLatglMJAcvLhW3Yzc4
    0qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784182680;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=98DXqy1A9WIVTG8tdZOKK+0Vj6vZ+g3DfMhxy1VLlpY=;
    b=gjaYPEckUjtwmCiyzwPNXU5L6n3BBREiucimJN7pWY4c7s5oy2oFIquFOGqOONcVJU
    Sv1/EAD7JBp4tkB0yVFnQHdCh2sH61X1Zw3pb63tae7VD+toVsknLxJhjHy6+e6REz92
    SVyyet3uPAScn0kbpJ+JzAMj9cFkITjHjZm3rL3qCFMUpX+pOj7jBdLtms5Mq/iJEZJH
    C6+RtWK8BZ+rXKpdSsGyU6kN4/rycGgJz3X0Oa0RtA0Pue+1BqylWnL59eu+d5Zu0K/w
    A/PbzrqsBXEM4roNRWuLPyzjlr+PpQefrh4e+utc1NQd8tPi6bNSKl0Ne7Fr0cyDCzCl
    8Nlg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784182680;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=98DXqy1A9WIVTG8tdZOKK+0Vj6vZ+g3DfMhxy1VLlpY=;
    b=p9t7U4qedV9AfvUFtMNW0vUQaVzx9OlUYA4cUaXiiki/n8+O7bJFbup7PgEWsw/GgF
    5t65SH9pPnEzKzpQGSR3eAUpUXgJaKwAg2uSlZzMJqNzzVuBUMaRbhqK+lgR3zakr43D
    NDYqyO5IqU6gabIXEP05Q+IkOIjoZosc6hr01LSajMF/WNU4cO37hH6/JudnyGQrBR5b
    PXJ5ove2arRiO17p6oqW/WhZ43EWl44+2FDo3rwusU31gB9/vmWX80y3kMdKyuy1FLhK
    iAXEwiOWWB2tXivEFGlHxD1oiMFQa6m9n1ko221G/mvr/2QrE1GI7hrA+uMjKsFiMVVu
    LGWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784182680;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=98DXqy1A9WIVTG8tdZOKK+0Vj6vZ+g3DfMhxy1VLlpY=;
    b=cEyKt1PCQryOp9f17GS/4lmudgdR9SnEUDOuofFiISI5se3YyS7mb1AQ8u3vwVlMxT
    mBJQybto+gPRPFtelAAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.178]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26G6I0EvN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 16 Jul 2026 08:18:00 +0200 (CEST)
Message-ID: <489966a6-6105-46c3-8a7f-61fb6b5825aa@hartkopp.net>
Date: Thu, 16 Jul 2026 08:17:53 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Weekly net upstream? - Re: [PATCH] vxcan: fix Kconfig description
 stating no local echo provided
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mailhol@kernel.org, linux-can@vger.kernel.org,
 =?UTF-8?Q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
References: <20260619090035.17769-1-alexander.hoelzl@gmx.net>
 <1f3a3c0d-71a6-4c7d-9e08-5e19f1999af2@hartkopp.net>
 <ef991c9b-276d-44e9-a48c-7bf52f69ea0a@hartkopp.net>
 <20260714-vole-of-sheer-leadership-1bf399-mkl@pengutronix.de>
 <10179a2c-c8fd-428d-a918-955b6412e712@hartkopp.net>
Content-Language: en-US
In-Reply-To: <10179a2c-c8fd-428d-a918-955b6412e712@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

just in the case you didn't see my (hopefully really) final bcm patch set:

https://lore.kernel.org/linux-can/b5b49ad6-c7e4-4971-83dd-8a0f8214e8c2@hartkopp.net/

Best regards,
Oliver

On 14.07.26 12:01, Oliver Hartkopp wrote:
> 
> 
> On 14.07.26 10:51, Marc Kleine-Budde wrote:
>> On 14.07.2026 08:55:32, Oliver Hartkopp wrote:
>>> I would be glad if you could upstream this patch together with the now
>>> sashiko-approved fixes for can-bcm and can-isotp:
>>>
>>> https://lore.kernel.org/linux-can/20260712-isotp-fixes- 
>>> v10-0-793a1b1ce17f@hartkopp.net/
>>
>> If I understand you correctly, you say that the issue sashiko claims to
>> be in patch 3 (mid:20260712181155.B42EA1F000E9@smtp.kernel.org):
>>
>>>> [High] Lockless state transition in the timeout handler creates a
>>>> race condition that causes timeout errors to be silently dropped or
>>>> misattributed, leading sendmsg() to erroneously return success for
>>>> timed-out transfers.
>>
>> is a preexisting problem?
> 
> Yes. Always broken for years but nobody ever complained as the pattern 
> that would lead to this problem is not used.
> 
> The core issues with concurrent execution UFA and probable stalls are 
> fixed within the patch set. Fixing the in rare cases wrong (and unused) 
> error attribution would be a huge effort.
> 
> So it would be something for can-next or wont-fix.
> 
>>
>>> https://lore.kernel.org/linux-can/20260709-bcm_fixes- 
>>> v12-0-61c06291bf1c@hartkopp.net/
>>
>> Can you clarify these claims:
>>
>> https://lore.kernel.org/all/20260709203552.D473D1F00A3D@smtp.kernel.org/
> 
> Fixed in patch 9.
> 
>> https://lore.kernel.org/all/20260709204058.5BEED1F000E9@smtp.kernel.org/
> 
> Oh, this was really an open point that I have overlooked.
> 
> Will send a V13 asap.
> 
> Best regards,
> Oliver
> 

