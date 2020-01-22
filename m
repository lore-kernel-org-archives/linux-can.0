From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/3] Add Support for MCAN in AM654x-idk
Date: Wed, 22 Jan 2020 13:33:07 +0530
Message-ID: <20200122080310.24653-1-faiz_abbas@ti.com>
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
Cc: mark.rutland@arm.com, nm@ti.com, catalin.marinas@arm.com, sriram.dash@samsung.com, faiz_abbas@ti.com, t-kristo@ti.com, robh+dt@kernel.org, mkl@pengutronix.de, dmurphy@ti.com, davem@davemloft.net, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

This series adds driver patches to support MCAN in TI's AM654x-idk.

Faiz Abbas (3):
  dt-bindings: net: can: m_can: Add Documentation for stb-gpios
  can: m_can: m_can_platform: Add support for enabling transceiver
    through the STB line
  arm64: defconfig: Add Support for Bosch M_CAN controllers

 Documentation/devicetree/bindings/net/can/m_can.txt |  2 ++
 arch/arm64/configs/defconfig                        |  3 +++
 drivers/net/can/m_can/m_can_platform.c              | 12 ++++++++++++
 3 files changed, 17 insertions(+)

-- 
2.19.2
