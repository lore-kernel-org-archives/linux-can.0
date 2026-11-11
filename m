Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794377930;
	b=TF9f1cRqUkVmtNEP5MSZzn7TmRNtIr3dN0HijoWBJ73zTEIq6FebxEX52nDOrhiF4YrL
	 oy/7e9z46KDacuUvVlLzf8miS8f15fGXhHPiVXuTVnMEx3xHtxkZTbsLc7G8yUqk08xG0
	 vQfERBM8WXIEmFmzeKIBsde2m9hgJp3SWWAPf+Wze3LAF9BfvaAnybxvlzu1XneLMgbc9
	 mbSN/T05b/em0dPf3pbR8wgX/dHujn2GIadk33g7lB5j9D8E6v+KzeXAw5cqMPELN4MgX
	 n9raDQtTfz/UmEaKJHGq0ZZUVU8qLhMsE7FqR3t8SxmHuHJNpCKrW/lGYdxTaHX71mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377930;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6Ye3YRIsT97Mj7VVEQLs8MErXXMktUlYSgMTSWOhF4w=;
	b=QQp5ICgQC8Amg6WIWp/zbW4JBR1WbGe290saQ9kxudIyNIg5PqGl+eKQC7NWEqE36O51
	 aEMTYY4+qiPkEmS0NboUwAI1LpESLWkazq+A/crXiM+1bIWyLPluOV+w96yNCHpO6wmri
	 su9FiHt2/I+ndvevAXOV6JaIVgH7ugiJ7iK3q/SSHmkIGrZ9vly0l7vnuXmOaXIWUmbts
	 7oO2Y2mSUrSIkd7hAVbS0LeufyJ+FvRMHAHo/jvYpTPdU0UUhBRM+i/FXITOtUit4D1DS
	 EqV0EQEkKEZWoBsaLr5fqp0vl5UYs9YjUGMgSPXwYDw3H4/AEm/ljIcoQ+80HMsdldw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHe10HIy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064860A2615;
	Wed, 11 Nov 2026 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHe10HIy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794377930;
	b=giebt0H9dd/X94g8X6NzCYNCxHJJUeEIlJhqgWHoaPMZGwW2+ebHJu3Xb82ZtZgCrYxc
	 VpPJy8rPBd8lsGVZOe5evhqwT0sp3o1uCbE7dPwgUELUe1QSNE/OyXBWy81JsXVlhi8Nz
	 986DqY9aifEdsPaLGuU+emNwgK6l/u/FWGEHaCdwL8NtnXQXp3yw3sR3t5iKCUeH2IkGv
	 NqFyW1KRN/wnZZ0r7YoJB4NCxXdLtKJZgLwWCL17PTmtie0x+cbzwJJ1H1gSZuPOZq4Rv
	 oQFokdS3alf+g7qw5DHydsOLJYSRAcRumFaruJ4PTPTUgwVlI+tb51klrkfls2mLj6g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794377930;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6Ye3YRIsT97Mj7VVEQLs8MErXXMktUlYSgMTSWOhF4w=;
	b=JVZsgsIe0nXUO1/jmEJ1xiVRFcxjnebLwlwEesHZv9Uzo8g1EIUA1Eh18ZXGdu3ceQkh
	 rTNODAYxfmOQcO6JMWCYHBzESTbvooTosaRLjjzu28nL/dJ9QIDu59EVq6KFr/axxcdu8
	 m4tbazXpKuY8Lp3R5BxCxf865YoAnZGAZjI29j1sMao7wV0nJxBY7M6JmcX3H2Snt3UI7
	 etJACnODaGn9UyZmfe0vaCZfKj4EqXpCnMCdGNztyLUBUGazRSMvvXRkLFSs5g9xfs8DP
	 8huXoHYQp5JPX0lLsm/3GbKBtjQ5pAvSjzkTx8rWAIfRyfcEOYMlmYc5JjXOIp6asJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A622C1F00A05;
	Wed, 11 Nov 2026 06:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377929;
	bh=6Ye3YRIsT97Mj7VVEQLs8MErXXMktUlYSgMTSWOhF4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=kHe10HIyliCJCyjFPtkOAhkPiTDLF4cUdW/XLBFN1vZW0HWLEudlp/lhrfwYsXtPP
	 ABm9vvTGNJNg255MR8qILT1DW5o1t5eorS0CtE6y0eDHb2La/cJnG1x+PeFp39ocWB
	 dRCJckssVA3U1qVjtJfQPOtRCapVQ2mUUcK0IYM+inM3Y7kwyBN0S2AgbxiABodwQj
	 w2GhMtbV4v/LQ1O3uiY8HMfcEx880Kn4tQQoSaUIKfwqcRz6euiBplNzqkZ0XWM2pd
	 /MWhKpbed1fo40orLYbpCA1I2x2SmHp3V1isiEk81NeYfFJGpXIF4JyPkNLrgnPUrZ
	 MH63ZiFsf1OOQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2049248E0E;
	Wed, 11 Nov 2026 06:18:47 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 11 Nov 2026 14:17:59 +0800
Subject: [PATCH net v9 05/10] can: dev: add
 close_candev_cancel_restart_sync()
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
Message-Id: <20261111-rockchip-canfd-restart-close-v9-5-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3@qq.com>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794377925; l=2772;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=v/w3baS7Y/4CSnrJdEt045rABuum9hoKz/eYbLPkCUU=;
 b=tHz1YgorGkk9TLpzDk7xPRc/cwq9HeNHHG+8DLegpYZBqStCvIlO6BdqaAPGmkkO7nFsU2KH/
 9gNKxM7R3LtDZ/4I2kd/j5aocxJXmoKwbRtftD7zeHUtZqOJnk5ZRCv
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Drivers may need to wait for bus-off recovery before tearing down the
IRQ and hardware resources used by their restart callback. Calling
close_candev() at that point also flushes echo skbs, which belongs after
the driver has quiesced the users of those buffers.

Add close_candev_cancel_restart_sync() in linux/can/dev.h so drivers can
cancel the core restart work separately, without accessing can_priv's
work item directly. The helper only cancels restart work; callers must
still stop its producers and call close_candev() for the final cleanup.

Use the helper in close_candev(), preserving its existing cancellation
and echo cleanup order.

The following Rockchip fix uses the helper at the start of rkcanfd_stop()
to wait for recovery before IRQ teardown, leaving echo cleanup to
close_candev().

Signed-off-by: Cunhao Lu <1579567540@qq.com>

---
Changes in v6:
- Describe the helper's use by the following Rockchip fix.
---
 drivers/net/can/dev/dev.c |  4 +---
 include/linux/can/dev.h   | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index a893a49a3381..39271a3ef0fa 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -537,9 +537,7 @@ EXPORT_SYMBOL_GPL(of_can_transceiver);
  */
 void close_candev(struct net_device *dev)
 {
-	struct can_priv *priv = netdev_priv(dev);
-
-	cancel_delayed_work_sync(&priv->restart_work);
+	close_candev_cancel_restart_sync(dev);
 	can_flush_echo_skb(dev);
 }
 EXPORT_SYMBOL_GPL(close_candev);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 346faddee02e..2a286f906394 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -22,6 +22,7 @@
 #include <linux/can/skb.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h>
 
 /*
  * CAN mode
@@ -115,6 +116,22 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
+
+/**
+ * close_candev_cancel_restart_sync() - cancel bus-off restart synchronously
+ * @dev: CAN network device
+ *
+ * Call before tearing down resources used by the restart callback.
+ * The driver must quiesce restart work producers before calling
+ * close_candev() for the final cleanup.
+ */
+static inline void close_candev_cancel_restart_sync(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	cancel_delayed_work_sync(&priv->restart_work);
+}
+
 void can_set_default_mtu(struct net_device *dev);
 void can_set_cap_info(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,

-- 
2.34.1


