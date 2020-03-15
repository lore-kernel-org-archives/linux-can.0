From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust to MCAN MMIO schema conversion
Date: Sun, 15 Mar 2020 08:53:56 +0100
Message-ID: <20200315075356.8596-1-lukas.bulwahn@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@st.com>, Rob Herring <robh@kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>, Sriram Dash <sriram.dash@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
List-Id: linux-can.vger.kernel.org

Commit 824674b59f72 ("dt-bindings: net: can: Convert M_CAN to json-schema")
missed to adjust the MCAN MMIO DEVICE DRIVER entry in MAINTAINERS.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches \
  F: Documentation/devicetree/bindings/net/can/m_can.txt

Update MAINTAINERS entry to location of converted schema.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20200313

Benjamin, please ack.
Rob, please pick this patch (it is not urgent, though).

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32a95d162f06..ebc3d91294c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10323,7 +10323,7 @@ M:	Dan Murphy <dmurphy@ti.com>
 M:	Sriram Dash <sriram.dash@samsung.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/can/m_can.txt
+F:	Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
 F:	drivers/net/can/m_can/m_can.c
 F:	drivers/net/can/m_can/m_can.h
 F:	drivers/net/can/m_can/m_can_platform.c
-- 
2.17.1
