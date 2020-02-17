From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 1/3] dt-bindings: m_can: Add Documentation for transceiver
 regulator
Date: Mon, 17 Feb 2020 19:58:34 +0530
Message-ID: <20200217142836.23702-2-faiz_abbas@ti.com>
References: <20200217142836.23702-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200217142836.23702-1-faiz_abbas@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, sriram.dash@samsung.com, lgirdwood@gmail.com, robh+dt@kernel.org, faiz_abbas@ti.com, broonie@kernel.org, mkl@pengutronix.de, dmurphy@ti.com, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

Some CAN transceivers have a standby line that needs to be asserted
before they can be used. Model this GPIO lines as an optional
fixed-regulator node. Document bindings for the same.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/net/can/m_can.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
index ed614383af9c..f17e2a5207dc 100644
--- a/Documentation/devicetree/bindings/net/can/m_can.txt
+++ b/Documentation/devicetree/bindings/net/can/m_can.txt
@@ -48,6 +48,9 @@ Optional Subnode:
 			  that can be used for CAN/CAN-FD modes. See
 			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
 			  for details.
+
+- xceiver-supply: Regulator that powers the CAN transceiver.
+
 Example:
 SoC dtsi:
 m_can1: can@20e8000 {
-- 
2.19.2
