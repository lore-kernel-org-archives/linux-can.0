Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62983CCFD2;
	Mon, 17 Aug 2026 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009675; cv=none; b=azl8vWrJmw0vZ0Z7OokiHgiNul7CsgsaVgjKjGvICDEHl2d5tt2q7KjiTiKx+P55C4hhh79jtMkqkxsFCAllhAulmwR/ZOgbp06EfMd3Vkpd8BlU9ziBGWEbTeHM3KW1A6fUz0KzjkQLjkdTFEoINme/3ceOr5PlBSby7aiQHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009675; c=relaxed/simple;
	bh=egYtyOPFpTdZZ3TL6Jp6rhpmxz++kZ85uo5Iq70q1mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ko5a5URTBVU1zcg7QrJp9slg/zGwTt2a/PQsa9kjfWaFMzbUB7OmIZOM9myFvnSIEQCEi7ynqT0v66bQj780Spo3BkjHLf8dkymIcaHYYkWOlYHihzB+sDDvdnbsPQsNmSK9eufM+VpTy+h/Z0Ka48kNigEXg1GrvtKZsxWt7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 13C0620228A;
	Tue, 18 Aug 2026 01:34:23 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qU-00220y-30;
	Tue, 18 Aug 2026 01:34:22 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A9B5D58515B;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Harini T <harini.t@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/11] dt-bindings: can: xilinx_can: Document phys property
Date: Tue, 18 Aug 2026 01:24:35 +0200
Message-ID: <20260817233420.2068204-9-mkl@pengutronix.de>
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

The Xilinx CAN and CANFD controllers can be connected to an external
CAN transceiver on the board. That connection is described with the
standard "phys" property on the controller node, pointing to a CAN
transceiver PHY node which models the transceiver and its control
lines (for example the standby/enable signals).

Describe the optional "phys" property (a single transceiver PHY) so
the on-board CAN transceiver can be described in the device tree.

Signed-off-by: Harini T <harini.t@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260717021415.2234865-3-harini.t@amd.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index e705c719f7b5..18015e60fd6d 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -53,6 +53,9 @@ properties:
     $ref: /schemas/types.yaml#/definitions/flag
     description: CAN TX_OL, TX_TL and RX FIFOs have ECC support(AXI CAN)
 
+  phys:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.53.0

