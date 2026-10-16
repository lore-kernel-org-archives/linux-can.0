Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6ED2D738F;
	Fri, 16 Oct 2026 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149223; cv=pass; b=jEu3ZOZr8nSqHGojgLGv17p1GJG1dh1Ql4ODBUxH9Ou/DV2OxSSSOrWxB6rSVrSPw5JtBay4qmPY+dfNu1uPQBRjoQjhQGm874nffBKXlaStodJz4nF6B9acHuxAFhOmm0CA8D05yScipszcOi3DdseXm+sTgba/q0hFtP2aUIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149223; c=relaxed/simple;
	bh=NeaAtCrXB05VF7DcW45u3yAKoHjTarRS9t9Vt0h4e4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVE51U2Ba6sS8yh0fD67YfFDJ+ZYWapMguvunHGVmtghkB6x+2Rmlzmm3ifzlVa5qax3eziT+2ZnjhH+Mx95Y7EL+99WU7DQtg7oJ8U9qE+FHx0hJswRqRBNN7M/VUseW6nizz7EertgDIMc7nyx+UxVLgmqVn1NZExdE43W4dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=i0rKK2SH; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=OGHON99t; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="i0rKK2SH";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="OGHON99t"
ARC-Seal: i=1; a=rsa-sha256; t=1792149091; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iLver0Xt2CfLb1Whr4RCqMbZjztAtmSVadiFZUdoU8ft/CHDCIBXlvOiKBnYGP2nN/
    LigopAQ9Ge58JGDqkdNoCtdwvRiQYXWQnbeNBF67AIQEYUnEQe6WQ79RrrarmMm5bUW9
    1Mtyd+oxeG9cOJgNxMeBOJgW/7/kn819eabVqfWczsbtM6ED+E1p3kbrq4ykCYR6VqYp
    of5xGyq7+GO4BpNgs7QZglMb2+z64Y8U3bt+5yU6YAbTifuzQGMVPw9cn2Q/Drj8dgI1
    nrR9IEa0kiq2sHJDfrQXC6Nkk/bfUUG8RHyLBgwuBk18U4h+J1qMo7A+Wlv9HhtyF2PK
    4jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792149091;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QcN8YdYo9HVBaWz+y3S0gWLc0orMSOrjCxvU73aeCGg=;
    b=WXNLPL/ldvBhJrGIu8SKoofcJKKcVhycRtI+CPT/Km/t+10wxwszambF4gJbAfSkx8
    DhkYjmsD+PQo7BFh4BEPcINFT9/RLe+5Rj6Z+n9qp8+WC0bhzQshhGHjUBHqRYawcAxY
    M/dr5/O4ilda1Jd7GbcveN5Zliz1HOORY2HcKUsIo60r72ZbHQsp/MiUzdTeAO6qlaBG
    SeY7LngTVL0cuDzHuz9vXP4oLmwfCe8ogjxZk/HTKX7U/EiBPtS/y+FmgCvgZJTXnkXJ
    YYIruZ9+0Q7fPLHPaxis6JTaqugG96p4cXy/gYExwr0V6LJ4cJh3Mv99VM81L+HVyEaJ
    1cng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792149091;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QcN8YdYo9HVBaWz+y3S0gWLc0orMSOrjCxvU73aeCGg=;
    b=i0rKK2SHvD3Z8pk/pwXRbpV1oBN88fno6hDnoeTD4RYKdcqQuOjUL+HZHF6dbYUZRY
    7m+Pcz0+EliVKeueNXJLBo5x6gAMEvnsyUOmCQxKVvEHh3NoRcJUCX5Advo09YvGP8s/
    wmrEuRF1TBieGKnJg52lzk9esYtxn8bM2mh0NSyRK/5lHrW2iwS+T1yZruNHrBtSg/WV
    vICYtoYscdmsthT/X9ITXfRuDE4oIpBMuoFp5RHT3ZWmCqp90+F3jgVod7cnL6V6gfPA
    rgGWxX+f9glOSFWdlwpRYw8fFzU9BdTtBs0ezB7cG4shaqeqROc7msZJmprcm6ph9f0h
    nQbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792149091;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QcN8YdYo9HVBaWz+y3S0gWLc0orMSOrjCxvU73aeCGg=;
    b=OGHON99t5ZR2jLvprvUy4jIVzuWX7g5Y5ot4Pqys5GW0mx9IlTP50ATpMggfHKVkLH
    LmEx6dY6qKmBsREE1+Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GBBVLyR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 13:11:31 +0200 (CEST)
Message-ID: <a135fc68-3985-47c9-a3ab-7a9dff9dcde3@hartkopp.net>
Date: Fri, 16 Oct 2026 13:11:30 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/37] can: proc: reset pkg_stats atomics
 individually
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, kurt.van.dijck@eia.be
References: <20261015015336.816543-5-mkl@pengutronix.de>
 <179211822321.434549.9771966136026807937@kernel.org>
 <179214271380.1225518.13670821676227816602.b4-reply@b4>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179214271380.1225518.13670821676227816602.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.26 11:25, Marc Kleine-Budde wrote:
> On 2026-10-16 02:37 +0000, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 1 (3) · Low: 0 (1)
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [Medium] can: dropped statistics updates due to unprotected
>>    atomic_long_set()
> 
> The found issue should be fixed.

Fixed here:

https://lore.kernel.org/linux-can/20261016110905.422684-1-socketcan@hartkopp.net/

Was easy ...

Best regards,
Oliver
