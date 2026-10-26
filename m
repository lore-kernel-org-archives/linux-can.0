Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793022431;
	b=HCY29tS8B1XpAcpsVoveiEajxAp8CXAx26tO6PjkfNhdNjHTcAzx9y5mZ6TxZgPGWrCY
	 Qqn8m4rvrIJQDuL1fBvtBvLkaLjQuZ1nGwiB93kkmr4b9R9JdkgW+HMs7aVKBtelQNim7
	 ktxLBj1MuWE6rwfPUk7uFNjSrBChw4EWLUueA5pKwnYjIirDYz+XXkc2UR2eSes/WxRNz
	 ddm/B3NJqzEfdD0pASyYZhw+1Zrb5x+GHklQ3ZcTeYgs24ztiynzOpu63mAh/vzFNca7v
	 z3gdoeq5t5zLxRsrRvx5ak+4yHonAYztA5a6nwINwFixJxHqFlHtzqFPnmsj0xmvGPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022431;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=f4dO6l/WULi98DidXbp2fZ13n4u3PVhQ6QYYrX8h8GM=;
	b=uyhU/zAm9ChlWQP/UUg78aVByB2S5J5kHeJb/vGeLPHtaOuVxeV9MSozNxTLwbsnk2hG
	 VjvmVrASFKZhIAPJQ3FsAaP6INTcWdxmTkqBNIHVXNGuC6wvvXzh6bV2nwaL/p63oc53P
	 tUO+4hRreV3pntPSxX4WMzT91b9kGFxc7NftSbUJRz8Lmecano+QJEvzReS8EQMCXB0lJ
	 kT65zSoIKerSNyXCnIt7F1agcxhekRU/VTSkhdODl5hKEIsyM7sQIt/dqfap3+epa/UHf
	 4fAp0KfYlkg2xXz9Dh90YfA8LCd6O26ZjmomNg18KVtfoyNjP/AreL8CVVIWs9183Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OwMbIY3X;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=AP9ba8y1;
	arc=fail smtp.remote-ip=85.215.255.82
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80133606A31A
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 13:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80133606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OwMbIY3X;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=AP9ba8y1
ARC-Seal: i=1; a=rsa-sha256; t=1793022428; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BnLOWzxf212HEqknkvhWE51gT5psdP0Y9b5t080uDvPxtpWiPO6Fx2zUGeuhWpnOIU
    bPnY9dQEalxsyzi77gGLYiSXQVGjzji08iv4uuF7LF401wVgudZg/whTho4T4cjkXWfi
    SdqqgNdmGLo9iRtb2aXyodBHy7Uu56qjubotr0lzy+uAgHiWm4tfxhhJayfxF92Ne6an
    weojFBtqHm73hWAwm26CFUAGMZcNvhuLKbP4zwZLp6SdhC8uNzGeiYQ4zDaZrXStdfr2
    GtQu1a2QVJAxbpWVrIWOCDBi7f4G+egr5kbJCv+RYZbBtpZrQDDW1bXaGC3PJBi8LkND
    ho/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793022428;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=f4dO6l/WULi98DidXbp2fZ13n4u3PVhQ6QYYrX8h8GM=;
    b=blmDxKN8JGo3PoJT6rZbDg9PuwySgpOHwM3YwzZ8hsfgK1uOYq8l2DSNYhq1GbtNnm
    H34W3f7KnQUfWSmpy894eSIZT6/R1uAEIlSv/0Jazx68SSlJYB5QFZfShxs8T8I1Wec+
    IMhx6hEwUyKiZhIgMWdZJ5L0oNl2DIj1ovaFK3K2YWSIGHstxGPnDE4MRG7vA8NGtqCS
    6Ix3wsTth8MrhNA9rbhjS4T+ojCyyH2HbqVVcE+mBtmutm9YIx5sheTuzniZRSPDEHtc
    9LB7+WuMvg9SQnSuPv6dL8iHyu0IzM9KyDVlzMTTk4U9MkO9yCUTylayNoMYnFWRBvjT
    uMWA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793022428;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=f4dO6l/WULi98DidXbp2fZ13n4u3PVhQ6QYYrX8h8GM=;
    b=OwMbIY3XHsZp/8ftcl1YzgBM6j4a08PV5vuT22/Sz3mQlIWOcNY5DTMRL5l5NVYacp
    FL05Yf1IAyCFsDIFNDpCvbswM3YPwgFO/Jq3Zg/NpE8ThwmuvQfqRNvMN7xH9Yaci6Sj
    C0IK0Nq1Qdx6hBQE1m8gJyKRWUGkkw8pW9ZuOTpfhu73ubJnEpzrST/J/Y+y8+UN4E6N
    N+zU7gz5R9+uV4xKl6Xzg7Wzue7D0HSOCYR/09VNovvXDLI+uwJWZUNUODAHoS/ijF28
    iqV0j0xelzAK54Xd/KLNrDpqDvMqjhkYOol0ULFmVNk/xf2NmlciKPDNKrhg4KljFaZN
    e76g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793022428;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=f4dO6l/WULi98DidXbp2fZ13n4u3PVhQ6QYYrX8h8GM=;
    b=AP9ba8y13d9f/qEuoRiynPeR9AZH6FqC/auc2PVgPM6O2vfyLYxQP5K0nzOirtF/ig
    iGA6EjG5j9OAEGQhDWBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29QDl82qp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 14:47:08 +0100 (CET)
Message-ID: <50850234-fabb-4907-9f4f-c382af11bd78@hartkopp.net>
Date: Mon, 26 Oct 2026 14:47:03 +0100
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
Subject: Re: [PATCH v9 0/7] can: protect the receive lists with a per-device
 lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
 <89bb8afb-dbe5-4c8a-a6f8-66f9b0489924@hartkopp.net>
 <20261026-belligerent-labradoodle-of-beauty-b07263-mkl@pengutronix.de>
 <c270fdfd-79b3-4f27-93bf-84d51b48c21a@hartkopp.net>
 <20261026-masterful-native-loon-48313d-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261026-masterful-native-loon-48313d-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26.10.26 13:31, Marc Kleine-Budde wrote:
  > I'll take your series first based on net/main and rebase the relevant
> fixes from linux-can-next/testing ontop.

Great!


> Yes, please make it based on linux-can/main or net/main.

Done! V11

https://lore.kernel.org/linux-can/20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net/

Thanks for your support, Marc!

Best regards,
Oliver

