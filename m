From: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] docs: dt: Fix m_can.txt reference in tcan4x5x.txt
Date: Tue, 17 Mar 2020 11:19:00 -0500
Message-ID: <20200317161900.14380-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Fix the m_can.txt reference to point to the bosch,m_can.yaml.

Fixes: 824674b59f72 ("dt-bindings: net: can: Convert M_CAN to json-schema")
Signed-off-by: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/net/can/tcan4x5x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.25.1
