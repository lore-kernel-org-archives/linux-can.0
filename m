Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817A4C4F6C
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548758; cv=pass; b=TDOTZkDo/t4p9hyW2LZUBPW5xTIVTw92krlpeNtpJCAMwH4B6J+oZ1TKfByDYbhlhe9EKJ4ugrh661P2uiYAxaaGSDsECV9OkSHfkpAoOyvrLYlD5vZBfeytrw0OdqnW3nLNXxF9ah4fw6InhI5F3czmxeGi1+ioWsHDHtvhMcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548758; c=relaxed/simple;
	bh=WSdGiTsmYVLdwFvcZGRKxVxst5/dMdYn2hWJ1zHRHwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZzzIbQMko89cZN09ADaAtGRAUVLmsZDgXh68u3oNlZvPs1uR80m9G8hl5We3rXnDuBl9y+yuy4+pVmMUbDH/zPtWZdOoWVsyW52zswPjjU8MRcIQIQ3S50GsrK4NOZyACctjcK6SjBMpkpZEN78a9rKbqQwzeXw9iEM8ah927Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XErs6Vtc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oFZGBC37; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XErs6Vtc";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oFZGBC37"
ARC-Seal: i=1; a=rsa-sha256; t=1791548378; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IYNLhVJ7n/k/5yONHkCAtlkRYTT35Adp89ucef6s7VJiuFwts9z9+4342fKI7/YYBX
    ubfNI3uMdDHNn7Rrx5gTmDtJG2/PFXYmpMcWcw4nQFzl1IofjKDdbvyB/JMwwxF3DlfB
    0OYwn1I+EjMRg/6PHDJDjGvf5nnqNxK2QBj2BC4JZPR6QYUbwilIUXNEbuHGBC+UAe3j
    tjfQRXchSQ17uivlINIGuIESm8JwM6dEeswdJmhb7odAa0/UhpwMg0a4K0vh4pf3pYaS
    XiwcLGvQr7qzZZa7RxAS94iU3g4i4ZMBNKseYLzNK+rPMdxurEma9xX++BqB15ni6iot
    1BDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791548378;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=taa1GO4inw7zz2ZUrZUk3ipM4M/OWy37cSvp/9gJQO0=;
    b=ocwQF0lgASzdwhmJlVUOt0hE8UzrB4x0mBFbMYvW+j0UlOttAt4GOw3RYuqnqazxma
    nhlw5xZ3fSeKD57voNYFHP8UIYLMrQ1WisF9RZaj61l7N/nDi83qx6Y+4d/5vmtJnN+9
    ZmS1g6LxgmSAN4h4egC90jdGR8I63gnldILAjy009btotTuwwLTzzUdNEIcjYBkyR3OC
    f8kRj592t9ygqp8u8sXmHn0uJ+0BfRrMlI2ZM2ISu2ibFCxWl35+3PKV7CTkTOISDcat
    ir/IL1tRzlV7FVxSz+9diM/LNqobVtqT/IWY+GiuJ+k75HtXFKtHykW2h7JVL1VSVYT4
    8Jnw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791548378;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=taa1GO4inw7zz2ZUrZUk3ipM4M/OWy37cSvp/9gJQO0=;
    b=XErs6VtcjVyoL1RIQl74wkPu2Y3+9uZANzYOVp2QNFygU6nFAQHy3mKf0vq+7h1CzU
    O7E6n+hWtRtzHieTsk5EGJiXMu8L1FdjvunsdkFFgHRVLrTDCHdS9rSsIKF8rmAjFfjk
    n0t6NTEe5W05ZMLZ6EUiDbhLZIg0eeiMLBHeTRf7Gp/78VjTYYI4824h/0u5r+SfwIk4
    yFnkyIAX8KgVTQIB+iVWbXBir50+oNBfVGBZfK5DJ8jw9VBfejZ+2wd0XVthbvP5annC
    eg8627xp3QEsojaV2O56We/iPIRCN+UecyusYjoRoUjmMODWFiQ4XTJEKyv3z4MibhJ+
    O5Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791548378;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=taa1GO4inw7zz2ZUrZUk3ipM4M/OWy37cSvp/9gJQO0=;
    b=oFZGBC37cTFfOaMXVY+eCykCW3pytyQ/oSDfoEzHXW3so2uMKUye+uUgcGCfdH45La
    R4JgQEc78oq6UKIQmQCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a299CJcV19
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Oct 2026 14:19:38 +0200 (CEST)
Message-ID: <df3da1ab-9a03-4720-9486-f5c5902cb9b6@hartkopp.net>
Date: Fri, 9 Oct 2026 14:19:37 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can-next - Re: [GIT PULL] Networking for v7.3-rc7
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20261008192253.574195-1-kuba@kernel.org>
 <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
 <a5860c87-b034-4cb2-9995-763c6b2cf58b@hartkopp.net>
 <20261009-hoatzin-of-sexy-poetry-3d407c-mkl@pengutronix.de>
 <7099597c-7b8d-46c6-ac5b-6a0662869862@hartkopp.net>
 <20261009-noble-straight-eel-4a729b-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261009-noble-straight-eel-4a729b-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.10.26 14:17, Marc Kleine-Budde wrote:
> On 09.10.2026 14:03:19, Oliver Hartkopp wrote:
>>> I'll be submitting a PR shortly. As for the Softing PCMCIA driver,
>>> there has been no response from Kurt regarding:
>>>
>>> https://lore.kernel.org/all/20260815103428.117201-1-socketcan@hartkopp.net/
>>
>> No, answer is ok.
>> Let's remove it!
> 
> Done
> 
>> Do you want to apply my ml_priv patch - or do you want it me to do the next
>> 5 minutes bevore the PR?
> 
> I think it's already queued in can-next/testing. Please have a look.

I did. It was not there.

I created to patch based on Linus' tree to be faster.
It should apply anyway:

https://lore.kernel.org/linux-can/20261009121115.61012-1-socketcan@hartkopp.net/

Best regards,
Oliver

