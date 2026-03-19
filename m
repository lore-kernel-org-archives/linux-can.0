Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6E23A4F5F;
	Thu, 19 Mar 2026 13:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927281; cv=pass; b=CfKuEQgBN1vSF7LQWh8yNl5q7KKbBZ6tZNt1bpPkc9C9y/H6aFbraI0QFxl1UCaD4QTsjCBfs3VGVa8pRPf4xPsv8OzmSgw0VXWdnd7dc4q8rjTs3nhwAeGdze1GgcVpsFlbAq/M92qWh15uwNrYFUsjJfEul0x0/PuwkR2jqtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927281; c=relaxed/simple;
	bh=LwUipd4w5oLH7fywbHg4u8uDP1LLdDapZrK6SCZ4+mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxIxT4mkytrTh8UEErc4u/qigCo16BYgFqSIki7DOc0M/u8EPIpq1pe80j9wJUAKClKGBcuQiw1e34F+8oZ8AwZOIehjAOjgKs2UrDSnTP1eM2VpY7ZMgRgNM5HMKLetcNOSy7FYTcdgt1DY2CXCRyHY+9BWfr35nqO9LKpzw5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DtwKMKX5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3GgDZN15; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DtwKMKX5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3GgDZN15"
ARC-Seal: i=1; a=rsa-sha256; t=1773927275; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DlaqRAGS3O2KGnI2dIwD59QXj7x0k3zr9DeQs4sP7B7EbaggWvJlmlv4gJtm4vBoot
    RmJNI9/srB0mQWzBn08ugIg40h6SO/x6OcCz8nXnZ0m0uPgWVKPVMY7YRSzSTUvRAyr4
    iMuuwtWeREzoiZkd6TxohWwHZJfNdRcX61VIz4ZiKPbBfchLrm65HDmw1wea3lSvZv2P
    SDjP1UbGECGsoxiUKcZNVvmYSp4zOcQRnHkAUEIbGiCDfAetRFjEpmlpu0Tn7lE3h603
    nqGP8JQjddSgFoDxrF11pSWZxS8jRiZg2aKifK4ZJdqqAaqb86fetE37cja43i1yYpnS
    b3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773927275;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bb+phr2ZuPTP3UcZwnmRM3nr+pjTmb5nTyFCYikERng=;
    b=VE5owsbhtD4qe3Tqq90DqJimwDw5NqTyi23w61XGWE6jcxyX1DnI7ZartkEXfLYLwF
    1fIBgmRS3G/dC6a3juJz/nhGHCO2DQMd8EMTCBwyrMYTRw2T4CGR7MVAogNF8ByGnUwE
    cj9kuC3TDfKrkDkXyOHb/xNFQT0p+zCJn0iFuabpYvm80DYhSg1OgrWt9kcAX2O9TEBS
    fFPvHUQOLubJ5sz7Q3G3DClABW41P14YvvQTLkw0IHGRDHp58Y8lM3BayKbNqNs5BwRP
    AYEgooqqivwoqS6QvfHoK83MQYOpvqLjHT/TluAC3Rghu3njzQDb+rYvUKf0hvSyQlnU
    9o1Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773927275;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bb+phr2ZuPTP3UcZwnmRM3nr+pjTmb5nTyFCYikERng=;
    b=DtwKMKX5yZEgDzPWNsbhCKk6m8IeN7nSd/L7DKKA7IELSbry3oCR9l2opJGkhsdM00
    ez0RYcKXRHqOAJKHe4jFv+6jcWd6k0pux7ABAZlQfRLsFaBVsn/7eiYBZ3pI1jy/a3Er
    UO07QtN7h1pNQi97zs0GxYUnZM/WpKK2Lji5h/yPfEieruYqJL4OvxcLZC8zPNfGDd3l
    FzCnS60mg0yLh7T8VhQU3VmTkC2e/WJnFe4YkMUHattAoI7mK3TyCN2hRpI4zwNVVuXu
    SKo1VKwkYRj1dPxiP4JMEGb5lh2zf0CA6KyGW4fcutHbQqIc9XJcuxHL8/wf7Gdq2vXm
    v2zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773927275;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bb+phr2ZuPTP3UcZwnmRM3nr+pjTmb5nTyFCYikERng=;
    b=3GgDZN15vMtkEpNchaPCkAMbC/5is69m/i4TmpzEUl0aPaSQZBtCqf6nqF/NKEJsXB
    /KYbpZSaMI0EIgXoBcDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d22JDYZs8C
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Mar 2026 14:34:35 +0100 (CET)
Message-ID: <244e94f7-46f0-442e-931d-1521601f60b2@hartkopp.net>
Date: Thu, 19 Mar 2026 14:34:34 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@vger.kernel.org, Ali Norouzi <ali.norouzi@keysight.com>,
 linux-can@vger.kernel.org
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
 <c6bb76ce-0f3c-4775-beaf-174e281f991f@hartkopp.net>
 <20260319-polar-affable-dolphin-db10fa-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260319-polar-affable-dolphin-db10fa-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19.03.26 14:33, Marc Kleine-Budde wrote:
> On 19.03.2026 14:13:55, Oliver Hartkopp wrote:
>> Hallo Marc,
>>
>> the AI bot correctly remarked that the Fixes tag points to the wrong commit
>> I took from Alis original patch.
>>
>> Indeed it has to be
>>
>> Fixes: 96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu
>> size")
>>
>> Can you correct that while applying the patch or should I resend it?
> 
> I'll do it. Please ignore my mail stating the same send 10 Minutes after
> yours :)
> 

Mail scatter today :-D

