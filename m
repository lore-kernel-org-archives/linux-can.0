Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312358;
	b=a6yIUYYXqt1DXk3wkT8p5HS66L4yDiMaOS/asaCDQ72O2sggwVbRPTdKHjSlSWc7XZR0
	 vuxO6vXkg7pBkFEQ8M7kObrKVLkPMdtOK6vZFzhVnk6WbOePidpK3Zi9/QDq9aeFKyHZI
	 5vHkb7vtFQPrc1OcEaZSZ6NERALioGgZGR4GNt0SWpp14T5RJFz3uj/u6HzxVXojv38iV
	 E1lNmMoE4BkKaVspPVnaS67zWXpLnEehs+sGLvZJpb4/Jn+5dECeam2rGEH7B69a8ayF3
	 g/TmtqaotoiPBHvzymRf21MlWczG/usodWHAxoBtsomH+MbjGL2863hvv0yHafHrB5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jpxgMCCbAUfPdT98Oq2wh4v9R3fJXQgdQPolxS8WuxM=;
	b=XuvG3na9vD4qKBbSEQNF/kk5Vat2Y8G3MlKExsvl7Awy3N7hC9D6xerZh029xUFc+iTO
	 s26FD8+zJB//1Mo2ePPs5vc4mxpd+pilJhnOGuwbC/QQe7pqv3waYkN+e7RaW7DDAU11c
	 JBncbL2IZp4Q6pzSREQHKroEzMQCneagd1Bdh477mhC3XpIfgpERo5aRGlbkMSj22tSLw
	 imi7+9s/Ov2GDV1K1okwtzoGJIjbF2cSvLEG05/KC3PYp73OxXxf/ZS5Anw9HyTel8sXb
	 QeZEckV/PoA3IDoxL/oseMlsM0wgKmkWAf5ouQlB5xLovqfSvh5O7MD8llQtwPglRsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tuxon.dev;
	spf=pass smtp.mailfrom=tuxon.dev;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8169606A321
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 12:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8169606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so23112535e9.2
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 04:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1794312346; x=1794917146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jpxgMCCbAUfPdT98Oq2wh4v9R3fJXQgdQPolxS8WuxM=;
        b=LF4BFKzrTfKOrCuSfp4DCyhP5JXW6aLC8XDTOi3QC6I1vLZtLE95OOLLw8+PaO15OD
         Mqzsu8ibEbOPvk0C0LZpmcHuoWuVD46E4lCbRLNSR4rlywp/TUbyv5jDIrUHnqRKUN0+
         VgYmCiQFOWw3por3vt60eXOGS7VxhrTSAy2uD5KjqibIYZXvhF8xkBxmfq26pC90h+jz
         nKnTq6DPVdhiHAlRe3p9KUoVmEpDTiOAWO5AsRJkCiuO3TGigutjr1wKeh2R+kZU8E2o
         7B4YTnJAghxXdSsuvEnENaGO3330T8hm5HVDo0cO+QeGHXLRYcSbSeMAQmUnkuj/DUfe
         xkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312346; x=1794917146;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jpxgMCCbAUfPdT98Oq2wh4v9R3fJXQgdQPolxS8WuxM=;
        b=gvrNDNK401rgurNfyNsUHe335tc3knMjbp5bO/zwbCu8xrO/ykbw6Fle9U5PiB00zX
         m7C+ofGL3JMTLkkxIXMjSaKfK05Do2QsnGpNIj2MUtQOYGeChJikNohXPAq/4mbDhvv/
         BBlmr+LrmHSZHhq7QAx2ziJiOLinCnDt1sIl/3uIpbZqkc/+L8QjRFvCo5uo06lmxXp8
         Mugq6ierivwJn68M5E6KzjGwcy8zdHtBZ1q2Uezc8U/NR8awOKUeOm3FgFiqYSIZHGrb
         iC6ADCS1Y0ox6jlaivqQh1mtWzcvgzhxxZ7RV8czEWHpBSTk61Ad7xAHezq9lv8sfoUt
         vKUg==
X-Forwarded-Encrypted: i=1; AL+hErFXl26kfesCNfHdBDp9Iqw2MK2MJzxytD1IJ1ccswFEhUox7hjRlvotr3szNa8cUny4mHMoDEDiL3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+52qmC1q3UR23+RYfQ/VoSVnQHMpFQZ1eGGwrafqJkCfWOOUo0
	LVUSl3En4yv/o839MQPHFlI+Hr94UYcm50O9E8TydfO7IILXbxMzw73aShNXhPsqfOc7gFbOYWu
	f/uf1
X-Gm-Gg: AYBFou2Rys7kqEf8Gt1KFwDAiU0XPVf+NIw9uTk99GLbSX/NiY5E1fnuWVo7EjQU7yc
	0YZZRPtFGhXILzQiB9/jX3Th8m2cNtDbIGHk9YdAb6Rth0tO9LddjBYgBwkmr1wOn1Hq8CDOJtn
	C0ex+vqF7taCqPqrFYFKu/mxUjMqsFchCuVJZEJAdSkrMkwTyO0HMATKKF2ehfuJ2udneJobkQW
	TRrGKdKLUos0j58/U2hSrdWSXW4iiPA1JFcdq3WFLG6bVdZk6bSMWi2RCAlZmfo6DPp4TBaTtSE
	YwiYI9Vg4/N7slPxmP7Sxa5ViQbdfFSz2ZJKzyHt/9I+SWfaVyFbf6kFhSj7A80AqkwGskjLSmr
	ubZTSh3XmLITJTCGUmgw9CrCDoeyseX3NAHKwD119jJ5A0xU+PQPSNZvpjQKhpnXKJQ3J9+I3hN
	OrnSY2fNCYv/Q3BR6b/S0hdvpI9rkMz+NwVRPs96//5RwAlKOQMft8Z6j3V6fJDdGwULVUJ83ox
	ynv90shegooLCFIKDDAyagLgZgxzSft+35AiO2KefGTHI0Nn1lePYZff9/V+DOv2rKZ4WfmYG+Y
	5yboFdf1Vq5LsNV9InYtkPlY/ZlBKaxypQHrZYe7PspzWqNjIwCJPYAJc3x5onGBzGlVAKc=
X-Received: by 2002:a05:600c:3b8e:b0:4b2:2ec5:8a2b with SMTP id 5b1f17b1804b1-4ba023367dbmr51948635e9.10.1794312345435;
        Tue, 10 Nov 2026 04:05:45 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0223c41csm61119315e9.14.2026.11.10.04.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:05:43 -0800 (PST)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Message-ID: <dbeb92ed-4bce-4de7-9699-6a8eb6a07284@tuxon.dev>
Date: Tue, 10 Nov 2026 14:05:42 +0200
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
Subject: Re: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev>
 <20260929-loon-of-remarkable-romance-197df6-mkl@pengutronix.de>
 <CAMuHMdUE1Jh605kgj4ADU7p1UjE-0u3ydBehL_5wsQPbe1EPMw@mail.gmail.com>
 <20261110-urban-bald-mastiff-d3cc34-mkl@pengutronix.de>
 <CAMuHMdX-jMZ+cxq54DdECVHTN+noavo0RfW8vv+GAgoxUyEkqg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMuHMdX-jMZ+cxq54DdECVHTN+noavo0RfW8vv+GAgoxUyEkqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, all,

On 11/10/26 13:38, Geert Uytterhoeven wrote:
>>> Thanks, but six weeks later they are still not visible?
>>> Same for " [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict
>>> resets in top-level"
>>> https://lore.kernel.org/20261009-holistic-warping-puffin-3b92fe- 
>>> mkl@pengutronix.de
>>>
>>> Am I looking at the wrong tree?
>> I tried to get stuff into the last merge window. For various reasons it
>> didn't happen. Anyways - I've pushed all queued Renesas related patches
>> to the can-next/testing branch. I hope I've collected all the latest
>> series. Can you have a look?
> Thanks, LGTM at first sight (I guess Biju or Claudiu will scream if
> something is still missing).

LGTM.

Thank you,
Claudiu
