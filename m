Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794741840;
	b=czLEgmIhSb/MBprUOYder36qM2It+b3COZBdWCWnGBAlzRGTjgCFikBYhs2PWqrnU/dH
	 4/MlUsgsbxGxlOVgOgdwOYOel2JZNhuWt1/LgxH1x5+CL0uUxAH5qChCBS8OrNx5oiLNb
	 QOaOZmmNEC8Lix3Z176H2uFy/e474nOcukljTjIcFyc+ASZU3bp+HPTODkZsHlsVjp1rm
	 8uH5MCmi8eDscwofT5ACzRrUWbEXFvN1wSmZCqtxXF+x0AhgyNxM9Z3vih80zLiEEmSQl
	 ue8kK9sBtzRPAVi74H4oPHX6d5tu+PtXJzXn4e2fHo2ccL+AdP8LYvohr0fADvtmgPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794741840;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=43spPD8V5Lp3Gb+zVaNrlyT+t5qJdqG1HEhNDLN2Utc=;
	b=TIXamcwWmwkmMEMe2YfRmbX8t2HynxqQOlYvpAZxUiUALJFmx+Fyf/BM8o5auUrJrHAj
	 lWNBTwiaLOSGC8Zyqfa5cIw7SVetrv/aPZrAVn2+dOWMCNLMeN+LD3iFnGSzACY4jcsOZ
	 9M4sFri4nksBDMXTV8J7l4UvwuLjFGYjbUVfi+sDKPJiH/G2CWrnrnA9EUv4H1Fq3uvxV
	 SoP0qjh3Nt+zEbvKJhWkUL7sHAS/ng80/9MD+WIiTADsGTswN+QIr5Ac78lE6TbRHTnVC
	 PhvyU9epZeBOJqWcRQQowUsbA07dr6v3xrB0w2w0qazhtVVR2YoJ6V2o7NZ8SHjXVTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TzPgBeNt;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=lk8njFt5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6866606A31E;
	Sun, 15 Nov 2026 11:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6866606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=TzPgBeNt;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=lk8njFt5
ARC-Seal: i=1; a=rsa-sha256; t=1794741819; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C/xAv43UBRAVDoMVQ+76RNWkAIzwvp7461ZOhIzSaMXxJVmjOaliNZffMlx8f3KmtG
    CVZIqfLb5v7pZgwNySaPdesZ86mruD6ds9MK0WwQW6zsdtwAEaWi972jSk653YFJ2np4
    BUd53fgSgGlydFLVY+nTPj9EUG1ftut/pFqlBFlmzmM47NU5glNxk3nQYc4WIUQDQm2C
    jP6HDApdewt8QTjLzxl+RoZvm7w97yzQzs/t2d1Qb2rS5YJm1vMA5A8TCVq1GRYymz41
    npgmZARpZRjmFd/mGrTVbabQRUJeHjs8D8fyG9KoCzqej4OBSdG2vQ70+AG1AvvQOQKm
    KuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794741819;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=43spPD8V5Lp3Gb+zVaNrlyT+t5qJdqG1HEhNDLN2Utc=;
    b=lc7abcJ0qrJUIbV1bet4xK1BkJfT7w+2QMSL38XDTC3lHAUoSiXxZrU6jMu+5fdK2c
    7n5a7se8nRDaQxCy2zUW5wioW+KXfb8SBRkjvTHiPgUwCF/vHmDrow49EyGfOM/7H1m4
    MoBcgFo6e0A8bX5dL4I4DhfRiYLPLVL39wy7K8daXvHUwVXFCLiydBLQZ98qLns2EX2b
    jEWGa1fBnEplGzk8so3BP0sdWJkU4srhv31ATkcC5OHILrcQgQHvL+LFrfSY0TDavVBg
    eyxiuuKl+7RgRY1TEj0Y9vDI65+5ZRkMMIzULc+kAVXEUq2xsihTpGAJTjipEEqkQn8I
    q2uw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794741819;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=43spPD8V5Lp3Gb+zVaNrlyT+t5qJdqG1HEhNDLN2Utc=;
    b=TzPgBeNtmBGFENW4tNs0YUqSo/QvDcj2cqhdBNrYFOMtLlhl5bH3kNlRlVEjYeROne
    bFVbT4w6h2PjBurxhRECjgKko/pSUDiPxSgYf181vwr1i74P54lzh0rjLrDpiryMwXO0
    mDdkJ8DWrEqCTOTacEC+gEzEYpVy35flKagwUaBxZ3WSuoZWhpYr+u/MBkR2yQF+r1Ee
    YZElY/OgcJnYs7CS+VfGlL5wOMBumW4UQ2OU/aq3mCfdCFTTMobpYrZF+1DH144whpbw
    E3I3DDntDIQvd7/hTfSZr47tVLL/YzXFATFfbRSt4OJWPpVDe7ihNYaIogf+kRt0yd1k
    OxAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794741819;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=43spPD8V5Lp3Gb+zVaNrlyT+t5qJdqG1HEhNDLN2Utc=;
    b=lk8njFt5LkOw7xz2kcZTiEcJRbtGDuH9e3E7IrO2eVKGWde2QKohysR9GpafqGPKqI
    hobFVxGJgv7Hs/Vw9pAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AFBNdOMv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 15 Nov 2026 12:23:39 +0100 (CET)
Message-ID: <bb2a488f-5734-40e6-b673-84612f6173f1@hartkopp.net>
Date: Sun, 15 Nov 2026 12:23:39 +0100
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
Subject: Re: [PATCH net 0/9] pull-request: can 2026-11-15
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261115095746.709371-1-mkl@pengutronix.de>
 <20261115-musical-garnet-turtle-de4539-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261115-musical-garnet-turtle-de4539-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15.11.26 11:18, Marc Kleine-Budde wrote:
> On 15.11.2026 10:54:51, Marc Kleine-Budde wrote:
>> Hello netdev-team,
>>
>> this is a pull request of 9 patches for net/main.
>>
>> this first 3 patches are by Zhu Ling and fix problems with the CAN
>> netlink handling.
>>
>> A patch by my fixes a kernel memory information leak over USB in the
>> gs_usb driver.
>>
>> The last 5 patches are by Oliver Hartkopp and avoid RTNL stalls in
>> CAN_RAW, CAN_ISOTP and CAN_BCM protocols.
> 
> I described patches in topological order, which is intuitive when
> looking at the git tree. However the linearized order of patches in this
> email patch series is chronological :/ - Sorry, I've added the missing
> "--topo-order" to my git send-email script.
> 
Funny :)

Anyway the current patch order is correct to be applied.

Best regards,
Oliver
