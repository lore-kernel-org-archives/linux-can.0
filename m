Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B23CF1F0
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790701641; cv=pass; b=UDC6psB2pkLxEfI48dbPHsP1fkpHYq/gtDdFdFE/KBl5YSWL9i6wGU98BlT8xepSYET+FMRCsYV5ZHCyOaDCaWGvTnjn9fHI9/gFnT4nN77+WXAQrszQmAabqXacBFJ8C2Lsierb7KKdTy64aZLqyqRqh/oJPCNgt8kgEBxXGqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790701641; c=relaxed/simple;
	bh=1hbu3sa1ZRCOt3YIVy9k9Z5HYPcO5a1QOWNNqucKIVA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rQD2MypBQeQ7DtqgIeRlzy1wbmPM6BPsc8VppOu6FiOCJBBkI2wclOL1WsBPQ7rwrhNYqVm8oOKvZMYg1X22GpmQj69iQqRLUtsPjuLDbRS5NRy/7JiRQAv1CIY5Cb3dAFxaFAqQeE1Q85238CH2oUuRdWSSQH90QcOp5BDm1qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b0LVFQd2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=yXalduob; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="b0LVFQd2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="yXalduob"
ARC-Seal: i=1; a=rsa-sha256; t=1790701637; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=K6qPOF6qVmc8GEq6LiFuVkH6x31N4n/O+DwNusBxKvAxof66t0N30x41Jyl1PI/iRZ
    16omVr+jVH6YIMejq5SITIQlLp1mngL8x/WKfzQJ6rHJc1uHqDjrMwWCZKJL72R4B9nB
    G/P1cmGVP09noI8LarsKy+g9a3yEKLoM9TgaOFOE6skHOJBWg4J0YlZO4IO+I3mfW8yv
    odYHK+4NvTSYJhhCLNfLGx1IUSV2LzxsfNrQYZQqJYJ78I3q9VXGOlxv3lybXTiZ8KXV
    FbKw6DCHL1VlRId9w9naCOWqdhYXOS4dbXEu5F68jRLhFdgZe/ZcDr3bE7ZjfYW6ReKp
    hiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790701637;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OJ1c0xCphemE8fXoOwhxi0oJPMbRniKl2QYvbMf8YDo=;
    b=sDBgkdj+Lc9OFbSYsqzBueGrCvCTklbMf3ngTrwYJM0+p7VY1qDVghIjQbGEwOzhay
    E+dNAjL60K+Xm1oY9B8r+WhRugvFpcXLcCvWxL7eYs4otLFyOQ5HO1qP9VQPYJJEmyKw
    zvxBlgr141AttVQRSLow217TEVjs5c3kECyPcKLAd8UcSWV5uq+2mBSMVbPusEftB7KT
    +k1LeTSQSaeqPkYmrmXKcyp94MPebANsWLe/SXT+Ks83tXhkkNS/NeNRGA/5aXRyhx1v
    0dWN+jbnopqP05b/YqPh2kKPvD1ux2uqlrx0PWdutJ8PIMdV4rk5k7iIZi3eT77bKs92
    WzlQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790701637;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OJ1c0xCphemE8fXoOwhxi0oJPMbRniKl2QYvbMf8YDo=;
    b=b0LVFQd2qjRyZ4ZwC3AyAt++HSxzxbP1gJEpTyIkF42gjVoZIdIKdS0z3b9I3Bi6xU
    o/DellMwUR2xtvCjd/RgFj3PWqX/Hpb4dPQYOEsmiWSZqcGP0NJ2YcS/Ctdl6SgHVxbe
    hrGo31vYWEzyAfDKMxAX37p5nkirdnL693bkMQtJjuNp7pLsgdt9t5cGs0nXepHCaByG
    3rYswiTPYFd8QQqB7Cjmuk8e2+lxJCCMj2Z/yYC4p2AyVDMHH9OjX0Ph3GXR4rGGbYAj
    5r4S08Bwg78xeBe2KccSKBIJQD6jM+Rc6TVwDKmj1G10KGFV0Mj+FgQPrdOJsxenXRD1
    N2FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790701637;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OJ1c0xCphemE8fXoOwhxi0oJPMbRniKl2QYvbMf8YDo=;
    b=yXalduoboWzaLIiO+yg0/BEzonlD5REu9t8JynJsfVycyfbRbmLImWqCceLa7KnRw6
    ifj8cvSNAKTlQEhdswBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28TH7HU6M
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 29 Sep 2026 19:07:17 +0200 (CEST)
Message-ID: <c0dabad5-e59b-4b76-8521-0ede9e0f8ccf@hartkopp.net>
Date: Tue, 29 Sep 2026 19:07:11 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: v5 is ready - Re: [PATCH v2 0/3] CAN netlayer fixes for stable
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?Q?J=C3=B6rg_Willmann?=
 <joe@clnt.de>
Cc: linux-can@vger.kernel.org
References: <20260928173105.51765-1-socketcan@hartkopp.net>
 <20260928-rhino-of-marvelous-honeydew-7abf71-mkl@pengutronix.de>
 <c3fa6f4e-d19b-42eb-93ac-bd694a666aa3@hartkopp.net>
Content-Language: en-US
In-Reply-To: <c3fa6f4e-d19b-42eb-93ac-bd694a666aa3@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Marc, hello Jörg,

> On 28.09.26 20:43, Marc Kleine-Budde wrote:
>> I'll send a PR soonish. Once this series is ready, I'll send another PR.

Done!

https://sashiko.dev/#/patchset/20260929163424.16382-1-socketcan%40hartkopp.net

The three patches are now ready for upstream.

Can you send the follow-up PR tomorrow, so that we can meet the net-PR 
window this Thursday?

The patch that addresses the RPS regression reported by Jörg is now also 
ready.

I was able to follow the bug report from Jörg:

# echo 1 > /sys/class/net/can0/queues/rx-0/rps_cpus

$ candump -n30000 any

$ cangen can1 -x -L 1 -D 00 -I 123 -g 0.3 -n30000

Before the fix cangen returned but candump still was waiting which 
indicates, that candump did not receive 30000 frames.

After the fix both tools quit at the same time. I therefore added my 
Tested-by tag too.

Best regards,
Oliver

