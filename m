Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C83F44CE
	for <linux-can@vger.kernel.org>; Mon, 27 Jul 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145775; cv=none; b=g8c8Zo8Jxd/KRYNDNVIZKpz11cHh8WGysPTvUSZJQ3j0UxgY+s75sfSJTDLoFzvGpeEt2fvZcKU3g2tQ59tzk9m60g4DoCpqIxoMUP4RZHVNC3OlMHrCge6E9geDXllUjzYImVCM67DpDEr9XwVLdLwuTvxtzTeVKZDBGSz6b2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145775; c=relaxed/simple;
	bh=n60ZiuuBuKfayH+NHMYH8py5zg311c9pKn5EgJBSVlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCLWOof2BU1NJKpWsS7D1A5Y9EDDGDFW4x6FEDm87+kDBx9OWDssR9fd7TwOpKXELWunOuALZkURxwf4yHVi/DTB+skStkgTNVs/DDgRmlZKE434xAmErMkPRfmiMkWL2p7zZqgiGIcwgEGyqr9ZdUodKIYiRthhwnzDkjGfPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=wrFUUeUh; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="wrFUUeUh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785145759; x=1785404959;
	bh=93/aiVkUWjg8mRQGMUJy6ooJ1LdN/JoykYvA+FjR+ek=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=wrFUUeUheCDHq2TpNrJPrwGp/ULB40bHmfa8svpdQvHU9aKFCaRq2+eCYnumou/uq
	 TBntPvzRj69vPJe7lzRUxhrePRIN7q+/2KvMU1SMdLYHR25wdDQJZ9SqHrh+SxJfwC
	 qCpSPkFLnyLJqn/FQ7mAcnIVVy40FWhnrv3CDTpyCA77t2NZaaFDW/wbfdPclvrT8u
	 ydNad5IthEs2cageJwCKnWjpWuyIuBUoAfdhO+SleBVzk78P8BSu9Rl65u5wmraCar
	 DrsnJT+Smoozd7G78sCOJmrDtiqvC8oUTtI2Mw2jcUnU+9d3BLIZfzfX5orpO7/nqm
	 kVZux+Emk+FvQ==
X-Pm-Submission-Id: 4h7v255ZmYz1DFh0
From: Sean Nyekjaer <sean@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: tcan4x5x: put tcan into sleep when removing driver
Date: Mon, 27 Jul 2026 11:48:59 +0200
Message-ID: <20260727094900.1214157-1-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put the tcan4x5x transceiver into sleep mode when the driver is
removed, instead of leaving it in its current operating mode.
This reduces power consumption(3mA@12V) once the driver is
no longer bound to the device.

Note that the reset pin is needed to bring the device out of sleep
and back into standby mode again.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
I havn't come across any drivers that leaves the devices in the lowest
power mode when unbinded. But we need this to enter our lowest power
mode in suspend.
If it doesn't fit in, I'm happy to carry this out of tree...

 drivers/net/can/m_can/tcan4x5x-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 734b34b28291..b1b4db9990dc 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -565,6 +565,10 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
 {
 	struct tcan4x5x_priv *priv = spi_get_drvdata(spi);
 
+	if (priv->reset_gpio)
+		regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
+				   TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_SLEEP);
+
 	m_can_class_unregister(&priv->cdev);
 
 	tcan4x5x_hc_free(priv);
-- 
2.52.0

