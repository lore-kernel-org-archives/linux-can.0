Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.161
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794741412;
	b=dn3h6X8ltOrCrNn2IPcTlY4E9hX5b5owSnjKlgjGPt813b1/uerlYhF8or5mFqhvsYtS
	 oKbSvob9yXMNHaMj3iDM90t8zOR9M5ORsmlZoz34oNBygkykXd+lz6GhMBwRX9XXrZ5gT
	 3HXDoBhCUKpAdN9i1uEbgfN3A6imOKXLeNfRAoCn4CbaeQHDyQ6Q+BXuYLSXZbhLOmCpy
	 UBochJl9OYOLsYT47KH8JOhOwxiswqXk/HA2K0/CtG47FjAdw3ni+qrOEwMUadM9+o0Ik
	 BdIiTn/8E2TE2UOEiV23X7RNt1druB9uqaiNgJhvM3IOoICfpPlkJ/xmj2mkI+tL9pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794741412;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HfL1rPAuRH1BjMJIGllWAFZWX8g7//N+M0PmHq7uHKQ=;
	b=C3rVDGA/w75NbJPVJ8XGKJvfcnQREZmaQnvPPTj5w0MKDPpnHbbIy9S1ygTJ2Ab5hXVL
	 al9maBet8FmPB5H8htJY/KaVFbRdfJylKItVNczmUPfGEzN0a4Kch8f5I1+eTw7rthAkq
	 tOFTLhPE1K54oH+E6AWyUQyVyjLYbs4aVuPnMJxIs2AQbp2wt7gU6P2j0rZ1+4OLPrxjg
	 PeXoO4+lY2RAEjiyACrbFp8o3sKE6UmzP2DXrVKKyzv6kwJnesZazgoU1uhwxtBqQnSUU
	 i9m0WfyBgFd2uUfj1CXnqtdiiIFTIG12XX3Id9PTjA6SkNXe6HAdbVCZKlnXb+3NApA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sAeXJ5p3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Ng9dmUw5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.161
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCD606A31D
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 11:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00CCD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sAeXJ5p3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Ng9dmUw5
ARC-Seal: i=1; a=rsa-sha256; t=1794741403; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EEeL4VMTyfwX5PSr0bTrD4eNk5TixptZYdBXZJ6K859AuSOKVWgjHsW0lII/q87v+H
    Edm19ucstshTc6cs+M/gHZE1w1kDRhoabm/XD2zyJ+TV/X+2Q8j9XelZn9bETOPDNuyA
    KwuJCIcqCvyautXSfAT+UQzO+rGIvyoPpFuj0WwMfkZiG/RZtWF4wTrIT3TZ6sRZjwW6
    2JDjHD/f4Zvvdj1T1qLAfcN3NCnXXbLjVG1joSa7jr//1ND1nKQJmWUznC8V3ftI3e9o
    i1GVwGcCBdhT42WfAm/o/6qTSy6oZffM0HThtIdumytGOkpLvRbIbbb1IAWBPhZcEuzb
    uhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794741403;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HfL1rPAuRH1BjMJIGllWAFZWX8g7//N+M0PmHq7uHKQ=;
    b=GW9vEz18w0P3R0OU3UBaYjC718lHqm0VPjuPkX7XOUU2z0F6FD91u2+C+x4Ic3ViAw
    fpggmA1qeAv93l6AAdktXmEa2x6tq1t/tA1X0/Dmv7+mB5Zsh7UVkHbVTnO3+UWRHfER
    OudTUwQ+YrS9TwbPEqtSVG5wiJEA1HCB6ANiXLlf5rpOHTwGZwcLCM8EYrk0ft/aWrz4
    VEcVCjdANmG3fl4gjiA5O0H4ndtaKedva42kZFYh6l3dC3oHx4076+T+KV8I9VK1goil
    nmnTxOLcaBN4KPaVbErbU1uDstt2F9rrd6GaudV2p2cVBTnUuOT3B/eM/y4nDN4QCBPm
    f2OQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794741403;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HfL1rPAuRH1BjMJIGllWAFZWX8g7//N+M0PmHq7uHKQ=;
    b=sAeXJ5p36NO4ieaHnb4A5ajc/SOgKte4N8SOe6r7HK7OBgQ1ngfuqKS2EP0vCkCeF9
    z0tdIlRocu1QIvgJQy9chu0L5mcNbiOM2HiR/U3psPurDJyIFBAkvIL7f1ivsB45hevM
    fsNAQb3qchjR8B7BmWMmlyavdjO6edSOUYtagxtzQq2MacXGErsIgI+Amoa5gPT32WZc
    X9H6vKFw+0l1an5ORrEjFUr7JzihdpXZ+kj516Ij4zL8nLaN0TauUNI+4tEiWrEMcYuU
    VqgaqU/6DGtNtNeDogO0WtVoTvymxwWPBYYsda5JIlr7X85iAmS66BZr8APrA4Pc7WZU
    Ixlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794741403;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HfL1rPAuRH1BjMJIGllWAFZWX8g7//N+M0PmHq7uHKQ=;
    b=Ng9dmUw5oYusGPUeRl1rLWVrmH4fB6bNS/P6rVdKwOr/7wiBXKr1I+ihjpNBgaUMzi
    yKCNN/phSFq8D8lMuXAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AFBGgOLq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 15 Nov 2026 12:16:42 +0100 (CET)
Message-ID: <28d4a5aa-535d-4486-b913-e413a043a309@hartkopp.net>
Date: Sun, 15 Nov 2026 12:16:37 +0100
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
Subject: Re: [PATCH v5 1/5] can: bcm: copy the CAN frames outside of
 lock_sock()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev-bot+sashiko@kernel.org, linux-can@vger.kernel.org,
 o.rempel@pengutronix.de, kuba@kernel.org
References: <20261113-can-bcmlock-memcg-v5-1-634c0e04bc72@hartkopp.net>
 <179470332579.488853.5643594273401866523@kernel.org>
 <25179774-bf3d-43d8-84e6-b0ce121f3eac@hartkopp.net>
 <20261115-nippy-adventurous-scorpion-0a33ed-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261115-nippy-adventurous-scorpion-0a33ed-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.11.26 11:30, Marc Kleine-Budde wrote:
> On 15.11.2026 08:55:26, Oliver Hartkopp wrote:
>>
>>
>> On 15.11.26 01:42, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential
>>> issue(s) to consider.
>>>
>>> Critical: 0 · High: 0 · Medium: 1 · Low: 0
>>>
>>> If you believe none of the issues are legitimate, please reply to each
>>> issue of Medium severity or higher and explain why the AI is wrong.
>>> If any of them are legitimate and you plan to respin, please let patchwork
>>> know by including "pw-bot: cr" as a separate line at the end of your reply
>>> (one such reply per series is enough).
>>>
>>> - [Medium] This patch's commit message describes the bug as 'a stalled
>>>     copy on any CAN_BCM socket can block RTNL'.
>>>
>>> --
>>
>>
>>> The later patch in this series, "can: bcm: use a private mutex instead of
>>> lock_sock()", appears to close this gap. At the end of the series,
>>> bcm_notify() takes mutex_lock(&bo->conf_lock), and the generic SOL_SOCKET
>>> options never take conf_lock.
>>>
>>> This patch is tagged for stable. Should the commit message say that the
>>> RTNL stall is only fully fixed together with that follow-up patch, so the
>>> two get backported together?
>>>
>>
>> Not needed.
>>
>> This patch is a follow up to a bunch of recent fixes to remove the
>> dependencies to rtnl_lock()/lock_sock() like
>>
>> can: raw, isotp: copy socket options outside of lock_sock()
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=43c973a0887d3d7b2ee0a446603c97bf0f38c58e
>>
>> which had no such announcements for potential future fixes either. Doing so
>> only adds some bloat to satisfy the AI bot during the upstream process.
>>
>> The stable process works pretty well without adding such hints.
> 
> I've send a PR, let's and comment on it as needed.
> 
Thanks, Marc!

Best regards,
Oliver
