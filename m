Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031B3B9DA8
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772387; cv=pass; b=gQg32oafpw4ciaK4IcbLVz+n1omWHxjx+iPyEZW9tESFPaMm2hC8IpcXnM/J3O1oGPG26Alru3bIqJSpsH+YwjmklPLMYltG6PeZxSbVxJKpnJnhIhiryAUL1bvuA+WFheGSMY2bXeyw3dsZ+01Bp9XyTCurav+0ksCO5KS4FBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772387; c=relaxed/simple;
	bh=XVBeYUcQYCRjwKDm6UWvf120rU66PVYgiKHSEwuw5Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntJg3tvrI7kK3TA7X+vJ4TwQTS9GhT8+GAp8GOUZjHN/6VVBtiEVQcdSUJweiBEnD7CLeYb2nogPuQ8XqFjFtWNe2E8KKm5hN+p+tb3cdZcJOfYK0aUHWGeekOXAzQtog8iU/HWW3TqAVXrIYwssTtNbCVrHssh47gkbEucuM4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=L8NNvcqN; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xFBp/TPI; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="L8NNvcqN";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xFBp/TPI"
ARC-Seal: i=1; a=rsa-sha256; t=1787772346; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QoWUsjes+OBteMQODdw3thCntC7VXgxfRqRGcejxs4Uvilgc8Mwd0PXlFJihG8f/aC
    5u9k+2rXCTc6Go7saarqFvylqbrmbgqrIjb1OSD1wJz86wH1Hok/CEJxttX2uqJePEUS
    SUeeB6xMMckFLzimjPTSlnZRieUbTk1zFlSmRZB7Wppkd+aaKHxfh+s+rkmfIyrGLGaB
    VPeNGmveFKD33Kj98GN9KJ6zZCGARzY+PlWq4mScgq8xai1omzvGzEHNgBbn+PYXJlQE
    ciBtaCWtzliKa0mo2YovWmfn6lMTelT6DW8ke4Z16DAyu5r6pLHaqf191yxY9bjfpgF5
    gnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787772346;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dl0ziYHTLixggZ2laKahyYDGgyGeiIENyaACk7ZUCkk=;
    b=WwofAKBDz6qN6qShpYpJljOawA0wKKxWz3UveNQWJTiUdWAsl6bxZsOIxshqT5uucC
    AMOcuRSANhr+Omn/ghnTGbTtdbcF6DD/1uJLK/M9kkQt9097dEEWpoM/ml4IVDkPTxNi
    DZRMD06n/72nQL+iFWXHejc+wGL1wm4ECmrOxCp+o2M0794vtblAkLptA3OhiWZxTZi4
    MGkn+AYX8CQDnyEzzyGVHVNWhm2Y2qfnyLFrbPxpljRNPrpYubXXIxdqoeojiuAotG8O
    B0VcVubfnx4ch1BjGzbb9jVnBoL1Vnoo0Y3U9RSVNDvWV2yzf+748Yj08D6LfKh2J0Wr
    g0OQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787772346;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dl0ziYHTLixggZ2laKahyYDGgyGeiIENyaACk7ZUCkk=;
    b=L8NNvcqNk3Cqn+CN5PvK+0Odriipt+/vvC2zX4ysy8xJIlyPKQTURnSir1Y5CDoC4z
    uH9tTTH+y3Z3el0t/sCrFHAJ2FXP/9UWX626WbEN/O15EXr1YdzR+4Nnz72Pm1WqaUlf
    yKeT0Bbp0bx3dpQwOinOm4s8JeSfLaNPeZrT7c2iObW4h6y8AhAJSHTPxjQcgsnsTrXx
    mR1Q20oZ2wQhBUlG3BMNAWOjetXsxXtqI5mYR+0b/AnIUQuqXkJjzSM03S+LeKDDB404
    2n79mjMB8wcJdpM5mKI/R0U9w9AFbdM/VD2bDKCZtA7avjocVjQt8r68pvAubAuk1r87
    w+1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787772346;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=dl0ziYHTLixggZ2laKahyYDGgyGeiIENyaACk7ZUCkk=;
    b=xFBp/TPISnnmjN71rOGjtqn33fYw7Cw0qxgtLhk+DOg0L462Z35KnVTz2lkHAuJuAN
    zubqDX/srpMpOewO7xBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727QJPkwFd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Aug 2026 21:25:46 +0200 (CEST)
Message-ID: <497c9c8d-743a-4ccf-8de8-81a89b94b07a@hartkopp.net>
Date: Wed, 26 Aug 2026 21:25:40 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next v2] can: proc: remove pointers from CAN specific proc
 output
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20260815103400.117175-1-socketcan@hartkopp.net>
 <20260826-soft-python-of-charisma-e981f4-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260826-soft-python-of-charisma-e981f4-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26.08.26 13:28, Marc Kleine-Budde wrote:
> On 15.08.2026 12:34:00, Oliver Hartkopp wrote:
>> -    receive list 'rx_all':
>> -      (vcan3: no entry)
>> -      (vcan2: no entry)
>> -      (vcan1: no entry)
>> -      device   can_id   can_mask  function  userdata   matches  ident
>> -       vcan0     000    00000000  f88e6370  f6c6f400         0  raw
>> +    receive list 'rx_fil':
>>         (any: no entry)
>> +      device   can_id   can_mask   matches     sock_inode     function
>> +       vcan0  80000123  c00007ff         0  000000000000f862  raw_rcv [can_raw]
>            ^^^^^         ^                                   ^^^
>              |           |                                    |
>              |          /     do we want to align "sock_inode" to the right?
>              |         /
>              |    do we want to align "can_id" to the right?
>              |
>           do we want to take care of max length of interfaces of
>           IFNAMSIZ == 16?

The headline is fixed and most CAN interfaces like can0 or vcan14 are 
between 4 and 6 bytes of size.

The can_id can be 3 or 8 bytes and it looked best to render them 
centered. Same applies to sock_inode. Only "function" has to be left 
aligned as the functions can have very different name lengths.

Please check it with your real setup. The output looks really good and 
stylish to me now.

Best regards,
Oliver
