Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA001320CD9
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413363; cv=pass; b=Vu56dY1NNRIn1xF3pER75cbMMEx4oIPELPNxbrd58Wsd6b4ZF7pGwwfL5A3/jwuiQvoLiAuKMHrPfL2bTUtDVJsZld05+47QuCGEnqnxZ93IJiDh4QQ/t0GB0Q+sa0mAafywxKf4vQeFyew1XIP/92HjVBMOD7hn6K5DddokqlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413363; c=relaxed/simple;
	bh=Eaf9cQHSN7GlXS8abqr+3zTC2XbDvJphG489LZls/K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YSjQ3rFb6+T1l7MYnadmSTyv9dCrH4qMVwIzsRuHnqqbFc5blVZhHHZuNpWA3qu/lGac88nqpFIU5FBzSZRS2/jLIJCmJjSuqqA6Lcd7JlNadcyfpZ/E2Cgl0zNx5zEywcP9baqjYKTJwQ54IPqa+jMkK7+eW56iosg6tpcCSUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BpPv2bmC; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=v3HSpbmO; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BpPv2bmC";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="v3HSpbmO"
ARC-Seal: i=1; a=rsa-sha256; t=1783413172; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PlzL3fpEC0MONxAqeXZlyl47MLCKiMVeUDyw16kteypU9ehmkW4RAHFXtEuK94qAt/
    yhKpgr3VyuxoUIPU3WekR2qr7Ph9D+DlE4i6DzkGnqaPLpLVPaAwBYTvUu9xe+W51dCA
    CsAhpJlHN3K8qQo/F0UT35DvbWvGUpjJ7KrneFjMaqZLj/Eavlh7lp1RqKsYdgJ7PLPX
    qlSwYklKzYFFsjw1tK0xPBxX9X39Gc0TmgNQxjGSh7NP6hP2esQTjNtuapbazj0so2Q3
    CAL9EAvFXaPSYPZcsdsrmRDLLFDEn2DQWwl4j5M2kq6cEbKdCAXzKePrjiuOVLKn84Ia
    2DAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783413172;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1Y462xLZBMkfRXHyQMCplbxVmwrDTOCYDqlRLB3eTh0=;
    b=tu9ODVIQHZbY5xV+GSs9+eUaf7EaO42vKI3K5q2ZYKeHYx1njIBbTDo1k4HAPJYvjD
    dVbapUvowHq5Xk/EBYQoxA3PuRHQ4MAaxMnEjFuc80V3YS9cN58kpynhjukjSIULQO8N
    eIC7B+T6UVEW+tsTc5h46Eid96Egf41KyIl6eZo7MCdHTv2+kt/qIJ97F9qx56fgpAjN
    jdJI2+cjWKVsJhsvKE0Me3Oxm0kAUMtdJMz29CVgLYt0dW7MMyFPrKBf5fuHsBhXgPQW
    GfxiPIPoWboMgUl3TaPBPbVbm3MifulWzXITaoWC20h0lsvFxxsj9IMFuSqaC2mTLn78
    3CqQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783413172;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1Y462xLZBMkfRXHyQMCplbxVmwrDTOCYDqlRLB3eTh0=;
    b=BpPv2bmCZppOxeQqQHsX+w4b2G4b1k5S0dwxYeAxrJUkC7pnMwYeylPZMrd1faMAgM
    xUaae5iK6UAOq85vF7zn0/w3fDoCmrjjcvHHQrVL02nYU/Y2z9qGeR4OwDtcULqMLDs5
    gSzISWKJZWrT8uS+C9Vqb3R5np6VGKoSYR1gGXY2Ziu+F0ILwW/p80zLwn8c4fPtd5AG
    MqY2hPq1J6tmoJh/rvdQ2u8BEzE6Wxsb7Wdqv3wFi1ZIHNPEwhRWXyTlWXln6YX16Pyb
    CVE/Oy5XWqoTWhCzLVry68CPo+q9XKxjixFUSJiCnDRKOjB0B58SZx8d9/qNIafNxt4X
    MouA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783413172;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=1Y462xLZBMkfRXHyQMCplbxVmwrDTOCYDqlRLB3eTh0=;
    b=v3HSpbmO3+xzQZfdB8QwTxLArT4/XVJLyFflYAFarfOemHpSpjBTCpDLEuS0oFl9FK
    yaOJAJQAhC+q/3QEohCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb2678WqQPM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 10:32:52 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Nico Yip <zdi-disclosures@trendmicro.com>
Subject: [PATCH] can: isotp: add missing synchronize_rcu() in isotp_notify()
Date: Tue,  7 Jul 2026 10:32:28 +0200
Message-ID: <20260707083228.47629-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

isotp_notify() unregisters the (RCU) CAN filters via can_rx_unregister()
and clears so->bound without waiting for a grace period. isotp_release()
uses so->bound to decide whether it needs to call synchronize_rcu()
before cancelling so->rxtimer, so when NETDEV_UNREGISTER runs first it
skips that synchronize_rcu() and can cancel the timer while an
in-flight isotp_rcv() is still executing and about to re-arm it via
isotp_send_fc(), leading to a use-after-free timer callback on the
freed socket.

Fixes: 14a4696bc311 ("can: isotp: isotp_release(): omit unintended hrtimer restart on socket release")
Reported-by: Nico Yip <zdi-disclosures@trendmicro.com> (ZDI-CAN-31764)
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index c48b4a818297..008cee547213 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1573,10 +1573,17 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
 						  isotp_rcv, sk);
 
 			can_rx_unregister(dev_net(dev), dev, so->txid,
 					  SINGLE_MASK(so->txid),
 					  isotp_rcv_echo, sk);
+
+			/* wait for in-flight isotp_rcv() callers to finish
+			 * before clearing so->bound, so that isotp_release()
+			 * cannot observe so->bound == 0 and skip its own
+			 * synchronize_rcu() while a callback is still running
+			 */
+			synchronize_rcu();
 		}
 
 		so->ifindex = 0;
 		so->bound  = 0;
 		release_sock(sk);
-- 
2.53.0

