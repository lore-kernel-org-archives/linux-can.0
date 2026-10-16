Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C63B42C9
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135032; cv=none; b=TB7x2LJjndnWrdu440g+0+MxcJdgeLolw176JCS1BKrPEy7l4WBa169RdwgnXtiz3ChP3k+vT3tW+j7FTW8ndFzXfebMM8fKbh8Lhbquo4/wJtVEG7pGx4Yy5UqTkBNkLpVlIDMxCV1C4Zf0QuS6UvBHVd4PDG6H/2BMz2zHhN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135032; c=relaxed/simple;
	bh=WYIoHRWahmE2fvmt+avDjJLVf4iUC15MrcJZtroluhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JYxAbD8iaNVGwZt7u2Q/J/yMtTdGlDoWBKzUUVc1NdZmA+d9vZHDhZMNPu27ZI/jLS+JiYjsFYLP5BGhdAjRu15p8t9pMNUiQWANXEOxVnofpZNA203/MXGG1wOkDqWDX7mG2IP+Hr2t3eS1XplFm4osxWmhh7RCHd0wia9cI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljB4bnyv; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljB4bnyv"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30b6dad2382so14704263eec.0
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792135030; x=1792739830; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WYIoHRWahmE2fvmt+avDjJLVf4iUC15MrcJZtroluhw=;
        b=ljB4bnyvKLk/t8VWqupEePEo8p86nyEJndWQkJ+twE7aQsnLkR1ip0bPAF+i9J/Ewx
         Y+7ALoeK8MWK1FbCZfM5r1kJIwqu5Zx8tnJ84LZpUt2xxTeVjWlDKrMNzW47WBsWBAOi
         DUqddf0ExPC866enxMpjhX7vPULYdXzmLYn/Ztg80GQCvN9KReZqvbTeB3yaFHIwmAb5
         ftMCLH4y5ClGAhFXBuR1GndE+VIgCXFXDNoURkMC1q+9b02V6693dHpC+Z5DVW90pyeQ
         PGhZ7g5uM/VPhGsgJj7m/q/w/SuRYoWcIyKphiGqSeuQs44EgzLearY80ZP1l7TVGVsd
         tLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792135030; x=1792739830;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WYIoHRWahmE2fvmt+avDjJLVf4iUC15MrcJZtroluhw=;
        b=RYGs0y3H5knCik4vYHkSCj76n45JSz4BAVmBhA4LjdHunJXSfkz97K7WU1gILhothV
         gD4vYaJkgVDOtPy9z88lFYLt+HVwksubrD5lYLTEVCi1PZIMm6XR5Jt66BonOyotjdtC
         lPXR0QtWzSwOwB1Px/kZQA1vnGS8SlFuN3xyQBUVwh+NwrMiggbVVVyWP3Wz9ugu9Gvk
         E364uzh8BKPCMjPhoictz39Oyc2CuArQHe08f0lTn8VU9ORFFjM98YnjqJ30ON+19yH+
         RI/QrgpccKYmGh1yKPbFNnTqNpTjjOC0zAZwazqFK0suV1Ecml+WTRvhYQ6vGEyZI5qo
         5w7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzieMR8T/Kq5HENo5LaddE6lIWKnSr1RggbkwLxJ9utO/J+KzpM397ZSPGCOh/nJTMBQxdGEACPr9g=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeAGiZZZRluB0p0vmL7NlG1mI3EmdsTqx9KQqcvGrM7PSZM4Lr
	UOAaiyw42l+bSqy7c5BKgEzY9ffM3UGtjmRHbbQFOYtJMlywy53ybJus
X-Gm-Gg: AYBFou1OzNUydIsuWtpWUNLtw6Hq7D18PNKOwSul8zu3+HBhoAHBKyfJcNeJWf0qPde
	CFeDX/7JkIs8IMefAgGt+hed74g7fS80Vgjmkmo7uo2RXJ8TcDd0fMFM6riu2/hJK2ZWnwrnJbQ
	K3ok94y+fbSmD5JlpjGSkLPIO7RZ+5SysIyQ/BnIWnG7DRHzO4INg7FyBO0WjzIX+jUevap0wm2
	0dyURyZ8knrX+A86S07I/xRZ0q/KL2XFqTfWmEUvNgM7Pokw+gi9v6C8dSFyboZQ0kFUL+j0GHx
	sDWcANEiRsfKCxjQqFhSxeFekkMKFzNPdJ4HxpHf3y/irg8iuRI2+UodSBtxSv/DBNWooaW8VvT
	ZXeJqT2EF/8SYRrx1hk43gP6rSqVRbpXLX3jWq4YODyeSovUdblFumSf3L6TaB05MJJM4M6IET/
	p7nmLvtbTgcYuy7v2+lnF6U591U+EPSoSFnBliu6KBzlTGoyJ2sLH80XhgPP6x8eDXE2Sq
X-Received: by 2002:a05:7301:9c91:b0:35f:8c5d:5928 with SMTP id 5a478bee46e88-35f8c5d5bc7mr4763847eec.30.1792135029915;
        Fri, 16 Oct 2026 00:17:09 -0700 (PDT)
Received: from [127.0.1.1] ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm3973233eec.22.2026.10.16.00.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:17:09 -0700 (PDT)
From: chaosheng.qu.linux@gmail.com
To: netdev-bot+sinfo@kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] can: don't discard the platform_get_irq()
 error in probe
Date: Fri, 16 Oct 2026 15:16:59 +0800
Message-ID: <179213501981.212310.9988031427961239592@gmail.com>
In-Reply-To: <179213131512.408196.11368789495251891862@kernel.org>
References: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
 <179213131512.408196.11368789495251891862@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

The issue was identified during development while reviewing the probe error h=
andling in these CAN platform drivers. Manual inspection showed that negative=
 results from platform_get_irq() were being replaced with fixed error codes. =
For drivers matched via OF, this can discard -EPROBE_DEFER and prevent the dr=
iver core from retrying once the interrupt controller becomes available. I co=
mpared these paths with platform_get_irq() semantics and neighboring drivers.

This was not a production hit or a syzbot report, and it was not found by a s=
tatic-analysis scan. LLM assistance was used in preparing the patches, as dis=
closed by the Assisted-by tag. The controllers were unavailable for runtime t=
esting, so the series was build-tested only.

Thanks,
Chaosheng
