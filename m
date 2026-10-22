Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673270;
	b=Lev8C/Sfrj00VipUYwxqksVJ6FL8ZtWLEGIQu+df18+15e7XL2v8aLrlifzpNZcyeFSu
	 4xg9me7aoORh1c2Oo7GJFvHMLJRWVVmFF0hzbPIVagnmGEZX03bWVQtq0SyO25tqCaR2K
	 /k5ThYcWfMCW5MlRrS5j9D9Bku48g8rF1RhCYx1vw2UiFzZZJmIvq+o6vXIEUMRmzhfBM
	 BCJRI6otYcezxSWEXaLrpV9GbBws2BZLIuMOdj8vbVD9KSkhiwT2DkkKzQHirz6GxSYja
	 CiRyPqGJhsO7/owAjOFXV1x3uNCaj9vz7aDxytB07G2i3OHhJnxDy+rJVSRuGGRLKSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673270;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=knmTPdSDWxbSo01ERLMzHjnDCwtfybqi3/93JrjvSpg=;
	b=M1THxqQMajYlAXfUS1X6q1pccYS8TL4ulL+omgNvJd+vepjSsd3xCRh9I9dz05sNoj0Y
	 QGUg7/f0ZeEzw0NwPOIP1glIkRzr2qLNMdZ5feEet/sqXpWSyltmAfEMFIybocPRdhxD4
	 TdXHjgCiZ4P3kaGFe4wLrTBkgSScUDbEftjJqAmln7yADBes+Si1dkziG8voTDt7hepMD
	 N6O7DkYWQENA2/vSRvBgc5UbK8NUBp9r57HL0v4Z7+4LEdNOyAo0PCVZT6CucXJMSD8lM
	 ALFCeCpFgX0YcFEsTpNHF0i420uXSbBn0aNtzdOHOAEfTqbm9IS2l/0+/MDdYVC/ZaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="aKUa/bJG";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NwrUaG83;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8859606A31B
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 12:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8859606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKUa/bJG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NwrUaG83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792673269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knmTPdSDWxbSo01ERLMzHjnDCwtfybqi3/93JrjvSpg=;
	b=aKUa/bJGvKUDfqIbEIQMHvmW56C0T0v6AU4DjxSmaL34C03BHBvShsq22/FFSQUIwByqOA
	0jbMl38VAIUeTlFcHaYx4QhPiZ6KTXXxmdpkDIsxDidtwpc/gx6fs2BLG72VFsOhoXg1vF
	3pHJtAJ+iJYvivZ2J/LFHxgP/SyaQH8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-WFTwrojxO-2rz_8utXKspQ-1; Thu, 22 Oct 2026 12:47:47 +0000
X-MC-Unique: WFTwrojxO-2rz_8utXKspQ-1
X-Mimecast-MFC-AGG-ID: WFTwrojxO-2rz_8utXKspQ_1792673266
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so1075426f8f.1
        for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792673266; x=1793278066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=knmTPdSDWxbSo01ERLMzHjnDCwtfybqi3/93JrjvSpg=;
        b=NwrUaG83jbWFrqnQu/YcUypkM8/sZ6PVE2zAiyG7lltsynKLGijmKSFuV98vnQvc5/
         FXYTQ4v0sixejO3NdShq8G8kluFCAioZAGIokPSkIUvnYRhXx1VRLKIvwR3QFHapG39c
         WTxuntCzeowy3iIMruugR8Heo1r6vKJiwIXXqsBJ+DDBPfdetwhiTxFtmaKDD13fmlz5
         6/EtCRp00L8ba/V18qeZvcWpLTGkGsWHSBUwhcz9XrFk1QK1s2RfumC/B3sKzti1zn4v
         FHP7PM6wFeM4wGHx0aIVE5wxc+u1flROu+toAK99KciJddYpXQhPihw/uR2eeQ0Y6/Nm
         fIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792673266; x=1793278066;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knmTPdSDWxbSo01ERLMzHjnDCwtfybqi3/93JrjvSpg=;
        b=oeHY96T/O9u8oDzfdqhAZWWQo875R6qEfI2YuQ6JuzCxCM0im8LKCkmf2YxEQCqkm6
         2v9rhV2QNXPby4LXONMB/A5jZDEJ74pA7Y2UdfnTaFEw3wuNTBZ3AwgYESZKFkq5jkKQ
         Ts5ToQVcrDszP/WzTNdo3BZrdBwPy294bbVhco7tFrkiOECOKNvLr7B+3swGdR6qGijy
         h6MB9RuyX9i4Qp+vRpaUS4LGTOzvKtF+bolP3AHjJhf9RUdlIlOhKAnavVwvSZB/B15N
         1/vmB9i0vUoxpKu6WA77JQywtn41zonyoeQI8620M6bRr3PQ5gG2z2wKg4/rd2QDUjAw
         V2Mw==
X-Forwarded-Encrypted: i=1; AKwUvBxi1stOq8K6LduWJGAt+zPzk0eRtPxxseUc8+WbzG8bMfe0qPeATkse1xfWG0RXRYtc1zFms2WgQNI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK8rztvIZdfPormnLaaf3CrKQPk679mJ5oB88+CafR/6p2mOT0
	Ulc6/LSzEYqle5GsUVpKlDSj7sJpSFvA7GNHt8+vpSl5cS5l9HOi4J4OenYVcPWKc7cHeaq9pjN
	aQ4Wz7NFJiYn4lJFGDW2NPx7e8bps2eXlBcNi/e7+t93vMKSIqEuSRLdi5ZD/dJfvTnEWfA==
X-Gm-Gg: AYBFou14xxzeRzZFY/dZ7Z1c/hM93bykZ6L64L00CS70lPe/jR66iYhKxcBxF/BAN7u
	sVmXdCkp4Y1jY3lyN8RRR0zcUe3PVwEDeQ3JtoEA5de85SsoBqZS0iwtIfYP6b4vq1oOzSmBVZx
	O6BaYPEsSfm4/fVGc1JUGpcoXoxGLzkpcZeycUiM2Z/+D1EOHmmJ2UOzfwDCcudGkCnNtt0WxQd
	P4qwSikOmMJgvWfpJ4dvJuRQ57MXZbJs2X9BqvDu9mWoiXccL3I0zj5nXkf2sJQie0A68al4PhO
	Mc+UoLYKwUVMNHYK63fPhdY7F8msxaOj0ISDaHkpL8fcwOEXjpIdC43LqYUIzClgUfvZdKwcZdk
	YGYOdEz7l42aa553uVyoOCuvKymjECXqd8krbLhdYVZN2Ovi0GrDa8EBhtPMMy41eG3ysGQdUBg
	==
X-Received: by 2002:a5d:5f05:0:b0:48d:f14a:917d with SMTP id ffacd0b85a97d-48e264c96c4mr10362144f8f.16.1792673266276;
        Thu, 22 Oct 2026 05:47:46 -0700 (PDT)
X-Received: by 2002:a5d:5f05:0:b0:48d:f14a:917d with SMTP id ffacd0b85a97d-48e264c96c4mr10362076f8f.16.1792673265657;
        Thu, 22 Oct 2026 05:47:45 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e2esm11945581f8f.30.2026.10.22.05.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:47:45 -0700 (PDT)
Message-ID: <51c656b8-2801-4edf-bbb8-f5e4309e910c@redhat.com>
Date: Thu, 22 Oct 2026 14:47:44 +0200
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
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021231130.2085690-1-mkl@pengutronix.de>
 <eb3b2eee-3460-4b03-a180-1d3806a7f8f7@redhat.com>
 <5fdffd4b-7f80-471b-93b3-706c00cb51da@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5fdffd4b-7f80-471b-93b3-706c00cb51da@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 13:19, Oliver Hartkopp wrote:
> On 22.10.26 10:37, Paolo Abeni wrote:
>> On 10/22/26 01:07, Marc Kleine-Budde wrote:
>>> Hello netdev-team,
>>>
>>> this is a pull request of 11 patches for net-next/main and obsoletes
>>> pull-request: linux-can-next-for-7.4-20261021.
>>>
>>> The first patch is by Vincent Mailhol and drops CAN-XL frames on non
>>> CAN-XL devices.
>>>
>>> A patch by Sang-Heon Jeon removes a redundant NULL check before
>>> netdev_hold() in the CAN RAW protocol.
>>>
>>> A patch by Kaixuan Li for the CAN ISOTP protocol improves the check
>>> for the correct CAN CC/FD frames.
>>>
>>> The next 3 patches are by Cunhao Lu and make CAN skb freeing safe in
>>> any context in several CAN helper functions.
>>>
>>> A series by Oliver Hartkopp et al fixes several problems in the CAN
>>> net-layer:
>>>
>>> 3 patches target the CAN procfs: A patch by Runyu Xiao resets the CAN
>>> pkg_stats using atomics, a patch by Oliver Hartkopp fixes the stats
>>> calculation after a statistics reset. Followed by a patch to remove
>>> kernel pointers from the output.
>>>
>>> The last 2 patches are by Oliver Hartkopp as well, they convert the
>>> unreliable ARPHRD_CAN type check to the robust can_get_ml_priv() and
>>> protect the CAN receive lists with a per-device lock.
>> I'm wrapping-up the net-next PR right now, and this will not make the
>> cut. Still all the material here, after forwarding the trees post PR,
>> looks like 'net' worthy. We could merge it afterwards.
> 
> Thanks Paolo!
> 
> Yes the patches are indeed mostly 'net' worthy fixes.
> 
> Unfortunately sashiko-bot complained about something new in my patch 11/11 and suggests to move some release_sock() calls 4 lines down behind sk_error_report(sk) :-/

Talking about the obsoleted version, right?
> Would you like to have that re-spin PR to be named as "net" PR ?
> And when would it be best to be sent?
No need to respin just for changing the prefix tag, we can apply
this one to net as needed. Generally speaking we are trying to
avoid unneeded reposting to avoid nipa resources overloading.

Thanks,

Paolo

