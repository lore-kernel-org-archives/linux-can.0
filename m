Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863E42C508
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414541; cv=pass; b=AYHJ6neieQoxPradw0Nls1C7GAY2OLf7vYFwl6hVTARfFTr3ARblxlQ9hLaSHLi4lNQLnaaSWHpm/dbFEehT8d+RT99XDwSBRx4mYG+TIG+THpehQOgHks3jeh80QspG7YZ9PavkkMtAu23XpX+/SecmvRXJY5uq5sXyXwWajoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414541; c=relaxed/simple;
	bh=Sidj9gbGLDgJnUWXL+QYC2HOTx331sphtnAXxwQ4ic4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI0X9+dCVwKs2wj4zhdlAv3dUuuCroBnnaNVWYy5fSzFzr/s9FUsIouUMJ/2k6W2gGj8qwx8tCPAr2E20NncKDFg/bAtuXAaaOmmaxfQ0uqi6lKgM2/LN6jDHlr/IQkFJz2QGup1VOkcc5Mex3pngHovzmWbNmhuJCX65Ag0CXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=X5ah69Bu; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=AwLjK9Po; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="X5ah69Bu";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="AwLjK9Po"
ARC-Seal: i=1; a=rsa-sha256; t=1785414530; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=okn7rvzX6goi+pXisB0WF0tu0q8bzo7TvV4EmKTGQE5aVLVesluCpjfcZOGa79qRJ+
    q9JiSSrmsx/duWJWEQZ/6cZ/Ybyix2W/Z8OdDUmOdRNeCljvWPPCa9vND1NMNJqKuq3f
    AcdiKDx6IMXpAT0g3R203afzI2ThKm/GU0PASFobcwUGlJ/vtIgy96bIH+PtpuZbolg0
    e9MUiAadgDdcOXJWVGtoI2IurH7A1QTbfKqnkpF8xNMO76LnHtXvucFeaIHvMntqTchH
    v3+pHaFwIvfGg1Ck7WFC752AKOHRgNqwVotsckznzVgiCGSgntN/vVZWkADbZnZYNKvU
    7qaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785414530;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+yEEbffzTZgmyXp/FEi/xs8knfRftBM2HOZRyjGv6GA=;
    b=UZuy7+U0Ph7p/4sBHuudqTW8OUotBJ5f6Al067xLBW2NNqGj3EkMQmI/4cm3ZHQUII
    aQmmmzkCncdfm0cJhAxnHj4N3ILGiU1mA0i1T+eosWMqHuriUFNlMov72WGH1NEHrBdJ
    ubb0leAlPxzaCUb4dIRlhDDwLEO7tmyodoFUYi7UXWxuX5lDlrP6hJ6Jor74HrsyCz7F
    MrcIUKpuTmhZR01f0/iNHyW9iaeCIDMNUKD7exOyk0yBit5gZmIZQAJqTmOeCpZV3g9i
    dRp9BW0YPK7FJMcv4JN7SHPmwx4ZyuEaBErwvuKpXlmkc+NDJI0opDjwkoFOqpruhcgw
    hHuA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785414530;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+yEEbffzTZgmyXp/FEi/xs8knfRftBM2HOZRyjGv6GA=;
    b=X5ah69BukjYZEN8ivaeXZy4quFfgp/3Unf04f+9pPHpF7u4AyWf/9iVee4VQpkIouU
    jPbefWbGqzAOiDhawVepo67xqrX+qcuVDkwrxOYcwQPchrPUoZeyWD4FvE/AscW3tqFp
    hjSuMnqG7Pz65pnTyV5iATt8IeoF2i7SNBDg4kGNh+q510PQFXij46qQw3MpOappcUWe
    a28JLSm+HaDAUiiJkbTXi/D73LTT1UdqsZPnmGQaCbKHIZGMlm8qySFPNJf/A5fqWuS4
    5uQYULkRQoBzIzEE9J7LbKI+X5JqOBlDQKaRlb8b2ho9XfSbnXwk6e7WslO9hM5xDK8V
    Lt+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785414530;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=+yEEbffzTZgmyXp/FEi/xs8knfRftBM2HOZRyjGv6GA=;
    b=AwLjK9Po/UomsV0ROg4WHjoxR1NF0iL6vkhuAzPlxGDjfhYBOsgcpUifqcrQq72aU8
    cMB/f29FGeOxKDy3SUAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K5281926UCSoYdR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 30 Jul 2026 14:28:50 +0200 (CEST)
Message-ID: <b3d83ace-6e70-4a62-a0ff-f9b57c29071d@hartkopp.net>
Date: Thu, 30 Jul 2026 14:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 03/20] can: isotp: fix timer drain order, wakeup
 handling and tx_gen ordering
To: sashiko-reviews@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-4-mkl@pengutronix.de>
 <20260730102948.70AB61F00A3D@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260730102948.70AB61F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30.07.26 12:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Silently dropped asynchronous RX socket errors in isotp_sendmsg() due to ignored return value of sock_error(sk).
> --
> 
> --- Patch [3]: [PATCH net 03/20] can: isotp: fix timer drain order, wakeup handling and tx_gen ordering ---
> commit 3e2ba28e6e9e34bb3ea9b3075735283b9c9490c0
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> can: isotp: fix timer drain order, wakeup handling and tx_gen ordering
> 
> This commit addresses several concurrent state and timer handling issues in
> the ISOTP protocol. It introduces a generation counter and packed result
> array to track transfer state accurately across lock-free accesses.
> 
> Link: https://patch.msgid.link/20260724181525.43556-1-socketcan@hartkopp.net
> 
>> diff --git a/net/can/isotp.c b/net/can/isotp.c
>> index 54becaf6898f1..1f11c66b343c8 100644
>> --- a/net/can/isotp.c
>> +++ b/net/can/isotp.c
> [ ... ]
>> @@ -1223,20 +1321,49 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
> [ ... ]
>>   	if (wait_tx_done) {
>> -		/* wait for complete transmission of current pdu */
>> -		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
>> +		/* wake up for:
>> +		 * - concurrent sendmsg() claiming a new transfer
>> +		 * - complete transmission of current PDU
>> +		 * - shutdown state change in isotp_release()
>> +		 * isotp_tx_gen_done() uses common tx.state/tx_gen read sequence
>> +		 */
>> +		err = wait_event_interruptible(so->wait,
>> +					       isotp_tx_gen_done(so, my_gen));
>>   		if (err)
>>   			goto err_event_drop;
>>   
>> -		err = sock_error(sk);
>> -		if (err)
>> -			return err;
>> +		/* still our claim, but isotp_release() force-shut it down */
>> +		if (smp_load_acquire(&so->tx.state) == ISOTP_SHUTDOWN &&
>> +		    READ_ONCE(so->tx_gen) == my_gen) {
>> +			err = -EADDRNOTAVAIL;
>> +			goto err_event_drop;
>> +		}
>> +
>> +		/* own completion, or tx_gen moved on - either way this is
>> +		 * what isotp_get_tx_result() recorded for my_gen
>> +		 */
>> +		err = isotp_get_tx_result(so, my_gen);
>> +
>> +		/* drain to avoid stale error for a later poll()/SO_ERROR */
>> +		sock_error(sk);
> 
> [Severity: High]
> Does this unconditionally clear and discard concurrent asynchronous socket
> errors?
> 
> By ignoring the return value of sock_error() here in isotp_sendmsg(), it
> appears any unrelated RX errors (such as ETIMEDOUT set by
> isotp_rx_timer_handler()) would be permanently lost without being reported
> to the user.
> 
> Could this cause applications to hang in recvmsg() or poll() indefinitely
> because they never see the RX connection failure?
> 

No.

sk_err is a single per-socket slot shared by the RX and TX paths, so it 
cannot cleanly separate a TX result from a concurrent RX error.

Note that a plain unreliable datagram protocol like UDP/IP gives no 
feedback for bad or missing received data at all - it just silently 
drops it. ISO-TP does a bit more and surfaces RX problems 
(EBADMSG/EILSEQ/ETIMEDOUT) via sk_err on a best-effort basis, which is 
fine: for an unreliable protocol these are ultimately caught by timeouts 
at a higher ISO layer anyway.

What this patch fixes to 100% is the send path's POSIX contract: 
sendmsg() now returns the TX-specific result from tx_result[] (>0 bytes 
on success, <0 on a real TX error), instead of returning whatever 
happened to sit in sk_err - which could misreport an unrelated 
concurrent RX error as the TX outcome. Draining sk_err afterwards is 
required in CAN_ISOTP_WAIT_TX_DONE mode, since the result is delivered 
synchronously via the return value.

So the send path is now correct and race-free; the shared-sk_err RX 
notification stays best-effort by design. Truly separating the two would 
need distinct RX/TX error channels (e.g. MSG_ERRQUEUE), which is a 
feature, not a fix, and out of scope here.

Best regards,
Oliver

