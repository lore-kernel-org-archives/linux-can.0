Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14D4EBAF7
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624242; cv=pass; b=a5PiU/yCafUd3/IDaOdg+A6U4IMj3KuLu/GkeltU1ca4fjTB+73wv1Vyvm6NljtV0MaiOQ9+ROFJkoTSwATsT9IwcMMHaYBNZFNOmA6GermkHB/oVkRb8iVQOnfM1lghBv4JcTZc+s7A8tDo2qSrdA8nHOmC/xOjhpCVyZyFZNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624242; c=relaxed/simple;
	bh=uG1AbUa4cij4TIAWhGw2Pz5oj+f+5x8PpW8CrCl3XMU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O1vC7ggvEi9RT/pBQ/k5paJktEeWjiSzZc5Eo52U89dhkN07HsDbyGR0Zb7Nq7nbR7y88nRZvIjvikZyoaClHptzVp8IlcbJq8LDWJ0il5cj8PykyByonIBOlSRSCMWB5HM1zrJkjd4KjmgUeLsVKyEQO9+UZwlgWWVVlvTSKjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RnEopR6c; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=2pN9l3L7; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RnEopR6c";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="2pN9l3L7"
ARC-Seal: i=1; a=rsa-sha256; t=1790624238; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FFyuAP/6zRpk9dDX8a0CPC5p1Iq0v3ohggFvRRA9zmdVzBoI+IIR5mNxc8NHvUAs0k
    +SOBEPlBh+p++muqRGRAtwqf3teRCwB4PWdzgPH0Z92p9/DxgY0AeNIJHLKkO9SprJd0
    EsSgar2VjSjiBLOFElfQIESZYFLxt0mW01gZOsNxXrgN2s4sUQOcQjdNrHWWDgpZPQxW
    irSGu5Lkw0V41yiW9ROhbVb8upn4f796TCywVFCXCOjm9glgcv4TLPbhxaJ4V3PV+0Ol
    tk4V8yXhFvIwqf+N39iX4hNr6dMc80yTBRRfoqzNFxZMjxe9foFLY0ze1KfOQW2dZZUz
    T46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790624238;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/Bve3AtboXE3WoaCQwUi5yAUx5z1BWMxYWlPzNYGP/o=;
    b=m5EPMpJEQlK1m8pa5eabYSbE5ddJRWrX+Z/C21b/EDr2yzM8vBSM2P+rXPAZ+iTBNp
    XYwg8JLDfcbTue3ErUNdZFnmI3cKqOHwBSD6s+FZx8y7G0gRqRoum4vJRdhFmJnl7DWX
    hVBwIedXNIXh6alvJ/SbhP4Sb1QOKRphTOZydwD6cu4h9dPIBvVuGIBIkQ8RsfOOATkc
    4ygPAfw2Nljn0yFUQ0aDt27RjmRqqnWs+rs+gQo17/9J5mhziC6O9v8EnnYrwvNIN8bv
    TdlIPqdUI55qXwYDXDWSCOHhBX7zlN7LgouVMgZ7tfriLTR7gxcbmA2ZIEEvJMzBteBj
    DHUQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790624238;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/Bve3AtboXE3WoaCQwUi5yAUx5z1BWMxYWlPzNYGP/o=;
    b=RnEopR6c6MsKRwrkhg7BdhLMBUPgTjvd+IPRTcbHYHpfW8P2FH97gKo1oZbTZAxoWD
    0n670F02V4Tyg6km/GecY/8QZf/Q+qBz6BLYd7VXJKi/dlnXQRdRrvmJ1nJd5EDFDtNp
    MlFush7JmGmpciUq+L4j+qyzQPMEs/60Xh4zd6FTkNwHaJaJMVBkv/tENvUdNmhI1Fed
    Np/MV1VN+pZTsqW2rd5qTZhPr5X3qvwCIlRNOyebiTRw+edPdpGGAf9YALsa9zi9O+dY
    2gKBBQ96Ua6x9rXtIPhPHu3sTEN4fjwjKbKh/jqTAegRrpj6isBP3g/yDiJwpPpC1UDB
    6eOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790624238;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=/Bve3AtboXE3WoaCQwUi5yAUx5z1BWMxYWlPzNYGP/o=;
    b=2pN9l3L7ClRnkkGPzIZFYQe+dnUjSNTd79tPJqQi+/0nOO/PxmdQ61RWevJDiAJoH3
    KkNx07SDAOkcNY/zlmBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SJbIP0F
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 21:37:18 +0200 (CEST)
Message-ID: <07764aa7-e46f-42a2-b2a9-b4fdb3411b48@hartkopp.net>
Date: Mon, 28 Sep 2026 21:37:18 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] CAN netlayer fixes for stable
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20260928173105.51765-1-socketcan@hartkopp.net>
 <20260928-rhino-of-marvelous-honeydew-7abf71-mkl@pengutronix.de>
 <c3fa6f4e-d19b-42eb-93ac-bd694a666aa3@hartkopp.net>
Content-Language: en-US
In-Reply-To: <c3fa6f4e-d19b-42eb-93ac-bd694a666aa3@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Btw. the first two patches of this patch set might go in immediately.

On 28.09.26 21:26, Oliver Hartkopp wrote:
> 
> 
> On 28.09.26 20:43, Marc Kleine-Budde wrote:
>> On 28.09.2026 19:31:02, Oliver Hartkopp wrote:
>>> This patch set aggregates the open stable fixes for the CAN netlayer.
>>>
>>> v2: restore non-zero UID value generation for isotp cfecho handling
>>
>> I'll send a PR soonish. Once this series is ready, I'll send another PR.
> 
> Thanks Marc!
> 
> I've updated a v3 - maybe sashiko is fine now :-D
> 
> Best regards,
> Oliver
> 
> 

