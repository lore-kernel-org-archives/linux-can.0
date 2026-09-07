Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB43E51E8
	for <linux-can@vger.kernel.org>; Mon,  7 Sep 2026 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788750309; cv=none; b=HzDRVYr73VrPLAvnY1oPO1RovMVSuaHI4t15P6OERYaumtB5HnYHAYjWztG0xLmuhHzKsT0K7F32YH0PaAEnUSsijIWrjIsopgBn7C8VukCusevH29SlG2mtGsriknsNjw7E9Wh7zTvvYoIyMsBKWQitBVkLcys3fZUnq5zyJYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788750309; c=relaxed/simple;
	bh=jDwGIeZSxmQ+QLCqAsPbZtWRi3JWDzSBa7tgxRNC8D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArJxlX98QgAdPaUOKYuT5tPbjPZUVWzsrSbdDtRmLa6kKhVM1KmijGuU/2MorfN7pNlEUE6GYXXa2ppwO3Tw0AmupG0Y62EzDbglqDmOjG0VFjAUytgdXwT72FrlFSm+UsSuC9Njof7K5aDFxnLRCBiYKYLBS9vDhqV1lr+39IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7lKvrTD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7lKvrTD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d944747d41so32177425ad.0
        for <linux-can@vger.kernel.org>; Sun, 06 Sep 2026 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788750307; x=1789355107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jDwGIeZSxmQ+QLCqAsPbZtWRi3JWDzSBa7tgxRNC8D4=;
        b=M7lKvrTDwucm7XxMywJCfAx5ed/rSba4V81Ds6CFJBLKVX7RAnZSk/3bvl6J7xMvnw
         BnV5n2XiG+eYVSHIJHy5Ikb9pWTEMpdmGqVbkJMJDoIWrYs8RAiFPB1BVgB7psexciIH
         eKUnaCTnTMTEOZpjRGNt2pbi866ALd4mDGw9CxvAGDIwYjVe78XHrARzsYY74Js4Y+zx
         iYik848iU08B+3ziFaHF1GIwag7s2ixNOrQPFk6M7TD+Se/TpJr0c8rvqTvaz05EFdp9
         LYCLyez9O5VDi1DCqyMqAyN/g6N4D0tVimc+D2t1xkd8RQRSTcIeSRuqprt/2mI23Av8
         CnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788750307; x=1789355107;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDwGIeZSxmQ+QLCqAsPbZtWRi3JWDzSBa7tgxRNC8D4=;
        b=QsdV+5gVrsCxJ/L+F4shAdd+17k7LKgnHJkY/bzNnpybNf8dgEiPY5m1jANBIwB5Eg
         GHXh7WR+l7cUWxCMzM5u6+0CtPSBKC+NeCzyuPVpmjtiP2KklS/D5D3sDuSkWvrzKhWV
         k98ZkF210BpRqyOc5+Y3LtiUcMU/+k1xsjG4ky6oIjwDjPYeIYo9Ml2Em3JsolyCGbzQ
         3XcESta/Y7mddFhc1aelYh87Is+B+NA3TCOGXv0Lud6r1RvUXkYd1RQGOWp+dud1NkD+
         Oc+L5V7HhKobGND2dQVki7HpUcUH/Jj0L+QiUpS8pGt621hAH3CAXiEVzID6ffzmLaUL
         oyLQ==
X-Forwarded-Encrypted: i=1; AKwUvByUuthLLfrpka+rwJogUK0YAH9xPUcCt6ky0hanXUhuyBA1buY1qTsu2rfZuX8YB24E8PW+jeviGWY=@vger.kernel.org
X-Gm-Message-State: AFuF++kDIJvAIYt0ZVZFibXBrm42rGG1nvy1XMIez002ZXRADZfg+AMb
	RzooZJNiOFcHnxn54wJlMnM0ettnX9NnNh7fCqvFmi5Be4B1qrt/YibR
X-Gm-Gg: AYBFou0g0Ec4Ph8Dho2P8ETgTkd8YL6cHQAoT3GJWv1tb9ae1aLWXTOd+087f5nGGyW
	hXh5Bo0FBFNj7Kifby/IUpoOZil9/wU5siCYzc2v937W00huPjLeIWeLSTBywrJShRIT6RThG4N
	3Fzdrrl2gMhSEu4+07FqMRH2UjbRH8GWLieJjB3I7mraj6xgKSrvt39I2EwpvVlyhq95B0YW6cW
	QhRXCVXFt68XlrN9dkVHjCa/QiSI21oSsGlJL9tJ1H6GjrywxDQNcVRZ5zpcsmSSY0WjaQPzqnw
	4ZIxMhG2N/7imuVw92aqStjw0udKP/HIfoDS1YkZvqwYyJkxIJ+64TH1y1jayBKuo70mTz0DOV0
	pdq5djq/t0n/kvdKW8ce7BJcPM0faPgYbNrkfiCA/6uqbSRup+8WhvyL12SHPoHn0uevGAcGKA3
	h8r0IPakmOLPGrJU9iyz3gdSgD8fE3oMDLlaJ/HgrVjU9pwPWQ0XiEHkmsxi2ui/5NACJeg4KCF
	Q+I3P3hUnG584c=
X-Received: by 2002:a17:902:930a:b0:2d6:e074:9cad with SMTP id d9443c01a7336-2db1236f4femr206645485ad.6.1788750307334;
        Sun, 06 Sep 2026 20:05:07 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db148404b8sm38593825ad.2.2026.09.06.20.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 20:05:06 -0700 (PDT)
From: yewentian395 <yewentian395@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: yewentian395 <yewentian395@gmail.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: isotp: implement N_Ar timeout handling for FC transmission
Date: Mon,  7 Sep 2026 11:05:02 +0800
Message-Id: <20260907030502.3049789-1-yewentian395@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6ca3c6f6-91c4-4f0b-9136-9345dbaac1e0@hartkopp.net>
References: <6ca3c6f6-91c4-4f0b-9136-9345dbaac1e0@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

Thanks for sharing the patch and the context. Understood.

Best regards,
Wentian
