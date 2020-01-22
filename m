From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/3] dt-bindings: net: can: m_can: Add Documentation for
 stb-gpios
Date: Wed, 22 Jan 2020 13:33:08 +0530
Message-ID: <20200122080310.24653-2-faiz_abbas@ti.com>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200122080310.24653-1-faiz_abbas@ti.com>
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
Cc: mark.rutland@arm.com, nm@ti.com, catalin.marinas@arm.com, sriram.dash@samsung.com, faiz_abbas@ti.com, t-kristo@ti.com, robh+dt@kernel.org, mkl@pengutronix.de, dmurphy@ti.com, davem@davemloft.net, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

The CAN transceiver on some boards has an STB pin which is
used to control its standby mode. Add an optional property
stb-gpios to toggle the same.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/net/can/m_can.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
index ed614383af9c..cc8ba3f7a2aa 100644
--- a/Documentation/devicetree/bindings/net/can/m_can.txt
+++ b/Documentation/devicetree/bindings/net/can/m_can.txt
@@ -48,6 +48,8 @@ Optional Subnode:
 			  that can be used for CAN/CAN-FD modes. See
 			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
 			  for details.
+stb-gpios		: gpio node to toggle the STB (standby) signal on the transceiver
+
 Example:
 SoC dtsi:
 m_can1: can@20e8000 {
-- 
2.19.2
