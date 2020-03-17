From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 04/12] docs: dt: fix references to m_can.txt file
Date: Tue, 17 Mar 2020 14:10:43 +0100
Message-ID: <db67f9bc93f062179942f1e095a46b572a442b76.1584450500.git.mchehab+huawei@kernel.org>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1584450500.git.mchehab+huawei@kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Dan Murphy <dmurphy@ti.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This file was converted to json and renamed. Update its
references accordingly.

Fixes: 824674b59f72 ("dt-bindings: net: can: Convert M_CAN to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
 MAINTAINERS                                            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index 6bdcc3f84bd3..3613c2c8f75d 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -14,7 +14,7 @@ Required properties:
                     the interrupt.
 	- interrupts: interrupt specification for data-ready.
 
-See Documentation/devicetree/bindings/net/can/m_can.txt for additional
+See Documentation/devicetree/bindings/net/can/bosch,m_can.yaml for additional
 required property details.
 
 Optional properties:
diff --git a/MAINTAINERS b/MAINTAINERS
index 39da9ac4cc1f..84cb39b5a23b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10327,7 +10327,7 @@ M:	Dan Murphy <dmurphy@ti.com>
 M:	Sriram Dash <sriram.dash@samsung.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/can/m_can.txt
+F:	Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
 F:	drivers/net/can/m_can/m_can.c
 F:	drivers/net/can/m_can/m_can.h
 F:	drivers/net/can/m_can/m_can_platform.c
-- 
2.24.1
