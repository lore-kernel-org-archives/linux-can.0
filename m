Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792618378;
	b=foT6gUJ8j4qqSg87pL/fEyEl+Dztk+EOvvOUNSNPNDWnqPi2aWsy6jWF8NGanAy2m3Og
	 yI2Et0klbd65K1ZiXeD6v8yNLENE8MHgy3RUtMZxCvOynOUfbBdgCldvJ92UvOEnOMlEu
	 fCPVdqHpgjSi1JqDp3B4FO8Mds/1RmpsKw6dZLdJ/gOKYXDA46xj4lT5Ff0utNwW84WBX
	 bdwA2xYVBDjdPrbEXeOzxeC6QpPRLcMH4TX3EjNEtICNOfEjfIEJcMzHyaMIZlbQKz/zm
	 5bZ4lfpZVNcKILvQaK4xsae3yJxMlVMpYk6arDd5AMBX3Ss0p/J1u0JWJ5GTuhQEDMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618378;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xwU2SfY0Q8d1+HiM+8ex0ddmG1xTJDRo5kisKy1knic=;
	b=BMNtnlDBfh4XLzMbu74PLTD8KaXJDwFK9BnmP9vH7uo+7/IoKHWTdOiAysWCbFL5ClZc
	 b4/8VSTlQTlNQYb0GCyRqFbQGaCZnUfQjsKq3l3f9cgR6VxxBCoIOVkK1rc0MIxv1sglb
	 BSEK/KZpLipbN3z9q0nYIYAWKvDyYBZpDadv8O69MxNo5bxckZmFlkugEQE6BqchpiO6T
	 det0wPkQCi8gjNDod+KNjdbTSkrYl1AkamZFEts7sA6UvSV7uE5tEA7KKkYPTPmDPUfHp
	 olW7zU8frHt8mu/cKWLjbnQ68XeMaW4fFjKxkR4pWL2tJBhxup2j1IYbxEdZGBpt7mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KjFvS3b6;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rWRGoOtV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E70606A319;
	Wed, 21 Oct 2026 21:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75E70606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=KjFvS3b6;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rWRGoOtV
ARC-Seal: i=1; a=rsa-sha256; t=1792618364; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NajqIpY9ZmAIUgA21N1lSc4b/eFggxalsOrujxoUMw7YuncYRZe5po53fq6x0JoH6b
    UeZ/2RDNhx7/Rtxme4lBAeiFsqwvYKGhGDNVw9+VnLR+xlgtSONazo+OpT4+tijxYmnQ
    kWhfsOL4qqNzt2rObmI/R/675K1YVEFXYcbTD3IhTW8hos9+g4A20donTpxx6DKNNshm
    wNkkHOaUSGX37KMlDTUqrFXaU1gRnGMEyNxg/P9nPnegD4OTS5LcZJlfXjx8gCJ0XNfq
    3HDy4ZyLcmLnJ/WHpFdTwJdJVNQKO/wL/4K57ZEw9aB5kv/IvXrr1xwhlGFMmqsOoKbp
    FIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792618364;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xwU2SfY0Q8d1+HiM+8ex0ddmG1xTJDRo5kisKy1knic=;
    b=RkM9segz0bFSvmRVayLEnVnMPgnq1VUColpN3P4bgK2DDoKF5EMXikCaJaTVoJvSDe
    yfi1T2zw9p3A/QL8xYePEyH+WobyyHYOem0tFNr/7P3Opd94SYUYlkX0Kw3h37Eo/IR9
    rYh9X9aXe34CnDPihJP5S/Vk5xmTM3ocFHa5Smhp7Vf/ziAoDEXABQNzO9vlTDKnQBeg
    V2+qYn4tkv4tVtMvPi4ZohUifhNA/R1Yv3nWcBRV6ejMMG0gKN7fWKw7CcgR0gXiOWIr
    LVJkwk1Xn3MYOJeuQi+k8c1aeZBjMguZvG7Yv7x6O9McE/iqJrWL2uCcjE5nMlq7k3yn
    WaIw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792618364;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xwU2SfY0Q8d1+HiM+8ex0ddmG1xTJDRo5kisKy1knic=;
    b=KjFvS3b6PZvGwC91fMjEKPoCm3CYZziEYKrhPoujuRhiPx5u2mN/GvfmcO16iScELm
    fvzL6X9Xi/T1Y0iCI2tlb9r+z50JG3hW5rm0UlnbiWZ/DjqusuKRbhT0kS2n7Aa8EmR2
    TBTGQKHRKRsQhUG7FfzNqoVJeyKpInReKJfoPw/4WOF2AOIf9u0IEwPPtb6tLIbGiilJ
    aptEaxiEwuIlFbArc4SHWcfQiDIVRW9rj+X0T+7OsbRr1gPnYSkhUtdLnwTwdKsqdu03
    guzv2N7+czaEMZfmPbT745s0Jo+co52yWeqOQtCFWTfmDfAhj23oy8ewUjw7nNBXkorG
    +jMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792618364;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xwU2SfY0Q8d1+HiM+8ex0ddmG1xTJDRo5kisKy1knic=;
    b=rWRGoOtVL2ax2JouU6Fk0tm57/c24oA8aKg2Xi9Vsd5DaacDBJlTG3Qcm0pjSCwxNz
    UvfRp7J4odv4SrPuy6Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29LLWil0m
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 21 Oct 2026 23:32:44 +0200 (CEST)
Message-ID: <aa9f71f5-7880-4b95-8b92-6b4610d68478@hartkopp.net>
Date: Wed, 21 Oct 2026 23:32:38 +0200
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
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021102756.1900679-1-mkl@pengutronix.de>
 <313fdacc-a8e9-40b0-a125-2317ffaae79d@redhat.com>
 <37e1db71-eaeb-40ab-8589-099f9d5611d9@hartkopp.net>
 <20261021135631.7c9884eb@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261021135631.7c9884eb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.10.26 22:56, Jakub Kicinski wrote:
> On Wed, 21 Oct 2026 13:33:38 +0200 Oliver Hartkopp wrote:
>> the original PR is pull-request: can-next 2026-10-18
>>
>> https://lore.kernel.org/linux-can/20261018164417.1540449-1-mkl@pengutronix.de/
>>
>> and I had to fix some sashiko-bots reports that didn't show up in
>> previous postings on the CAN mailing list and its LMM.
>>
>> So its really just a fixes version of can-next 2026-10-18.
> 
> Right, looks like fixes mostly. Could you please quickly look over
> the feedback on patch 11?
> 

Yes. I'm working on it.

Thanks!
