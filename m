Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793220939;
	b=e2JbU26DfMUrQ6X99zNY1vDIebhby/bI/E07OWeAgkj56PpAWU32NRBaPMn95sb1ObHW
	 6/p4FG06om268B+v5W33BMzTkQT9vWSyZunJStO/hJbt98QPiTAZNjjh+tXa+w5moGtro
	 o1N4JBQ4DuCnoGhIsVcRipPwXGOmGBP9hSpPLeMV0uXDR7RbW/r84qclXnn1DXKnL1zEK
	 JqrRd6XWqSxfnaxAFMisHWnF+M35I3aOBQtgIPwlVOiJ1qAxYws4yZvlODewY5y9J+UI8
	 z2ciXP1qyUvD3eAWOJ8JFFYd1aUXrGi5FO90u4EZsD+MYDXE+40sIrtE8IYMzFS1qAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220939;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cHq0q1UEI3nf6g9nWwga54MtsCLsxmnTNGgRwDtNlv4=;
	b=GciCVw6pv72JRTOxuEtiKxtP9YAJZI3tmq+S694O9TTigwicomfmG63+R6ybzTkski1h
	 AGMH5hFiO0T6XBzS6rQm0zIZvQpEEICAIg6Dkn+GwFDhQSa59iQPITjGy25ivKPx4N8Z0
	 ZogqNLlZs6/QuBIe9khbNkRRJjrq96nINJ+o+OiS5PfrXyAxUMOgVNajp9XQrbCQMPO29
	 kv9EMc19QD/7OPcbogOAMFc544WmDqBN7ZqqsTI9/qFEVQMmQvN6qD5ZBVmCmbf1ocwPV
	 LQNxdxaAkV4jFizsgyuusBnfIxh8rMfB/cbLLCsdLY9GFE1lFO8wYcONezXhFScaGCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="mi0u/M/P";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=weNV4DQ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.25
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD9606A32C
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 20:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EDD9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mi0u/M/P;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=weNV4DQ6
ARC-Seal: i=1; a=rsa-sha256; t=1793220908; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jFXc/oeyNal7w5V6GAl9FXMn5Dq+QJJBfe9TIUj63wjmJBboKC2ivbTAGjHcFDMhz2
    eAoAmGL18j6UeVKMaoD8OKQgcK+x1oNRZmQgSnij8BMWKbixt6xQxAItl8zpxsLYSGIT
    UtxoTzVyCCWHO5ezvliSGKLkkZJRt6ty38+2PfE3RpnZ+XRMdeO2/RDnzyA4jiIomTLM
    KBH8uDnJ0KTohvbrkqLgD+WOu5dYB6yu1miCYX0aF5sam+WeJL5aRN4uuNxHlab4Hof7
    jQGQZU0WAySsF8tcA4GQZ2bUMiCTOQQSFHvO1dGcWvH0doTVCBPgwSq2HrFbLh1gNmTf
    kLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793220908;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cHq0q1UEI3nf6g9nWwga54MtsCLsxmnTNGgRwDtNlv4=;
    b=IZtVf1B7LR4zowFVYlw22q0JsmESLAAieN1roHPqWLMXvWKMtTEC4yOe9DljiKbQkH
    g1zVIHXjIw+3O9LurNNAzdu73OC7qc3BH8CCvHNYtBd7ksAuSFZuXz2H3/SdlQzfgkqE
    +V0GH0+BOOr4u73X29vGzJrPEquzX3DNytP0nTxbWbRqMHqjwlYm4EOATkxm0sJ7tYQK
    f1diTx+Jw73FMPvU1nn5P5nvNwKwJyXBirmXquuRQIuck6ES4Qu+XdP6vpdNleCybzEL
    65gujC5DD4tJiFdPuBC0gbYYbvKxI5yB/CN+FB5pWO9//jSFbhKgUef4xlxHH8GVDbwP
    eDNA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793220908;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cHq0q1UEI3nf6g9nWwga54MtsCLsxmnTNGgRwDtNlv4=;
    b=mi0u/M/PNhfuDOIjLhqNfrPYk0bMQSFqRCigwBL0koOFDwNiv9a3izOx199YZ/OuXZ
    3aWLooMq0UHjaakFSrmquKU2TF79ZtKDLKv+8c9mu4L44FO13db6BPPVS6eo+9EKFOrV
    zvzDvNCUWxsHl/5S3S58Z4GmgnMYzM+C1E6S7FA+CMy9fH4g46bWzSw0O/RCw1HA4xL0
    lFeLUp0ZRMaR4fxcnEkx5qDTmKrcvEXXMfo9G4b9AVKx3M1g30zt4mn2qCHcn5Qe24VK
    VrOP19mW6ZUBwzwpo+UDMEXi5ESjqqltbngSsrK0yUNfRVX+wjLARXd71OMVhpOTPGc0
    3lOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793220908;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cHq0q1UEI3nf6g9nWwga54MtsCLsxmnTNGgRwDtNlv4=;
    b=weNV4DQ6wt5X1CboYIyozASdY5TD69xUzL7Ce9vDsi0dxEjiz33DtsUYmkXDEQLpt/
    ZBA/xJ5LWlLHfREZArCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29SKt7M8g
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Oct 2026 21:55:07 +0100 (CET)
Message-ID: <ae276e09-2a2c-4887-836d-0ab0b7561f26@hartkopp.net>
Date: Wed, 28 Oct 2026 21:55:02 +0100
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
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261028-miniature-smiling-leech-6d02ea-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28.10.26 21:51, Marc Kleine-Budde wrote:
> On 28.10.2026 17:36:26, Oliver Hartkopp wrote:
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-can-rx-lock-v12-0-eb5afc2d8b9b%40hartkopp.net
> 
> Seems clashiko doesn't post to the mailing list any more? Did the bot
> reply only to you?

No, I was polling the URL until the embargo ended.

>> The remaining Sashiko findings on v12 are either issues that are fixed by
>> later patches of this series (as Sashiko notes itself o_O) or pre-existing
>> issues that are not related to this series:
>>
>> - CAN_BCM and CAN_J1939 also copy user space data under lock_sock(),
>>    while their netdev notifiers take lock_sock() under RTNL. This is not
>>    a new problem introduced by this series. I will look into this later.
>>    It does not affect this patch set.
>>
>> - The user_reset in net/can/proc.c is denoted as not network namespace
>>    aware. This is on my list for a separate can-next patch too.
>>
>> The only new finding is that isotp_bind() keeps so->rxid/so->txid after
>> a failed bind(), which is visible via getsockname(). This is intended:
>> As so->ifindex is reset to 0, there is no interface and therefore no
>> valid address. The remaining CAN IDs only show that a bind() has been
>> attempted and failed. No need to reset these values.
> 
> IMHO a failing syscall should not leave any half set option. You're
> rolling back so->ifindex, why not roll back rxid and txid, too?

To me it is not relevant. If you would prefer the cosmetical roll back I 
can send a new series.

Do you?

Best regards,
Oliver

