Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214133F8253;
	Mon, 17 Aug 2026 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009678; cv=none; b=mspSqdOFNuAonFGh9s8xsBSFXrzOaDrWLbdK9TG0YsB14Ifb2BFhT99u/asxs4FuMdvUx/nTw5DtPAfMIrU/d2bOinXorp1/Lmg2hHgZ3Zp5x1Qlk/MV5g823PHhTyXfWB9W4mazMtJuxV94w86xvrq+Zn7vSsG5P3XBsW7X800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009678; c=relaxed/simple;
	bh=2OqnZYAypKhe4+1ak6uSXvLSfMqgTt234yq8l9W1ROU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEajLTZp0Y88jlokhWf8hvvvHf4vJmmGhSMk1kwwuGO3vO+PtKDVGujH6H9wSDJAWksHDaW6KmqsUCHsTWmoqxSETurjsIf+j26/R4PBpCV863CELHIRNRvUOYRIVeqdbSsvm6MbC6xL5cZ7GZVI0Wn5AdgCBSEjoaY9qj8zgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E86BD202285;
	Tue, 18 Aug 2026 01:34:22 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qU-00220u-2T;
	Tue, 18 Aug 2026 01:34:22 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 736E9585159;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Harini T <harini.t@amd.com>,
	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/11] MAINTAINERS: Replace maintainer for Xilinx CAN driver
Date: Tue, 18 Aug 2026 01:24:33 +0200
Message-ID: <20260817233420.2068204-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817233420.2068204-1-mkl@pengutronix.de>
References: <20260817233420.2068204-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harini T <harini.t@amd.com>

Replace Appana Durga Kedareswara rao with Harini T as the maintainer
of the Xilinx CAN driver. Kedar is no longer maintaining it.

Signed-off-by: Harini T <harini.t@amd.com>
Acked-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260717021415.2234865-2-harini.t@amd.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 2 +-
 MAINTAINERS                                               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 40835497050a..e705c719f7b5 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -8,7 +8,7 @@ title:
   Xilinx CAN and CANFD controller
 
 maintainers:
-  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+  - Harini T <harini.t@amd.com>
 
 properties:
   compatible:
diff --git a/MAINTAINERS b/MAINTAINERS
index 991460050da7..6b49a2c80cd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29573,7 +29573,7 @@ F:	Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
 XILINX CAN DRIVER
-M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+M:	Harini T <harini.t@amd.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
-- 
2.53.0

