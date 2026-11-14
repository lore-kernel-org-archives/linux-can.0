Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794639385;
	b=pZKbkTzKqVjB17Q84SS7lUdd/7oyF3SZ09r/GsZrF2FzKOMKUEnXFCGYI4pt2nea6ngo
	 RFqemHCDM+fI3VHlLvl6WdeSA4NSB61ViwKE6LbJBM9rRNIIhMF/R0hdxUS2hK/f/j4j2
	 WB3efU7tLtKOoU/zrueXp/36NFAzsqmQOwaKrnB6YBPsfg1AYHvmFD8QHJyz7CCRUmQOV
	 N+k9fpkn/jMgFyJlfWJg2AptrOCNn8WnkhaaZXUQNYduArKza9x9843DPVG1yIIguZWLd
	 7RfZ6nU8J9zSOeBLToo9cZQASrSpYALvTugAY+B/oXjJnfezXKbosnh00eMUJZPxkVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794639385;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7siuoXm9RPkfZ85X9bBvlhA198D7LHvWIyWvSmAGXRA=;
	b=QKDqjQ4BVL/1bHBv+M5YYa0aj0lT3ZNuEgvjVTGufgT0CndkMGnee2mD7Eg2u9VOeqoQ
	 FnzINHCA7grG8AAW4BjPAUapEfCo4E/QhDFZR/G22bBOCOH9aFRTEWx+W3PHYt0GLIG7n
	 wQY9X0EbqC0ZGNoFGlpIr++sGZJrJ3cIsLcbXf3AvGHsEvoUFwb6a8F9yRXQOfyQbcE47
	 Kh6BrVH3AO007boAvmORnQwBNIaxFx5ydq7JqKVmSDjTk4/REAhzdD+M4zj9W/ymhbANR
	 t23OaEWtSidLWtRduwcf89rJf6auSHR2aHhtFArswGa5MorbmPrFjUJcIhLV10f6K0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mXQfchyq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2Sj7TJwG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E2606A323
	for <linux-can@vger.kernel.org>; Sat, 14 Nov 2026 06:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A0E2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mXQfchyq;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2Sj7TJwG
ARC-Seal: i=1; a=rsa-sha256; t=1794639374; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kngZNmF9cEWVCJZp+ntAxfY1/QVlpnY3c7ZeAatWgIwXaobHtHx1O274k4VKGXHec5
    IcfTBfqQDjAihcDd+EY2Fz9onD4DbpV/eMKZ64v6u2bI3/9aFvSGFl5TsEvzY43xjsW8
    kK7xkO14oz1Fnv29UwA03Nv5dcvPR4u4Fe+SEsmcgotmN5PBx7fVKA46YHYs6rwE/BsI
    LZUm2r55RcqBz7fpZijxbJ4Hye04iX54Dqu9cIdfdYUihfwxwH27YMh4XFQrHQEqFwvI
    EmgngJNsKkhFWMSYvwiajzPfGcHEVCxucavGernbDgXt/M97MTf4rjdhYqcOuj1KB0Jl
    bi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794639374;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7siuoXm9RPkfZ85X9bBvlhA198D7LHvWIyWvSmAGXRA=;
    b=XRINv9C9CwZaUiqxve8ytYFFWZxxM/V3yVY5Ikh3A7JrKLHHMJ+zWhMvYsB00teb/V
    iifmLWSHbytY3u2ViMcDHNAweYAUaO+GuGfcOik38AI190ckbOiZwHd207/3v5NO4psK
    ZSbuC3j3JD44HzyfscGDIv+Tek56qEI54SRDRED395nstqwVJWFiTtcQAcYsI2qgK1jW
    VnmgNaeWS3/KN3e3IeM5luz0tmjCEngqvzdhJxs2NYaqTHgUjhNH799G8LYo4isaPtYb
    70bSS3YzwV2oqbbM93RmlnNwwwyMsvVypBGi4yiOppC1Qx3wroTgmDMVLXUZLeX8CIwn
    6lHQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794639374;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7siuoXm9RPkfZ85X9bBvlhA198D7LHvWIyWvSmAGXRA=;
    b=mXQfchyq9r7sdosZtNtpLgh1HfbE9FRwtzmEYLiq9stQBxr59MX2M5UT1V2fSAzhaA
    x18HZCnjENKygLwc3H+zaIWNNKiV2OTcxUySQN6yZkH9qczNq3sffORKPDV9bwd9smoi
    pzVHoz+ERyHdVo8ufRTmGMRJyJSStQ1AZHL+JrZCeI7r4U2bjwcxySDPDLthROuZ/PwW
    5AhXZT/u/6FEnyQs6eyrq5o659LBQPnCVzx/i4rj/frq9CArOho+JYQ5yMQKu731HP0r
    rj6KIMRfowmcCY+mK66hV+4Rh7xfcg678MQVk7gXOu2ZylcqLWFbOV1ZQRY7BPacCB2h
    er8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794639373;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=7siuoXm9RPkfZ85X9bBvlhA198D7LHvWIyWvSmAGXRA=;
    b=2Sj7TJwGDctQeE1hu0ZGZqJ5gtaVePUb9VyZkNnE8Y6v1+p7/DLqAKHAhfOSL6FxgH
    YVAdaTBJ8RI/VzERr8CQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AE6uDLwc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 14 Nov 2026 07:56:13 +0100 (CET)
Message-ID: <1b782cac-cb24-4f9d-9a28-aa5e5cbf94db@hartkopp.net>
Date: Sat, 14 Nov 2026 07:56:07 +0100
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
Subject: Re: [PATCH v4 3/6] can: raw: use a private mutex instead of
 lock_sock()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev-bot+sashiko@kernel.org, linux-can@vger.kernel.org,
 o.rempel@pengutronix.de, sashiko-bot@kernel.org, zihanx@nebusec.ai,
 kuba@kernel.org
References: <20261111-can-bcmlock-memcg-v4-3-5428607a608f@hartkopp.net>
 <179454426541.488853.15379643605511531742@kernel.org>
 <5b2f1dcd-292e-42fe-91f7-fe0255e830ab@hartkopp.net>
 <20261113-cooperative-capybara-of-persistence-52ed5c-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261113-cooperative-capybara-of-persistence-52ed5c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.11.26 11:57, Marc Kleine-Budde wrote:
> On 13.11.2026 11:51:55, Oliver Hartkopp wrote:
>>
>>
>> On 13.11.26 05:31, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found more severe
>>> issue(s) in other patches of this series. This mail is only an FYI, in case
>>> you want to address the nit picks below when you respin.
>>>
>>> Low priority / nit picks for your consideration:
>>>
>>> - [Low] The comment this patch adds to struct raw_sock, 'struct mutex
>>>     conf_lock; /* protects bind, filters and sockopts */'…
>>
>> Changed comment and commit message in v5:
>>
>> struct mutex conf_lock; /* protects bind, filters and setsockopt */
>>
>> https://lore.kernel.org/linux-can/20261113-can-bcmlock-memcg-v5-3-634c0e04bc72@hartkopp.net/
>>
>> Especially:
>>
>> Sashiko suggested to hold not only the filter copy in raw_getsockopt()
>> under the new conf_lock mutex but to also protect ro->raw_vcid_opts.
>> This change will be addressed in a follow-up patch as it goes beyond a
>> simple lock replacement intended for stable.
>>>
>>> Pre-existing issues:
>>> - [High] This problem wasn't introduced by this patch, but the bug class
>>>     the series is fixing is still reachable through CAN J1939 at the end…
>>
>> Read the f*cking cover letter before tagging things to be [High]!
>>
>> "CAN_J1939 still takes lock_sock() under RTNL in its netdev notifier and
>> has the same issue with the generic socket options. This is not
>> addressed by this series and will be handled separately once the
>> currently discussed j1939 patches have been merged."
> 
> I think the bot doesn't include the cover letter. To add additional
> information to single patch, I add them with "git notes edit".

Thanks for the helpful information about git notes!

But it does not solve my rant.

The AI bots are really eager to check every single word in the commit 
message whether the patch below fits the announced functionality.

When there is a series of 5 patches that are explicitly not related to 
J1939 it can not be the solution to place this information into the 
notes of every single patch.

That's like humans spending manual effort to satisfy the AI bot.
I've seen that in dystopian SciFi movies and it didn't end well :-D

Best regards,
Oliver

> 
> Add this to your ~/.gitconfig:
> 
> [notes "rewrite"]
> 	amend = true
> 	rebase = true
> 
> [notes]
> 	rewriteRef = refs/notes/commits
> 
> [format]
> 	notes = refs/notes/commits
> 
> It will keep the notes during git rebase and amend and include then
> while sending patche (even with b4) after the first "---".
> 
> Marc
> 

