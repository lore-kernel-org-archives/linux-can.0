Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162121;
	b=fi9B4E2jL4sEsTs0WOR6kBvhsiud3WO+V1LK0+kSfbaErqV99oYgcZK36ZPDuyp27WH0
	 bYFP83ejFv1beSRkzQgwdjoZfwE6t43u1dOJLzhs+VrFPlhcMA2CPQ/P1UZ1n+03F2e0H
	 iTE2yvaeOl/cUuIOQ9mmLJpxv7fOqFj8NPxPOE0EnzmJxCf2Zft7/ly3MK7SC5zAlHzr7
	 YA/xr/PV/v2VxTDbOI3hXHnPuwC8qooF/HOm2uQZcIyIyaQ7vbztSBMLonvn+Sz3Mro4D
	 jAKgl6tjvp7Xerxcpt7PS8Dopf0zhwRuBM1GCOeScp7bsKZ1fOVkb+6yxTw6UrMLElg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162121;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=vOdQnly/qrJT0djSoitDrJq3o052nNL1pkh6L3B0ilY=;
	b=todxhCpSD5T/I4tEQmjIqaBCXlcEfvF5wzDBIeKhamKvmest++FYjQTy5ejLTMTs3JLB
	 XQxshneVwwCvW4TKJhvR+PzIz3Ze6beTE1D8te3LGz3teTrDFiJeDzURcEP7sEJB6b28R
	 z9EyewUdXdOOOCqQym4/H46aIOldzsYPjmSDMZ0kwGQEbuxAhh4aqWEwkmnOVIpikfanR
	 Ll5CvPGVCwaZ6sdL6b+sSLDPk7UtUjpnNQQqp844vxJmX5KrRNjNvq0uBGMmV9K5FnEFe
	 7tYl6QN5C9K2X02fjxELuzNKOrIdwsd4f1Qa915KwrGQXsJlbkbPwVbDch/0l5b+/Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F42606A331;
	Fri, 20 Nov 2026 08:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04F42606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd03-sz.software.amlogic (10.28.11.121) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 00:08:31 -0800
From: zelong dong <zelong.dong@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Rob Herring <robh@kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-can@vger.kernel.org>, Zelong Dong <zelong.dong@amlogic.com>
Subject: [PATCH 0/3] can: amlogic: add support for Amlogic A9 CAN-FD controller
Date: Fri, 20 Nov 2026 16:08:17 +0800
Message-ID: <20261120080820.3340646-1-zelong.dong@amlogic.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailsh.amlogic.com (10.18.11.5) To mailsc.amlogic.com
 (10.8.11.35)

From: Zelong Dong <zelong.dong@amlogic.com>

This series adds support for the CAN-FD controller found on the
Amlogic A9 SoC family.

The controller supports classic CAN and CAN-FD. The
driver uses the generic RX offload infrastructure with hardware
timestamps, reports bus errors through the CAN berr counter, and
implements suspend/resume support.

Zelong Dong (3):
  dt-bindings: net: can: add Amlogic A9 CAN controller
  can: amlogic: add driver for Amlogic A9 CAN-FD controller
  arm64: dts: amlogic: a9: add CAN controller node

 .../bindings/net/can/amlogic,a9-can.yaml      |  65 ++
 .../dts/amlogic/amlogic-a9-a311y3-by401.dts   |   7 +
 arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi   |  25 +
 drivers/net/can/Kconfig                       |   1 +
 drivers/net/can/Makefile                      |   1 +
 drivers/net/can/amlogic/Kconfig               |   9 +
 drivers/net/can/amlogic/Makefile              |   3 +
 drivers/net/can/amlogic/amlogic_can.c         | 864 ++++++++++++++++++
 drivers/net/can/amlogic/amlogic_can.h         | 367 ++++++++
 9 files changed, 1342 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/amlogic,a9-can.yaml
 create mode 100644 drivers/net/can/amlogic/Kconfig
 create mode 100644 drivers/net/can/amlogic/Makefile
 create mode 100644 drivers/net/can/amlogic/amlogic_can.c
 create mode 100644 drivers/net/can/amlogic/amlogic_can.h

-- 
2.47.1

