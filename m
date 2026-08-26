Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B435DA55
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787726560; cv=none; b=mCHxRCLFR+fNK7FOyA8Xn2J0ypZYo67ERlIjVVFEQP9cmhgCg/AdaR2pyGpPtRCgnUeaL7Vk4cAgg7NdWHmz040dQRY1E0vzDqY/3N+2KpUnCB76NpKIssJdOalVWxwyIV84RgSysdM2gUUtW9LfbgmBLJY0eaRe3myiGM+BLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787726560; c=relaxed/simple;
	bh=UUWuO0QwoebqATJxWaCtzKnjbyKj32irOZFH/34tJ7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIP6EEGmbkwlJfLhE4Ej9b3DkiiEulvtuPSTIg7tgVgLXHjTVkdth6vs9hUxFM3nKApgQRxprYnismZrI9j9J5a6h682J8omLSm/PqVmg4B2BryHzpabaCwgIlAzjoRmsg4XnetwIRN3X/pPukpLtmO+iDIWWxVcCNHqqu51vJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvbVP870; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvbVP870"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d712281f8bso2867435ad.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787726559; x=1788331359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UUWuO0QwoebqATJxWaCtzKnjbyKj32irOZFH/34tJ7Q=;
        b=pvbVP870GHITDsawvgcV4sKCGZB2UNbXZq5czxR2QOpYQhPIR+CiTrVhqT79GwmoBg
         K+5FbXvwKVSL/tOdMPETnBIcxA1dWgZxjU9Z2+Qic9dyX6x3iVuoMbm7qRxa3oagCQsn
         kQdUR7eBv8z8QGBlrO5jU/hAjzmt/XqmOF7OPRBITFfMjJXunsS6FXruKbWkMQ3/gLoR
         Ivl9J28HlRTdwIAhh+bloxMQkEV5qxTR4V7sfe/C2X4KTnTEkamqYJhnZchbbTLkL1c8
         waEKRGSg5m9J4KzBBg5eyYtyG1GcHfCsC4sgfv0iNGSQZBoWs2garN/Qq5ofoIxf67Ay
         zUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787726559; x=1788331359;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UUWuO0QwoebqATJxWaCtzKnjbyKj32irOZFH/34tJ7Q=;
        b=Fe2COobDOFNiyGFo14JGvyhENf2w7yomLAhIuEtcosWWSx2iYr2TDTMkszxfBwIpjm
         0Z7eUaR+ugakyCKXMZ1Kl7gkEYzhHVwPty3GKBsIKtfYEURahsG+t3DMo9VzSlqUbD4T
         r2lf4CwZ7HaW5dSnba2rWr+ZCZ5mZa4E9KXX+6s9RKSQcGU9U+r5pDewbHjLZxbKzOSF
         S+B+naBKgIJQUOHrwAMUdNMKmRZA53g3s+dwUgA7ZVBPOjowiBqo2MCYKIBgvW9KxGhG
         OOKncR5yAH/FJ0+Dwafqcut5OZpRMfdE7+LaYDFgVGakTDT1xkO6kW+hX13cUrURdcXA
         wEAw==
X-Forwarded-Encrypted: i=1; AHgh+RqDRmwnCVx75vJqsqiO7x+oDFxANPkpK7800hv8azS3kyj9Da5xjbdsv3rW9PMCLAB7JkLUTyevsZ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mChhhO2a1kiVtTbsXmyzlLe4i9YYUOm5P0HzH3B2hwLce0b2xE
	gz4WMHZB2ymLr5J337w85v2Gadeuab9gaRAFeb3SIWxQKV6TJYyoJYBw
X-Gm-Gg: AR+sD12WVJUtpVgLhrRAQ9CR+7MofHLo/9AuCaOO1TEr1fStKnKOWz/nbPVvxvg7tPu
	e/KtlaPd/PWVUQq+8SH2cDGzkdv64ka8AkyNc3Fhd/OnXvK69FrdBUB/KrAWOil57aK7wVzlnuW
	FhnKq0qzcR9agmQPn0Qh0MD5hXqPZzyleunLSZS1PTawRMUQ2tcvXZAVo/cnWSzyLFTkZKrPCPJ
	2/GM+qvXriind0cNLPVuiyCJOmziKUk6/qF5Z+GFXu6oFuD0Dv6SW54Fj1fHhcHJIf2Jg6kKwMZ
	OOZasS878CSDeaVbwochFmJ79pXdbQyCYLoF+C4FrpId+2/6RdBQZk604JvcYVIU7Nr9IQLRX1V
	G6ZRmb5cRnS37dTNskMkq4xiQUva2Oxl4zuO9yVR8S560dwMZq+vG7UoPpR8m10HPbXH6i/Im2t
	OCSI/m4ktsJwHJzZy+vydbEWK2IJAvg0yuDxB2rZ0QMkBk1cpm52OStx1ZcTbVUdw+IUxcVZkSG
	xPP98BxpXkWB0sFFwuReq32+Q==
X-Received: by 2002:a17:902:fc85:b0:2cf:8131:75f4 with SMTP id d9443c01a7336-2d707bab9efmr70947645ad.11.1787726558635;
        Tue, 25 Aug 2026 23:42:38 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704b9f73esm4284795ad.39.2026.08.25.23.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 23:42:38 -0700 (PDT)
From: yewentian395 <yewentian395@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: yewentian395 <yewentian395@gmail.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: isotp: implement N_Ar timeout handling for FC transmission
Date: Wed, 26 Aug 2026 14:42:33 +0800
Message-Id: <20260826064233.3248193-1-yewentian395@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <eb5e9618-3dbf-42cb-a635-752ff9fbcb99@hartkopp.net>
References: <eb5e9618-3dbf-42cb-a635-752ff9fbcb99@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24.08.26 20:03, Oliver Hartkopp wrote:=0D
> Nobody cares about so->frame_txtime and therefore I will not add any=0D
> extra complexity to check for Ar/As timeouts which have no real world=0D
> effect.=0D
=0D
Thanks for the detailed explanation. The simplified model makes sense=0D
given that no real-world user depends on strict N_Ar confirmation.=0D
=0D
> Btw. while double-checking the code I have seen, that I was missing the=0D
> addition of so->frame_txtime when starting the rxtimer above.=0D
>=0D
> I'll mention you with a Reported-by tag then.=0D
=0D
Thank you, appreciated.=0D
=0D
> Please also note that your patch would not apply on the latest upstream=0D
> isotp code, which does not contain "*(u32 *)cf->data" anymore.=0D
=0D
Noted. I was working against an older tree. Will rebase to latest=0D
upstream for any future submissions.=0D
=0D
Best regards,=0D
wentian=0D
