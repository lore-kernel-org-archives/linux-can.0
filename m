Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB74EF140
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615524; cv=pass; b=bdWJ8zcut24Wg4l0tSRrkAaiQop1bA2oUEEJAde8NauAsNbGyVB+Ib3SItiI6rmC9lb6Ev5D2nwEzHMmz7gJ19W3RORsgP5/6qW0k6f7p78FHjgAK6ZEeucvJAUTVzrh9L6ErLJpq1wM5mOcjjo5CGqANS0DtmXPB3L/2cSz/PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615524; c=relaxed/simple;
	bh=Huw1BI1FO/TBN5EEtR/cUAp5iDQOKkY05pq1QIbPBHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WZnOes04xWRud5TbUhTIf973rZVUoMkSFWTpizIfYWXgaz6ZsihQfy28SOHkLpE3+OzuZnamO+XTq3tid7qkNC1WyOJEurt5gopW7dkBFKz2zN0luiBO74fr1qbFTVLvvSj72MTVxqB0uXrEuY7DhMjyu3Vw/Ehke01MmOMzkcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WvZzIevA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PSJkBz/R; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WvZzIevA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PSJkBz/R"
ARC-Seal: i=1; a=rsa-sha256; t=1790614793; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MWoVjdeVe+eLj24oymmiss0iQCXFYRj2nZuZ3W/aXFKv0onMsHmeFxjjaxg2lOQtJ0
    F0lbt14vuLRiQx3hLLRPmbo5rqMYOQ9h1EYYaocxbUgKA3mJVHz7t2ziDbhw86wT6jS2
    Awo6BGf4E9n0704RIoYjmX4Aq0Tey393Pmp/4MoC/Ltt/L/7GgHj8o86PTjlA4e7Kzj5
    l7cY6NMhzLrWoHy8h6VrroKLCjO/2GUuMWhVjHV8NGYoNAQvsiHjv/FVFVOn5GkCFwjM
    YiszvgEcfHc+GSrQfb5uw1PFeaFLd/owq/WQLZw5SS2EEG1PRMRe9rEshgNNJGrU+/UJ
    sawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790614793;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aK6AxXblI3oo38fciZU3HAW68nhZhmC+uW4aCngQp+c=;
    b=PI1Mji1hWW4ivawFf5tuMWYZ+nQ93gBvbZWZ3maeTS4zTflH3xb87iiSdC5jPBIowU
    KeytD0qNXXTs9mkju5CjfkUuWoMJ1F7qctNjC9NnorfttTylQeY7+YJZU7ssCCyNbeaO
    guLOoEL61V228aHzO/cBHsYxCILrOMjWhsrSSI5zeZGDd5MZWpJsh20rBbpfPiimlNKl
    v7ijppdmZVH0dkTPCAZgAIKz3FWiGrx9Vx3Uqx0BJWDDsDNt9PRYeAYU3rRjq+f5IHye
    2HOSNeVfGFcdZWazHBaOgHwq0mbhFmBLXm5p2OhdoataMAompiz3MFuvRvQt+e4zXhZe
    n2Fw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790614793;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aK6AxXblI3oo38fciZU3HAW68nhZhmC+uW4aCngQp+c=;
    b=WvZzIevA4ezDby3n5B8CBCtO9xurde46mUTOCVuVH2ndIl0yE007m6gJZVCIY3Ot6L
    wScvjpRq5LqI/0vqtqfukrbcGPL61vz2BMJk/8rm5mgZFAkDm6+RRt+0tl0Cuo4u0BZq
    pHitLr0NE2eubK12yYQYHVpYwOUV16qKZHYQ55SLJRsw8fBrsZMqZUnz4a9+T0TvQh8F
    ZQcwdX3e41Pyjr40YWydEZwxf4i538+Yf5q++HxDA8fagxtl1fh75Fpw/jY4vL2Au88m
    LGXFjnJDQXZfwXthWnU3yS6AUS5bG/n4Tc27mdlZKT82KLJlQl/9yuEuFiiC7RZb5W03
    hx5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790614793;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=aK6AxXblI3oo38fciZU3HAW68nhZhmC+uW4aCngQp+c=;
    b=PSJkBz/RmsmPHHY7cQgfMC7IU1Z1vFy915V4Ry723u8KREMK0KUG+e1DOPtHimmyi8
    oAbMEWDqxEoCrDRDmNBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a28SGxrOff
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Sep 2026 18:59:53 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/3] CAN netlayer fixes for stable
Date: Mon, 28 Sep 2026 18:59:24 +0200
Message-ID: <20260928165927.31667-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set aggregates the open stable fixes for the CAN netlayer.

Oliver Hartkopp (3):
  can: remove CAN filters independent from namespace
  can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
  can: fix unique skb identifier regression under RPS

 include/linux/can/core.h |   3 +-
 include/linux/can/skb.h  |   4 +-
 include/net/can.h        |   3 ++
 net/can/af_can.c         |  36 +++++++------
 net/can/bcm.c            | 107 +++++++++++++++++++++++++++++----------
 net/can/gw.c             |  10 ++--
 net/can/isotp.c          |  16 +++---
 net/can/raw.c            |   7 +--
 8 files changed, 125 insertions(+), 61 deletions(-)

-- 
2.53.0

