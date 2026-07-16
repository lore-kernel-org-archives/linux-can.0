Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A083FE653;
	Thu, 16 Jul 2026 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217408; cv=none; b=JbSydBfxje9YX6NrZc+EWTjywew28YdpwElc+ULT30pWSV9mOKrwvEI9ViRTN8qbByBJUf+eU4OEl2lC5Yia8/CdKV0Evnu22g6xMsgK592cEVKXEt+OGUtD9KhzxiuyNnLKspWcV6IimmDKpZHr7V2zw5SxZ1S0FD3Pbjn31/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217408; c=relaxed/simple;
	bh=W2y6JQ59E4VEzqSfwBXrpxqjpX6j/D30u0sBOsod6Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/EDkbFmAiHMn3DCQXm+dZVMelb7alXUjMlMPp5u261w3tNiXY7ZjKsrYIjafN46XBFTUb6+DWflEYmRWZoXpDtYnQcLc9TwP1e1OfpWfPxVoslDlyMQElZexY5HGSG3ctRqTRqNiomks5ynTX9yKuMTvzxPrudQQ2L6gmv7kZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5ECF7202282;
	Thu, 16 Jul 2026 17:56:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wkORj-0027oj-39;
	Thu, 16 Jul 2026 17:56:24 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 55E3856C3D6;
	Thu, 16 Jul 2026 15:55:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Eulgyu Kim <eulgyukim@snu.ac.kr>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 03/19] can: raw: add locking for raw flags bitfield
Date: Thu, 16 Jul 2026 17:47:28 +0200
Message-ID: <20260716155528.809908-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716155528.809908-1-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Hartkopp <socketcan@hartkopp.net>

With commit 890e5198a6e5 ("can: raw: use bitfields to store flags in
struct raw_sock") the formerly separate integer values have been integrated
into a single bitfield. This led to a read-modify-write operation when
changing a flag in raw_setsockopt() which now needs a locking to prevent
concurrent access.

Instead of adding a lock/unlock hell in each of the flag manipulations this
patch introduces a wrapper for a new raw_setsockopt_locked() function
analogue to the isotp_setsockopt[_locked]() approach in net/can/isotp.c

Fixes: 890e5198a6e5 ("can: raw: use bitfields to store flags in struct raw_sock")
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Closes: https://lore.kernel.org/linux-can/20260503112200.22727-1-eulgyukim@snu.ac.kr/
Tested-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Tested-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20260504111928.41856-1-socketcan@hartkopp.net
[mkl: use Closes tag instead of Link]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 66 +++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index a26942e78e68..82d9c0499c95 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -562,8 +562,8 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 	return RAW_MIN_NAMELEN;
 }
 
-static int raw_setsockopt(struct socket *sock, int level, int optname,
-			  sockptr_t optval, unsigned int optlen)
+static int raw_setsockopt_locked(struct socket *sock, int optname,
+				 sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
@@ -575,9 +575,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	int flag;
 	int err = 0;
 
-	if (level != SOL_CAN_RAW)
-		return -EINVAL;
-
 	switch (optname) {
 	case CAN_RAW_FILTER:
 		if (optlen % sizeof(struct can_filter) != 0)
@@ -598,17 +595,11 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 				return -EFAULT;
 		}
 
-		rtnl_lock();
-		lock_sock(sk);
-
 		dev = ro->dev;
-		if (ro->bound && dev) {
-			if (dev->reg_state != NETREG_REGISTERED) {
-				if (count > 1)
-					kfree(filter);
-				err = -ENODEV;
-				goto out_fil;
-			}
+		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED) {
+			if (count > 1)
+				kfree(filter);
+			return -ENODEV;
 		}
 
 		if (ro->bound) {
@@ -622,7 +613,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			if (err) {
 				if (count > 1)
 					kfree(filter);
-				goto out_fil;
+				return err;
 			}
 
 			/* remove old filter registrations */
@@ -642,11 +633,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		}
 		ro->filter = filter;
 		ro->count  = count;
-
- out_fil:
-		release_sock(sk);
-		rtnl_unlock();
-
 		break;
 
 	case CAN_RAW_ERR_FILTER:
@@ -658,16 +644,9 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		err_mask &= CAN_ERR_MASK;
 
-		rtnl_lock();
-		lock_sock(sk);
-
 		dev = ro->dev;
-		if (ro->bound && dev) {
-			if (dev->reg_state != NETREG_REGISTERED) {
-				err = -ENODEV;
-				goto out_err;
-			}
-		}
+		if (ro->bound && dev && dev->reg_state != NETREG_REGISTERED)
+			return -ENODEV;
 
 		/* remove current error mask */
 		if (ro->bound) {
@@ -676,7 +655,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 						   err_mask);
 
 			if (err)
-				goto out_err;
+				return err;
 
 			/* remove old err_mask registration */
 			raw_disable_errfilter(sock_net(sk), dev, sk,
@@ -685,11 +664,6 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 
 		/* link new err_mask to the socket */
 		ro->err_mask = err_mask;
-
- out_err:
-		release_sock(sk);
-		rtnl_unlock();
-
 		break;
 
 	case CAN_RAW_LOOPBACK:
@@ -769,6 +743,26 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 	return err;
 }
 
+static int raw_setsockopt(struct socket *sock, int level, int optname,
+			  sockptr_t optval, unsigned int optlen)
+{
+	struct sock *sk = sock->sk;
+	int err;
+
+	if (level != SOL_CAN_RAW)
+		return -EINVAL;
+
+	rtnl_lock();
+	lock_sock(sk);
+
+	err = raw_setsockopt_locked(sock, optname, optval, optlen);
+
+	release_sock(sk);
+	rtnl_unlock();
+
+	return err;
+}
+
 static int raw_getsockopt(struct socket *sock, int level, int optname,
 			  sockopt_t *opt)
 {
-- 
2.53.0

