Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.216
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774116;
	b=c2PkxfaI3kVlG4qw2zMtoWphgDYeXRlInJexiQXN4GfQ2wt6oEdlQVeW73n4iw5uloFQ
	 aPXSDnqnss6uYCCzExuzh2rK+s+jjtjoVeBmP/2NXx2BBevHbhwpmP2AlcyxWp8RILp0s
	 Mda0cInRQIb7R1JSos8gtPCongA57yBigpifkrzA8kLecUHzIWOgHSWuQ7d7EWbJfc78R
	 0bsEsB2gTg0YHhQ/oRibVc+m4bVPOarxyh1GxVd1bUR+3V/1XtTcXS/0PIUatQIiMO/C+
	 FByIXk2MRk7VvErg2VM9WtRFPxTe2FTrzey8lqREdw7NWnDEcKcBE5I9zy0LUc2Nxxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774116;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=d70m1WzwYuyXPOtMxsBuSd0GhEwwlBWBeaYw7DC7yGs=;
	b=lApvmA41LEm0zEepMuC6oa0FAccQ+Fwkq9p37Wgr43k9u6o0BPkRQsMY7EVuuqTX7D/q
	 rW8Pc+eTCOaaBdotEvzdtxNUXZ6EqW9xkbt8MYL0K3I7EqG75ITlyG3D4hu04rF3Ueupw
	 yOXMTBGuCRt/i9i2Eu+szfWiS4YkKnvzsbWao3KvWHn59f6ykrAQw7hLp1m5tidkww3Up
	 GPUokl+Oygt1ZFGoGMh9KNkgjVY4cviCjaD15NNWVo48vjms8HVQaaTMelB2gPXcUlMzw
	 cM022UNR8IHIJpOumG8D6hVL64ooM3SR3jqcztEXj8b4ZDf0T1botLZJzo9XBsU9YQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TWR5BJbB;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="/+JkJ8NF";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.216
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7162606A32C
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 10:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7162606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TWR5BJbB;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=/+JkJ8NF
ARC-Seal: i=1; a=rsa-sha256; t=1795774108; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UZNJuceTiLzjhYWcfIFx/xLN8Uz7dtUXQIjEpegxlm56mW+thy5gC6gq8dEH2U8+/R
    FYnWJnmhVYW/t4SbG7lPUi8K06YAFIgUmZDXm/BtENDzt951HvtQ/mFSTo90SQcpLSc/
    WBFX958ET5eZ5Vs/zxxiXu4xQzJRfOitt+TUyMIdBioNOONHDy8Vq5IyJLmaQWpR9dWD
    IEEuYNbJ6iLITLUu0+dT8n6Y3BP0CbLlE6umfLuXaoTcM/AeWa8LEaWHcyqV3FqoxnGJ
    14j+AQeMOmkrb9GOpRRxePuxUO265+XEQchUe6oWO1pBQtLVJRxgx7a1pEZGT9vZe2tV
    rmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795774108;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=d70m1WzwYuyXPOtMxsBuSd0GhEwwlBWBeaYw7DC7yGs=;
    b=kT7rJ7ytz+c6RXZC/D0UA1zzPi5LUCzzFl6nRuXlCI3wOCj9Y+mr9KV1NfvcnOjlst
    545b7ReFXZSnN4fqzUnV6yYgbn433Vlrr0q1QAvMPw9daTJJJvaExuGFgBsEZpAymIJy
    YLjnFz3Qd0LK5/ohX/qXzX612RqbyCWn/LDUFfG+5cxY57xTdpmLQulQ8N0rdalCLGAE
    Dybw5A5UdZyobN50ucOZsO1N4a19XmJUtcISajhOO7kb8Kajo0czGDvF7RyY/3QMh5Hn
    k/7ZFTZot5qWbBiJL37AugPfvbslTIxySWH/tHYAYG1xvHuQ1OCKGFyh7Qvtoi6LDYxr
    dklA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795774108;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=d70m1WzwYuyXPOtMxsBuSd0GhEwwlBWBeaYw7DC7yGs=;
    b=TWR5BJbBKodtWq+fFQtNt88irWbtlHRXnBqQEwGX8+8BB+Rii1Scj7bGoI/sLwVDqm
    tpVjc5LqGBHCdtDusilBJlI78WG4gJlk9ZKpmbJRTue53+aGMlQWgHbRJj6LYbC8pJXu
    oyPuynPV4qOdMoFcSvE+y3EBbeWOks2lFLZ5bevDXOi93xy04rRGx9XyXpTYpoT5zKAA
    KGqZI+PYwMwZQTnLBAq5BKDnCe+ul3EOyFstjv3X/wcPbbzVMqgcvfSMbyfMvtvmrhTE
    djLkHCQ6YipGwyb6KiMRyyCcdAGzqW0z1xV7uc+HzLI2SP/XLgIbMXeJYFN32Un0fS5Z
    TbcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795774108;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=d70m1WzwYuyXPOtMxsBuSd0GhEwwlBWBeaYw7DC7yGs=;
    b=/+JkJ8NFt0OE75H9nymjga40GWdqr+3tX9WUIBeJ9QMc0AarYi0/LWSK2QPxIteALl
    GeCloSgBaOorJ1QSx9Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ARA8SvyN
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 27 Nov 2026 11:08:28 +0100 (CET)
Message-ID: <d65925ac-364d-4fa6-adce-dfa4027ef509@hartkopp.net>
Date: Fri, 27 Nov 2026 11:08:17 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next 03/22] can: enable memcg accounting for user
 triggered allocations
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
 <20261126-getsockopt-memcg-isotp-v1-3-681ef8d8c2c9@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-3-681ef8d8c2c9@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc, hello Oleksij,

On 26.11.26 22:05, Oliver Hartkopp wrote:
> 
> The following allocations are accounted:


(..)

> - j1939: the SO_J1939_FILTER filters and the per device j1939_priv,
>    which is created by the first bind() to a CAN device


(..)

>   net/can/j1939/main.c   |  2 +-
>   net/can/j1939/socket.c | 12 +++++++++---


This can-next series contains the leftovers of the former fix series
which were not suitable for stable. The memcg accounting is one of them.

The J1939 code is currently changing almost daily due to several fixes,
and some of them will likely go to stable too. Having the memcg changes
in net/can/j1939/ in between might cause additional effort when
backporting these fixes.

Would it make sense to split this patch into a J1939 and a non-J1939
part and to post the J1939 memcg accounting when all J1939 fixes have
hit the mainline tree?

Or would you prefer me to drop the memcg patch entirely from this
series, so that we can address the entire CAN subsystem once the
J1939 fixes are done?

Best regards,
Oliver

