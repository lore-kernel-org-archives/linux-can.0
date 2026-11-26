Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711745;
	b=T9UmA7S3ABT/t6pOdVzIRJGThk8ncdSpLoUHF/NGJIsV9BIxUL4MLTjuCx5ao9RklSOq
	 Th66AhLUzzGVIhxWp6Rwwb9gCysaaGtlb8LKtUm14v+mVEAin2tr5qVUh8Dzvufh610H+
	 DLXBkwDYLTGBP8qRRjGfpOi80FH03YwIvu1SU6s9qi7drRq93o+ahenl8loO4P8yiTi17
	 Ym8WqZ0qu47F8N23dDPtLCP02v5OeaKkoN64Xhk5x0nu53kqY/XMC7Y485jNpmbkS6PxM
	 IAv29o834UgfDTsyF13ta47YhLdJUnM6oaKcm4awUMyB0GMkguL0pc0GEx9dSX7yi+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rzDnp40CE+pREC32cu0fVxrG/CaDJAbCUC6G5UBtf1k=;
	b=kkMNaEnMTiFLTC83bqofEgZK2K7G+kQyRROq+PhmK5UOo5pOmPHtkA9Iaymtgjb20Z/t
	 gav+/eD764kKE8ZsOv2ZJ3Fs3Mmxo3gp0J1/QwVxTBJT9kREUJ9uvDfY4GxzoRoX0Y4iH
	 1qcW6nyhHNRREbUtdoWEG4ZJIjyR5l5aN9Le9okme8zisvUcUMps2Z53GbdjbbG/PIaT+
	 SdAh8iPvaVZTVVNqNdgjNEd35pJrW9a85xUGSyvDF1PZ2rJ0xJs3FywGVxT5s52Aa0jsq
	 nv3od7DjW79KDGlQssUNjVR6OVv7zHkkqcnsPffgEiAz65Nlt62LJrFFIexYFpszpPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tuxon.dev;
	spf=pass smtp.mailfrom=tuxon.dev;
	dkim=pass header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=Z+PAYiRo;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D17606A327
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 16:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32D17606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=Z+PAYiRo
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so74107845e9.3
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 08:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1795711743; x=1796316543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzDnp40CE+pREC32cu0fVxrG/CaDJAbCUC6G5UBtf1k=;
        b=Z+PAYiRobNheQwZbfb5f7QnQu49d25SfmVyFqoPiOKNsJj+kKgYtX4MJYBi87CehJz
         jYsCk/iNt3mZlIJS4Nt/63q1faPRJEGPLekhja7Tf1hTGuPp0dle1UglF+CV+SzD0VJT
         X8Hkl9tjgLa+GkYtXcP/J0W7KyxRIt88GFlAYWwyvsqHluwqWYXn8eabVGlHz+QwDlac
         G07/avkpNPctUrH2sDvpcAlRqmhwNisEPBzFxhUqWAXhnLvbhi4HshA8USZgbqdNbLv8
         pu6iUDPxhOZDlfr+pAtoisZDkzbhLW3oQANqE25LjsYP4NYBYn+mrD7xJrLajoQFP2+W
         SlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711743; x=1796316543;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzDnp40CE+pREC32cu0fVxrG/CaDJAbCUC6G5UBtf1k=;
        b=sfEL1hsVyqQd9WlJK54g92ooqdyH4l0dqcG1HHCNNTAIFnLT5KGZH+1p2BszZoDepE
         ZEWQuZ/Anih787fnz8aigCVEuronfGFO9BmB5NPtEvsHMcIEQsingqAvwhvctVe08/my
         4c8WmHKg6ty34PTaDn6zA4RbEInLLQ0o5nRxhW1LVxAqLo4nR7YXjiuP6zI2XUnlotNk
         OkpBWgQmxjLxqsoRW3MyWK9Mr+zIGAtt1//079g/brIS2AHyKcksWki4qWmpMGMYPxYw
         tukXkw71O9Cv3ain7VGz43Nz4WDJPuxbt2rakGzoCFTpYTQZXWnemSYilJaVR2EkJBx5
         xfCQ==
X-Gm-Message-State: APuU4Z8efD02ox9qaplmpkAHKakmHXV/jWBNyOi+pQIWm6UsN9khvCrV
	QsCh+6UFT7AQJXxiopHdrLJM5V4i5bTZjldzBHLyUnifUnCAroDcgiVUbqvaM1k3Rw8=
X-Gm-Gg: AZFdTZfhy/NJoPPVs4Psvf1NomLJeYF9WDHbK4afaNCQ8jIqgfDl2IYja3uNkF+5DOV
	LZmekKoTEcrEu9jEOsLT2oMObXD3NdRHpuQU4Iw4NxdTy/IpBqvJlzmRSEP3ljrlFQ8UI+8Fwia
	ySD0yTl1gPWo06kCZAT8EZuuVaLZBZwIPEH4ZbAkJJMvZvud9m6DTWGa/wqadU5IWl0VZ0sEJfs
	3JZzOHWzC8XAWuZ3uw4IimKtsAtJlmV8sCXYN4RbQ9jsqZAZK93fGTVL+WKeBJEf8ycsE2MpxWp
	GAuE+345wd03UEur/qzHjSjYREi+Ucd2xBKpk0kOpg8JpjL5h60ntUAjws1jUfdYfPabw7LjJCz
	hIMKrM5OgI5/4w0iaKrZmjDPVi4vSQdf7l5aIEf7ZAZ05dyeoSZVHat44icvCEUxXkn8PQcf3k8
	D290SGU92p1scpTcxb/F5AaXvBE3dXrYP0vjdNhAkf8jHV7FgKF742PmD8aDGUlsqUoC038jt9L
	h8g8ZCiy4NiFdZb0v49f8fEZcxeFX6dbtVH8wyMTl92ZIWK0DcJnO36MfAVIDjoxhTOaHKE8rVp
	RhQJSrfkO2rLvsmPFugtyivzeBdEw7ddKjCmLqsBwsokBFq8YoEjTeQgZw==
X-Received: by 2002:a05:600c:4e0c:b0:4bb:875b:f23f with SMTP id 5b1f17b1804b1-4bb88827f0bmr417736165e9.33.1795711743379;
        Thu, 26 Nov 2026 08:49:03 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm43506290f8f.8.2026.11.26.08.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:49:02 -0800 (PST)
Message-ID: <54b84f7d-163d-4cc7-8ae7-0bc41f48ae1e@tuxon.dev>
Date: Thu, 26 Nov 2026 18:49:01 +0200
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
Subject: Re: [PATCH v2 3/4] can: rcar_canfd: Make clkp local
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
 <72de009af38868a4c72c0af674e2f527035a2927.1795703576.git.geert+renesas@glider.be>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <72de009af38868a4c72c0af674e2f527035a2927.1795703576.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/26/26 16:46, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven<geert+renesas@glider.be>
> 
> The peripheral clock is only used in rcar_canfd_probe(), so convert clkp
> to a local variable.
> 
> Signed-off-by: Geert Uytterhoeven<geert+renesas@glider.be>
> Reviewed-by: Biju Das<biju.das.jz@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
