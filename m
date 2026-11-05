Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866825;
	b=QMyN28lnJQ216Mq6dAjffyYSzr0GBxktW9d2JE7F2GCImQDZ5DoOs9PrnywJViPQuPJG
	 dGCGDwiMvYpcSXZzfArpZT6+Rcg2QRt7IHXzTZvOnh9xaXL02DWHVAA877D+30v9Vc5xK
	 ghk6nXcrHf9DgOqsuizk42DXNegpvHGnBoIqtMi91rwnZBMz5dfC4N4TlpEPOK3NcPYgL
	 Qh3SEtoiEo6kPR0Cf6CdUj91uA+iXUs3wTLV0AqL0DNBD50x9uHNXxLXPdkhEvs/y1JJd
	 4E3B2sm8nXpLLrlIktLcegiZpIvs4dVMHXKfpaBPoupRsSFmUcBHWymtgVHYDmaaWLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866825;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
	b=xPUX8FHEqM9OLtvJbvhs12ZwK0+50k6u2DwI1ppi+j8LYvGSqHgXRgrEaLNWwSDD9YTZ
	 46ZsXoCkWQT/7AL4KYixUApS14fV2mJSEx8xNDwqyMUIt2+zY7C01ep89/ZkCpy3czDiW
	 9JSmeP1zI/sXY2y03Vkkk3QkKkQkC4Vj+oRG0gsilO7zkusskZONiMi6os6KZ77ylbNhI
	 gVfnCVRKLck0Pi4/Db0M8UzyLLF+UspqvVX2KrZpx7p6OysJMMln3zfK5aWw3wqNZF02z
	 BhsHFPVWVMvdoSjEyR/8zkUo2JO19WWavzKUyuGV5oR2oUs4TgfSHg2TJLFMOC7jN/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vg22TDiB;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ERqhG0AN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC03606A326
	for <linux-can@vger.kernel.org>; Thu,  5 Nov 2026 08:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC03606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vg22TDiB;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ERqhG0AN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793866823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
	b=Vg22TDiBJDnhHbZ7Pl+180HoaGvnB6m6FJ/VAyyBrGllE5U9k98zt7uvvlaS9OHHnC+fHJ
	81Y19u7SE9PSwNqNOshnxrw5OSv7DPCenc1H3pRKFQX6Bze60zQIj6RMV+PrbJAI+QGZ2I
	B5si15YiNPV2taO1ODQFHgNyEz6Dtr4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-QZQQSCnfPzmRX8ZNV1oryA-1; Thu, 05 Nov 2026 03:20:22 -0500
X-MC-Unique: QZQQSCnfPzmRX8ZNV1oryA-1
X-Mimecast-MFC-AGG-ID: QZQQSCnfPzmRX8ZNV1oryA_1793866821
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso16848225e9.0
        for <linux-can@vger.kernel.org>; Thu, 05 Nov 2026 00:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793866821; x=1794471621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
        b=ERqhG0ANIDuOTgPfookFk2oMxGQOH4n7cdFFXkfT3zus0ZW3ZegBiBZDWA8JU52AMC
         LbWP4UAqvKvvDB9FSWz98JXI2uaIojfUamIG0nkq+ctWfbf7pD6WDG54tTTPv/TYR3xC
         cfIjZYSsgspQuVAzv5F23bQHC+o+PUE73xLOuBKhMlrDwUNpMuMFetGTaGGRWYpmDJJr
         qlSCCIqBy+kc63NOVVJYzqGC6Jm2g0mjftQrZ/lk8JGffS8Hd7dRWYG9cXFXgFjBkHuR
         tIgTLqfniAgAfw6qeUtfJS3Q8hv+xYrY8e7H1Ky0y/RDDVgpX2tLKprcibvix2o0jBOE
         hCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866821; x=1794471621;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7SqvBtUFCpw5NHA+FIMIJmAFl8K9I4MkTlXE+t2fvpg=;
        b=JWIFLh45PQmTLJj3xICV86/88QtaYcj6i/FeDNoSTlXqjXg11PHZzGtReo+2r9wWMs
         DBW851qU+cTXbtNmwoei8DnqHRKbjpbfXWNMd5Nt/pR9KxJCuciTcg86ky+DzQtfL4up
         84/197b/QBAdw3K5iWVsLhEvequAjdSYH/2PHXE+H2IZzojR1ElPagrj+8si3VrDpPaw
         Q17hDZ+EvhTPoow23Ze4o1Ni49SZqnlhF9aNrsUWygmroHoMcNNQ05ENNUC0G5YUA+jG
         qGIMqeGFdp2orxudapCGdKGU3pn+Fmczn0hIUmSSchE0gwKnA5WB9XLGpLQ8prpsNOwb
         Xiiw==
X-Forwarded-Encrypted: i=1; AKwUvBxKwbLxQMHK+Uym1iJr0rPhMnVs2dmo657CbUrXOAtoitwNJQJOeQCA5hPWR2lMWgEYMnRAMe6HCSI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yXd6e3REwAjDMgAkKNE8zhkn7xWsoHYOGvlFZ6BZZqq5ZLJ1h
	sQFyoj7AH1wN1Tn2UBrbWImvMzi4z8RWKzZmkdnTKHC1me/eWGcZj167j1Ykl6qJFNa5sqtOQC6
	RSbjtLKq+GVNtsBL6IUE420jDRcbD3vIzknAOR7koX9fb151i5hQV/NNDDVirDw==
X-Gm-Gg: AYBFou1lLjzOLpGe/Z95tlwT2ltBAYW4dXB0vhMFkmovSj5SFxEwm+eawSoxY7ZRG10
	ZBwSkAM9SCygdf4hv9hCC2F1QUxHWS1OqKA3Zzntbqxlz0h2YFvMoTHKizViqqvrVeg2H4cTNGm
	UdctBdgu95AI5I+eTtAtd/gHZ8grziilUoH0OQIXzcs2krJ+OLQvQRyjDTYZ2XEleDulsGInaAa
	g8C6SwtxJKhAjeocNscW4yh1StHD3cijKolhxPEDIAQl/rfJMV6YlCw53vM4hyePikiqBwS17yj
	YQbzf++vB/9bHzjRa43wgnwV9/MfMdQ+9rQQO4ZQmtyI7xlBrPCryFqYclsB/Axnda9uW+WKo/d
	icG+9GoFISMKWF2dr5xYu/wDUtVMpeFPVgn55Dn1OLiR3uS7nWE8LY8EbbG2P7VsSXdzHZu7HI+
	9WnKu5mqpLzwIFoGPn8piB06hHYMYRS0lkG5MKphtjJoE=
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4ac1709a7bdmr421751145e9.12.1793866821331;
        Thu, 05 Nov 2026 00:20:21 -0800 (PST)
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4ac1709a7bdmr421750595e9.12.1793866820846;
        Thu, 05 Nov 2026 00:20:20 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99d67sm8729801f8f.24.2026.11.05.00.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:20:20 -0800 (PST)
Message-ID: <ca189d78-e981-4e05-877d-8b4e4857c4af@redhat.com>
Date: Thu, 5 Nov 2026 09:20:19 +0100
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
Subject: Re: [PATCH net 13/15] can: dev: can_fill_info(): don't wake up
 controller if interface is down
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, liucj1228@outlook.com,
 s.grosjean@peak-system.fr, stable@vger.kernel.org
References: <20261103204305.3211144-14-mkl@pengutronix.de>
 <179382521036.488856.13184139645230625670@kernel.org>
 <20261104-prudent-mottled-gharial-1bfbfa-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104-prudent-mottled-gharial-1bfbfa-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 00:08, Marc Kleine-Budde wrote:
> On 04.11.2026 20:46:50, netdev-bot+sashiko@kernel.org wrote:
>> The commit message does say that the attribute is no longer reported.
>> Could it also say that this applies to all CAN drivers, and that it
>> replaces the per-driver support for down interfaces?
> 
> If we need to re-spin this series/PR we'll update the commit message.
No need to re-spin: your replies make sense to me, and my understanding
is that some follow-ups (on next) is the best course of action.

/P

