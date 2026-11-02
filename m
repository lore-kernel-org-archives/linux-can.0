Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.161
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793610985;
	b=sjCKAKRrZYw8EtNNQFJwQ4IwiVIAZTpKIaWxmCrBvdkNcJz2XSz5pHBc6k2WgiLSil1j
	 0bWHSS66G+aPhxFY4K+vFl6zKPw5ntkoFuLeXAuEENOHZdT31KScYvF50hc225OL3Jic8
	 L5Ca0GChTfDO0pAYyH4M+8XFzsDrfYBV1joZd9ksCSX13fx3WtIn/pi6299OIPpjfyI4G
	 Ym36cKL6zNzpmUnI9ApL4HwKGaPySNJFA/LR7v6PuaOY7JL49mF4306BcdZThqQbl4Wne
	 CbxLZnhWhO9olmt7v6Pce0iHV4gf8XJyvW0ETLq5G0+fSqyU+t0RC4KXdUMBZYvYYtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610985;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=h7U24v9RAPoXbz3b8xUkhAPvQFCG3xrHUAG/FfglRQc=;
	b=R2NzBiSsoEoApOWmFegau6rV0mzrT47HMYoXcmRk0WSaWBKFvSu/zysLGWMt8xGY3qre
	 s+nzj7pRnedcZDwkN6wD3ngACjfl684RtBORpaKIZGxf8/1jSJroZt00p02RjigLMazKb
	 r8+umK0ZFRn0/iV+5eNlxNrvLUo61d9LLSGC/6G+FzrTSyZNfi/VuNDa5VmH+X6xZz/VJ
	 JYybyEvd3UlmQfwW8TAJZmCJZj/q3fw5TclGZ1AZafzI9ux89n16DfmTeqKHgbsL2eFKn
	 xkatHJLKRUhYn3Pjf76U6cWPh9odVuLfIaRcpnmDZmLNpXTbmQt2SPqqxJJWvRlkF/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Acc3s+AN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pt+VmjmX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.161
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7929606A329
	for <linux-can@vger.kernel.org>; Mon,  2 Nov 2026 09:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7929606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Acc3s+AN;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=pt+VmjmX
ARC-Seal: i=1; a=rsa-sha256; t=1793610967; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=g7HzqXd/U/FhkH0l5YkpI8/rLCfFwepWn4lKEpVGlcP5FMeaKI1jTTNJlwc8K7dbij
    vPPq63gEmCoz3XAtTqB9Zrtl2RRj4katPuPWy9Xujyx2KD7ncplRmsksQLPxc9KKM7Oa
    hFMscQCZBHHfSOOvJHrPHvRoaLVgtnlVvziNmucoxqCB5URwTgniYhueVVtFe1gnkFV4
    HVQzp4XYLiUP0m6FUrTUqispenOi18g+u1MlqWJRhS7u4XFstUPrqO0WzSQrX7blst61
    gyMg0Q0eoQhARDIVHVEjOeAgL8DAQrffJvFhfwDgUsA9BJMggJJywPR8K8gMDMMQTUmZ
    L3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793610967;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=h7U24v9RAPoXbz3b8xUkhAPvQFCG3xrHUAG/FfglRQc=;
    b=HwDEc3hqyodhn2zUa/7Eb7W1qGzgP+p9OexMYrLYOXFgmD+MpDNSQTziowCi+DmruP
    ZLz9+WrzzK8Tzp3Q+x0AeSjPGwEHPaYY27Jft7Ejmj4RdbfJze739Pt/3gjmkU+JGb3z
    r7mmykQ5QcYFXV4+/p5a9jXdLqTr2ZyRbPb3CyJrHVB0lIjqtMDMn1ti/Sils3ntX4WE
    gBjJHMbtYKNK76CTYwZVrRqbhU7Z9wWR5ryzzcZGLJnW6OZadEhZVBnm8jTAzb2g66rn
    FjhHuw4Dj930cglBNwEo0cyn/OduFdLQr/gTfYPStpplPqUQbTFbFT0TApM416PDDjoJ
    WYOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793610967;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=h7U24v9RAPoXbz3b8xUkhAPvQFCG3xrHUAG/FfglRQc=;
    b=Acc3s+ANaxvr4p0axmVTKkKpFfjhkfNEj5r2YC1SOPn9h3O7CX4/rcCJl3ClTju641
    uSZc/Rq4dnvie5Q4UXt5H9k4j+AdPCiFkTL2UeFhBdI1vU3kBC9+lkW3XHk0FYZsj/Z5
    OrLG/ochJdX2hJ+ZuZRt8HDxgtYST7SYzsOAlBgqiB6B0dfHPpTHypERaSJ02MsjYyZD
    EmqhtZCtRJ6U0S3QcO+9gQt6bjiDqrzAN0yUrrLfyW+ehiD6qic9mDLCov6GFhnLJdHU
    qyKjaLsqPrzLvA2D0rGSHBDxLeVSe72ck2BSWtSIYRva7ZOBQcEceSqIpYkb0Y41gJlr
    MKXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793610967;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=h7U24v9RAPoXbz3b8xUkhAPvQFCG3xrHUAG/FfglRQc=;
    b=pt+VmjmXXykj29jTNkLEpvGyOx9Qi5NzAToUjmOfSFeKDIRY5CrJ2o6FMt/a2Xu0lI
    x4CfH7sKBQ6AmHtYVpDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A29G6gZO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 2 Nov 2026 10:16:06 +0100 (CET)
Message-ID: <d87ad286-dcf7-47b6-9612-e8c2c547805d@hartkopp.net>
Date: Mon, 2 Nov 2026 10:16:00 +0100
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
Subject: Re: [PATCH v12 0/7] can: protect the receive lists with a per-device
 lock
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Norbert Szetei <norbert@doyensec.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
 <1e9a2768-e30e-4f2d-bc71-57550d210c0a@hartkopp.net>
 <20261028-miniature-smiling-leech-6d02ea-mkl@pengutronix.de>
 <ae276e09-2a2c-4887-836d-0ab0b7561f26@hartkopp.net>
 <20261028-positive-cornflower-partridge-3f822d-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261028-positive-cornflower-partridge-3f822d-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.26 22:31, Marc Kleine-Budde wrote:
> On 28.10.2026 21:55:02, Oliver Hartkopp wrote:

>> To me it is not relevant. If you would prefer the cosmetical roll back I can
>> send a new series.
>>
>> Do you?
> 
> no - it's only low, so fine with me.
> 

If we would like to meet this Thursdays netdev PR and want to answer the 
sashiko feedback before, when do you plan to send a net PR including the 
other patches then?

Best regard,
Oliver




