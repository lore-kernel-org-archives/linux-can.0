Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1D47CA7A
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154469; cv=pass; b=m2wjEw4baO5Yf//2hNcLeqO8tPH9tb8IjykpgP/e04TX/CghrAGYrkCToLcsy2/n9ehNQfLMGcuFfrJRvSVTJ5KgMc1v/mKhgWgqZL/f9DVkQYihrtbXeD5xoLc1LZqvrBu2YdGFmvJl0OaJN1xMDoRoH70dw2spGsktHri3BoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154469; c=relaxed/simple;
	bh=+tK7H/Zm6LgGuRIEK4THFuY9B+Y+pdRgbqTkF800OoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZGNB/Oc68l30p9zUxu9e2eEKQ+AneNXHfmUQF6aLoc8GLkbS0V+q/ixXabpXYK/tdL91FaJ3DwPak+om6h7sok52KjmXvqxnlNIqiOi42sw5peZz1WH8Vv99z5CXIvnRz90uWbKaMh+EvSCESWRZMrN+NLmDU5N3RSqUzWdeAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GIoqyCwz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1KGfoDG3; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GIoqyCwz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1KGfoDG3"
ARC-Seal: i=1; a=rsa-sha256; t=1792154455; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=N4vsqWRq1wt+nolmxKeLmB2cH5+biuVU6Ix4bVU8UZTX4QNtr6EWuB8JIOLcAPqu4i
    tbgeEltUaV2UMNWJzogHwAgNiVWrqd8sOo4+8Ing3hVJAQfT24s+ktHGQTIk3vmyNY2R
    kDwWqhVDVbt63yY6Mpd7IvvLlnFI4L3rfmhLE7bjzI70oj3XY1wQYtMD08SdF4NXrpXt
    wz6MbUIGaFenVEMn5aaNYyqrKpXdkZsVebY5VeCL5JgLuIhCHGONAer3i3a5Gy9O67Pe
    wgNDyuK7NbFsLYbYd81DdHQjNC8Ya65pK5aXyp90V7Aia326L/HPgNwLdjJ0o53nJJxe
    h43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792154455;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q7SySBlCpkZ9vN2XVJZC6nEZNgpb1VEG4CJUSfAj19o=;
    b=bgCbh1OvWwd6CLUirdEHBtr5NTLo/MEzMSFtxOOc9KYATFBmc8ndUGnKQ88loRoRTt
    /n4yWWAcPj7SJnSgO3nVM6zo4dTUKFRs8BXiY4Xd78YNDDmq5+yoQgErhiGu6f1wcUIk
    oss5VDWIFIlojAkUWJ4iHCzbrIc421+kCvDZkWtTHMiXoRvtCEjRzBvQe2mmy5lKlhHZ
    syXbPgGw2xCyBYj6Z4RRvH54ei9ghJrs3raQMVtL4Gtlhvy4xUF67VSISK7dQfPlJcYm
    qvDNQXUrVRDUdSv6ZFw0ESiFDFArtS/K3zYiuWowLaOCXi5CCqALBseRjAlAt7ff2PvY
    aPJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792154455;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q7SySBlCpkZ9vN2XVJZC6nEZNgpb1VEG4CJUSfAj19o=;
    b=GIoqyCwzTdTOMKfZPRDbcJtRUX4griRAd7yH7Eqdf+iEtceOf+xLzlitY5EFjETwcx
    3hB7J8qlSfMQRZ7cdxEVCDFCGeBMhBOEa+1+Y1YiLOoc1fZSK9HAzamthH+8B2pxeLhs
    xSVsY3wPm4vumbhmezOwVWtqTt+qLOmnOnNRTffyFaK2hsCUxrxFImgyaiNNymBpmhZD
    HIrEV/aoMFAHjj6lsDtZur7BM5vjwawNBOzulLpX44diOsu5gixwd3RONz1wG81ma9Y8
    DldRvpM7cuB7Q0BxONotQzI1URkRm0TuhdOml8pKM+o61/Fz8l42faymuNiTdI/mVeag
    bdDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792154455;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Q7SySBlCpkZ9vN2XVJZC6nEZNgpb1VEG4CJUSfAj19o=;
    b=1KGfoDG3e4+7WpwePAAfaObYwAdzg5n3P6bha2zv6PTDi/1b8gUdCAiuwW9q9vhiz5
    gHNxaKMxay/tUzjDSsCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GCetMMg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 14:40:55 +0200 (CEST)
Message-ID: <6aadd4bb-75a5-4ee1-bacd-704ae5a036c9@hartkopp.net>
Date: Fri, 16 Oct 2026 14:40:54 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v2] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org,
 Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20261016093525.327367-1-socketcan@hartkopp.net>
 <sashiko-outbox-174104@kernel.org>
 <e71563e4-2d8d-4302-a9d1-b0dc34fea3a1@hartkopp.net>
 <179215290023.1285626.1847782701765808982.b4-reply@b4>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179215290023.1285626.1847782701765808982.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16.10.26 14:15, Marc Kleine-Budde wrote:
> On 2026-10-16 12:02 +0200, Oliver Hartkopp wrote:
>>> [Severity: Medium]
>>> A few lines lower in isotp_bind(), the return values of can_rx_register()
>>> are ignored:
>>>
>>> 	if (isotp_register_rxid(so))
>>> 		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
>>> 				isotp_rcv, sk, "isotp", sk);
>>>
>>> 	/* no consecutive frame echo skb in flight */
>>> 	WRITE_ONCE(so->cfecho, 0);
>>>
>>> 	/* register for echo skb's */
>>> 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
>>> 			isotp_rcv_echo, sk, "isotpe", sk);
>>>
>>> If can_rx_register() fails (for example, returning -ENOMEM due to a failed
>>> kmem_cache_alloc()), bind() will succeed but the socket is not fully
>>> registered to receive CAN frames. This leads to a silent failure where
>>> user-space believes the socket is successfully bound, but no traffic will
>>> ever be received.
>>>
>>> Could this regression be prevented by checking the return values and
>>> propagating the error appropriately, or cleaning up any partial
>>> registrations?
>>>
>> When this patch is applied isotp_bind() can only fail with -ENOMEM and
>> nothing breaks. The socket just becomes unusable. And if we have -ENOMEM
>> we have a big problem anyway.
>>
> 
> Please run "b4 prep --check" before sending patches:

I'll use b4 when I start sending the ISO-TP CAN XL patches. It still 
feels unhandy for the reactive review traffic to me.

But I missed checkpatch ... sorry.

> I've taken the patch and fixed the checkpatch warning, but I suspect the
> netdev sashiko will complain about the missing error handling, too.
> 
>> If I would provide such a patch the proc pointer removal patch would
>> break next.
> 
> I think this is not an argument for sashiko :/

The check of can_rx_register() in isotp_bind() is neither important nor 
urgent. I'll address it later.

It can not be the right way that important and urgent fixes are delayed 
for weeks when sashiko-bot finds some patch unrelated pre-existing issues.

I generally like assistant systems (also in the car) until they hinder 
the intended operation. This is like refusing to start because we have 
freezing temperatures.

Best regards,
Oliver

> 
>> I have ~20 patches for isotp and its CAN XL support. I will add the
>> isotp_bind() error handling there when these current (can-next) fixes
>> are in mainline.
> 
> regards,
> Marc
> 

