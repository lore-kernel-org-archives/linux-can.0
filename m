Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792582441;
	b=WqiI9UIMYwv74QOGIOS3aljGRuV0O7SZTGAGneucRDtfHHMmdBeDSB06pFo7Vsbnuhqw
	 Veo3BGsOmH9RNAR09ns2PQc0HL4c6eNgbfIxMOJMhxLm/dYtt+trNl2eQkSHuyZ3vnpN8
	 sDJhLH0URwK7f6bHZmVa2pjvO6JGEWbCF774K6uFhR3KwuZdPjeJJZN9XxFGfKEDv2XCR
	 EOmjKM/AFRhGac4Xtj3GpiB49RP7tFS+2SAD52vasvhEvhJA8kqCjmUUM7+SEdL2/fZwU
	 xiswig7N0K93BfxtVUkgRvXT1xh8JQ6UnvemZu1Yr1GHI0xcAEnCu3f+WakAN+TznXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582441;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XZbpYx2QT8SRqRQMd9EWM51qhGzQzVjgKxv8x7jW8MY=;
	b=FRjbXYgcT3mlU9U04k8E9d1z4XF0858cJm93KIr2VQ0Fc+uFeNF3rcdWtqYr8RyVOs3d
	 MpOhj/p0108Vq8JLX1oexBAtz5qZRtmuoHBLdd9mrwyvAu7xsgV26WPljV3FC1+gNWI9Y
	 by2/XjiQf4tgx0m3f+GNZLAw+3hy2XADdv813I3KVtrG0XJtj2vkeIxXhcQQ4A6JFkQsx
	 wfZ0o2jFIT65QQWaWhIwkmPmdI+M1ubbReHDhxT/jB9SBTixug/zLys4zvM919A1ApAIi
	 Y/IufRPwuV7QSPkbmieq+J5kUquXW7qD8SK7bYYcTg6hwRceGrveAj7C5GHHPck9JCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qoKfKa1n;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="/eF1EWpk";
	arc=fail smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D5606A319;
	Wed, 21 Oct 2026 11:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D8D5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qoKfKa1n;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=/eF1EWpk
ARC-Seal: i=1; a=rsa-sha256; t=1792582424; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kQsJCEKykk1OKrTFFmYQkbT47Lbrt+2jAPr6cOUcsEZ+t8Xkd1fN5d/gbacYHcACeA
    2EC5I5jQHHSAe4k31kUQJbVzpWwwoexSZqZ95vD8xXZpCgVoY16VS5IUIwGrDqQIpoBd
    2ato1AYLLq6jEhUZ4Ac5rMsqouOYsOFknHS9QeHZ3KECLnZsmuPukW3hlcnhj23b+9V1
    HDyx+0etKPXgoqRM1L/8opQBspAGpSJOZxyZLUz9It+QYftB2orwxmhSqGYRL1K7KQwa
    QfDPOxqWDYb3oRTKKljRI0m3LLp4U67oE5Mav5XuN+D2hDgJ1HhWhfkXBbAdVoz3CmQG
    DmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792582424;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XZbpYx2QT8SRqRQMd9EWM51qhGzQzVjgKxv8x7jW8MY=;
    b=NwieL3BAqxtwMCCyz6nzohoJ9+zM0yNe5va+EsBIenmVGpvsBBsYGABLR0UYUG5a/x
    qIVUVh6hNKpXTwJtVjwnpX8oOh2GI3zdwOopVrtWRNcgovzliTtv67EJipq3XLmFuUNR
    PBB0xRbvQnM4NPzf24DP4Ax24QdwujKc/eK/eSd58L/bkk60Vx+2ONpqPrh5DA75DRqq
    21yxf0I+QATU24U/KDeeLmjfGiNLLzNXjYdW9VAdKGTkJ1pLNn2b0nne49a464hSaSpi
    WrhbnRokL/frulwb12gEpt0TjXs1PvM95dGC2TJ1yluGe1f0cVM55QjyE/VZg2YeAERG
    KloA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792582424;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XZbpYx2QT8SRqRQMd9EWM51qhGzQzVjgKxv8x7jW8MY=;
    b=qoKfKa1n3aMqI+c1cHVqogZRZy2YQv0Wt/ArFqgtYgk+eaFfXoso+kXA/kP28Qxn5g
    ljcm09IxRq9XBNJg0jwPeoYGDizruDWJKcybNdJWQ2irqJK+eCf5fFpwj+U4nAzowk+W
    kOrP0+bwTSgkG4fhnOjV8TT7inpDtiGwORCnmPJOTB8X4d8Kze77FjZD3KSyCQpQ5Ih4
    A83ojexJv6R4AfRESNKSZhFINFV2/+0Y3YaViuyVj4pZKkUqJtEu8G6oPIlh39LqoLot
    R18i/8749sZlTgcHJQjZvMJMpJy7Yy4RL55oEDa/JYkHwtYi2cfIv8+rJlPjQoUbo7QU
    nQhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792582424;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XZbpYx2QT8SRqRQMd9EWM51qhGzQzVjgKxv8x7jW8MY=;
    b=/eF1EWpkDFIHDuutZNK3CdiMtTogAPRZmtmLOmS3iMu0/OWrVxlCbAtIZ3dqzvmczB
    0e9Jq+85pxS/+J7GJaBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29LBXhhiQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Oct 2026 13:33:43 +0200 (CEST)
Message-ID: <37e1db71-eaeb-40ab-8589-099f9d5611d9@hartkopp.net>
Date: Wed, 21 Oct 2026 13:33:38 +0200
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
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-21
To: Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021102756.1900679-1-mkl@pengutronix.de>
 <313fdacc-a8e9-40b0-a125-2317ffaae79d@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <313fdacc-a8e9-40b0-a125-2317ffaae79d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paolo,

the original PR is pull-request: can-next 2026-10-18

https://lore.kernel.org/linux-can/20261018164417.1540449-1-mkl@pengutronix.de/

and I had to fix some sashiko-bots reports that didn't show up in 
previous postings on the CAN mailing list and its LMM.

So its really just a fixes version of can-next 2026-10-18.

Sorry for the re-sending :-/
My faults.

Best regards,
Oliver

On 21.10.26 13:19, Paolo Abeni wrote:
> On 10/21/26 12:24, Marc Kleine-Budde wrote:
>> this is a pull request of 11 patches for net-next/main and obsoletes
>> pull-request: can-next 2026-10-19.
> 
> This is a bit tricky. We are already into the merge window, we should
> defer all 'next' material posted after the merge window start.
> 
> /P
> 
> 

