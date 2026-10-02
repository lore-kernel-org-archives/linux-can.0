Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17200443312
	for <linux-can@vger.kernel.org>; Fri,  2 Oct 2026 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927767; cv=none; b=TfW/rLQ7nQ2zjzlYCLfwz0aJP6tqvW+Q8XnfXK3udHIKVPo/3o1jcSCoC8AWq+xfIejPjsIO6jetRJ8nX+H4GLl4Fr4LWMqSctMZeqIH9C8Jl5hWvpoGiFX0uEof9+wxLU0wTCJjSaa3F1W71eyvroMw+IhcdbZCNShtHnEeNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927767; c=relaxed/simple;
	bh=HJAV1pZ9lXgDKLEOxd4tNuiZSy+JrfvBzEnvT0zKL/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awRZogEahVWpU9R3uye82gonas9yd8/pMhavH56rgIpxmDNm4hNGz17dvAHO62+ka4UHi/LHQofe6obXqlAtEZxOOEyUwpS6b6W9tcIm6cwkbGI8spXJnWBpJnoLCaGaPiEm0xqHWfsO7ONASF3I70bVzVsWCPOPo22v2CM/Rn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcWVeM2F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q2pldzC0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcWVeM2F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q2pldzC0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790927763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvzMj0FWXdEre8JeFTQAy8sUSU4Rxxd4Ot38DPzLz1w=;
	b=JcWVeM2FYmLw0j+7eVuf1gVb16qiqoKC0GO0PuUk8tZJ4cmZ8b0apZZeSvXLUk/wm9YOCf
	F2NdJMn1NaI6mXGn43Y2dzbgmpdUqh7gW9yPLVxCvr+6pzLQ1yLjLMWLTh6GHZPOzVJyQ1
	Rulldwm6KemhIf9KC1Wuf0Y8muAFjU8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-_YBGLrZJNxKJ6yDtPip9ug-1; Fri, 02 Oct 2026 03:56:02 -0400
X-MC-Unique: _YBGLrZJNxKJ6yDtPip9ug-1
X-Mimecast-MFC-AGG-ID: _YBGLrZJNxKJ6yDtPip9ug_1790927762
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b02e93a1eso2273868f8f.1
        for <linux-can@vger.kernel.org>; Fri, 02 Oct 2026 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790927761; x=1791532561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvzMj0FWXdEre8JeFTQAy8sUSU4Rxxd4Ot38DPzLz1w=;
        b=q2pldzC0W8jNsdVUSv18rMGndoBhoeWTbyF0wql1eMChMMYnfdsIKrbIExWP3YxOGd
         MAjsf/Gb1ay8mM6P1XEcoG2eJXQAIvP9TM4c9XC/2Lr4DEtTaq9DmpnzIiGflugOZs4v
         69tBhdL5EoSxrEiwbPwtk4ISuMa6gtGWGFvwHWYEpR+m9Z7salJMfCGn+1p841rPud32
         nrTe1K3dwxskG3720DHq+p7qr70PBEW4fkqqCHGqItlbLSIBrjXovGfVZxBQQBXz/DkM
         nN4aJAgjwzVr7QNKOq+x60xQf5QHNC0W41HndAtlfbWTEFzkT1hgbj0WjC5M/AqmiCnY
         7g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927761; x=1791532561;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvzMj0FWXdEre8JeFTQAy8sUSU4Rxxd4Ot38DPzLz1w=;
        b=soMybmL2pX/A5RhcknbzivS0n7IE1aaTiSDbte6fA3msQIECdBIpT9v997UJ7ABUzC
         JG4O9hFXJZO/9k9ybM+Uez/iPUkky+Thg0BzFEsAMOJnrNmlO14kjaCi0U4NFqoN6f8s
         mlGMgANMGIMY6Nlqq7hLDAQQ+s72tmVFntezOFg9To1Y8ANZZHvzPPWYTDZewZFIZZfB
         xeackKpDpBWzzxu/CCzo016p7wnEo43LP85mm0gBCwp+u3T0cCHRe10WAdEjaIyLcQ24
         K2Kd9AL3Lxbk03tQ1v4Su92wRUvaMV8ZHwHDCju8/zj3yzdnNiObXT9hPEgwM3VTcDOe
         GbqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdxgIp/JNVXOoaSjfy2XMgOj2Ot13cResyL2Z440rnkJnjLgKQ7v8Y7o6TTBB8j6J+zraQtrag/6o=@vger.kernel.org
X-Gm-Message-State: AFuF++mDwg1XTypYBxG8KZXPO070TWO9lhxoRua7o+QBEwrobolUNc+S
	W8phGlmb7QCrYubUJCTmThcHgGp2SJgaa/HJ8YGIBQlzEvQTcJiVKlJNkO1JGXv8C8yNrkLJG2N
	GAfSdNt2RlsQ3KzSPR3mjHXNcPBKDtVWgiuwlIOPw73AuPlVHOftOdoyWjUBh1Vki52r3Gg==
X-Gm-Gg: AYBFou3cAT/frQBwjGNX42fUbnXqIxY3/k7wZ3PkKjialpkJEUn82CYoYl6v87nRVTT
	5MVBW8jy/sZJCJc3ayP2RkG5WI6yA1CPnbY9scETu4WLWgRxu3HGSsZG3wzpK78m8YaFxHknKjF
	0GbzTgHRuTNec7cEGXpSoM0ST6a0xdjubv+wyoSw5kfbt847W5gtR37hYSP/n3Auq5ZFUBLMBfK
	ySAB9JVn6R1xyHXxPhu3NevP/uFIR9BxGzsp3CpiLJ2pns47DZAPuj+pHUQqcuwuLOADI2Inw4d
	DTGAXbynmSB9stgI8yqbvYIdFE4wW4UIWURrXmtmjf6iwL6ygbj0awLdqUU26UYuK9UXHCsjctB
	I7nMUYqZTs7YGkj5uQodNqK9yL5xOJ6ScgmfCntLD0DwHYaVn009cNuHPdGpbshC32HooLp3PgQ
	==
X-Received: by 2002:a05:600c:34d1:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a027579e86mr36781495e9.12.1790927761543;
        Fri, 02 Oct 2026 00:56:01 -0700 (PDT)
X-Received: by 2002:a05:600c:34d1:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a027579e86mr36781205e9.12.1790927761148;
        Fri, 02 Oct 2026 00:56:01 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02752aeb3sm62108685e9.0.2026.10.02.00.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 00:56:00 -0700 (PDT)
Message-ID: <5e6b5fce-b941-4442-a8d8-3064eb4b9d45@redhat.com>
Date: Fri, 2 Oct 2026 09:55:59 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] pull-request: can 2026-10-01
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261001151905.1556270-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261001151905.1556270-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 17:14, Marc Kleine-Budde wrote:
> this is a pull request of 3 patches for net/main.
> 
> The first patch is by zjamg and restores the skb header initialization
> lost during the v7.0 release cycle.
> 
> Oliver Hartkopp contributes a patch for the CAN net layer to fix the
> unique skb identifier regression under RPS, introduced in the v7.0
> release cycle, which causes lost packets.
> 
> The last patch is by Ji-Ze Hong and fixes a struct size mismatch in
> the f81604 CAN driver, which results in a TX starvation.
FTR, I appreciated a lot the effort in keeping this to the bare
minimum.

Many thanks,

Paolo

