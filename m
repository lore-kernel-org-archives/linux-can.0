Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FD4A33;
	Wed, 11 Mar 2026 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244464; cv=none; b=mpTnha5HdL8+eQqm5i8CfXBzuU7wLE7Rq8SKxQ0Se7Vkc/f6F6uMsq2OkI6QchkjJAz/QK+IObbVX2SWd8Wr1+lCsPT/4AlPBLRKoBEOZhlk0Ukn94UkhASPNy5o2g3BbY43zs2kveUo3B1o7fuSOcbK7GZEKidHMWKZWAi76TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244464; c=relaxed/simple;
	bh=NquMYluHFJgrqgMAnXH6v+ZUkizoJ3EBD2ZydKBQ8GM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WhBprpU1EvyE5HOxoWX74cYz/CT3ZGk/gc44e6pbvUPbtobVdTuxj9HNL1vzORrQZW3faJzj+u7bM/x0EZiySLxfKErWFGSexwt1YgaT5ROXei84Hn4H3FwEPY/Z4255hpNAF4Ik1eIfhQs0EdLl6mlGVmsZR1YqKM4uG5gFjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NK+qGl/4; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NK+qGl/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773244458; bh=L2tVhP8PqehcOr1B/bvC80CmAw0vEc+4Z4UH4QLZQ9A=;
	h=From:To:Cc:Subject:Date;
	b=NK+qGl/4wuRlBLIAjmjnAmuBZ2ubmfmCPR997uHrAcggBDoGCbEakZMMyP9Waf3iJ
	 /eOZTAnU55phb7aYhuTdocgofUQhG6J2IU7DY/lQRBMLPR9Un8YnBC9brpfuEZf4kk
	 gWQ32Xsz1tm5vTYLpmDUU44+vYVyDFHK1u5jDxMU=
Received: from LAPTOP-KQCD4QBN.localdomain ([183.242.199.70])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id CB83728E; Wed, 11 Mar 2026 23:50:56 +0800
X-QQ-mid: xmsmtpt1773244256tgk6gkxmj
Message-ID: <tencent_6A462B2C8A50BA55116D560D2FFE9EED2D09@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7C7XqABiJMbjlP0hlfCvyfjPMk2RWL9DNa52I4J2Yd8/IJW8kE5
	 NgFTlRWYsWLRZsnaHHab8q7Rv9sOekrgxeKA8IVBChjESmTADxY8s3rIfF1qPqBv66tA+FmpizVG
	 BozbOMwZS4s+KvRNCzyCpekU76wP1my2s5iSshmcmS3zVvm5/AxWRSPqqAGdC++/Gc7CAUgyn1rT
	 0tt6AbFFZYBW3bOsdwraxPs+uC+52NHvkIBcla5zEKXHZSfg48BjUmlcsT8wrk3pLyfC8G2HcxRN
	 7apapU4AjLTONDoU8Cr9WUF25Rl3GskvNd46Sc+aV2fVybyOLi/uBbz7i2INbju5ESD/eJ2qX7E/
	 RAXjc6ib4yaBmS4l4syZrMYrN2A+FyTy4PgCqdxexrz1GwBHSQrjRb9nc6tGszUtY4i2QZuGA8zP
	 yDvtMui+xKsuFAKXSIMG5pkWlJqvlRtpl2ApwxEmCgsC+NOemoi2Hh65+9LsGiclBFZt6hza1HFO
	 64dObSUCi+EdEQ2zVNEjL2/a9gjzC469sTpLCNMYe28Jy+q49I9BAbPhFF7/ZsIBzMXMBWdDj1Hh
	 ZAPwrFBdOk1EsZBQbiD4bFORSXfUWGk8RNjlXZ/Pp3Ot+yiUqHNW8mr9F+xElcofJau+NzkTUQqa
	 rIIhdba+UNE49L08Cp2a02pdH9jJlIUv+RUs3Nn01GMHpBHixlza3UkXlHipDTeMaWUYz18ZCkNT
	 1spGL2dP8SFOxhOszbB9m3/cfboC+4z7iovFgz3O9Sn6FC2nui+HeTFTtFlgPtMRWVPOXXQEAWu1
	 +y40FBUVjmJSYS8k2AvbHMX3MbfrbMGv7jrznAnMwOsJNa5c92Aq6hxhP7L+6FgY2nF0syheT+lF
	 BP/XHcHBeAcFV1JqeLQ36B6R2ICIxz2nWkf9xIsCb0Z+DDl5XqnK2G+v1gSuxRBuXlzojicugMlX
	 H3mtndRi4m0kVfXATqj4QXt7agYOfp/dRq19czft3Ot6JNqlbbBzEbJAxBZo1TWjDm9P+GEx6Y85
	 GakglTkb5U1acCBBymn3ipVyWbY55oXtQx/xuddmx5hrd/iTDg
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Wenyuan Li <2063309626@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Alban Bedel <alban.bedel@lht.dlh.de>,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenyuan Li <2063309626@qq.com>
Subject: [PATCH] can: mcp251x: add error handling for power enable in open and resume
Date: Wed, 11 Mar 2026 23:50:53 +0800
X-OQ-MSGID: <20260311155053.6237-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing error handling for mcp251x_power_enable() calls in both
mcp251x_open() and mcp251x_can_resume() functions.

In mcp251x_open(), if power enable fails, the driver should not continue
with device initialization. Add proper error checking and jump to
existing out_close label.

In mcp251x_can_resume(), if power enable fails during system resume,
propagate the error to PM framework and log the error with dev_err()
for debugging.

This ensures the driver properly handles power control failures and
maintains correct device state.
Signed-off-by: Wenyuan Li <2063309626@qq.com>
---
 drivers/net/can/spi/mcp251x.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index bb7782582f40..807293a7857f 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1225,7 +1225,11 @@ static int mcp251x_open(struct net_device *net)
 	}
 
 	mutex_lock(&priv->mcp_lock);
-	mcp251x_power_enable(priv->transceiver, 1);
+	ret = mcp251x_power_enable(priv->transceiver, 1);
+	if (ret) {
+		dev_err(&spi->dev, "failed to enable power: %d\n", ret);
+		goto out_close_candev;
+	}
 
 	priv->force_quit = 0;
 	priv->tx_skb = NULL;
@@ -1272,6 +1276,7 @@ static int mcp251x_open(struct net_device *net)
 	mcp251x_hw_sleep(spi);
 out_close:
 	mcp251x_power_enable(priv->transceiver, 0);
+out_close_candev:
 	close_candev(net);
 	mutex_unlock(&priv->mcp_lock);
 	if (release_irq)
@@ -1516,11 +1521,23 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	int ret = 0;
 
-	if (priv->after_suspend & AFTER_SUSPEND_POWER)
-		mcp251x_power_enable(priv->power, 1);
-	if (priv->after_suspend & AFTER_SUSPEND_UP)
-		mcp251x_power_enable(priv->transceiver, 1);
+	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
+		ret = mcp251x_power_enable(priv->power, 1);
+		if (ret) {
+			dev_err(dev, "Failed to restore power: %d\n", ret);
+			goto out;
+		}
+	}
+
+	if (priv->after_suspend & AFTER_SUSPEND_UP) {
+		ret = mcp251x_power_enable(priv->power, 1);
+		if (ret) {
+			dev_err(dev, "Failed to restore power: %d\n", ret);
+			goto out;
+		}
+	}
 
 	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
 		queue_work(priv->wq, &priv->restart_work);
@@ -1529,6 +1546,7 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 
 	priv->force_quit = 0;
 	enable_irq(spi->irq);
+out:
 	return 0;
 }
 
-- 
2.43.0

