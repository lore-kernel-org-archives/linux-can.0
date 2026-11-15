Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794729343;
	b=i1UJcgAM3ZvPegFz4+wbrWctMr0KK68AAbFw9vhC17luSakQbrbUUvrvct4XrN9CwCIr
	 3Q4MOIRl9+d9EDoscegIMXRFg2BuEq+ODFgeoP5UJ6tF++bj1HbqQiVVyiJiaLM+kQstK
	 P8KM28PQebHrT9GVoINcmn8HNOJy1nG/82yG/TNh/z/DARPOo0kaw4Kuyft1TYKIgaLwo
	 VnOev2hXAAB6pSAGoBZOMO2oy2+qo4t8nkl/sn2EmHT0vesSbiu7ONN8qv7KB1awJGVRu
	 YkyE1pRuDw19MVR2YrmmpMmLO2aLdYLXWGkriavuzb5mXw32dbZ70CzF8Bon4ohmbzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729343;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YbDQ8UXAkGg6W3YVqEP9Uins6K/gz8GuuzvH63Chc08=;
	b=ug9nc8KDWCFjj50MK8cffnAZVrSqE+KMFPhWouMqw3/6tBW3bTDOk27ef9x5Y5EuG20s
	 LCgZDA9mYzwwBATd3X0U1kEfY/hXTs1yRJ9+GKJLdQItyhCqY2DeqIEWgvP2aM9I6QbDj
	 qT5mISrK6IW/8qQ08twSy1ulnK6zVQ5/QnKdYPSkNKC6RV3+oz+3UnEBiUyk1NZha+TNt
	 ZQ3YwwnpkepJEFhGPzF0P7J3sTvhdobjKwC+ICfbDyDzdAo9vB/qfKVPgNLySbM3EcTFu
	 ic2wdIrYfZqaHy1WckTXqaxBvFXw67THWBiQQ5ealOwrHhBJXl1tGdqNt+ZEmvb9nXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MMvhSfqw;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=T1tbsJ7x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.20
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30308606A31A
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 07:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30308606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=MMvhSfqw;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=T1tbsJ7x
ARC-Seal: i=1; a=rsa-sha256; t=1794729332; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YipHIjC/adFbz7tQKtHg11UuCXobjlicv3salJuQsjsMdQsEe9D/zRMwyUobVM2gZa
    UUq+fQy0mBP8YfzP5Nb73FUQjDapGmDqR3NMiK/6OTDJ1I6b+J3j+AeFjbAjft6DobmM
    f0s36OWpoXYkHqtnv/YmNewLuW253ZABDpYaQD+rn/bYz9EJk4B2zHJSFeVeXNF3n6/6
    I6j6kH2bE2qmYKInghte95oumQ/qCKHCf8BExM+cSIO/42dkQh2DtNFWZ0ECQziaplHs
    EvMWAvT67PHZ5Oraj7mX8Z/pM9XhTcDKsDXrSodX8QPposb93nGw/A+1sxTR/Gd+uElS
    SKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794729332;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YbDQ8UXAkGg6W3YVqEP9Uins6K/gz8GuuzvH63Chc08=;
    b=Svl+BEIqV2IVNdouqTKLbs3QwJb2znCRaWXBj6K36eZjtPrV4dOmWdBPRNUJ7/SIqf
    QF6lBHHvRpRzg3dvO/0anWG3YgSNCPqfqC1qNPoCUKkTh2Y1oaeBBalGBuU9R3yXg0CC
    rLmwoYaD29GGWTJXKDZVVVWp7wLzqv2mSAEpuLdjWVR3VzvmeypqA6s9F5UtxqfRCXDy
    wE2EC+iaeOanHWNIm2diG/IcuLG+iFsMuBMBR8+Fn6jzN03m8h3NHA1XGrp/l637CqJ9
    /XtBJEr5UdSnea2cNZ+7lk/jSeK2AKkEAMid9xFN5IzfMxkWXBEfjvIG+5SR78vAVB7j
    CjWw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794729332;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YbDQ8UXAkGg6W3YVqEP9Uins6K/gz8GuuzvH63Chc08=;
    b=MMvhSfqwe68Gt1v4UNPG01GB9OwVIvO1F2l1s7eDWFq6TqNAiF+HGoonfZ0xNTQJTd
    pGz7GjLlGzw7cI4zkLIq9GAk5WJpGrCOA/tpwEPYXE1ijUVwf9IUMcwkSn5zIuy/MWqc
    S/A2QCEFlTrmzJM69CdeJ1l8I1u6VwtLD9S7rhOWSoV2Tba1VrrLdMpgR9jPEkbt3diJ
    lcevDDh9+EELLcJRERFYN8aIR/mLaBM6KcZqfyfJ4TsgQk4GBJPQ7GBYlPH7qqHzuC4g
    2/PaQd6UPKTf5zsGXXOQCL86xUHQ8/wC7dZDVpPJMkLZInfGbzJBGKUq+bl0AbZR6LIt
    MiGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794729332;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YbDQ8UXAkGg6W3YVqEP9Uins6K/gz8GuuzvH63Chc08=;
    b=T1tbsJ7xwNsayRchqJ3mPC2DRzeKdH1eZTijySvB3AaTmDXJHN8uXiANe3b9UEFdPR
    SHqR3GjPgBgblFvgwgDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AF7tWO3A
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 15 Nov 2026 08:55:32 +0100 (CET)
Message-ID: <25179774-bf3d-43d8-84e6-b0ce121f3eac@hartkopp.net>
Date: Sun, 15 Nov 2026 08:55:26 +0100
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
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 kuba@kernel.org
References: <20261113-can-bcmlock-memcg-v5-1-634c0e04bc72@hartkopp.net>
 <179470332579.488853.5643594273401866523@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179470332579.488853.5643594273401866523@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.11.26 01:42, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch's commit message describes the bug as 'a stalled
>    copy on any CAN_BCM socket can block RTNL'.
> 
> --


> The later patch in this series, "can: bcm: use a private mutex instead of
> lock_sock()", appears to close this gap. At the end of the series,
> bcm_notify() takes mutex_lock(&bo->conf_lock), and the generic SOL_SOCKET
> options never take conf_lock.
> 
> This patch is tagged for stable. Should the commit message say that the
> RTNL stall is only fully fixed together with that follow-up patch, so the
> two get backported together?
> 

Not needed.

This patch is a follow up to a bunch of recent fixes to remove the 
dependencies to rtnl_lock()/lock_sock() like

can: raw, isotp: copy socket options outside of lock_sock()
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=43c973a0887d3d7b2ee0a446603c97bf0f38c58e

which had no such announcements for potential future fixes either. Doing 
so only adds some bloat to satisfy the AI bot during the upstream process.

The stable process works pretty well without adding such hints.

Best regards,
Oliver

