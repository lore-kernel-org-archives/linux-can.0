Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03CB37BE8C;
	Mon,  9 Feb 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648459; cv=none; b=BnN7mMZFl+xleajtd8SdNcRNNST99v62AezwZNWYBlM9S7RsHybbPa02sPIJ3rAHUr1teUtJfNMJlSK7DOGUk2VVRXJTZHIGo1ZHTh8EKfhtw1+IWY8giM81pK+DhE5diaUHqaCATUKzZZljRBhtHLn9HQEkEGztC4VYGA0H8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648459; c=relaxed/simple;
	bh=gau756h2wWnWWW5ut9gDHq0I4J7iMrPnfBl7kT6TsCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iERzJqMwVumC/96xLAig1zKlcCgu0tZZZo8mCRoyo+vj+POvzgITIiLAnxkB44Nr/KqOp4zKzxSBXQLNeQq6K5dgUCmddjDa8XVGHIeCEFm+/QlN+GehxcBAvwMxvYZkqFoKUKiahk9WnPWC4pi3OeAt8DJh2kHcK+K8U5LLoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=lht.dlh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from albans-vm.. (unknown [213.61.141.186])
	(Authenticated sender: albeu@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 97F0320039C;
	Mon,  9 Feb 2026 15:47:27 +0100 (CET)
From: Alban Bedel <alban.bedel@lht.dlh.de>
To: linux-can@vger.kernel.org
Cc: Alban Bedel <alban.bedel@lht.dlh.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: mcp251x: fix deadlock in error path of mcp251x_open
Date: Mon,  9 Feb 2026 15:47:05 +0100
Message-Id: <20260209144706.2261954-1-alban.bedel@lht.dlh.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mcp251x_open() function call free_irq() in its error path with the
mpc_lock mutex held. But if an interrupt already occurred the
interrupt handler will be waiting for the mpc_lock and free_irq() will
deadlock waiting for the handler to finish.

This issue is similar to the one fixed in commit 7dd9c26bd6cf ("can:
mcp251x: fix deadlock if an interrupt occurs during mcp251x_open") but
for the error path.

To solve this issue move the call to free_irq() after the lock is
released. Setting `priv->force_quit = 1` beforehand ensure that the IRQ
handler will exit right away once it acquired the lock.

Signed-off-by: Alban Bedel <alban.bedel@lht.dlh.de>
---
 drivers/net/can/spi/mcp251x.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index fa97adf25b734..bb7782582f401 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1214,6 +1214,7 @@ static int mcp251x_open(struct net_device *net)
 {
 	struct mcp251x_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
+	bool release_irq = false;
 	unsigned long flags = 0;
 	int ret;
 
@@ -1257,12 +1258,24 @@ static int mcp251x_open(struct net_device *net)
 	return 0;
 
 out_free_irq:
-	free_irq(spi->irq, priv);
+	/* The IRQ handler might be running, and if so it will be waiting
+	 * for the lock. But free_irq() must wait for the handler to finish
+	 * so calling it here would deadlock.
+	 *
+	 * Setting priv->force_quit will let the handler exit right away
+	 * without any access to the hardware. This make it safe to call
+	 * free_irq() after the lock is released.
+	 */
+	priv->force_quit = 1;
+	release_irq = true;
+
 	mcp251x_hw_sleep(spi);
 out_close:
 	mcp251x_power_enable(priv->transceiver, 0);
 	close_candev(net);
 	mutex_unlock(&priv->mcp_lock);
+	if (release_irq)
+		free_irq(spi->irq, priv);
 	return ret;
 }
 
-- 
2.39.5

