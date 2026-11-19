Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107223;
	b=BU2NF3GyFM6bqE1H3ZmtPSdWhsdDeSLHWKWFxvRKC2UymgK8BCA1Wu4Q34OgdioGZ8+m
	 zaRlTieMrdNgcmSfwT0qq9Mf1lyyuTS7VFf6fDBA0npGdUEF2hCH7NGGOd5kSlag9wMKP
	 MZy8NfE67pE5qK80JYrmNgr2KguGUe/TQtqGTbCUW9+ZlLhy3p+6hjk6ZEdCpm6Oa8Zfe
	 g+BhDY+An5wyUMeexmmqSwZQ3i54tBidFkRyuQC9eyfKjS28LU3c1n/c3MSMqu7CIUVB4
	 21ubXtfyhgFjHu2MauJnENt16Nov/utyIQyeh/isHlZ5X2bVT0wV2SRs1y8y5fLcgpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107223;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OtMdOJaZq69S2A0LhNMkt2bWXueXY+Xln52cb/4jmAU=;
	b=tHhlzBIjjDnOczG0T00OORS1XE50BHFEGn3O9whdxNVQGhVpNEH6c7Aavnx8OuaADXjA
	 doTkS7I+pjMwZ8wrSW51bJU4bNH7mCdKt0wrPOUB57d4vneDec/yCmFkjwhNJUGp5h8ZR
	 LQHbJxY+J8aJo0N/y04e0KOpFczeZD+twwO5OdeCryNV3SrqH60Rh/FWmu4ZNZCeh4xWj
	 IdNEWerBU7H+6V91kMP7Mw3Ccv0ttc85rZzHrP2Cz6E552T+4GuwNTUTR5/auBkv6gw5K
	 Q1OmLIPvEAm9ccMItLe/t7keFG8zRdypSY5x2y8spyoQhhhzMt/VQWJAUIbx+gHrxpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=dC9xIT0s;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=WFQdXQFQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5C606A324;
	Thu, 19 Nov 2026 16:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35B5C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=dC9xIT0s;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=WFQdXQFQ
ARC-Seal: i=1; a=rsa-sha256; t=1795107201; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AhYYpVRnXV2ckUUIi8mS+h40IhFKj9j9KXBOBmZWK3hNIG3ZofgTIQv4zdHjtXFgCg
    cdOFjXginrwfdg1fV8LITL7S8WeMtjm1rZ2g/h7nS7biygsB4resO7kmtowy89yhluI5
    r25DBBbVACCVBP12yVE3H0f3bCFxQRPAN3YW0mBIAOnFjIPia6lm9RDMKXKFxJ2kyQGO
    XDQ48UPz1aIVSKSrcQnbyFrUqZCsvLuJN3bMzTTWJppEhPtKTMO8ZRZUkHhhtVDfFAnq
    +rlq/Gi+m+hrGJf9e5g673fB9y4gC36dKGmIG7r7N2JNXO/016H0aKdJjiWqID/NBB3a
    hKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795107201;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OtMdOJaZq69S2A0LhNMkt2bWXueXY+Xln52cb/4jmAU=;
    b=n5D1oxFniiHGYydog0AqusXyajIPiH8WXo0eVOaOHD1/ewqptOgXmg5NHml+UnDBNb
    afqQgRb1DBlIXgv+f/X5DKmHsFCQrVLlX6Xvtc94f7Vx32LvANjDgXK1gX6eDgNaYjsv
    ijSSJVFQ27kT9JpVU7wKmB5d6WsI2SQlyUmTW+Nob1+Ac0nkYFN+PQ4U3o0EbJpWsE4C
    wyYdBeuEGw+AeEY/cmL/9aTwiaFzJcfXoGdXYlQ+yaZnzJA5pKuwgXbqfEhG8iPLsaIc
    L36uzVqf/3K81rMc83bqG8MSPrEiGoVT0xV71octnTP48E2sOk6gBSIRudgP1alXbDwk
    ++Cw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795107201;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OtMdOJaZq69S2A0LhNMkt2bWXueXY+Xln52cb/4jmAU=;
    b=dC9xIT0setElcMscvGP7RjFNi6yCaxYIskuLy/FyY1uukmb60aK1RK7vQb4XHhz+CV
    /wSQ9tQxHn8SIiB2y5ALXmHMFpmHsN4YvfY0DdVK8Amw4pzDb6BGMGAqKcByPCIMpc5l
    udj+fS9bCGM+ZlmQaM2aGnto+VragRoKzJ24ZOs3zLLVdUDvrIuFtLShTRFeygwyTT+P
    m3uyD/UzKUGsQrMVygW8nbWwJR8dPHwm2IbXnuwao61t+0jYb8F8wC6akTsdHJoR7ie8
    VIue4do2H+XpbPwrtb3ofcdj7iqLwBShAOXbxz5gWO7XbByzGnco4vZ24P/tYoE8/D30
    prMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795107201;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OtMdOJaZq69S2A0LhNMkt2bWXueXY+Xln52cb/4jmAU=;
    b=WFQdXQFQ06oCCSTsWWtVwGd1IzzVFPnDYYXq39UPmmvK2nXKL+jQkL2HSB20W6NRQD
    sBeYoa3DluhsfIeXyyCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AJGrLMph
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Nov 2026 17:53:21 +0100 (CET)
Message-ID: <f29308ea-4493-4146-bb28-506522040ce8@hartkopp.net>
Date: Thu, 19 Nov 2026 17:53:14 +0100
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
Subject: Re: [PATCH net 0/11] pull-request: can 2026-11-17
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261117220818.1142581-1-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261117220818.1142581-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

unfortunately we did not make it into the net-PR for -rc4.

Do you want me to re-spin my series to address the Sashiko remarks and 
commit rewordings for this PR?

If so I would answer one of the reviews with a pw bot cr tag.

Best regards,
Oliver

On 17.11.26 23:03, Marc Kleine-Budde wrote:
> Hello netdev-team,
> 
> this is a pull request of 11 patches for net/main.
> 
> The first 7 patches are by Oliver Hartkopp and avoid RTNL stalls in
> CAN_RAW, CAN_ISOTP and CAN_BCM protocols and fix CAN_ISOTP issues.
> 
> Followed by 3 patches are by Zhu Ling that fix problems with the CAN
> netlink handling.
> 
> A patch by my fixes a kernel memory information leak over USB in the
> gs_usb driver.
> 
> regards,
> Marc
> 
> ---
> 
> The following changes since commit 5e9b2ad9b8384cd3c417cd5e2c3bc7eee4a72791:
> 
>    net/mlx5e: rep, Fix races between devcom PAIR event and uplink close (2026-11-17 16:12:52 +0100)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-7.4-20261117
> 
> for you to fetch changes up to b772103b7a4feeee02fa12a3223a7fb5a5a8a81c:
> 
>    can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB (2026-11-17 22:26:21 +0100)
> 
> ----------------------------------------------------------------
> linux-can-fixes-for-7.4-20261117
> 
> ----------------------------------------------------------------
> Marc Kleine-Budde (2):
>        Merge patch series "can: avoid RTNL stalls and fix CAN_ISOTP and netlink issues"
>        can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
> 
> Oliver Hartkopp (7):
>        can: bcm: copy the CAN frames outside of lock_sock()
>        can: bcm: do not remove the procfs entry in bcm_notify()
>        can: raw: use a private mutex instead of lock_sock()
>        can: isotp: use a private mutex instead of lock_sock()
>        can: bcm: use a private mutex instead of lock_sock()
>        can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state
>        can: isotp: reject socket options while a transfer is active
> 
> Zhu Ling (3):
>        can: netlink: fix static FD-NON-ISO mode validation
>        can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing
>        can: netlink: fix CAN XL PWM attribute sizing
> 
>   drivers/net/can/dev/netlink.c |  22 +++++---
>   drivers/net/can/usb/gs_usb.c  |   2 +-
>   net/can/bcm.c                 | 114 ++++++++++++++++++++++++++++++------------
>   net/can/isotp.c               |  50 +++++++++++-------
>   net/can/raw.c                 |  41 ++++++++-------
>   5 files changed, 153 insertions(+), 76 deletions(-)
> 
> 

