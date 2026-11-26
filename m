Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711718;
	b=Df5iSDm5PYkJ55YlHDlsxw7eqXW0Tiv9WaDDhEulvPejdDlRm1wuWAlDPLbaLCVD3Ixr
	 FlqzH9giWArTtMZAQruufBM31vozI+CIah9eTEdq2n8CAB++/eTCNeCZiDCMrf3jhT4NZ
	 RmyKLxefO64pWCUp9773KPU22ncsGTRCYgAM7m2hIPi8IDYAe1b7isOkm8gJj80XIg4Zz
	 VvhqG7RkvC7EgUYiKnQtaweEuA5FXddRkwp77ymCgCAuJgHgIy/Aofs/cAiIodiHOmzwK
	 KZMoCl/OL3erJaH0riVFdGFECzLQ1mqpJP9nGfDyTDli5tvKZIDqBjUHnnul+HDMPSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZVsq7HzzR584tpf1ZxWh8VZbyO/31x1/Kte9UhSSi5A=;
	b=JCXObztyIupMWT7xzAafeDv08igAKd+nvZEIgkO0PbdlMYhGmZR44INR3lHJAyxYCjqj
	 Iyw6MbtTlMJd6sVYumRoy90KDyT5wAiRw/RZhoG43Cd2YcOPk6ZYXddu9Lp4Xt2KNUD/5
	 wo6m49/KJ3F6J9UR7lWiuRBh+qhTBmP8z11kxc1EwZ9gM272XrVXYla65yeif+R0oPffO
	 uYIV8fXY177SintLHszl/bSUmtXFB+aoXGvTJ2hvw7GEUBMNDH+IgGiNjgAR3A5FdTT7a
	 pUT/MjCpQap3eNbX+6IoQcHQcM5QAqwvaRxKdiBAsWRgZLxPUo/alI5CRH2eAeIdAFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tuxon.dev;
	spf=pass smtp.mailfrom=tuxon.dev;
	dkim=pass header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=Tpi3UyPb;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2D606A31C
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 16:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=Tpi3UyPb
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-498f5fa5103so4310937f8f.2
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 08:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1795711716; x=1796316516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVsq7HzzR584tpf1ZxWh8VZbyO/31x1/Kte9UhSSi5A=;
        b=Tpi3UyPbUEwAbxv2YI8qS6q9I4WYwk9hOYS1KUt0uqR38AocfXhUKn9bDztAP6zGVk
         DrICgIBQ4IL6V8rxgebQV2Cw/SJsAn3My66XHXVG20DjP6P0WCqcIIq/uD842BvdDNRR
         qL5HOABwJYkXJgTNOP5FMsk/AwXm/+VXrnSCu94UCMX40qDCFu/PUk71UJ2Em2nMYkTv
         vfF+czxdeaHPMBR/yEdJBwq4wseagIfJHqJqAQj4xcfl9zvrNmU6ONvX+mtwrzC2PboB
         GvtcIa/ec/OzirzDUFGcPn/ndoX/0NcnjtZe4koYr+ePazyWjlf5bUvKtkXnLs74jyIM
         iATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711716; x=1796316516;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVsq7HzzR584tpf1ZxWh8VZbyO/31x1/Kte9UhSSi5A=;
        b=QmsD5p6SI3VaaILtvA8h7CjbytB1fOkhu18gt5fptlPHmL5RMSbyJ0pBvbRRHCDwbR
         tpxKXeEJC32dpkJxcCghvX/QhAqJdy2SHSMKhpKqnTvVWnDMpE9NKRaXhfH8s4dP/MCi
         9lGF3Q8J7uqqs5OJFIzBUYDPu490vT0eLf11B1MIIv35UvNIz3uZUQ6mbiLEFa5Q9guC
         +2+sClY4g6LLnncTJ/n7Qb6YlNV8vyh+jVGCzb1OXSjdMlDETMG1ZKD3ofZXgoeWqMRP
         Xuxyo5x+JzY5xTrbbpXBIN08e4RPI79njfqAgUqUEFj0xz4uFkeTOg1FUkPMISBXZ2GK
         HC5A==
X-Gm-Message-State: APuU4Z/rcgKY3jFNXc3xvPqb0+ORCvkE3/xoQEgdu0yoJUAVN1lyWtpB
	BKw8LWzzVJAldqmMYwvlo/BfHFnM4BKFIvPDG6WoNQ8QpnuCbACOC+VeAKG4X6fr200=
X-Gm-Gg: AZFdTZfDm/Hd2nEKFzUlZtYKa8MmgfSy9l+oGQFahSkroYrCB9catygTRru4CT8nyaQ
	7ihaUJ+tQksPlrh5L65XA8YS94ZyDD+RG0mtcW8NAC2DrQco10p29NJ9gTgmh+uf2/zKiavrapV
	1I0mQAMGraRJmko1nra3rmuVmaynNYzcyu2AOg7GGv0a4rYsrHTIRXrb5hWzajCqcnYY1Zjkx0A
	XyltX5e/c0NN7QROFvgCUrbG5fOjNzcfSAnvIK3jBsJkEN/m0HNpXFCPhJUGrp7+WR5YPChgiI8
	JzNK32Zh2jAwdfZrSkRrW639RHK5WBBZYyYwtPQH2L2KAPnXbxdgLEo73BFCSvPQn87YAiAsZ6T
	N7ea46jbUqPw8hG9H1nHPWXOcSN+qEijcGhjhYvzOa8udxqmfTGabdlKqwW8mwdKJ1iWUr1Vkiw
	pl60Fdg7WxcbE8+yq+WmJjcBGe/oyLcu6S1FfVWt423i+Bs6q0ny/7QCbiko1lgaQNNJvV7hHeG
	1+bLgIcrGTefFLPI6Bd4rhbb8uuP/Z+c7UGHwEtTAXq9nsO+VFfi8auykWgzmppdj1ccGuZuIOh
	RmiI0G7NPxeSck7FqXmlMIlkAIQbw96efQGl
X-Received: by 2002:a5d:5888:0:b0:490:a481:7ac8 with SMTP id ffacd0b85a97d-4abb532ea79mr39988008f8f.29.1795711715830;
        Thu, 26 Nov 2026 08:48:35 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm42879947f8f.3.2026.11.26.08.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:48:35 -0800 (PST)
Message-ID: <9a269c63-86c1-425e-a892-b37856a26df2@tuxon.dev>
Date: Thu, 26 Nov 2026 18:48:33 +0200
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
Subject: Re: [PATCH v2 2/4] can: rcar_canfd: Add Runtime PM support
To: Geert Uytterhoeven <geert@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <cover.1795703576.git.geert+renesas@glider.be>
 <557fa8a4776e0ee7d6c566b825771075db46b276.1795703576.git.geert+renesas@glider.be>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <557fa8a4776e0ee7d6c566b825771075db46b276.1795703576.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/26/26 16:46, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven<geert+renesas@glider.be>
> 
> On R-Car X5H, the CAN-FD module is part of a power domain.  This means
> Runtime PM must be used to make sure the domain is powered when needed.
> The CAN-FD module is part of a Clock Domain on all supported SoCs.
> Hence remove explicit management of the functional clock, as this is
> handled automatically by Runtime PM.
> 
> Signed-off-by: Geert Uytterhoeven<geert+renesas@glider.be>
> Reviewed-by: Biju Das<biju.das.jz@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
