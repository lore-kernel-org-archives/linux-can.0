Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72C3D79FE;
	Mon, 17 Aug 2026 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009676; cv=none; b=E9s1PIcyOhSu7Ibx3z8ur2EOzaIsbrx/qb7gQEmMTue0VpIMkjQmfSv66Gv/P1zjmJaAPgAJCDu/KtzEIqK7TS3txlmA5gsNqtaYakNFPZ7iNmALcPv95Ezom8pdKD1xAPYZdPeYU0gpBtqABknFnkqx9QbGUeAJ965TpxWI+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009676; c=relaxed/simple;
	bh=pqgQJIVNeNW6zzuhDAM2Xe8KB0Zaf8ho2U2xlYzs6SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsfgmYg2REm7alrDc4/1l5nIm0syd4vbfwQJFmHuhRr1gZYC0ZXow0ju9AURXDzni8we7SHDfCwELna88TchB/by4tP9PVEUb0rLKLRcy7fAiTn0ouBnlChB0CaZIucn/VKjAJRtqibP8ygAy7KJ310CCvq7SAcB/5Dp3+jZrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 45C4A202293;
	Tue, 18 Aug 2026 01:34:23 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qV-002219-0Q;
	Tue, 18 Aug 2026 01:34:23 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DA16458515E;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 11/11] can: m_can: pci: Remove driver_data
Date: Tue, 18 Aug 2026 01:24:38 +0200
Message-ID: <20260817233420.2068204-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817233420.2068204-1-mkl@pengutronix.de>
References: <20260817233420.2068204-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>

driver_data is set to M_CAN_CLOCK_FREQ_EHL for all models. This change
was already five years ago, I don't expect any follow up models that
need to set a different frequency through the driver_data at this point.

Hardcode the M_CAN_CLOCK_FREQ_EHL. Once there are new models we can
evaluate what data needs to be in driver_data.

Acked-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20260515-topic-mcan-pci-driverdata-v7-1-v2-1-e33e014ff328@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index eb31ed1f9644..d11a7c88fc32 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -126,7 +126,7 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	mcan_class->net->irq = pci_irq_vector(pci, 0);
 	mcan_class->pm_clock_support = 1;
 	mcan_class->pm_wake_source = 0;
-	mcan_class->can.clock.freq = id->driver_data;
+	mcan_class->can.clock.freq = M_CAN_CLOCK_FREQ_EHL;
 	mcan_class->irq_edge_triggered = true;
 	mcan_class->ops = &m_can_pci_ops;
 
@@ -183,8 +183,8 @@ static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
 			 m_can_pci_suspend, m_can_pci_resume);
 
 static const struct pci_device_id m_can_pci_id_table[] = {
-	{ PCI_VDEVICE(INTEL, 0x4bc1), M_CAN_CLOCK_FREQ_EHL, },
-	{ PCI_VDEVICE(INTEL, 0x4bc2), M_CAN_CLOCK_FREQ_EHL, },
+	{ PCI_VDEVICE(INTEL, 0x4bc1) },
+	{ PCI_VDEVICE(INTEL, 0x4bc2) },
 	{  }	/* Terminating Entry */
 };
 MODULE_DEVICE_TABLE(pci, m_can_pci_id_table);
-- 
2.53.0

