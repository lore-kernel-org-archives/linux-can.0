Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6435E92F;
	Mon,  5 Oct 2026 07:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791185313; cv=pass; b=uNIAcyQqCn9/sn//md+0DkPeBQKaEvK+njK2jPLLn3nxJPOexIJUOvfexuOkoW089crw2RQO+BEfOUKVz/eBeytvbmAjM6pmx/4fkHM0LWxtqNS4+3prurz+ygTQzs0LZISpeCr11tUwaoulnrxTSMS5EUgT7fq8w/z1+tvtWRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791185313; c=relaxed/simple;
	bh=rUH4lCKokJkm6yR0TPOL2WKHChVGMSNzELVG/zK8/4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXR1N40Jnqmi8xCcR8Ybub4VYM23b0xuQ5UfukFVnyX+ARpMLNN4erdgCJ3RLngEuN7Ix0kTLLSvXAPO79hrYxNegrygOSZZXTm4URH15RE5ZR4+BqG96abLIQPb82xmNfSkk5/KRTmban11ETirEW5fsqApM6Axsh9chSXVqfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=U31I0vmc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=II+RJxBN; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U31I0vmc";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="II+RJxBN"
ARC-Seal: i=1; a=rsa-sha256; t=1791185299; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j771swJcLD9JQkOsQSO9k6/uPX2HMQ/qfzjdP7Gfwr6UDQbEFmF6DSbUda8zRvRL9C
    UVeFRTdrfGYSKruau31E3V+XTvFwIiWGoXmXnz7MJBnTSNgJ6lw54KMOq/wTlV6ojmkC
    iqBI8byyyb+2i1zc+q9I1ELsmtg4Y4fi8hwmsTSEjxBCX8uWB10xXClFyl74bfNDQO1F
    nN3xkHrAI1Nvd9JTAbWzwhX6Pz/2jFvEK3lCAhfmutHBrViUlDeIQ4pq3zESXeIQN1Fy
    kh1GAs4DzQXAidpEjrwJcqn5cFr6ZTV2F75uP9sMoMfytqi2fKtHYjsSptUA34Ck8vng
    vu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791185299;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WPejr16oaTyws4Cdzdym/JnMKdNmWm++I5ieavocqy8=;
    b=g75K2nJ2F00sQSiAuySx0BzD+51zhwHHGh/34OQv1U2eT0hu/21c8k+LbYblWVsPc9
    v4nVsNEvqQ2wqyaMuFv4ob6jUkJp9zp7lvqRexMM1UoNxhARWve1//98dQqAZth5fN1h
    gMpT3o78JT3o37yhFB5wonzbpIibMT+Xmh5nu3bD7scKSG+IPIcD0A1LXMXdiOweUprg
    jRmxXSGrFFuaduKQuwE/6jdS6XHcc9DR9FdVVa6ob95pLDDg5Pk8UMYSZVh91ZvJc32k
    jgb2Pj7XauOFMpMKCttYC4ewMl9ipIfAMXNDk20xVGHhkMQ2K0PhtMBL2xPVtMFHR3wV
    Re2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791185299;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WPejr16oaTyws4Cdzdym/JnMKdNmWm++I5ieavocqy8=;
    b=U31I0vmc47ET0c59dwEhpokppwQwrsQBDkGIPJP2VFmi62DWarQQEIrW237vR/pSMO
    LIFnavmQ6Qw+ShEuVBJ8avWJBPvaX6SknsQs8Plv5Ewyj97AGS1nARUnDW/g0LWyPCWt
    zLhH/Qpe/3/IDJwT2YT+qBSyzhTNpCFP8RW6QkBbjwLkVi2ZYpftXU86z1vgIX2ixSnF
    qS544mLWIU44VJNSNJP76Qqfb504pP8ISQMzb8Cbfao4JVrYzqXAFCfh4qqo04qZVMqr
    jPm4LDNCWNeyjIbA+wi8N2R5sPtieeI5fIUshu0DzfzUrsFQdD4PB8e2KJE+25F88Nnl
    Qwfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791185299;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WPejr16oaTyws4Cdzdym/JnMKdNmWm++I5ieavocqy8=;
    b=II+RJxBNtLSRYTonEuA3foOZhfDieThXKMoOeOWmOrR5SZ+VMVhY3Ci1nzP8PiT0Ib
    cPzxLqu2cAnW+yKz6JDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4Kp38="
Received: from [192.168.20.237]
    by smtp.strato.de (RZmta 55.6.2 SBL|AUTH)
    with ESMTPSA id K04b9a2957SJ04e
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 5 Oct 2026 09:28:19 +0200 (CEST)
Message-ID: <57de2511-fb5a-4689-bc21-2a9fe25761fc@hartkopp.net>
Date: Mon, 5 Oct 2026 09:28:13 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
To: Jakub Kicinski <kuba@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: ore@pengutronix.de, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20260929210700.1183036-1-mkl@pengutronix.de>
 <9956662e-6001-413d-864d-d8d048a93819@redhat.com>
 <cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
 <19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
 <e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>
 <20261001-fascinating-clam-of-plenty-5307a0-mkl@pengutronix.de>
 <20261001082552.514c54fd@kernel.org>
 <20261001-portable-mastodon-of-dignity-380136-mkl@pengutronix.de>
 <20261001111954.2ebaf14c@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261001111954.2ebaf14c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jakub,

On 01.10.26 20:19, Jakub Kicinski wrote:
> On Thu, 1 Oct 2026 17:38:17 +0200 Marc Kleine-Budde wrote:
>> On 01.10.2026 08:25:52, Jakub Kicinski wrote:
>>>> Don't know Oleksij has done the sashiko.dev integraton.
>>>
>>> Let me try to plug you into netdev-ai one for now.
>>
>> Thanks, do you need anything from us?
> 
> I don't think so, we already had the setup for the old AIR system.
> The emails should start flowing in a day or two. Please let me know
> if you don't see any review out by Monday!
> 

The new netdev-ai picked some older can-ML patches for an additional 
review but not the important latest "[PATCH net 0/3] pull-request: can 
2026-10-01" which is still only reviewed by gemini-3.1-pro-preview :

https://sashiko.dev/#/patchset/20261001151905.1556270-1-mkl%40pengutronix.de

Should Marc resend the PR or can you trigger its review manually?

Best regards,
Oliver
