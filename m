Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C433361657
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829718; cv=none; b=YZ+Wo/dQJBIzViGQpGRqfUE+8ieh1IC8QhaKn0In9+K07EhcNwjfqrjgZyARefPVDJffqOdqiqok7tg8mWxMZdAjOfuDoIs22SsCzJW/ajiD6d8Io3/OAZaPhmG1/gP4HdehfUL2yZ1HJtI9woGbGzd6KbGzHART7i3L64Yx41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829718; c=relaxed/simple;
	bh=fGFkL4jcCzx31ugZS9nSuOAKVmDJQyjlNVWl0mvdm1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSb6qClvlDNUHiKK5d4tyz3BPPKhHsI3D3SVoFxwXg/Gi2o720Jgj2BKB9mfrmigQOW9jFdSbU3YygH0r14vDQcVnJtxfnmW3ek2UGjQxw0NcIeO5zICgDF46QkpaxEE39zbkunVxdf/521zlia0TASP27p4G4Uzay2VO959LQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=kYkxuDlu; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="kYkxuDlu"
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward206b.mail.yandex.net (postfix) with ESMTPS id D9F1082013
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 14:14:20 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:3033:0:640:ec58:0])
	by forward102b.mail.yandex.net (postfix) with ESMTPS id 236FBC046D;
	Thu, 27 Aug 2026 14:14:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp) with ESMTPSA id BEcT7S9d0iE0-EZNgqVJI;
	Thu, 27 Aug 2026 14:14:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1787829252; bh=Lg6rW2fVPdQydjhqjKsK77tS3Wx4XIpy1l8asdTL15M=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=kYkxuDlumqst1T8tiZYAVo0u0VG2b+zVkHKC5iZ7m2B63oQ2luArpYfoLgyzod4Kd
	 UgUTZDUduftJIbjU7VZaegj2Y9wfL+dSdSfbgwE3g1vHzUlcvS3tfIlhXiVZxqOqxW
	 AgL0dTLvmJx4oXWnO6GHYHoixbVXkR5oOOacMbpA=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>,
	linux-can@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Subject: [PATCH v2] can: j1939: cancel all pending ECUs on device stop
Date: Thu, 27 Aug 2026 14:14:10 +0300
Message-ID: <20260827111410.20401-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cancel all pending ECUs in j1939_netdev_stop(). This is needed
to prevent the case when stopped device no longer processes ECUs
and, since ECU holds the reference to 'struct j1939_priv', the
latter (and ECU itself) is never freed.

Reported-by: syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: add extra precaution to avoid ABBA deadlock between
    j1939_ecu_cancel_all() and timer callbacks (Sashiko)
---
 net/can/j1939/bus.c        | 39 ++++++++++++++++++++++++++------------
 net/can/j1939/j1939-priv.h |  6 ++++++
 net/can/j1939/main.c       |  2 ++
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..e02454a4c64c 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -96,6 +96,16 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
 	write_unlock_bh(&ecu->priv->lock);
 }
 
+void j1939_ecu_cancel_all(struct j1939_priv *priv)
+{
+	struct j1939_ecu *ecu, *tmp;
+
+	write_lock_bh(&priv->lock);
+	list_for_each_entry_safe(ecu, tmp, &priv->ecus, list)
+		j1939_ecu_timer_cancel(ecu);
+	write_unlock_bh(&priv->lock);
+}
+
 void j1939_ecu_unmap_all(struct j1939_priv *priv)
 {
 	int i;
@@ -131,18 +141,23 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 		container_of(hrtimer, struct j1939_ecu, ac_timer);
 	struct j1939_priv *priv = ecu->priv;
 
-	write_lock_bh(&priv->lock);
-	/* TODO: can we test if ecu->addr is unicast before starting
-	 * the timer?
-	 */
-	j1939_ecu_map_locked(ecu);
-
-	/* The corresponding j1939_ecu_get() is in
-	 * j1939_ecu_timer_start().
-	 */
-	j1939_ecu_put(ecu);
-	write_unlock_bh(&priv->lock);
-
+	/* We're asked to stop from j1939_netdev_stop(). */
+	if (unlikely(atomic_read(&priv->stop))) {
+		lockdep_assert_held(&priv->lock);
+		j1939_ecu_put(ecu);
+	} else {
+		write_lock_bh(&priv->lock);
+		/* TODO: can we test if ecu->addr is unicast before starting
+		 * the timer?
+		 */
+		j1939_ecu_map_locked(ecu);
+
+		/* The corresponding j1939_ecu_get() is in
+		 * j1939_ecu_timer_start().
+		 */
+		j1939_ecu_put(ecu);
+		write_unlock_bh(&priv->lock);
+	}
 	return HRTIMER_NORESTART;
 }
 
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..1e8f018b7c8b 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -60,6 +60,11 @@ struct j1939_priv {
 	/* segments need a lock to protect the above list */
 	rwlock_t lock;
 
+	/* Used to avoid deadlock between j1939_ecu_cancel_all()
+	 * and timer callbacks.
+	 */
+	atomic_t stop;
+
 	struct net_device *ndev;
 	netdevice_tracker dev_tracker;
 
@@ -204,6 +209,7 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name);
 
 void j1939_ecu_timer_start(struct j1939_ecu *ecu);
 void j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
+void j1939_ecu_cancel_all(struct j1939_priv *priv);
 void j1939_ecu_unmap_all(struct j1939_priv *priv);
 
 struct j1939_priv *j1939_netdev_start(struct net_device *ndev);
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..22ea2b000185 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -306,6 +306,8 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 
 void j1939_netdev_stop(struct j1939_priv *priv)
 {
+	atomic_set(&priv->stop, 1);
+	j1939_ecu_cancel_all(priv);
 	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
 	j1939_priv_put(priv);
 }
-- 
2.55.0

