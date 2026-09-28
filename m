Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC54EF144
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623461; cv=pass; b=o3LKKB6XwBvOcVRN0YsHCRYtdVWbIU8eq4/hOKoR4FN6Wd1sfztiq76s5ZpyeQMjGFV+DrvY5zB8eJSLXGZI+VP38RPPDiHIVKCpv37ktqA+wU6HxjCnZ1BG4ptvq0yAIG84BkzZW5QXfh62koudgylgVAZJ7n37GRN0S2A6A/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623461; c=relaxed/simple;
	bh=v79T0VezA1EgLfTh733nlrvJ8mTsOEiXJIdy3ebUMfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uqGnm2rZEZWKBwmAagKMX0HePdHpxYsmgmdks6SR55lBy9nTrpSDdgfHxCiU51zLlC+ZC2RYBobrJagbUQC0x6SykJacushWTN4u6RTUVAEwAfLLvqnZ6JSTo/GMd2Bjr2ta/yfKLZ3G/YqyjIwgSviR8vVAoqAQtBKv0e2IJao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GfvSqYsG; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8gO2az8E; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GfvSqYsG";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8gO2az8E"
ARC-Seal: i=1; a=rsa-sha256; t=1790623456; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r6R7o/urj/wx2qdVBXV9ccu481XqMrQs67ikGyuaBBOz1XWC+o/NlvX1yvgPX/hcwB
    9ApOMjXs8nsfHYQUHGspKvU/YOJM8hlfA66R89U6zYMGw7pMxI1mPwIrBzsQcyUZ3uyl
    pVGWe4FRrHZa4rksOHKU2Zj7oHnmbBRb5LnuuvBzH51oHI2wKkGJgm9/Z5QtM4cx4bj8
    xZ4ezxkNvP3NU+sfeREB5fHwy13Ubr+jKajB4IilJU3buAzDgMahDLCNT7VgMW0qXF4+
    MD6RAdWMKEKE+usBUQMe5SLhhBQ3fHiiERT/MMsOr5AiuH3yKRDSmFZCfClKA8H1je+R
    U1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790623456;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=uVktPeQV++zyuweU72obWgNnLdl0gMQSKd8aWEGPdvY=;
    b=qRFtEQIgdIxu5V2MgZjsw9HrlPFx5TcgJfFWOf+s05v1pKUYQJSOYT9JmkRzCwDg8B
    3V7k4OO7LLJRIStHbYJ6Myo006r7hSGbWJ1+8TcJ4aHtraapU4vHP/jnkHxzAT+/6TC4
    NkNMDaABePqYxnsGqjXwgp/1rVSvHi0IgphkvLoq967kFrm+mQBfFq8mZAE+7vCWGzgc
    GlQhXqsZWzpCJKKuHb/ut8ezwkA5F3ZmpUgsdy6sPlG03seu7oARHSHiq0UTvfbWzaVg
    QwplKXJjX7gFsVvauk5sNCZXYpgvLgCu4NpZlLAZyVQr5ixI9+EGv/YutDwGgRw9X/Pc
    Kebw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790623456;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=uVktPeQV++zyuweU72obWgNnLdl0gMQSKd8aWEGPdvY=;
    b=GfvSqYsGHU6+eS+GS7foANiEOFuqzoMQyTyAZ2FfbUtHxjhYyuvm3eKsgg0KDuNZTm
    LzcIiHvtF0N9R1f4U+W9AmFqHSyV8GEazOvw0v6RAIHl0R7Snp3ZSPRAL/dZnwPmc3oX
    sLn+vVs3G5sU+a6IyA2D9mobm01I7OIewGKFXxfR0JRbRL20gbLJNPQ3/ckJ98Z/NtMc
    AKOxrfEwdMls8v7Tvogur8zVIbrzbDu48PcgWXptJlRZhm7HKXF9pcn4nWBETq3Er4mu
    SThCxDfBSYKJ0MrnGQW9K9IjDwYAQ0DH72FR6d3WvCbbzRT5eO4sRnGVKYHvce4G2J0S
    VcPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790623456;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=uVktPeQV++zyuweU72obWgNnLdl0gMQSKd8aWEGPdvY=;
    b=8gO2az8ElYnpNUCD94tcz3r/Wcxb0bjlqF61P0tzJfhfpGBgSgiCbE+xEKINEfDlnI
    QT+aNtxb+2ljD3oDMOCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SJOGOz2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 21:24:16 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v3 0/3] CAN netlayer fixes for stable
Date: Mon, 28 Sep 2026 21:24:07 +0200
Message-ID: <20260928192410.71100-1-socketcan@hartkopp.net>
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

Changes in patch 3 only.
v2: restore non-zero UID value generation for isotp cfecho handling
v3: omit the use of skb->hash and use struct can_skb_ext::can_skb_uid

Oliver Hartkopp (3):
  can: remove CAN filters independent from namespace
  can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
  can: fix unique skb identifier regression under RPS

 drivers/net/can/vxcan.c  |   3 ++
 include/linux/can/core.h |   3 +-
 include/linux/can/skb.h  |   4 +-
 include/net/can.h        |   2 +
 net/can/af_can.c         |  35 ++++++-------
 net/can/bcm.c            | 107 +++++++++++++++++++++++++++++----------
 net/can/gw.c             |  10 ++--
 net/can/isotp.c          |  28 +++++-----
 net/can/raw.c            |  17 ++++---
 9 files changed, 139 insertions(+), 70 deletions(-)

-- 
2.53.0

