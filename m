Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6170545D9A
	for <linux-can@vger.kernel.org>; Wed, 14 Oct 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987701; cv=pass; b=lFoqOT8JRWdpdhWVCFSom/vsAgIrdYdUS1m1e6KmxUBsePc5NUMgngFzL4/jyLNE4bCH57jxQl86OIEv9HTIgA0ml1a5oG3mzolxm8oipMPwwWJIl8D73YlfACRHefKMpGj11qt9BtTULmKcgLYX2FksNw5qu1F80LikmQ6sPTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987701; c=relaxed/simple;
	bh=KaFkwGrI9zGAmmlY5Nt8w+g5r3wO3xwsgpMzb9msASI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rw7jNT6VgivXEFPL+ulTpHeaIWZ36mXW5e1kBzoB1IZxG9jz+ewT2HNprXn2OEFCeixRuOL45LgIjerNzNbbR77QukQXrCurIqRHsRF6udxtvvySg97OU0MbjSFXdPHLTlszt/kad9GKPAUETEw2yzKmsTxUvonxWQWJxNdK4gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=E/f7RkFl; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=wO6KFMP8; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="E/f7RkFl";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="wO6KFMP8"
ARC-Seal: i=1; a=rsa-sha256; t=1791987697; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=S4456qWsXiycZe/nV78NMbM/ia8uPH4EQKF2G8ggMhGxndKzhONkvosNGvXx/iqmfj
    /kovRWrB0pjuK1m144q0SYIaeJu8zYA5YdvhAHhU3bR+T+R6RvdHJ4DLHUKwy813Fevc
    PDoENebB/Xw0XLz4WnG8fXkJin1nPvjGbVl6fncFt7GCruU6bHGsuwX9RVHqwBKqKZaC
    B6MH77jYab5CAIaT8lHkDeaNFy70AIHEf37iJqjZkMo0BWHk7b6mpiZh/JbaCKTkjenE
    B/olWq3KW8xRsTqgy9YJ6gkYvRAp/ovAda1Eq2VGjGe3xXNpJ3jhsNUpWWNLZwPbg5GT
    Yw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791987697;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tLwwuKwD2trWnEgLsReqmKM4UIpKIQ65cOGwwybphw4=;
    b=MFy8CEwOIledXRCN+ZMY62YRfhDuLagk3LR14+J9MmgQ8oVD0QMiUpPmHfkjs3AAPS
    V+6vGx1gNAV6lxxRAuUWhB7ZsaeWTTVClZRhz/T3z1Af39Q59f8tOySIPla2DSSNtdrJ
    ApATXGVVZudTnGMtizJWrUW6tKKN3ObT+sYbSRQAYcxAhl/RxImmGcGorlGTeLMQwA5x
    ZkY53DGwpe7WCkN/0M7JUQ5shacH+Co4dXisQuFvJOQ6fPqXXVY0b4a8jG+dHHAyXs0q
    oYJBxpyv7TRb8sf1GPkY1+oV7pnJ6Zacx/XE+6kF/AQCsQuZ3qUlTN76TjO6t3raVUFB
    Aqkw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791987697;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tLwwuKwD2trWnEgLsReqmKM4UIpKIQ65cOGwwybphw4=;
    b=E/f7RkFlvr2JWJUEkd12KMEYVbi/zq8SASmDOV/+/cUa380huqKYj01ONNG/rCdaXa
    7+EazD1ES2/twtxVIVopm2Oew1ndtvZqAfdgYmvhEMsOekzqq/DBICFKCKvSPsvOfRN0
    VffUiEcsAIXliUAd2mM5Vncuytmg8RH8tqQjB4p+PCUeqEP7QkKPh1tq4/42UdrJOR41
    mInIG6MiwXpCQQB8dAsrasru1cTNvW/v+diccTDNLyfGkuTUhj4L0y9SGQJoGaAPgeUy
    KRj9sxOtzXxBElWcD9i7auNBRFkNgCTGkC/MrWpxdIEmEl+9m6F3zuSnkGmSR1l4rAg4
    T8+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791987697;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=tLwwuKwD2trWnEgLsReqmKM4UIpKIQ65cOGwwybphw4=;
    b=wO6KFMP8JKbfwhpLHUziltDFcFrB2W0CgY6nHF5d9KE0TVhGa5mOB4hD/53tWG0UWZ
    auXkZIK+6XwSDoCkZ4AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29EELaDZa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 14 Oct 2026 16:21:36 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v2 3/3] can: raw: take rtnl_lock() before leaving the notifier list
Date: Wed, 14 Oct 2026 16:21:14 +0200
Message-ID: <20261014142114.280279-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014142114.280279-1-socketcan@hartkopp.net>
References: <20261014142114.280279-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

raw_release() removes the socket from raw_notifier_list before it takes
rtnl_lock(). As the netdev notifier chain runs under RTNL, a socket that
leaves the list in this window is skipped by raw_notify() and has to
remove its CAN filters itself.

For raw this is not harmful: raw_release() removes the filters with
dev_net(ro->dev) under RTNL, so they are found even when the bound
device has been moved to another network namespace in this window. The
receivers only remain on the moved device until raw_release() gets
RTNL.

Take rtnl_lock() before removing the socket from the notifier list, so
that raw, isotp and bcm use the same locking scheme in their release
functions. As the notifier chain is always invoked under RTNL,
raw_busy_notifier can not point to the released socket anymore. Replace
the now dead busy-wait loop with a WARN_ON_ONCE().

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 0acd4f6c6dd6..925c0c1d243f 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -420,20 +420,21 @@ static int raw_release(struct socket *sock)
 		return 0;
 
 	ro = raw_sk(sk);
 	net = sock_net(sk);
 
+	rtnl_lock();
+
+	/* The netdev notifier chain runs under RTNL, so raw_notifier() can't
+	 * be walking raw_notifier_list and point to this socket. The spinlock
+	 * is still needed as raw_init() adds sockets without holding RTNL.
+	 */
 	spin_lock(&raw_notifier_lock);
-	while (raw_busy_notifier == ro) {
-		spin_unlock(&raw_notifier_lock);
-		schedule_timeout_uninterruptible(1);
-		spin_lock(&raw_notifier_lock);
-	}
+	WARN_ON_ONCE(raw_busy_notifier == ro);
 	list_del(&ro->notifier);
 	spin_unlock(&raw_notifier_lock);
 
-	rtnl_lock();
 	lock_sock(sk);
 
 	/* remove current filters & unregister */
 	if (ro->bound) {
 		if (ro->dev) {
-- 
2.53.0

