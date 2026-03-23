Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A040386C3D;
	Mon, 23 Mar 2026 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259539; cv=pass; b=ee+l1s0yz1kh7A7I5Qyj+0rfZucgYVEx0RGxUvz9+pRxnfd+3YLh0TZyLfe0CBPsYgBgGPbml7gz4APTwVbota8+DJdmL/ifJ9++kE/T19Z5yrC27LXqAzqKWo8KMRViStp9iVtsxb6EtOFuUMYioCb5CNuj9KUdinxudL3Tgmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259539; c=relaxed/simple;
	bh=FOoAd3DUL6Q7w2+MKVIMDpc707xPwBY+lWNuxP/C+aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2heZgfQ746bolC7mGYoCqRrqGDhWWJH3BDubul03IY3HgFXlLTvaZ7KeobhrZ22sLOz4u8FsJfBKRPSV+nFlDhwQSDt/K5h20N2AWOWHC0WrvALZy/qkGUvNKGY8q0COjFsAFuMZGxLuSFaJiKrPNt156MK6TrQY6uvGZmW0lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BxsyfUmP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=xxHnDBmu; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BxsyfUmP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="xxHnDBmu"
ARC-Seal: i=1; a=rsa-sha256; t=1774259174; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=o3Hx8AGMxGqf72DAvqKDu4ZOE7B838U72IgUZzWn3MnXqXIJhS1Y2jqa+sZwq/IGMz
    zuexXXq5putw8kKvYz2eZjDh5TrdH9ldUC5NZpcQsAG7oJ/WimKhJ6UfzIP2LD3JYA0m
    7MCXvU/KvnlnUXyWWhS4EVX6ABtQQV2E4H3wldst27K8AyjSogJ9Jeq325u+MUKcQo4n
    7yqKotQsKVdMMsI3eGJwnz+dh0yRgTKyVpRD/70qjSYY+/6OboYJtAZEK2dLlCuZXtQ9
    oyR4WQsodKDI7V0RPeGK49i/O+uMHoiNl1984NPM24pjFy1FkCUUL24bO/qNQcNEqnpw
    2BwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1774259174;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zsGbUC7Wu+gvAA3nGX6HUNQK/j0NsqsQmAeIhfCDFTg=;
    b=e/P7ORkeVGe30dPSqiiNYE3kp8cJZysMWFWM6PJk7XmtiFBbKo/lU3buq80pY7oni9
    sR+to4F4L9DwL+/9gQqsoWWBCAza0H08kPEsZaFIpRRgu5JZCEe336nkFc06siPZUgUB
    RLtbzwcRpwbL8yPg2yaK6gLP2LT9qphK0XvKOmy3bY1KTxOzU1m737In9j4K619CFXWF
    WzeN4y8Cuo41ZV307Jp1X3n593sJLoBI5f+tc0xNnByC2Q+xPxjAB1fODKlz+KEG1M0O
    A/XY/XyHOIOd3qODncV6nWXZZifrnDwdKgghFwNS3O0TyaemssFM3BmtgtHiaa4d/Jol
    +2tA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1774259174;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zsGbUC7Wu+gvAA3nGX6HUNQK/j0NsqsQmAeIhfCDFTg=;
    b=BxsyfUmPVMu4k4HJtQGZjVZGDYTXrhH/MYMzBBPwGkdwvQJtxYS9pE0UVpxUZK4AmB
    DZsASLtty9/QSdDxcSN9L/h2Mhdg3FvIfgs93W5DRQzRS9qFZQs7PHGVo7sBXxh8MHuX
    pPOgfP4eiXdvs9Ts6yqXI3anIIhgeFRYC6vFvLD1YgwnulfvYvOlp0n821oR96hoSL9s
    mzFdAQwF8gJaw/T6A/rEdhjk8vru+4hrA74GbXirHT0+KUuCGDB8NKtTXKue+//LEJvx
    vneX4EWUvpGeFU7Mkq7Fth57nfVMyjc1d4KXaWgXOZFaKHBvm1MrTUe+0OiJGKfljuKG
    hy5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1774259174;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=zsGbUC7Wu+gvAA3nGX6HUNQK/j0NsqsQmAeIhfCDFTg=;
    b=xxHnDBmuRk3aVitBWo5XnYJWBd2RgoZ+6XOheckQO9qH8JcFkIDhh1umIQQWS+XFjJ
    QJQoIAtF0MYbBuEfETDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d22N9kE23F
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 23 Mar 2026 10:46:14 +0100 (CET)
Message-ID: <afec0eb7-ca32-43ba-8a32-3bd9aedcb030@hartkopp.net>
Date: Mon, 23 Mar 2026 10:46:13 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] can: bcm: add locking when updating filter and
 timer values
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Urs Thuermann <urs.thuermann@volkswagen.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
References: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
 <20260219-bcm_spin_lock_init-v3-2-c61026740d7b@hartkopp.net>
 <20260302-gregarious-poetic-wasp-e73cee-mkl@pengutronix.de>
 <20260323-valiant-whispering-buzzard-3e3471-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260323-valiant-whispering-buzzard-3e3471-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23.03.26 10:42, Marc Kleine-Budde wrote:
> On 02.03.2026 11:21:38, Marc Kleine-Budde wrote:
>> The nipa/ai-review bot found these problems:
>>
>> | https://netdev-ai.bots.linux.dev/ai-review.html?id=873e6dfb-7d8e-4f4d-98ef-a89fcedb701a
> 
> I think this patch is the only one of this series, which is still open,
> right?
> 

Yes, it is still open.
I'll look at it soon, but it should not delay the other fixes that are 
currently agreed.

Best regards,
Oliver

