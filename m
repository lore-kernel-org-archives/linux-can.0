Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792513227;
	b=ANnG0Lg1cpUO/XYSmB9WcUYU3VG1pPfspUDxK/j+lCYqHpkYOSJ7WA+Xp6LYtCztuKl4
	 X4SGjh6FX1TuMD2rmRUXY6rsOrzxdflw2/74/DMRrDSbqaFqv174A2EoMjunrIT2u9AE2
	 YVcEg8ow2zrgy/6B/OVZ6ijd0vQHg774eWF1YuEauSV52r8mLYL19Nz30NLxAljAJnuEj
	 5eZ5CQ3+P9kbCOIMMikZtCpwe+wVTsFPRZ3engYTZSPwbhkGhJB320Vx72gWoHa+d+7iS
	 pwUUecntyzHm4x8AN8qB95/UIQLMHcmIELLuWe5EtfVPUABSidPnwWMMElt4O3DqI9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513227;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GRoGB9NhrtDuFk45/ynnsvabRomHrLHWAPk5WoIiboA=;
	b=JUGz8+KMux0CxXNyb+2M7D67esoyAJmItlomJS7yWFNfbepD0v9MqGix8Jy0JFtcsMPh
	 8gg/tTF+E1DYRLKhQ/ttpmh/HHjizPTgQn1LrmllO/aX8ms00clVSLYaukeTjJf/qHeAn
	 2RO6HudDMOAAj2Sw26Tm012FtPuchYY/B1eWm52sDlP5ccbUIpkL1N/4M4JsR1HaJif4I
	 Wt2NkILrupmYmPQ34AGJEPObTe6B6ivC1DwVSMoODAa4qiphT5l4PTmeEVmE+aDsM6Or9
	 VCgHuLyEqDjZpvapnmGkHcYfjQ/Iql8BPTypMjHJS/RuMXLXSJ+zGirRgjqc5e1+/KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=aSCRHejH;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="Fzd/WG9K";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8969606A32E
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 16:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8969606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=aSCRHejH;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Fzd/WG9K
ARC-Seal: i=1; a=rsa-sha256; t=1792513223; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YBEm1SYT9Bl4UenX7yCbwu5rfKAllRHeSOpUvhov/Xy8fKJsOQu1oyz6wnZLNvEeAY
    3sZdAkGxYubyY8GDq+x/BfXI1IJaU6GhL8GasUeXOBjGR6PaIqfeNL+fQ1PO2YVx4FuU
    byV59aUqQbm3ewdUQZ8Xshc30Rj7E+xgheKjpK51TNIS/0NPiQmhO3o1HyvxDW4ozNZ+
    wX/GA6go9bwxrDyTrvgaFo5y183B0To1QitSr2aKNYIQIHW57MfR+AmQ2FBlVbVpqMAd
    l9Bx2/nJvV8hDmoqoXA4MjJHd7NGclki11ATgu0JKTLk22O5e5VwRQvj7JtXt8PUha7E
    8mMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792513223;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GRoGB9NhrtDuFk45/ynnsvabRomHrLHWAPk5WoIiboA=;
    b=MjTZhxegAwRzVDc49GqJRC8cyIXiEw5Q2Iqw6jLIHzMts0SU09Bfyb0DnN0x8WSgj5
    4JdEOo/eQsB6n/VStpIZBZQZRIA2iQFf6nb/8aTCYR4KUvt/F5PsD3NigJQ73FhNh/62
    EZu8KzcfoGRM7Cvrj/HhaiGSJkaZbUCnfpm+N6pYSwLyqq2HuzrovRs5Y2C17HBGGlPs
    ch7az7u/CAByqthO3P93onsj6v5QmdRCgqFOOxdxA8QIYOPWe9WbkKGQ9cfVDVmXKexB
    0PDUoFmHIQQp+JXADx84XZlovsKL/s33Z3nls3PiynDoSZLsd94FNlhw+MHx/IxCZOrq
    4qiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792513223;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GRoGB9NhrtDuFk45/ynnsvabRomHrLHWAPk5WoIiboA=;
    b=aSCRHejHdPigTvB53eMyGpepHO/NlhT9RnSqye6syBDtZprvonOLMsDwJzrAL09A8j
    utLXx17YRImZOTG20U7PLSTbL28nVQKYa4yQ+okY/7diPMLxAb16At1dB8PxrUEKfc5y
    KLKoi77KnA+qADsty1FxZdIELS9FYaxsHrxaY7zY6KXi0rUI/uhH8VMs2E94w5B+Jk9a
    hNveKFGEGVpJM7xbCovruDlk1jJ94oiizo+U2u6s5a7J8WgYEChPPQ6Z+8wnbzZtiHzT
    IeBY2R65rLTQlTAsoxpsnXkTHRfbybxFGia3N+dyopDBnC0Xk9etPdNtyjfoY1Sj2l6S
    tWmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792513223;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=GRoGB9NhrtDuFk45/ynnsvabRomHrLHWAPk5WoIiboA=;
    b=Fzd/WG9Kssa7U5tB3p/8VL/MtLdvVJ61uV+fAdEoHEkzz9SCUPO7JuVXHiRGe+AE7k
    jAtgeC9L4+R2kUvAPGCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29KGKNcfy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Oct 2026 18:20:23 +0200 (CEST)
Message-ID: <d23196e0-6307-458b-ba31-15f54ef46b73@hartkopp.net>
Date: Tue, 20 Oct 2026 18:20:22 +0200
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
Subject: Re: [PATCH can-next v3 0/3] Introduce diag support for CAN
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Filippo Storniolo <fstornio@redhat.com>
Cc: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20261020-funky-buffalo-of-progress-fa4bf9-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261020-funky-buffalo-of-progress-fa4bf9-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20.10.26 17:50, Marc Kleine-Budde wrote:
> On 04.09.2026 16:12:54, Filippo Storniolo wrote:
>> In the current state of the art, it is not possible for userspace to use
>> tool like ss(8) to query open AF_CAN sockets.
>>
>> This patch series adds the netlink can_diag interface for AF_CAN. Userspace
>> is  now able to send a netlink request to request information about open
>> AF_CAN sockets that are retrieved by the can-diag.ko module.
>>
>> Patch 1 is a fix that is mandatory to the correct behaviour of the diag
>> module: the field sk_protocol is not assigned during `can_create()` instead
>> of being assigned only in case the CAN socket belong to the j1939 transport
>> protocol. This is needed to the correct filtering of the can diag module.
>>
>> Patch 2 introduces a list per network namespace containing open CAN sockets.
>> The list is protected by a mutex.
>> CAN sockets are added in `can_create()` to the list and removed from it
>> in the `release()` calls defined for each transport protocol.
>>
>> Patch 3 is the core patch that introduces the userspace structures to query
>> and receive netlink messages for CAN sockets and the actual CAN diag module.
>> The latter will use the userspace structures defined in <linux/can/diag.h>
>> to filter and retrieve open CAN sockets.
>>
>> In the current implementation, every CAN sockets in the list is
>> returned to the userspace, however a filtering could be implemented:
>> Userspace could possibly request only bound CAN sockets or CAN sockets
>> belonging to a specific transport protocol (raw, iso-tp, j1939, bcm)
>> and so on.
>>
>> An example of the output given by ss -cpe:
>>
>> Netid                     Recv-Q                 Send-Q                                 Local Address:Port                                   Peer Address:Port                 Process
>> CAN_ISOTP                 0                      0                                              vcan1:1110                                          vcan1:291                   uid:1001 ino:50324 sk:0 users:(("can2",pid=9210,fd=4))
>> CAN_ISOTP                 0                      0                                              vcan1:291                                           vcan1:1110                  uid:1001 ino:50323 sk:0 users:(("can2",pid=9210,fd=3))

The fact that the inode number of the socket is visible fits great to 
the upcoming CAN procfs output:

https://lore.kernel.org/linux-can/20261018164417.1540449-8-mkl@pengutronix.de/

But I'm not sure about "Local Address:Port" being "vcan1:1110".

A CAN-ID together with a CAN interface is a unique "content address" to 
identify the content which is in the CAN frames data.

I assume "1110" to be the decimal representation of an 11 bit SFF CAN ID 
0x456, right?

Having a CAN ID in decimal representation is generally unusual - 
especially in Linux. Additionally you can have 29 bit EFF CAN IDs which 
does not fit into a 16 bit port value.

And 29 bit IDs have to be marked as you can have the value 0x456 in 11 
bit and 29 bit CAN IDs. We usually do this with 456 and 00000456 to 
indicate 11/29 bit IDs.

So the "Local Address:Port" output does not really fit to CAN here ...

Best regards,
Oliver
> 
> Nitpick: can you remove the most of the spaces from this output, so that
> it fits better on the screen.
> 
> regards,
> Marc
> 

