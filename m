Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794741541;
	b=RsanBMyC1xl/smTdJkpHYOWPIyQf6BjKUG0HJkU06uj+pHrHw7kS9ZDJZ+ABVVZC65Xg
	 50X99k/a8qH0CCCIQ+6UgZofDrpodBfCJTU+TloL5ECJ+dbsMQeDyKV6gTG8KsOPkF4+I
	 H1yO0Enf8OeTxSySZjYLnIu1z3bzAwy9cz+I09VeYg1eHa+KPuIdMSeE+Ic7cZTtY4FVL
	 wWnjbfBgNUSBD6cLHWKPPJkHJiw0g5ULN28Xhyo9+74+zUgtWd165jhqFddXxe7licDN5
	 IQfvU4lqUNNAG6vS6xOo90qFD1XB92G2II9gyLdkJtq8iFjTUiqhOcTPQa5TPeWvgfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794741541;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MrfX9qIkYlFfGemWYwlk1BGSJukySqFvwj+bcyOXWaY=;
	b=ZGbl1khS/Six7dLZMcpkR9TGkyu2qRH47ERVA+EWPLHoLnI5OtEu39NegsYXgIi0Vrfu
	 VRtMISJb1H942F6Rv6Vx4Ed2KpXDTa0BjEgpfnxsgMSwYK6tEra/xQcnx6wGaP3gIf8Gk
	 92uq6WQKBdxVc31S4MGEGht60wLiBb6bBd46u09YliiZH52C8aJYHNtVTCvSEkpKO111E
	 y4N0r90vAN6xJMxINc1b0xpzVoj9VBTcHXP2ePeM/Pfb9DFRRYv4/XJrUwiALgY8pxxtR
	 IqUtgRi/e3ZYGA/aaeSr9e+/hSgavu527b+LKZn2wgR3zmpmtvVyePHTTJzgz3tryyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="p0GDn/X9";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=6ho6TCx0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63009606A31E
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 11:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63009606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=p0GDn/X9;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=6ho6TCx0
ARC-Seal: i=1; a=rsa-sha256; t=1794741531; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kAQb17EJCb+O3MhSeVmZGykFDqAX9IlWDgSv7Jg7FMixnsGTTfPph0DuAc9arGlzio
    ScqKaoksWLmYhU+M/eW/EMmXtAJYiYz/o9Zs4IE3ms3CECHV+/OU22DXARPrCZIFvR1A
    iA+TzLIQYp50b/jzdPyrQEnRWLEqwBAaup/qORmyaYcuQbz0wjLEiuk2ze6VGk1Rs3Cx
    2oFgPOOTLTrFj0p2sUtydvNCgI77HCQ5ulzXPp7DOAhw5hh3bOLgdQJr4zxbSbi4n7Sn
    xBvsnRbgnGsBt3n2ggBR5oPjkju7dz53YUHnkNBHDlXTHIiQJBFH0PbSh0mS/PcwibEt
    FS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794741531;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MrfX9qIkYlFfGemWYwlk1BGSJukySqFvwj+bcyOXWaY=;
    b=Kn5ik9EvpwnzvSjd5jGd9Ntz68313QNjK5DpJEEC/Q/F5VA7HKkYkQkYR+XsxB5WJk
    zSzOVXb1ZpC5zM3F+CZoeK5YQQaqF4KbNvt9d/jNuEMsqrQB3ZEU7oj3dqpdERBvCYPM
    OP0u5BafLpyS6zAiXBeXkBQb62fc1liUwN/PsxfM8GdJCvO8NsaNDeB+ON2THOCGFvB4
    OrTEn46vVFCVkGnkr0fMQNq6ZkkvwGkRn48NNwfz4NB60HpFK8uS2VssQQwQ2DZbJFSV
    f9k1i13ovvmOH9tqgyhvOVtOYb+SSU18vJuquNC6UD8dhvhOyeYtN48l+eOgKVswx/U7
    /PFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794741531;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MrfX9qIkYlFfGemWYwlk1BGSJukySqFvwj+bcyOXWaY=;
    b=p0GDn/X9svEjSJeu+SA3WDcUxZUSPAxHaAhZ0msLqSxBd5gJzYkubChXi4tr/9FM2V
    O/C8HCqwAeEinMDAAv0QZKJdUc/AHfsOQv51Hw3B84ZG/YVLKWq9z8Se/qZkb6wTwF+c
    ZSCNdMNZdkR+ptLA4zw127aGENDaBPXm+RVq928UielH20mqEAIKpd/msBC6L/eihpM4
    xilXDtV1Jh8wFTFvZQvmlracmMNCCp3epolE0v0+eLr2fiMB15leo5ltBEpoK3syNKT2
    uspgf5OGdt2njpBZGvVIYhn8MwNC7Z4SVnx8qAf5kltDvvAQ9Mc2xk1DasfjZE1meebW
    ellg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794741531;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MrfX9qIkYlFfGemWYwlk1BGSJukySqFvwj+bcyOXWaY=;
    b=6ho6TCx0vv1NOZIJN0vhzSBOTCmpDu6s+ToOoMTJ8K67f/90LBnyHbWP/ky4qxqkcU
    w0sUtNCUccKHNIevbqDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AFBIpOMF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 15 Nov 2026 12:18:51 +0100 (CET)
Message-ID: <b32f335c-a672-4d5c-82a2-17c784bfbefa@hartkopp.net>
Date: Sun, 15 Nov 2026 12:18:51 +0100
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
 <1b782cac-cb24-4f9d-9a28-aa5e5cbf94db@hartkopp.net>
 <20261115-wakeful-true-seal-1950b7-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261115-wakeful-true-seal-1950b7-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15.11.26 11:27, Marc Kleine-Budde wrote:
> On 14.11.2026 07:56:07, Oliver Hartkopp wrote:
>>> I think the bot doesn't include the cover letter. To add additional
>>> information to single patch, I add them with "git notes edit".
>>
>> Thanks for the helpful information about git notes!
>>
>> But it does not solve my rant.
>>
>> The AI bots are really eager to check every single word in the commit
>> message whether the patch below fits the announced functionality.
>>
>> When there is a series of 5 patches that are explicitly not related to J1939
>> it can not be the solution to place this information into the notes of every
>> single patch.
> 
> sashiko.dev seems to take the cover letter and later patches more into
> account when reviewing...
> 
>> That's like humans spending manual effort to satisfy the AI bot.
>> I've seen that in dystopian SciFi movies and it didn't end well :-D
> 
> :/
> 
>>> Add this to your ~/.gitconfig:
>>>
>>> [notes "rewrite"]
>>> 	amend = true
>>> 	rebase = true
>>>
>>> [notes]
>>> 	rewriteRef = refs/notes/commits
>>>
>>> [format]
>>> 	notes = refs/notes/commits
>>>
>>> It will keep the notes during git rebase and amend and include then
>>> while sending patche (even with b4) after the first "---".
> 
> FYI: notes are not working with b4, I've send a feature request to
> Konstantin:
> 
> https://lore.kernel.org/all/20261114-rapid-diamond-skylark-6d6cc6-mkl@pengutronix.de/
> 

A good idea!

Best regards,
Oliver
