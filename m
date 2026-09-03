Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494184052DC
	for <linux-can@vger.kernel.org>; Thu,  3 Sep 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428297; cv=none; b=p6TO604Irl9f6OgCL1P8AQGUO8j3/LjbFogJTHqayRYzo2+jO1dkZeCU9lIiJRjDEgavIAWkD2J2PHjqJv/BWmQ13ylZ1Byik4Blxcq89FLVBK1BSZsUYnjmvA79OxlgKPKYdcOeTw+czWOTap6VaMk2ebO/64SEHSUAjJtyzac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428297; c=relaxed/simple;
	bh=Q9BId9yytQXtW2g9cbFswwLQG2BZS6hF1a5zfdPjrO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dah6wDa9sqjhZNimrtAuFiVeEaYQ7WWn0Jg+Ptk6uUiA0aySFEvlHzSuUBdfYuctxwYb1pRhyn1l6HcKdi26Og9EE950q7mxiLKUur3eynqgr7v/s26kmi5ucxeJ9HVURwdgezosGSF0t0Wnd+Ebn/64XMdxBPQHcAdJffNKIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMG8tSQY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMG8tSQY"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39927410578so3789535a91.1
        for <linux-can@vger.kernel.org>; Thu, 03 Sep 2026 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788428295; x=1789033095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q9BId9yytQXtW2g9cbFswwLQG2BZS6hF1a5zfdPjrO4=;
        b=bMG8tSQYmtDhqBaslfZrgbrhxaOpGaGDxy2GP2OIjiF8HYZ2hCrsbAFpRmlcWAx0/n
         7jdRIUapPgOu3qmWj6vdV40fzKoHoKJ3U32VJkIrWVSZbjk8BilM/GAhQ6j9A3FO45UL
         CUDLvB8s5V+THAkcAMaRqlBpUfB7YWsvXFxnnLBpQCWGhNeMNn/sefgWtgK0X9cE8e1D
         M2wyweEpBRZdWkb4KD49S7Oc0aAZyb+BMfge4yLdq55eNWKXtvxoIJFfHjhjRC5ryBZR
         qz4KkvF6SjVIwz7k0+hyWrQX6VKYPpJzBev99V4SKusJEk3u9w7H3IBisUB4RYfqSIHU
         pZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428295; x=1789033095;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q9BId9yytQXtW2g9cbFswwLQG2BZS6hF1a5zfdPjrO4=;
        b=XhPGAj5J/Y3Jiki+fa7MDoSWAK7GIFeEQJefL6iZRQMcUD8CZvy7R32zgrfWX1FLcw
         DGW29WthSGjzOAp6a2N+cD8tTIAxalRDI1S2GzDm92omsNui2Uf5ck+jLwpGUiJDD8JY
         dtuEo5L7+/Us8q0zOtnMw9RV7CoX8fCYAnLSb+3xBUk0SQgl/uqgHnLjL1Q8kk/ZcEIZ
         ckyi0xMx7pUnTu5Qi2FrvzzE3FCf+s/t8RfFREVDlPK+mZItm0NPZX6SuO6jRlIX3qOq
         phzB3CPfWyu2aVhnIac02xZL77pITPGTjLx37qfK85eTRX86j4VjF+scF7thtdcffZXY
         /9Tw==
X-Forwarded-Encrypted: i=1; AKwUvBxly/9c01fK3gelbV1IoaVXv8qTDUs+s4q0u55RQrhAhFIAG2P7P5ETsUGf0jqJTbFRBpVJqLVMHJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mzEdRw4yHxwcpS1WrA2nHzJ6L+Mi9KFi5Y+YJ3O82yP7VFagCq
	ruCEc/+EgoLgLXQMM2zLNJUaorVHWKeWw0uEGK2pusMRya7gsH00mB8F
X-Gm-Gg: AYBFou0HfjDSr9gG1xcBx3c1WSjLOmTmyvGp5cfenxm2wWSmkBNz7Ob9C/WKI13aMrO
	JE/qmc9SBZ+lQQmmf+L+SzkP88d4LuV+s5tYCQVqFWLFtF5+dp32AVPXfF2Nv2Wu4AUaiN+POxu
	Dyo3XhzBTIipNmHAXdubh0mQko0SCrvYobHdQMjTt9Iwh71c+PUVQGlEMPxsC2gNXqKslXY85kM
	WzOM6BeY4S9VmlDnVMamGHg4lm+EDlfacStgttkAzcIXepid4cZe5nsPCn371n79bBTObGgkYL9
	DkkxUWm3wub3Yhhm4Qt7azZYP8xgjgxCs1+W72QvIOEJSBfJ5ouj8o8ExlG5hblFQ9cH10yatdg
	keMYd8OzXqfRNkRgF3JdphLe+0y2sh43xNRq17Ej2VTEJ4gRflEd+5Lo3n9niPtDTeo3UmC08SB
	sS8wkeswrG5mecugdqIDV5lB32mZ8dfPiWvkKcus12CoyAV+FsA4ncMULKKPwUs3HUH+aAd6BDW
	O91wd4O9dgw/WwL7Fd/WvemLg==
X-Received: by 2002:a17:90b:268d:b0:398:ab03:95b2 with SMTP id 98e67ed59e1d1-39aee023191mr18618479a91.10.1788428295488;
        Thu, 03 Sep 2026 02:38:15 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ce4221sm5086931a91.14.2026.09.03.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:38:14 -0700 (PDT)
From: yewentian395 <yewentian395@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: yewentian395 <yewentian395@gmail.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: isotp: implement N_Ar timeout handling for FC transmission
Date: Thu,  3 Sep 2026 17:38:09 +0800
Message-Id: <20260903093809.1894919-1-yewentian395@gmail.com>
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
Content-Transfer-Encoding: 8bit

Hi Oliver,

Just a gentle ping on the frame_txtime addition to rxtimer you
mentioned. Happy to help with a patch if that saves you time.

Best regards,
wentian
