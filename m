Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835F35C193
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607341; cv=none; b=jmJHeQrcqlq+OCpgRSojvHGiZFy+eaN2xQz5Ilo0j6KcnspUFUj8tX7Q1CaQcXApjN5ZpH0rIYcENiCzuxxbKQprvZjjHPbZ2pobEEz4Tsfe2Jy1clxdi4Pdouv+7zJM7U2VCcgFRRtURmMZaXt5G+w7/CAI/1JOOFQlSYXVYP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607341; c=relaxed/simple;
	bh=yWQiJFBQ6Z/CdcZVha4rKQlEjViKMbG4VWIrLOGW3KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqBPnTJBRebmy+QmENhuFJHMTVZ0mOKMcztMb9VQ0jnS51C1iDnAa97HbTK7aJhcY38hRm6C+s/ZHJaD5zm68kpfzCUXpE8b545OWJftcPlIHgkY15nzTviQHdZOItvCC1jm5hjKxs4VZBNYdt9RtnmjZ5PgVc5prIS97+ukUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjYYCOHs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjYYCOHs"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccf2360620so37186445ad.3
        for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787607339; x=1788212139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWQiJFBQ6Z/CdcZVha4rKQlEjViKMbG4VWIrLOGW3KM=;
        b=pjYYCOHsgy1mZJSreFlIeJHdlQp9zhkZfRBj1zdtIpPEReMtUOYytvkVnUj0icQU4q
         M1DhNhYtmdOwHxdcizATFnVDUZsdsPYU8ZB4+2JNah+izX87DFlITxSTYTbyfSSntMkI
         Iieu5ojZdjFUHEBa8Sjm4PHyilp48JpjzJ1IM9c53GCeg/vN22aBd+o9ZMU9ehdOOHg1
         V/j7G/wSv8W+6vqnMqB2XScV+wC/l8q0NWhb0qEoSgn5cbv7A433WCeETvAX+A1S750z
         hJHRILMQtBhMSEJiyH0FRaEHf57Sb4X/LJ9Mbd6sL7pqHTLpbbaP1wpiEBb579V1IEIj
         gsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787607339; x=1788212139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yWQiJFBQ6Z/CdcZVha4rKQlEjViKMbG4VWIrLOGW3KM=;
        b=eklO9p73xEb2NVW1PPLq89bVboAhbME9rwZGBiTehXzOKApouu/pmcN5Q0qRtmBoeN
         bSZzxacffqlLU0ttWEOmBGu/ixOPQcq7ZN+GKCiuqiphOCa5w0P6xe3n6xiTlvAe3fGt
         bBfeV0vPHeB4G4pxs3pU2glJtY6Z2Uc3H3vQG145ReRkxEiV3wO42+gfUrCF3a8rOuAs
         o0UufRjl2A4KH2Ao1DxTnHDHZbJYwsl9zFkZupRHw063lBTSCjx4Tl+d41P1ZhpZhlV6
         IIWb4gtBucxNOOVZKPnYt+macwZ62mfcIQCqYmTRBDftKz62YKSA4KBK73G2nn5Bcdul
         1/Xw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3tTFsWkBN3m7nbUMR3jO5eo7wysobcwtUT3LkPz6uYJt5D4p5mBn0bSrXA4Kan0TlusNclHcSxEY=@vger.kernel.org
X-Gm-Message-State: AFuF++mx5B5ij8eQLwN8oHNUjEhHAoBVwKVx8b902TsDFAWqxwzY08Gt
	U4jrturqg+EfX8Qg2rpyUKjgNkSsUbefZElXnoFN8xPbQUKUaWMfhzJ3oLSMgAtW
X-Gm-Gg: AR+sD12ewKponSP00nP2bN/zb/aEXs3stPBHI9P9Zo7Mr0UrGTMV+Hy4utEJwNZHRZp
	TBzdK7VIhyGED7CRx6pwW3PtyLVCfDgGLurUbqFLiEYMthAz5WDgBkbosix1+g0FaeimZDGmOr3
	E6OKkU42kQQozX3ZyQ1yBuXcKHXl/eFC/SZWcUDQgDLUiQDNswYVz3ha5Vl5CdUf3p7VA2R4YG6
	I3kmDgx52VoVCSG9AjZM6i5+5Kkk4Gi7gAIXI2aaqGKJ+13QZ4SZg7ifHBmDDvf1xStnaPT3Kg4
	WIfm6GqlRkGTRgHS7vJS8teXcXgtbIOa7HZEyMvXLKvKBxpR+FX1T59xFo7lZEZ9MK2lBvtv/vi
	oxcqxR1gyUX5eBZOeXDS0Hw59wjzvRZ94+yXOhn92MDe12K0/ukwH5bQQOLzR2kPu0nlqx12nm8
	yS5W30xJlINXhHgVpq4Q1rEdZOzRWN6qUc/B4RQ0rNFDI2C7cfeY6oDt3X7fofjrNM8CZLcuExI
	dKbbq8JYqsJLmsCVf409Zw9
X-Received: by 2002:a17:903:22c3:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2d6dca94914mr40050445ad.4.1787607339160;
        Mon, 24 Aug 2026 14:35:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1010:84e9:817f:7171:6561])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d67678af7asm21685125ad.19.2026.08.24.14.35.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 14:35:38 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: sashiko-bot@kernel.org
Cc: blbllhy@gmail.com,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net
Subject: Re: [PATCH net] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Mon, 24 Aug 2026 17:35:30 -0400
Message-ID: <20260824213530.43827-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819151026.9296F1F000E9@smtp.kernel.org>
References: <20260819151026.9296F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 19, 2026 at 03:10:26PM +0000, sashiko-bot@kernel.org wrote:
> This is a pre-existing issue, but do these error paths need to reset
> usb_rx_leftover_len to 0?

Yes. Otherwise the next transfer retries the same malformed leftover and
fails again. I will clear usb_rx_leftover_len before returning and send
v2.

> This isn't a bug introduced by this patch, but does the parser loop
> trust cmd_len without validating that it meets the minimum structural
> size expected by the command handler?

Yes. The generic parser validates framing, but not each command's minimum
structural length. That is a separate command-dispatch validation issue
and is outside the scope of this patch.

Thanks,
Cen
