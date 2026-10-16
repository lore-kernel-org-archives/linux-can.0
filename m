Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B43BD635
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141913; cv=pass; b=seAV9Tr96Ukws6LCAlKiD7ur9PEG/Rnan9PDduqAiGRgbytw18k449vtNJgOcoczR2SgGdKyBtxo8ekWRly3yzhe+BKWsJmSLH2IFTXUZbFo9FAEeJeeZuVk6zgI0Bs18+BRhqEziWQIJ05sHAboNbh8+48Au948b5ljOMhM2iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141913; c=relaxed/simple;
	bh=YWjsAsmgTJyAklIBYBOxEAhDc33b/cSnL6use1MuP6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgpaWqP1YJ446pCcJe92XQFN1e6A6HbuKIukdqg8m60hMWd7+jAF/+bNOfyna5P7W4Sk77yX68+AcYzN9LNcBCRhPpI3+Y3JnnkaCRJYMmVaMrxZpR0GVTwKKkCdjnWPvroxd+T9P91NXZQdQ709ItjQqdP4BGDjzlzLPkI2F/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nOZwvSMO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ggqe/5nm; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nOZwvSMO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ggqe/5nm"
ARC-Seal: i=1; a=rsa-sha256; t=1792141904; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lCXQq8FzyG9bRb4JUTTowkIy37uVAkhzInecjtBLVJxE1bcnF4k3eUr1eUgmaaSB0v
    dscIcWz66Acg30Wfl541XLzheGGXkvvve0gYyj9UC/C82JZvws48Ki/dRuMqt3TEqWaM
    LLMwfQpdWssGSlwYssyO2T/2t7AYLwSg1ASpaBLNDU1J8M7vixz0s5kl79z4Z9iuclyh
    ZgVoTOmnhM78qq0WUKSYKm+5eTs8x1QIlwRfQdngD7/WecTptvwQ5biBcK9kwlA8CoW+
    ouIXLEgZbbXwWiSvsjXQ4uSBETpTrAC5iTZCAe4UP55NW3IXUrRBXH2QaMpbcWcNKGmf
    /QNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792141904;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=JP+v++QFzgwKDyMbq6oWc+2Ze4Ni72G34vzbUOXA5P0=;
    b=e7MgIcF3y8amZ8rTE7Ev6sA2uOKak5mWxjdTAUygrZrqAD62ULn2faGeU7mE7Mc3k4
    KjgwAv/Lwg3vOqIH2jSepehRufejzCU0HEpbNeXuE2+LBUA0e2ODeHIVj1Ib7BfLT4WN
    +4xRoGQeUMyszs86dBTiDeDI3dYx66BxT9CDyw8LG99hxN2gjXVmwo/08Gq96Xu8JcuV
    ldBkyTToJ3A29S6PZr8EDqk2X24wZ6L3soEFiHfyUUdjqT9hzHpvUsJbsztil2quxYtA
    7+034j2JC0twvHSVwGfX5OVi1ENiOaZlIOQLC7wKF0NGpPzJIUBf87xFYvbdusvtwVEv
    Ic7Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792141904;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=JP+v++QFzgwKDyMbq6oWc+2Ze4Ni72G34vzbUOXA5P0=;
    b=nOZwvSMOTs+eJleNZVfHNGmXDTtsjMOPZPDq2i9Mr0fcu4M5ovttFnTTvDEVGvUYoA
    sPS5xngn5UWMDYH7FrVHCsfn+8HAc4Kx64rWbCEX5BPcXEbPZ6yFe32RzcaRzSPLt2Dn
    gA5aFTK23zD2ajmA+uzVtWbfD8QN0smea27OX+vGPkWAmmBi9mk29VCcRngM4FoUixZE
    2nzcceqAz5DdUr7JBPx0XMUECVPNX0CEpSmEOP/XDdu4upoI6Y5OGcQjCFaMHMMo/Dms
    y3r+h+8COu7pcLwi2d8wjf5uv7w+52Ol2FWoE6abC/VGWvaugy11so4Bg61di/ml0nUp
    4QCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792141904;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=JP+v++QFzgwKDyMbq6oWc+2Ze4Ni72G34vzbUOXA5P0=;
    b=ggqe/5nmvTiDuxaq4+sfNxdMg2rg3Fm7Z9PBpncCkaUFd5FUE8KVzZzdTxbbhUDovx
    aL/OfKDp0gU837RZDOAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29G9BiLK9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 11:11:44 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next v3 3/3] can: raw: take rtnl_lock() before leaving the notifier list
Date: Fri, 16 Oct 2026 11:11:28 +0200
Message-ID: <20261016091128.325332-4-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091128.325332-1-socketcan@hartkopp.net>
References: <20261016091128.325332-1-socketcan@hartkopp.net>
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
index 0acd4f6..925c0c1 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -422,16 +422,17 @@ static int raw_release(struct socket *sock)
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
-- 
2.43.0

