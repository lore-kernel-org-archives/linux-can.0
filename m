Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D03F3CB2EA;
	Thu,  5 Mar 2026 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725819; cv=none; b=mdl9fsTkIxjZWakk2Vqs91RftIvx6lTi4j+lykSJS14Vk8omVS5vniCJi7JMdtgkd3Zuo7g51Z2tqWlhRnuRSH33tqZmTfoT19kjaf63NpimNWIL/TaTPfTQAjrwkdnrMvJ8Wj5nyO+XjQwIB2Qg/0mCNSAnu2Y0GA8GsUyeg5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725819; c=relaxed/simple;
	bh=NykbTJ5jgLGhZzfC4awgL+Up5amfZk586+Ff9y3lwzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=gfcbzQx/cat+6a5CF+JYI/ikDXrfzU43qrdMXPheCL8tk3U1djS4ZXtG3guWTM1aFVIcgGCMU4GjswFwv1/61ZfxAYiAl8fDecmQ4Vh7WSrp28sZ+cfljljtJRGY2HuGolS9k4HhGSaveTeqP3pMdHpCqrwGwjsHs6zoRKGNbus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=L/xqKdLF reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="L/xqKdLF"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fRYhh6Zggz1Fg90;
	Thu,  5 Mar 2026 16:43:00 +0100 (CET)
Received: from [192.168.0.5] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4fRYhh3TjXz1DDdY;
	Thu,  5 Mar 2026 16:43:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772725380;
	bh=rfVl9YuezRI/BlgZRdRIDp+p6giKFDrfdMWf1+WvbI0=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=L/xqKdLFUwtxK24gGXIClO3EJf7TZnAqJuf4C//8Q5qdV0Wth1alBsrk6uDzSHd5L
	 1Fq02AQf5u5t55DfrNn+t+cdXPemoZjFzuyVkLlDFlS5EXgv2qXG2tE6ttd1ZvX0PX
	 +bitZFmqvWT+0hs7+ffKfyF+Yw1oSAEJ0Ih2bNinjyi3TzxGTKvyINh1kj7wQ0nd4i
	 c9iABy5ip2KEFVGbgrHyhrN7O/Nha1ixhLhelrPDjA+yB1P3OM3PPdFm0TYUNEZMAg
	 GL/X2cSPnmS3WzWXOR4mp+8xbuxxWqjS5etcX8EI1NBeHVwIBANbfr1oRhd4Yfizg5
	 VDLLGeQF3EYpw==
Message-ID: <4399e6e5-e83f-4831-936b-58f1a03d33b5@gaisler.com>
Date: Thu, 5 Mar 2026 16:43:00 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] can: grcan: Replace bit timing macros with
 literal values
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
 <20260216135344.23246-6-arun.muthusamy@gaisler.com>
 <fa473d32-ff7c-4ca1-8caa-57eff39f79a5@kernel.org>
Content-Language: en-US
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mkl@pengutronix.de, mailhol@kernel.org
In-Reply-To: <fa473d32-ff7c-4ca1-8caa-57eff39f79a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/16/26 16:01, Krzysztof Kozlowski wrote:
> On 16/02/2026 14:53, Arun Muthusamy wrote:
>> Refactor the bit timing constants in grcan_bittiming_const by replacing
>> macros with literal values.
>>
>> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
>> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> It's random DCO all over. One patch has this order, other patch has a
> reversed one.
>
> Please read submitting patches document to understand what you certify
> and THEN certify that in a way submitting patches asks you. Not other way.
>
Thank you for pointing this out. I apologize for the mistake.
I've corrected the DCO order issue, and it will be addressed in the upcoming patch series.

-- 
-- 
BR,

Arun Muthusamy
Software Engineer
Frontgrade Gaisler
T : +46 (0) 700 558 528
arun.muthusamy@gaisler.com

Frontgrade Gaisler AB, Kungsgatan 12, SE-411 19 GÖTEBORG, Sweden.
+46 (0) 31 775 8650, www.gaisler.com

