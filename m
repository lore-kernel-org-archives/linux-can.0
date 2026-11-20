Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174154;
	b=MGpXMJ6oDHGCg/oYzs4G7VJ+Hw9lak3Ih4NZkwMKMV1rw2G6QIopT2q9DMdiM/LJyd7j
	 mJ7E6EDc3NQ7l6Kug0kCfzEn+Md+kYWBF95JeAcDY9kgrOy8T7qvpKwctZANhxnc5vFNR
	 Vr8RQT3Xj9PdAg8QqfDpJtnkWF5tgn4zoQ1QGpU2qsv9KX5kcujpCTHABe9yfPk34g0Dk
	 lGViGabNMuh8lvT6vdtaN7Ly6yYzbKWV/AD1lVq9Pg7+WgJlD8lpmtUZ7fgmghf9Xll30
	 +kDNs7RpIO2KXB1Bp49lazZ1U1iOtK2GlyqPR208JJfPnrSybZQZK5NTVsWZ2/O6Hdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174154;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/mNAwVep5GJ62cCQ8PEJiWl9l9BzUfOWKzJcY7GmVq8=;
	b=lThW7brznWOyGqYFoit9v8vbTTJy9bnWsW1CMYfbTmsG00LKQTe/5Hz/D3UmKJRcOiwp
	 D4C8hKr64iKkWtl+Fmp+WAqzS0hrChKJxuwuHJgBf/zbazVtcdvoEyTHfP13VlM/A7vKN
	 EIQr0G6F8TVvu5BDuuYnBf9B4wjiLIvSZlhazcpXvvYbUfcD2Hovla8gLU207Zt6e3Euq
	 lDAIvS4ETaDYH9kDBdaz8+25FDHWLBuJBMKbTV5jA2lqhmoiktknP3qwimRtHwIX9R1ty
	 1F96mZdeRwhAP2yF8tKX3lAioVQdDI2jJrKdh2E1HDYiEW5AZ3iuhw8kSxmfjwfcVIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=fZt4UKqw;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=g74sU9ur;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.169
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F460A260C
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E48F460A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=fZt4UKqw;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=g74sU9ur
ARC-Seal: i=1; a=rsa-sha256; t=1795174143; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=noKIPZRCjgtJZElnerjmtRZUHVe5LIYWeGuj+3z37/37RfwFoGGeYTG/JH7nUgOEqU
    4OEouG4V8SA8IEgeCIITTV1H3w9DElat5yTVQz/QeE3/fbGJ7ADxeHI5R6GhkuRXjvOA
    N0b9+Mj8Lazt2JVLN3JkWGtuLO4YNfjWY+qrB9HRcpxojg4znyJxtVzmUY8jpkdT+DJb
    Up0oVbSb2lIjDw6G/e4tYt74sZdKLdKG3lZTLK5gdVb5peSCKR7t5eqmJKh3RnfVlIad
    QqICs87TNPJt3YMfj1ljss3OZpozTXZgLZuU1zrpJ9anDEwh5Jl0Rb5Nmn9NSPGqi+hO
    Xnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174143;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=/mNAwVep5GJ62cCQ8PEJiWl9l9BzUfOWKzJcY7GmVq8=;
    b=Y1icCeH+66vChBx6e4WqZYuUC5Db1epQhzRWYWV9Jlt905G1+IdFvtVmo/iag9PzNE
    tNSFCu4XzMaiA061CJYCfLtkn1EtIMlNCjYVIscIkCaAcqBngJ3LL+YTc2rUIUKjU8eV
    4egAv330pMCjdwsF5pvUatN8NbglBRkdl0GWc/Q/lUuxX1kXGZnr6JXdGgeYRD7He/h4
    EdQz2YZokuOMJFyQDalFESQ7B9B+I6jwss/lMDAqGv4yXf+iObccdwCV1EkaIJfaGOhJ
    n1uLnp0vtjF8qBcR185SmX9kqAH4GYqx1Xli4nUm6fEbEpP2YqfCrrBNEMH8o3a4z+2V
    Lj6g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174143;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=/mNAwVep5GJ62cCQ8PEJiWl9l9BzUfOWKzJcY7GmVq8=;
    b=fZt4UKqwlgNTNTi2TJX3tNTPwSz0PYyBdMEvanXegUinULVqpom1rsw1MuuhorB+zG
    cjonTpIopgyuUfuX6MI8Ia15Hn0pRT2eVyT/BRW+NGZLzuHaCPAFeBx/m1Su9+A9aTRY
    +B96wHKyt4YVhV9zdk/gKNSv9B4Sf06YGfUiFDKyDsguOGK/BxugFdRDdnkv8Ngqq3If
    GBG+ZgHyosHUHYqqLElqK/Xlich8gNRL5xucNs6qLpIgCzUUcNFQ4X6SQYnlt/RFE2ze
    w6za0+dG5yL2m/d62gBOmngyZBtHw0sCbBsd63NzTpaxakBWfItHBLouMFaX0WvkAzsy
    kSvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795174143;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=/mNAwVep5GJ62cCQ8PEJiWl9l9BzUfOWKzJcY7GmVq8=;
    b=g74sU9urH2GP6lG1cfIUPTt9GtHQAnAfXWHnapOysretZ5Kgqilb/PXaA+li1M/hBW
    99jUeC/+DrugQuvMNQDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AKBT3QME
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 20 Nov 2026 12:29:03 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 20 Nov 2026 12:29:02 +0100
Subject: [PATCH v7 8/8] can: netlink: fix static FD-NON-ISO mode validation
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-can-bcmlock-memcg-v7-8-f6b84f5257b1@hartkopp.net>
References: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
In-Reply-To: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174141; l=3666;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=f9ttjRqG9xjtV1yT99/wMidVxDZFE+6GChyHKQrSk98=;
 b=AxGQoLvRC5JntMP8DNaQ7fD7CcYU6GSfrm0MBP0QutOd9QudO4MbNSJW0mr0eALNbfdASxr5w
 JUNXqLHcWx0AKC56p/kuYLv40pGxyTh3gYUBS78y77RE9meZvEyCV5t
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

From: Zhu Ling <zhuling0805@qq.com>

Controllers with a static CAN_CTRLMODE_FD_NON_ISO mode (M_CAN v3.0.x and
v3.1.x, PEAK pcan_usb_fd with firmware < 2.x) do not require the
'fd-non-iso' option to be provided when CAN FD is not switched on by the
IFLA_CAN_CTRLMODE request.

Since commit 6742ca18cb41 ("can: netlink: add userland error messages")
ctrlstatic_missing is calculated before this exception is applied to
ctrlstatic, which is not evaluated afterwards. As a result every
IFLA_CAN_CTRLMODE request on such controllers that does not contain
'fd-non-iso on' is rejected with -EOPNOTSUPP and "missing required
FD-NON-ISO static control mode", e.g. 'fd off', 'loopback on' or
'one-shot on', regardless of the current CAN FD state.

Apply the exception to ctrlstatic_missing instead.

The exception must only relax the requirement to *provide* the static
FD-NON-ISO mode. It must not allow to *switch off* a static mode: before
the above mentioned commit a request like 'fd-non-iso off' passed the
check and removed the static CAN_CTRLMODE_FD_NON_ISO bit from
priv->ctrlmode. As can_get_static_ctrlmode() derives the static modes
from priv->ctrlmode, this information was lost permanently. Therefore
reject any request that explicitly switches off a static control mode
with a dedicated error message. With this check in place a static mode
can never be cleared by the 'priv->ctrlmode &= ~cm->mask' operation as
every static bit in cm->mask is also set in maskedflags.

The request is rejected independent of the resulting CAN FD state, as
accepting it while CAN FD is switched off would remove the static mode
from priv->ctrlmode as well.

Older kernels without the above mentioned commit do not need this fix.
They can lose the static FD-NON-ISO mode by an explicit 'fd-non-iso off'
too, but this only changes the reported control mode while the hardware
keeps using non-ISO CAN FD.

Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
Link: https://lore.kernel.org/all/tencent_3A964832542399A780E646D6A6246335C409@qq.com/
[Hartkopp: reject switching off static control modes instead of restoring
 them, extend the commit message (Sashiko review)]
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115095746.709371-1-mkl%40pengutronix.de
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v7:
- explain why kernels without 6742ca18cb41 do not need this fix
  (Sashiko review)
---
 drivers/net/can/dev/netlink.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 081dfddda000..521e2496e2cc 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -328,13 +328,21 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 				   "requested control mode %s not supported",
 				   can_get_ctrlmode_str(notsupp));
 		return -EOPNOTSUPP;
 	}
 
+	/* static control modes can not be switched off */
+	if (deactivated & ctrlstatic) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "static control mode %s can not be switched off",
+				   can_get_ctrlmode_str(deactivated & ctrlstatic));
+		return -EOPNOTSUPP;
+	}
+
 	/* do not check for static fd-non-iso if 'fd' is disabled */
 	if (!(maskedflags & CAN_CTRLMODE_FD))
-		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
+		ctrlstatic_missing &= ~CAN_CTRLMODE_FD_NON_ISO;
 
 	if (ctrlstatic_missing) {
 		NL_SET_ERR_MSG_FMT(extack,
 				   "missing required %s static control mode",
 				   can_get_ctrlmode_str(ctrlstatic_missing));

-- 
2.53.0

