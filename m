Received: from ag.fintek.com.tw (mail.fintek.com.tw [59.120.186.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B143F081
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.186.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663766; cv=none; b=q2OQzECBjxNx50qROtPRpYcZA4H/Kf6KQxN4YI2cQylGS85gRsOYDLpniXNJX3z31XN8gTVIUGcW2Ok5XxHf47+C+tZH7HKNJWAtqs5+cqS0zoc7DAxMeQZiLfwirbP9Dt22D0iayX501Kw6qxWNdrMcVGNCNHklwTN1Fr8i8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663766; c=relaxed/simple;
	bh=1prtkr+fXMiLAqGBIn9i6EQvU8MZC21XpXOY+sC7SXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u172r8+xb7XE7zBDbdruObLblYuHM2hVr/LPZD+H2LMsAbknsbNYYbrIw5l46pSopTlKL19XMqmlIJamcx2MWZ3E6UDTubdoXJ+PQdu7QcQl6LyGHcJxgVetEFGWUMWjLDQmrHzX8QiacOrdtP05OkMticw0nVB+8jXdN2oMtbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw; spf=pass smtp.mailfrom=fintek.com.tw; arc=none smtp.client-ip=59.120.186.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintek.com.tw
Authenticated-By: peter_hong
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67PDFNyW42230407, This message is accepted by code: ctloc85258
Received: from [192.168.1.132] ([192.168.1.132])
	(authenticated bits=0)
	by ag.fintek.com.tw (8.15.2/3.29/5.94) with ESMTPSA id 67PDFNyW42230407
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Aug 2026 21:15:23 +0800
Message-ID: <e7dcc6d8-cc36-40b7-b0bd-d1346338d48c@fintek.com.tw>
Date: Tue, 25 Aug 2026 21:15:23 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size
 mismatch
To: Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>
 <20260824133009.CF85A1F00A3A@smtp.kernel.org>
 <20260824-rainbow-marigold-scorpion-d95c6b-mkl@pengutronix.de>
Content-Language: en-US
From: "=?UTF-8?B?UFMxMCBQRVRFUiBIT05HIOa0que5vOa+pA==?="<peter_hong@fintek.com.tw>
In-Reply-To: <20260824-rainbow-marigold-scorpion-d95c6b-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marc,

Marc Kleine-Budde 於 2026/8/24 下午 11:11 寫道:
> On 24.08.2026 13:30:09, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] Improper teardown order in `f81604_close()` allows asynchronous work to be scheduled after `cancel_work_sync`, leading to a Use-After-Free on device disconnect.
> Can you take care of this issue, too?
>

OK, I'll try to fix it later.


-- 

*洪繼澤 **Peter Hong*

精拓科技股份有限公司

Feature Integration Technology

Address: 302新竹縣竹北市台元二街10號7樓

TEL: 03-5600168 #813

FAX: 03-5600166

E-Mail﹕peter_hong@fintek.com.tw





