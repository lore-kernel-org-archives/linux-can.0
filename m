Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250904C14E5
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547411; cv=pass; b=P79fLtmLZFlrpkjccKBlPuDME+290H8+JpfhZOH4XJTwUnD3/gWRc8IBIXvhb7rPvHm8MnwRtM/2ijRH+uloqIrBUe0czlGu+7y1VBaX+2ZmFnZ4GA+Y68H/wfd0t+jT5Ymxbi8z0RAj/PMXrMLiUUli8PXgnD5Lw9ctWprhvS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547411; c=relaxed/simple;
	bh=eFsqS05Xswd8Ro5Nz79W+GwHzoOY+nJ/L0K0JbSHU4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KOdIhdSt0m8LpbpmFbxJbWnf62Aumh+4d9a9u+Uo9hdBy8tYyiigM8+5CuXWRtrSMguKREQsmrZ9XwbpNhd0TTCT5RvIduiEJkhE4KyWQAWtDpdnz4QkkTkukMTy/kp60OAuizEsYCE0PgsN98bZUapjwNty3h2jALH3boR+TeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UV5j3KHN; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LKZKq6Ui; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UV5j3KHN";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LKZKq6Ui"
ARC-Seal: i=1; a=rsa-sha256; t=1791547404; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b/ugH482LCDfXYHoMY7nWCGDJWPjKjBm4mSkPfhqhP1nWeMlZXQLx5rUfhvyILN0Np
    6z0IpIO+Dxn6/v34MOg7pjC5y8EGBuiJM4jBI6g8hSsN6WtyYBzPJ7YrVkhmtyMoMGCz
    YOws2b0oD42mkggt8wmGa7vj9apqV12iXP3U9vGDxOVY1UYSjSDEvk7lenvjBBgBD33T
    R43rC7nlYg6yZyBQeBgkQ9eCgvB1WaubVA1L1jgYr/K6/Jylq0yCr/8cQYjPCILQW93S
    pyGaa+w7kaX17T/viLYoP8S5Pq6387Lw0d8OVJwFMzyfKsuI8OdGIm9Fm/QXjRzN+mTc
    Il3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791547404;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bT0pL+s98RTUIa8GHslq0xAcIsNkz6pdwrk1hYS1KqI=;
    b=TPGiCd8ggjpL2FPFQ9n67I2aEuUKmZfN0SferSA4ll3Wr27aRZhJX9PlloXd7fz7tM
    jRhzs1SzjdFlqTgOcXm1OR7MmS6vZ9nCamqFhjG0YiLETKY/zrcIbcpcfNoozUI33l+5
    lLV08TaeIAv8O1DFHrFV5NCl7ZGfXAM0RFVpxtX1FLasEU3URdKtth+yCBrHspg4Llfy
    HTUXcQrnWeBva7BLWcUevkERfyIgsl6naHVi8mzx6VxOlYJWwAsPV4am0ovV6pBMeq5L
    hrPPKf8m4BePUyZa0uHDTAzXWzxakTI8QCvIB4DRZcdHihQIj+3saG5T/rpWaH7ffTMS
    64FQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791547404;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bT0pL+s98RTUIa8GHslq0xAcIsNkz6pdwrk1hYS1KqI=;
    b=UV5j3KHN3I4vVZV5KcEGTyv8PTQiWWSPIHzereUX/wF+TpEHBG2n21xTUqjvrkOA7c
    DnUL97pcxfzjK50EK3VIIFxjNpPQOgQDuqcg7ZNZehIIMy6tZFxiYLcBkRRwIAGVsieD
    0JhOE9GN1iVtjJ1PftkGi5IxF0i2xxdDpzAnsGXaFHBPA7lQvdiYNX4B65vx1dAR0qdD
    EQS+XVWYUu5jY8ulMFyfZOA8BegTjXpsEVtn5/jC/FmQf+pv5bTdU/ij2jguBsD/5cTP
    bStDy5WdovfZmna6eMydqfEyHO+aZVCb8SD44zZVWa/NqESmBFtDKgOzuorRJzOWoGaa
    4e0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791547404;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=bT0pL+s98RTUIa8GHslq0xAcIsNkz6pdwrk1hYS1KqI=;
    b=LKZKq6UiVRwdD0/QKfh7rDgRKRkc7hY5lMB8Xf+uCAZAQKT8eRUW2VtlFyQBm03HWI
    PAGtt33wOjFy64qV79BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a299C3OUwX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Oct 2026 14:03:24 +0200 (CEST)
Message-ID: <7099597c-7b8d-46c6-ac5b-6a0662869862@hartkopp.net>
Date: Fri, 9 Oct 2026 14:03:19 +0200
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261009-hoatzin-of-sexy-poetry-3d407c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.10.26 13:46, Marc Kleine-Budde wrote:
> On 09.10.2026 11:48:16, Oliver Hartkopp wrote:
>> now that the latest real CAN fixes are in Linus' tree and I can re-spin e.g.
>> the patch to use ml_priv instead of ARPHRD_CAN:
>>
>> What is the status if your can-next tree? Which patches have been already
>> applied (e.g. my Softing PCMCIA driver removal)?
> 
> I'll be submitting a PR shortly. As for the Softing PCMCIA driver,
> there has been no response from Kurt regarding:
> 
> https://lore.kernel.org/all/20260815103428.117201-1-socketcan@hartkopp.net/

No, answer is ok.
Let's remove it!

Do you want to apply my ml_priv patch - or do you want it me to do the 
next 5 minutes bevore the PR?


> 
>> Against which tree do you want can-next patches to be sent? can-next or
>> net-next?
> 
> Please use can-next/testing.

OK

Regards,
Oliver
