Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350DD2EF64F
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418014; cv=pass; b=FmLLMNNokctXK8n61PV16I2nGRLmLAcry+0tg5lY7OSlB0k19gev6BakU5gfmB8zkV3F9HPwV+JqVPW+zcPaCN2/jfZ6k8cYI37U8sswsOvh3OAXV2s4bHIPDix9guqaSET1BI3xgQPBvmsBZrQZ5x2tpyl1XpQ0hG2OvouIKgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418014; c=relaxed/simple;
	bh=CZLurvKKfr+XOX3ZejZ3hXU/aEEfCoO+4SwrqdU5gkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DmtArYK9mlEQkpmhloOsnh37Kj/irkGflDNhCfkSD3Bup6I1RyOune3s/unXF7/TKixupW9vffG3ZFc2FB9hHXRyjc8gV7/SmMHrZAvayZ4ZUeOAbGxE9qaW8mBmNm3aEy2sXs8U3HMYzXv497Yb7z9YVUYafZKcLePgGMBLRHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sJjqu58D; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=H6v8Pte0; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sJjqu58D";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="H6v8Pte0"
ARC-Seal: i=1; a=rsa-sha256; t=1783417648; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I7/nI5qfTs2kSVaS9o4twtkl69F15NOrzm/YfzJMih4KTE723uwC+l/bHU1SVG1T4t
    DX7FL1IOfm6cbGuGO/hfSPftcmzD2jRN8SgjmI9vJyYNqQVuvs3EWaaN/5jH1u2vcbVK
    TG27vbM/b6xreoueNKo9twnVmRC1zRo7APKjGT0MwPbmoBeE2+gvk6dj8+w6QTR4zSly
    1ZaRetml1y23uOGW5uupQI1ZBpfhJT8ecgmL+ABsDoMAHSvs6HepXEUXSs7cWcHhWoA8
    X1Lh6v66FRZF4VJpk4nCjmhHFFPCL4xIeeAWxUO+4znaa3VMf9A7Wl7/u8z0FB1L9MQS
    cFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783417648;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=wcskrvJYh29Ii08kdiSIswqDT37lrm9Pi12E0c8smYw=;
    b=ejVjUKLDwbOYvrtl2C+zEoZoFgyLCFgtTE3xzeg0VFWUn/M2Kpn9LcbMeyOXOWC98Q
    /UEP4xA7c/z5rzR2I1p3uuZ+nalEIr2kg92FSXntj6I74BnEJJ6u6rVNy62gNHM02Vtz
    HuqzNj7HWGWjVMU/9e0B6dvT4bk+YyTmEndyyWnNWAmmqm120zYwh/ByvTOmqJmPJHG7
    yI5ABaZIIBnCv81T/XZoJq2SzwRRyp2+0p7FfEseRPXwHCTk7xBHlPRq+KX+WTKoMrsr
    mNT3QkUbweq0SzP40iX3pFj8C2uFWdoVPwcM3knTg6beKupzkyjVQTdcdi96d1JGtgWu
    PKkA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783417648;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=wcskrvJYh29Ii08kdiSIswqDT37lrm9Pi12E0c8smYw=;
    b=sJjqu58DYg2SfRAQx4xQ9Z/CrJwh7tfXAW+7s2h0DLlc1v5ELIxlvKlayitCDAJQjL
    yQkNkiHjp58nB6DvtGzs0SkR1hyptDXJQ3sG7V/WttjQEatorigCH/QPl6r0wAexuPdS
    ORw3qS21+yRTYHLwrkdfjl34orDyLGzfVo7QGVBH4ofcGeT2Z7Wra4uHSAEHsrAJT6Rc
    LE3ZdquJdv49CGpTsvnwqytavmwgv0umSOs6jeqRvcq/NrRUaXHmqXE97WPQMXke1ff5
    eWKLNXyR/hxZgNKuV3DdPydFoxCY6XVy+k7pCHUOw4DMqT8yh/Q+YYj5t2nUoOSzd80R
    oA/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783417648;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=wcskrvJYh29Ii08kdiSIswqDT37lrm9Pi12E0c8smYw=;
    b=H6v8Pte02gs4fpu7e5T7DoCJj0ljdva1mIK7jRKWCjB6k2qw+2QqzWW3pH/sNM7mtp
    owB/CyrodndHu6c+/bBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb2679lSRsF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 7 Jul 2026 11:47:28 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Nico Yip <zdi-disclosures@trendmicro.com>
Subject: [PATCH v2] can: isotp: use unconditional synchronize_rcu() in isotp_release()
Date: Tue,  7 Jul 2026 11:47:16 +0200
Message-ID: <20260707094716.63578-1-socketcan@hartkopp.net>
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

sakisho-bot remarked a problem with rtnl_lock held in isotp_notify(),
therefore make isotp_release() always call synchronize_rcu() before
cancelling the timers, regardless of so->bound. This still closes the
original race (isotp_notify() clearing so->bound without waiting for
in-flight isotp_rcv() callers before isotp_release() cancels the RX
timer) without adding any RCU wait to the netdevice notifier path.

Fixes: 14a4696bc311 ("can: isotp: isotp_release(): omit unintended hrtimer restart on socket release")
Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.kernel.org/
Reported-by: Nico Yip <zdi-disclosures@trendmicro.com> (ZDI-CAN-31764)
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index c48b4a818297..d30937345bcd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1235,15 +1235,22 @@ static int isotp_release(struct socket *sock)
 
 				can_rx_unregister(net, dev, so->txid,
 						  SINGLE_MASK(so->txid),
 						  isotp_rcv_echo, sk);
 				dev_put(dev);
-				synchronize_rcu();
 			}
 		}
 	}
 
+	/* Always wait for a grace period before touching the timers below.
+	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
+	 * filters and cleared so->bound in isotp_notify() without waiting
+	 * for in-flight isotp_rcv() callers to finish, so this call must not
+	 * be skipped just because so->bound is already 0 here.
+	 */
+	synchronize_rcu();
+
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->rxtimer);
 
 	so->ifindex = 0;
-- 
2.53.0

