Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D593CF694;
	Wed, 29 Jul 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320971; cv=none; b=c3Rmpv0IUrri95d1TNa0K716upyUsg347Oj8ha9UVpP94p+Vu5wgt6GwSecAumuZx+Q8gZbi0whgmFSqHWoUTdjr3xtlWwH/6nVipylx+Sf98TE5Q5Ctj3W5mNaNMhyjE9K7LWDkafc4uhkjgBw1sDT4eUMe0HVdzmIcmXXtfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320971; c=relaxed/simple;
	bh=c3XfIpQgA2XEYIKgo4RBNBSIas3zE9OgVOBMFh/jSPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiGLR/cghezjbmLSC6A6AlxXHOEqMvI4f5OsctvDg8dIAaMNe81YfQHppEDbzvQL4PfTmIk4PHT/8BYb1XNDs+d1LvhqdB7eki/GtZAImo6CZnYISc0+xncC3fcu4MHcS7Lx4jBk2tYDpDJmV25is8YDxxvnnklu7hxWvbZ3/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C7D18201CBA;
	Wed, 29 Jul 2026 12:29:25 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XR-001rms-24;
	Wed, 29 Jul 2026 12:29:25 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 18E3E575DC7;
	Wed, 29 Jul 2026 10:28:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Pavel Pisa <pisa@fel.cvut.cz>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 09/20] can: ctucanfd: add missing MODULE_DEVICE_TABLE()
Date: Wed, 29 Jul 2026 12:12:49 +0200
Message-ID: <20260729102802.505168-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729102802.505168-1-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

The driver has a match table for the pci bus wired into its driver
structure, but the table is not exported with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE() entry so module alias information
is generated for automatic module loading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the driver registration structure, and the missing module alias
publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Link: https://patch.msgid.link/20260704151957.48194-1-pengpeng@iscas.ac.cn
Fixes: 792a5b678e81 ("can: ctucanfd: CTU CAN FD open-source IP core - PCI bus support.")
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ctucanfd/ctucanfd_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ctucanfd/ctucanfd_pci.c
index f845951c5d51..4b6db28f7b67 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
@@ -266,6 +266,7 @@ static const struct pci_device_id ctucan_pci_tbl[] = {
 		CTUCAN_WITH_CTUCAN_ID)},
 	{},
 };
+MODULE_DEVICE_TABLE(pci, ctucan_pci_tbl);
 
 static struct pci_driver ctucan_pci_driver = {
 	.name = KBUILD_MODNAME,
-- 
2.53.0

