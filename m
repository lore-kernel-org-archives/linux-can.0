Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A813D9DB0
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696681; cv=pass; b=KYrUUmY2Akznb4GBuWrLa2wn7rk+tG7ZqegNU01jCkQD4qDk14irn6sIN4ClH57EkljSHbnCyROd2kyHF4Gqa41k4gM7lav4DIyGd1E66oLoJjfs0fzVK266hcOH6buFG7wBiEkTLQPPfC8x8dY+hN/uxz0/xbjsJpftwCqD0AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696681; c=relaxed/simple;
	bh=8o1uLhyJEpOeQReDPO6ZiLMOXkaq3Arbt9mTzdeO4Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/8ToUgqQH4UZsd0WoiHRHSco4YSpfZermGrC9puYVdkaDczPtcc4QSpbwjkLr0+P8JEVY7/lJddUGnKbojBxw6LZNI0etxV9o/xdep/d2PQDOqvkBNTSf+IoNiqqnBDp4aiekiLJqRso7qCN9ZROh2ma9l/V8kX18M4L6YTHV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Lt0NaVFz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=KegFVg6J; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Lt0NaVFz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="KegFVg6J"
ARC-Seal: i=1; a=rsa-sha256; t=1790696493; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lf9XYxcwNP3lCWgNRWEy16/+CvWmJm7DyyEp2JNrnx5DsuQDK4gXpiXYLeXL5ncAmU
    FVqhMZvqwi2ibLF+hbFujogsfrSzlD1/nCDwia4p9noe7FP/guiI1i0ur4V2VCIDnFzE
    QUyyof8OpB8cLmz1eczfGWoUISlLGHwbQ7K7j4l7cRVplyP7ZzEnkPDhvV12L8WnrFxA
    jC/td3s80qnWAQaGPm51S7dZ6u8KowCFp3xBeg7bSII4NLbdhZwdeFHfKVmg8NnsCFRc
    bbl9NCOsBMq/KwV1x0VU7VqZeGQXVMx0dFONynWgUnHAjvQ3Q9wkJTSDRhCuFCouZAes
    qXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790696493;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=+n9YS++NwhEo8SIXWjTiXuzt4UH7gdha9Xhqcgn9ycs=;
    b=jZLE7kwrw1nAPgTIo13exTJraLEzukne0gjLp5E2BnhVzTaBVtswCmdb+cAH8umcCb
    sx5szxhZ6IrGSz2371mObuXgL3DlWQKygQIZdL3DUd7yXqxm0AoaciXeyZIWklhUaynw
    QAyrg3R34UQyAiVplFxFZ4KDcrhussHfv2zZawk0m32UdG1qjaljI3CE38AzAenidBIE
    oVPpqBhAJ50z38Yh3zwsMxdoR8hUbMxqQHwOn67cTjlFFi6XGcjGy/Z2jW9xWHZm5o8y
    1XF44blHN2rjL93Lxu7Lg/zObtS0QnFNSuX5BNlikxy1yrjk0XDbdmhfdqagLUwrWjmX
    IK+g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790696493;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=+n9YS++NwhEo8SIXWjTiXuzt4UH7gdha9Xhqcgn9ycs=;
    b=Lt0NaVFzExxnuv9CKLHQevFCfURhvKccXoO3K6QMSbCFbMxaY/ZAolu2IoKWU20vH/
    ZxAbGe1YeoEF2OXZV8pixY3wP7gEZpGXc4y+Djuw2i9B0gT+5lRpXifCWo9r4cqXVZY4
    S5IAo4E+tT/lIz7zESOP+/vxMRvLyCjuEGUJ8OXFwyoRg4F+MelUC+OzR0SKqnNEbe46
    Oiy4os6EYwBsjZWOfKDCUTRAY7LUOv1FwkESSe7lPiEc/JDnttqTgToJ9zdUhXfIt1Gy
    +2cYoSRcg+k99NQ8/Ym4X9T+nLri2Xm+EFIadlWeh/SH5Ch8S6Z0OPAwQkCa/BqSqHTv
    VcrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790696493;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=+n9YS++NwhEo8SIXWjTiXuzt4UH7gdha9Xhqcgn9ycs=;
    b=KegFVg6Js6LnE9+FovAsAIiyF9kOfRPGufKIueDXbfC97/qLpZXkDjfguG/skcIlpe
    9PMR1MzzOO6jlj0zfvDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28TFfXTeT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 29 Sep 2026 17:41:33 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4 0/3] CAN netlayer fixes for stable
Date: Tue, 29 Sep 2026 17:41:22 +0200
Message-ID: <20260929154125.3298-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This patch set aggregates the open stable fixes for the CAN netlayer.

Patch 3 is new and addresses a RPS regression but it needs the other patches
as basis.

Changes in patch 3 only.
v2: We need a non-zero UID for the cfecho checks in isotp.c
    So restore the former while (!(skb->hash)) statement
v3: omit the problematic use of skb->hash reported by sashiko bot
v4: address tc mirred or netem duplicate clones suggested by sashiko bot

Oliver Hartkopp (3):
  can: remove CAN filters independent from namespace
  can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
  can: fix unique skb identifier regression under RPS

 drivers/net/can/vxcan.c  |   3 ++
 include/linux/can/core.h |   3 +-
 include/linux/can/skb.h  |   4 +-
 include/net/can.h        |   2 +
 net/can/af_can.c         |  63 ++++++++++++++++-------
 net/can/bcm.c            | 107 +++++++++++++++++++++++++++++----------
 net/can/gw.c             |  10 ++--
 net/can/isotp.c          |  28 +++++-----
 net/can/raw.c            |  17 ++++---
 9 files changed, 167 insertions(+), 70 deletions(-)

-- 
2.53.0

