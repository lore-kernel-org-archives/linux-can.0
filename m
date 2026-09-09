Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEFD1397
	for <linux-can@vger.kernel.org>; Wed,  9 Sep 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941748; cv=pass; b=GZzRTQbOMkvuyBTpkI7EMSLi2215uE+yZA1iPeDyKvu23W451NKKEksOypsnHHp+IfoVaFpAIMoLyMdu1P+bXfTLvWUiRYWQoyAYZXDKEQTWbpWcghYqywPtfqYZviaXR8G3V1QRVmMmSYq/G2dkjuit3tjMiMSkY2BLqVqZe2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941748; c=relaxed/simple;
	bh=OF2cPH8oxB+FDimnFcIx0XT1rTzcoJdbswlVGCbj/T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c16h7dcIN094eSwekXB5F0LNJ8g41nJ0CZGnE0BMae6dDBcd4rQLzehbP1k6InP7gY09opZlKsGkcwh/HCAvkNIFlUTjfc1tCX4SAUBB3LIj0ImuM6mKcFlOQSGdaZTMU2a9sRQDiAta8tnj0W+Irp3uuD+FOl7NtOhXD3/WGnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UaSVv5N2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=90GqyN2w; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UaSVv5N2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="90GqyN2w"
ARC-Seal: i=1; a=rsa-sha256; t=1788941553; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TB2nr+SQ33N+vVu6o8krD2ovfgum0ZDc9kx8nyGiCCj6T6skdCT+ioFqukyRKC4b3C
    HnlVEdSoy1KvGGAt9rhRPQ/Tc+eip9I0Vq2SBH3HrpSPNBeu3nDHOH6l2RjUz2iKlwKZ
    1SY9UnHs0KhT8HVsewIWyt66q+aYz0JsyM1hk7O5GEx7zWoLCZt3EPOnXe3R7XTMfscd
    wldh3cC28d9Wgk9RLEHy+nulq/SuNGqagCL7O7JQuAK5ImJ3XDtmhs6DoDk+595BZLgO
    vFk9Pv9bYGm9h2yVEVxcv6BB90mj7kT0jQHHqbUvNQhN7IrvL17YUdayBHIBojNQFffU
    h4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788941553;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WrlYYNUVTSEkb6TuZmObXZAAHQusRS7WIaXbXIg6onc=;
    b=PKp8W6HwtswAeehIt3Eoa+IqdYPs4747xwKea96+6v/J6yb7NLSI/ItiKep/Fzii0s
    e6/PCvYSVtEuMf/8CxW+mWptFp0IlIodZOBS+K1qTygdPemX82FGyVcZPMeh9Gk5g6Vf
    Ux67Pe9qY4dTCrzqu6s4kICtYPQM+QQ0U6TWhH+N2YVs17WYnMbKqaka9f7brqKa8YIL
    S2qiX8LjjPOMHu8CElGCID28HJ7YijCbVRGOPM1HJ+oLXwxFEQbz+5HXpJHdwUzDD3MF
    U5avSv6mBSSv1cA6CMwXPAjGfSVyfJqs1AgpuarVkPEtA6nwH1zOjyhFyEHLOPyU3xvO
    ZwAQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788941553;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WrlYYNUVTSEkb6TuZmObXZAAHQusRS7WIaXbXIg6onc=;
    b=UaSVv5N2Sb0R/1dZtSUMJAYALUEDDy2ZcnqFwuSxD7vGVOR23fXmQmj3onMU6nxtjB
    EbgHK/22wGPzCHm5cryA5/Q5p2DC6323kZ32Yb2duE4VjIYaG/ogF/LJYcOsM3pIG+bf
    vZmRG8h7nwk4MJ9ZhuvmSCNuHkjjn2KdA4kA4rPV2epYMLyZCx21xqQMTtMOIOed1vF+
    kSsOo4bdYwcPY1LvOzWzjnVg33Ks+IybuxLuF/kocqyEcWDb2XxBdGZo6QpSslWocUF5
    QMYxfqV+eAEDUKYszT7PYUD3RyCegVVrfnidKdSnOaWXy+7dHFyE6DnCu5MvP7/A1KWH
    7kXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788941553;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WrlYYNUVTSEkb6TuZmObXZAAHQusRS7WIaXbXIg6onc=;
    b=90GqyN2wpbZOnDcqnJMQEt7seYDBC43qJJgbVTA3rhGi4UiePs0hqLFkHFhS4mac7r
    G/uh7HsHwJw2AnYXdKBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRsLs5JjOm80i8vvX3XM"
Received: from [192.168.1.20]
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id K171b72898CXghn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 9 Sep 2026 10:12:33 +0200 (CEST)
Message-ID: <a2f6d5b9-8fb1-40e0-aec1-5f9acce1e0a8@hartkopp.net>
Date: Wed, 9 Sep 2026 10:12:28 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: remove CAN filters independent from namespace
To: Norbert Szetei <norbert@doyensec.com>
Cc: linux-can@vger.kernel.org
References: <20260903065947.7718-1-socketcan@hartkopp.net>
 <D4EEFE9E-284F-45F0-BF4E-39CFF7134E52@doyensec.com>
 <AE7A6380-97F7-46EE-9A45-026B60293DE0@doyensec.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <AE7A6380-97F7-46EE-9A45-026B60293DE0@doyensec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08.09.26 13:41, Norbert Szetei wrote:
> Sorry, my mail client turned the address into a link and mangled the tag.
> It should read:
> 
> Tested-by: Norbert Szetei <norbert@doyensec.com>
> 

Thanks Norbert for your valuable testing - especially also for the bcm!

Best regards,
Oliver

> N.
> 
>> On Sep 8, 2026, at 1:34 PM, Norbert Szetei <norbert@doyensec.com> wrote:
>>
>> Hi Oliver,
>>
>> many thanks for v2. I ran it on 7.3-rc2 with vcan and my reproducer no longer
>> triggers. The ifindex case is gone too, from another namespace I can no longer
>> touch a bound BCM socket.
>>
>> Tested-by: Norbert Szetei <norbert@doyensec.com <mailto:norbert@doyensec.com>>
>>
>> Thanks,
>> Norbert
>>
>>> On Sep 3, 2026, at 8:59 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>
>>> When the devices namespace is changed the socket namespace and the device
>>> namespace might differ. The net_eq(dev_net(dev), sock_net(sk)) check in
>>> the CAN protocols netdev notifiers therefore led to skipping the required
>>> removal of the CAN filters from the (namespace changed) CAN devices.

