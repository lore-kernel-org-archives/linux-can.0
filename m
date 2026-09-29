Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B88367B74
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699675; cv=pass; b=dQjQxOobC9fhugOCchEScfhSVNIatVhs8doxAuThwhTQseN2/Dzj9dEdgCc0JqaVyF9om1JF+ngfvHTCxHHq4FqT31l4F0e4Ut6ll0bD5xBROH+bJv5RhfD9AT4/aOTVbF/vqBAZrqDZfDG4Gu1r7zpTi1c9G9kLNWeRr7aDl3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699675; c=relaxed/simple;
	bh=2umtojJDHds3UWjnMDx8UKPXfVbBgx2fgPgoZ4OIQZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+XJMnTPTOJaKQ3dJHO7oJ1wu+GdKDXkh323wyOcbv9rUtcXDLpF+hKskt0jkqVEyCwwOeqxGNxBkV9U5TlF741vcbqS4w02i8vTrk6VBLwNU7A8UeP/a3boj2hUZHh3mJo2AHHfnUre0mt9F85nCh2DZZI3illswm9w9Ea5tGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sI5xSjFJ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VlQzFTIK; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sI5xSjFJ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VlQzFTIK"
ARC-Seal: i=1; a=rsa-sha256; t=1790699670; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Pikn4TU/ABVY+Muoh5ut0jNQdjq1aXkzwXMex6bzzyYUR/xFaEyQhAN/lN0QdCDPhQ
    x9W2kAqgbQxZ7YvMn7OG1qnyt/e9j9VEtb1HVGC1Nf3YylMnxj9UEwTvlqdMU4e4we3e
    3ZYKBNATYZiLkubLnw1Vvvm91zS772BuQf89HsViH4DnZyVClynGl2F+hDKfXXpZINUs
    oXclONELKPFV2EjI3JZx4DkwsTd2hcah24YoeJvKGIRojzxFTd5pJQkSxoVKET93B+vM
    H7FaUiWpes3W0HYIqvA9gNhKvJxiY10a9DIPc3i62h710x9YJ95qxPJocGlJ6RBBU9kP
    umaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790699670;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=vNFSeKchleC/eCcTERiBeqixeOEdw75f/xh9tTKAqJw=;
    b=GBCO8yN2loTOYd33T7h8Z5kFy43chuTR/uFrIPOjoRYZYmB4lPDmI49iaKlm0XHUkE
    JCX32BU0ltK1mYUS1GamD9wavuJ/f2YsDSxbd7tRwCA9jb+v27Bqa6Zs1su5gUpBf6zm
    rHPBhDV8uQT1Uh1HVg41FP4DESZ8Oil6UdyVeZSCeHMK++yhEhFd0DmaTM9MFlpucDbd
    U19l6NDihYo19ngOCVcHs2aTmfX5K0vm6N1XLoMS6YtRl4+Eahj8RGT7B06277bulKBX
    SfC5ImSmsM1HJQ5TlgqJhsLvJsbsUfe1diGoz555OUjN+I4Zp/l4sgZtysVKQUxxLxVa
    H3XA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790699670;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=vNFSeKchleC/eCcTERiBeqixeOEdw75f/xh9tTKAqJw=;
    b=sI5xSjFJtuHbiCsDKoN2J0pPszR+MLDXPYAcmdbw6TZJiBaYSJq5NJmThLL4hJEkwt
    WSlwV5zmJrteF/FWijmHR9YF5D9B7EyiVFMPRmvgTfOX+tXpDnttAcVmD+SwP9Uecf2X
    YFvK4Dv1XTn+gahVsdQTf/F/QJTBBzGBIh/2FRfGwQm8wAoh7z5moFPkka151ivd9gOn
    kk43SxNx4h1b01eMO+LpFWxXVCHp9hPobO15KneeHYbmmMozM3VKi7hCfVB7wWlC9Sl0
    mpmqpG9Vlm5HInbNo2Jq6zrVF7FYDCfZ88idD9OOFChFEf9JDHdDv5DV3RUCVRvJ1JDp
    y/lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790699670;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=vNFSeKchleC/eCcTERiBeqixeOEdw75f/xh9tTKAqJw=;
    b=VlQzFTIKSxhPQAIIIPBDddAORsyYwF7kXuY3CVUBOdU+l9eZqvVmzr+ItrQJFc0pXP
    whW3YqtxWn+7+kD2PoAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28TGYUTtt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 29 Sep 2026 18:34:30 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v5 0/3] CAN netlayer fixes for stable
Date: Tue, 29 Sep 2026 18:34:21 +0200
Message-ID: <20260929163424.16382-1-socketcan@hartkopp.net>
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
v5: remove the skb_clone() test speed-up as it introduces a bug

Oliver Hartkopp (3):
  can: remove CAN filters independent from namespace
  can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
  can: fix unique skb identifier regression under RPS

 drivers/net/can/vxcan.c  |   3 ++
 include/linux/can/core.h |   3 +-
 include/linux/can/skb.h  |   4 +-
 include/net/can.h        |   2 +
 net/can/af_can.c         |  56 +++++++++++++-------
 net/can/bcm.c            | 107 +++++++++++++++++++++++++++++----------
 net/can/gw.c             |  10 ++--
 net/can/isotp.c          |  28 +++++-----
 net/can/raw.c            |  17 ++++---
 9 files changed, 160 insertions(+), 70 deletions(-)

-- 
2.53.0

