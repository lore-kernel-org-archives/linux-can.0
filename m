Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49622097
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602113; cv=pass; b=VFvXHNu8zABPtSBUh9qAHQ7Xbozr/B3QriJOrKCms5ChaPWdKVzqx0L8F6aUaz6NjXuBuYvx4mqyZ4Sjo+0YaBIG1FhH7r9feNUXTvAk5d3M00vUSvB0JKx7QbPi5jo8jXfZ8pZPz+tU7ejuVy7PHnkllmHiFmrrR3PTkCIElys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602113; c=relaxed/simple;
	bh=QrSI/5EvGaasEj56QqD5rgQ+prKe5/npyooQtOEwGPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kR9lGPmYh7ihwaST5uD1iPJuNxW6NIe68/n6YnA9dykM9+8PL5HDGzft0oFZjR9+xAb913KF0GKFKTyRfhMbCIwDNWREpVk8mRl5gX9TbipJ41hCftG5EIrBn1pKDeu2gh0ahCuMRk74uKI6+F5BuCnlYR07Z5FqLMalEYejyOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GhcoqFxr; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=c8N8KV+t; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GhcoqFxr";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="c8N8KV+t"
ARC-Seal: i=1; a=rsa-sha256; t=1783601922; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EqxX4pTx1IQhL9Ut91s7Gb2QqVr8uxrWxUxyfoJ9Zs4ZDvwlySs7ynafHKS+0dFCWp
    4LJ324JTlGjgm3t8omL+gcwCNUXRSpN9lqpMq6UkZClP4lQxHOJlKkMYOBnbtkanim4D
    PoUzHjkXnJoVxPyxFKuci98h/onA/xab0aLIXVnBAcazRBSPGsthP1poIujNs1fKv6te
    KJ1oVM0vPYy0ko/vicVCf5bbEBB7k3spSxssEcHzzFMCp28AYi7Fq6ocDYnKCXgLJaVR
    KBJQH2j60eSR0JzR6m/zOULvOyBJxoaduiUh6WjZ+2+DAL7v6n8BwSwVJSQNgu8Skfeu
    rJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783601922;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=R+QDR9o44utWwB8CXC+SD8yEfOX920E7Jl2AVCVebCQ=;
    b=QM75vwNlzHJWdEb9LJ8nwwkNrXpqwHJWBk9jrYuk3jAEQ+zZFKtTosRTmwvsiPrXgz
    QGF53NsPU95iv873a8VB7K0MZVkXQ5862vEJfstDIPuim944cgL0KONxzSx9qJjo6ZGv
    aiKKOLUPbjbfRQnRLBSjQQhb3O9qqOAcK/ztRdu8H1i4onH0uThHMEuQiikzTw3dNknD
    Y7BDmVLH/FhQAxaX5IP0vx/XdnqEZSFdo8r8HRWXuUXFzy2iM9Tb9RhcRCsjHUYleLxI
    AJ05PMnz6rk67GBMCe0J/HP23Cuf5bWZa3Q8IONtQeKFe6nt6msVtz+Fevl2RHKOIHu/
    +IRQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783601922;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=R+QDR9o44utWwB8CXC+SD8yEfOX920E7Jl2AVCVebCQ=;
    b=GhcoqFxrOxUxTP+JSLUkXsE62eRZl5rbnfpStWVpsnjmvVAqrrycKPFPqbdRtBDPYe
    xHRzMUrxdjXq4+OQaK6X0rEnzJjlE0f89on7k9JQLqbZrGoh9h2FbPEuPkOHWimETOge
    LGWtGqwpbI+8L7Aw2lZW4OOmdGq1yneJqrkxmvMGu0eqryef8Bvs6Ievt5rBxsVFXb4d
    xsLBYIjKZcCwM0MuEdHQPmoJI2rVdOyZrO6BcMpuNpGVt5BxHkMru+jhqvfkFWufnwlK
    XfkPUpM4jFTJO60QCtbSuE+mx50BZ6qWqy7Pko4RmJ3u3wdmriYmMVezmO9dBDt9GOez
    hK9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783601922;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=R+QDR9o44utWwB8CXC+SD8yEfOX920E7Jl2AVCVebCQ=;
    b=c8N8KV+txDitTMcapME0ywjrxuU/eWjzyXAgGk0tBrVWAIQGMOWTaJbm0DK84041FE
    wGpLfx1aLXZ4+PouOxAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.183]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb269CwgoOw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 9 Jul 2026 14:58:42 +0200 (CEST)
Message-ID: <a970cdbc-6e36-4baa-847a-8abf0ee0d308@hartkopp.net>
Date: Thu, 9 Jul 2026 14:58:37 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/10] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: linux-can@vger.kernel.org, Ginger <ginger.jzllee@gmail.com>
References: <20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net>
 <20260709-bcm_fixes-v10-2-57fff38e34ce@hartkopp.net>
 <20260709-funny-bustard-of-genius-e31cc6-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260709-funny-bustard-of-genius-e31cc6-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.07.26 13:58, Marc Kleine-Budde wrote:
> On 09.07.2026 12:24:16, Oliver Hartkopp via B4 Relay wrote:
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> bcm_sendmsg() reads bo->ifindex and checks bo->bound before taking
>> lock_sock(), while bcm_notify(), bcm_connect() and bcm_release() all
>> mutate both fields under that same lock. Because the lockless reads
>> and the locked writes are unordered with respect to each other, a
>> racing bcm_notify() (device unregister) or bcm_connect() (concurrent
>> bind on another thread sharing the socket) can make bcm_sendmsg()
>> observe an inconsistent combination, e.g. a stale bound=1 together
>> with the now-cleared ifindex=0, silently turning a socket bound to a
>> specific CAN interface into one that also matches "any" interface.
>>
>> Keep the lockless bo->bound check purely as a fast-path reject, and
>> move the ifindex read (and a bo->bound re-check) into the locked
>> section, where every writer already serializes. This removes the
>> possibility of observing the two fields torn against each other,
>> rather than trying to fix it with more READ_ONCE()/WRITE_ONCE() pairs
>> on two independently updated fields. Annotate the now-purely-lockless
>> bo->bound accesses consistently across all its write sites.
>>
>> Also fix bcm_rx_setup() silently returning success when the target
>> device disappears concurrently instead of reporting -ENODEV, so a
>> broken RX op is no longer left registered as if it had succeeded.
>>
>> Reported-by: Ginger <ginger.jzllee@gmail.com>
>> Closes: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com/
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Can you give me the Fixes: tag?

Yes. I'll send a v11 with a fixes tag and another patch addressing these 
issues from patch 10:

- [High] Spurious RX_TIMEOUT notification and state corruption due to a 
race between concurrent bcm_rx_handler execution and op->timer expiration.
- [High] Throttled multiplex frames share a single metadata store, 
leading to incorrect interface index (rx_ifindex) and timestamps being 
sent to userspace.

The binding of a rx_op to ANYDEV (ifindex = 0) leads to multiple 
problems for the timeout monitoring and throttling of CAN frames as they 
are only intended to work with a single source.

I'm thinking of some autodetect interface that grabs the first interface 
from a configured CAN ID and provides the timer functionality for this 
stream until it is handled. Anything else makes so semantic sense.

Stay tuned ;-)

Many thanks,
Oliver

