Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA25366DD3
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616678; cv=pass; b=Y4zzGSQHCPaoMaQGKi3I4qiiqTVFHY3g4yCMAZgRuuboJqUskxHaXkwIemNH7ezSdtVKrTQ1El9lPfL4NPKsCCs6YG7yr83ftjEhpfZgUVWnabKUdjeYujzTPp3pB+ENxUFTJPMppexx82qcHPdUFfXepL6YOvAEz3z4JJQ2a6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616678; c=relaxed/simple;
	bh=+RCrXGAvVbgYW8ZGSfqJWAz/A4QdIMKs8Rqo+fp7HcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lWP13uMsCPRnAU1xF7yyLOYfL5CZ3L0OI2hkiisHOhNOkfeQJGxmwSmwo/ydM682zeKi6Oc0CWSJRgGzk5M+237HlT+c36eUf0+cVWUoQAczWt+uNc3+2vR2aYGVweoGoLhS9J1sbRNDmkVNylCWewxCDNDkmHhd9PS2lVWdXdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=oCpbUdmb; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LbsX1Zlf; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="oCpbUdmb";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LbsX1Zlf"
ARC-Seal: i=1; a=rsa-sha256; t=1790616673; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j8FpgGlaje1EI3LJzWU4/8OffJnvMyG7GADUqhbObuhvyaSbU5PP2FzK+KZ2Kdmxkk
    Nqz/PrlsOn/v46A0t/a4rNRiqNEh59MiCN6X4yr1i8QgHzdxpuHQaxTB8u4oaPLDdvGc
    LkjKnTeufYQJaaKHEzWvQwPL4ffIiJeNv3Ws9Lk2NCsHOF3iY3slUjCrJiBL6Wgt+A0B
    uPlBiQ+91m637ZzUvBKA4c/camSgEihcYZwtjmkpmjJLyTPAKnnBFjhv9OR+QCSbYKRj
    Kmfjudr4Q3kmGc42+Z1jKfr8qiPFsVI7L9HM7XkZTkj0wR7KSWg/ubcStqnaFV2bdrEM
    bLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790616673;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EAiA34euOthpiGgEH+suiuBZyONElM0mzCs6Vc0kpmI=;
    b=JG5v6y00jrxV6OgW3ht/XYe20vSI0fR3MDh0tN6lEa1QCLf7IT6G7IToaR/Wvlm7En
    b3i2CSwusk8S/ydBaiYXH+S2lAHZxzBwB3ZV3dPvx/iSrByWafgP7kczFT+7FrLESSdd
    lJi8lv5h9zinTSH1UUyA94ss36qCvMv4bXfiDDfIMmVT9AUk/AUegtgWWw+3Zcg5M8RD
    /erUMq57Z3nrdojzEzD4s++eOCH+CQ07C7x7bLbD/grlRFRDXdBSceLTZo2seaMH0+kV
    x+atwttCIiWG2vtKQJPnb6ZhvezhboDX3O19Jiya6yx266Agw7o39fs/NoL03RxfU0D4
    coRA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790616673;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EAiA34euOthpiGgEH+suiuBZyONElM0mzCs6Vc0kpmI=;
    b=oCpbUdmbWcfP/OIh8YDluMJ1FHC4mee2jDf7iS6uZa4eVleL2zPdYRwYpHoWN6kqV7
    yeYD0P2yjLwYrWawd0jhJmdyWuP2r1+jhPA2Or6MigbWWFMNRCKCpIlPOoMneH+xB2S7
    DUjL2srFlm4OHP+kiyIoG1nms1cDeUKayoAXCIoyv9AbbcZvfVGzANcfF9beRq78Cqj2
    ydeW7T1Bm+n9j8Zjsw+0ZHYmsWGzYjatbTh9xV7FqJRfz3XSCsk4yTjj8EaWD1ZwJ1Mq
    Bd2d/KsUZrA44vRjF6Tk9JOgwqtqOEGh7l/QHOEhindHYr1dXKKEfwZuLPK9gPbVIyLR
    KtFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790616673;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EAiA34euOthpiGgEH+suiuBZyONElM0mzCs6Vc0kpmI=;
    b=LbsX1Zlfp5JBKUEzg4EQxNFucJyRKy1jzaPjEru3srGcvShyEtk2IuXBUzxwALsATj
    SRM6I4+0sVXCnDHegrCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SHVDOjp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 19:31:13 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 0/3] CAN netlayer fixes for stable
Date: Mon, 28 Sep 2026 19:31:02 +0200
Message-ID: <20260928173105.51765-1-socketcan@hartkopp.net>
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

v2: restore non-zero UID value generation for isotp cfecho handling

Oliver Hartkopp (3):
  can: remove CAN filters independent from namespace
  can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
  can: fix unique skb identifier regression under RPS

 include/linux/can/core.h |   3 +-
 include/linux/can/skb.h  |   4 +-
 include/net/can.h        |   3 ++
 net/can/af_can.c         |  35 ++++++++-----
 net/can/bcm.c            | 107 +++++++++++++++++++++++++++++----------
 net/can/gw.c             |  10 ++--
 net/can/isotp.c          |  16 +++---
 net/can/raw.c            |   7 +--
 8 files changed, 126 insertions(+), 59 deletions(-)

-- 
2.53.0

