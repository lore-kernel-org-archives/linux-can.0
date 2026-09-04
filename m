Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491E395ADD
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509109; cv=none; b=bPioUwhIA2xkXo00kCY264jXv34gw1Oge872rPSzXX6xeFVoj7LiKuEYps/2kqyTPTK2ObaGZQHko2g2I3ikUtvtgrslRaFO74bfJZtu3Jx7yhFw/i9BqksGjRCmmBC5KzwI7x046oi5Q+NAlldM9zEx81byNjZyoBbqbSInln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509109; c=relaxed/simple;
	bh=BvIfMMm47er9RPtfZ/UE5V8MqSHHGNhQUryo+YL4lNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OML/0VoWg1GhsBY3/zObM7g8+Lb1bpNYnoG78/CIsa2/dN94JdLjMhTx9KS/wr91z/4Gz0uFsFqb/hott8swHQTzZ2qm7cjahkoGIiIW7Y3/R9/G2jYWx22mFBRraFgVFle9r38aMZUn/jzD4TS5ZVuwZ74kzFM3Liv1Q3cm660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=efCQ+jGB; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="efCQ+jGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=l79Vf5R4Pt+9AzLlTe4Z9Czd9eqNsjFkEfTeah5UgSY=;
	b=efCQ+jGBfVYfVoEKCyWzCfPxZSlYSx4BvfvpccjGhmklDZyCX382WeTxPyDEIb
	Cd6MlDIgFtjy0wG+6ctFvCBe5/eR4hgnEUATsyfteGIMGsw+v+1XI4ZUQZUbw1Pa
	LZ9P5vV5IoGtdACrCBxFk5h7l2DYStXREer365Qna9Nc0=
Message-ID: <83f29357-5f4d-43f7-971c-924934c6c10a@163.com>
Date: Fri, 4 Sep 2026 16:04:25 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: sja1000: drop RX frame when skb allocation fails
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
References: <20260903095444.495807-1-luyun_611@163.com>
 <20260903100449.0D7E41F000E9@smtp.kernel.org>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <20260903100449.0D7E41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnFPOJe5pqQa1POg--.53029S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF17Ar15uF1kCF17CF4DJwb_yoWrJryfpF
	Z0ka9YyF4kXryjqws7Xw18Zr1Yka17Wry5GrWFv3Z5Z3W3GF1vyr4fK3yjv34kur4xCay0
	gr4jyFy7Cw4rJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2kskUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wtCEWqae4tR6gAA3I


在 2026/9/3 18:04, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] In sja1000_err(), an SKB allocation failure returns -ENOMEM, discarding IRQ_WAKE_THREAD requests and causing the interrupt handler to erroneously return IRQ_NONE.
> --
>
> commit 6507d559134b8295113fac43d6ce819e79885772
> Author: Yun Lu <luyun@kylinos.cn>
>
> can: sja1000: drop RX frame when skb allocation fails
>
> This patch prevents a lockup in sja1000_rx() by dropping the frame and
> releasing the receive buffer if SKB allocation fails.
>
>> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
>> index 3cdb583ee3e50..da107feb22af7 100644
>> --- a/drivers/net/can/sja1000/sja1000.c
>> +++ b/drivers/net/can/sja1000/sja1000.c
>> @@ -348,8 +348,12 @@ static void sja1000_rx(struct net_device *dev)
>>   
>>   	/* create zero'ed CAN frame buffer */
>>   	skb = alloc_can_skb(dev, &cf);
>> -	if (skb == NULL)
>> +	if (!skb) {
>> +		/* drop the frame to guarantee forward progress of the ISR */
>> +		sja1000_write_cmdreg(priv, CMD_RRB);
>> +		stats->rx_dropped++;
>>   		return;
>> +	}
>>   
>>   	fi = priv->read_reg(priv, SJA1000_FI);
> [Severity: High]
> This is a pre-existing issue, but while looking at SKB allocation failures
> in the interrupt handler, does a similar allocation failure in
> sja1000_err() lead to the IRQ line being permanently disabled?
>
> Under memory pressure, if the SKB allocation fails in sja1000_err():
>
> drivers/net/can/sja1000/sja1000.c:sja1000_err() {
>      ...
> 	if (!skb)
> 		return -ENOMEM;
>
> 	netif_rx(skb);
>
> 	return ret;
> }
>
> This unconditionally returns -ENOMEM, which discards any IRQ_WAKE_THREAD
> requests needed for overrun recovery like SJA1000_QUIRK_RESET_ON_OVERRUN.
>
> This error propagates to sja1000_interrupt(), causing the loop to break
> before incrementing n:
>
> drivers/net/can/sja1000/sja1000.c:sja1000_interrupt() {
>      ...
> 			err = sja1000_err(dev, isrc, status);
> 			if (err == IRQ_WAKE_THREAD)
> 				ret = err;
> 			if (err)
> 				break;
> 		}
> 		n++;
>      ...
> }
>
> If this happens on the first loop iteration where n is 0, the handler
> returns IRQ_NONE despite having successfully acknowledged the interrupt in
> hardware:
>
> drivers/net/can/sja1000/sja1000.c:sja1000_interrupt() {
>      ...
> out:
> 	if (!ret)
> 		ret = (n) ? IRQ_HANDLED : IRQ_NONE;
>      ...
> }
>
> Could repeated IRQ_NONE returns under sustained memory pressure cause the
> core IRQ subsystem to permanently disable the device's IRQ line?

Thanks for pointing this out.

The IRQ_WAKE_THREAD result is indeed lost when alloc_can_err_skb()
fails, because sja1000_err() returns -ENOMEM instead of the value stored
in ret. This can prevent the threaded reset handler from running on
controllers with SJA1000_QUIRK_RESET_ON_OVERRUN. It may also cause the
top-level handler to return IRQ_NONE when the failure occurs during the
first loop iteration.

But this is separate from the issue addressed by the current patch. The
current patch fixes the receive path in sja1000_rx(), where an allocation
failure leaves the RX buffer unreleased and prevents the ISR from making
progress. The issue reported here concerns error interrupt handling in
sja1000_err() and the propagation of its IRQ return value.

Would it be better to address this in a separate patch?  Since the two 
issues
affect different paths and have different failure modes, I think this should
be addressed in a separate patch.

Please let me know if you would prefer it to be included in a v2 series 
instead.

---

Thanks.

Yun Lu


