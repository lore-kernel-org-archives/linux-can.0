From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 0/3] Add Support for MCAN in AM654x-idk
Date: Mon, 17 Feb 2020 19:58:33 +0530
Message-ID: <20200217142836.23702-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
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

This series adds driver patches to support MCAN in TI's AM654x-idk.

v2: Model the sandby line to the transceiver as a regulator.

Faiz Abbas (3):
  dt-bindings: m_can: Add Documentation for transceiver regulator
  can: m_can: m_can_platform: Add support for enabling transceiver
  arm64: defconfig: Add Support for Bosch M_CAN controllers

 Documentation/devicetree/bindings/net/can/m_can.txt | 3 +++
 arch/arm64/configs/defconfig                        | 3 +++
 drivers/net/can/m_can/m_can_platform.c              | 6 ++++++
 3 files changed, 12 insertions(+)

-- 
2.19.2
