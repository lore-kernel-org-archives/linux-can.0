From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 00/17] add device tree for SAM9X60 SoC and SAM9X60-EK board
Date: Fri, 10 Jan 2020 18:17:52 +0200
Message-ID: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
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
To: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, dmaengine@vger.kernel.org, linux-can@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This series add device tree for SAM9X60 SoC and SAM9X60-EK board.
Allong with these, there are patches that documents some compatibles
for SAM9X60's IPs.

Changes in v2:
- replace patch "dt-bindings: at_xdmac: add entry for microchip compatibles"
  by patches:
	- dt-bindings: at_xdmac: add microchip,sam9x60-dma
	- dt-bindings: at_xdmac: remove wildcard.
- replace patch "dt-bindings: atmel-usart: add microchip,<chip>-usart"
  by patches:
	- dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
	- dt-bindings: atmel-usart: remove wildcard
- remove patch "dt-bindings: spi_atmel: add microchip,sam9x60-spi"
  as it was accepted
- collect reviewed-by tags

Claudiu Beznea (16):
  dt-bindings: at_xdmac: remove wildcard.
  dt-bindings: at_xdmac: add microchip,sam9x60-dma
  dt-bindings: atmel-can: add microchip,sam9x60-can
  dt-bindings: atmel-tcb: add microchip,sam9x60-tcb
  dt-bindings: atmel-isi: add microchip,sam9x60-isi
  dt-bindings: at91-sama5d2_adc: add microchip,sam9x60-adc
  dt-bindings: atmel-matrix: add microchip,sam9x60-matrix
  dt-bindings: atmel-nand: add microchip,sam9x60-pmecc
  dt-bindings: atmel-sysreg: add microchip,sam9x60-ddramc
  dt-bindings: atmel-smc: add microchip,sam9x60-smc
  dt-bindings: atmel-gpbr: add microchip,sam9x60-gpbr
  dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
  dt-bindings: atmel-usart: remove wildcard
  dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
  dt-bindings: arm: add sam9x60-ek board
  ARM: at91/defconfig: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B

Sandeep Sheriker Mallikarjun (1):
  ARM: dts: at91: sam9x60: add device tree for soc and board

 .../devicetree/bindings/arm/atmel-at91.yaml        |   6 +
 .../devicetree/bindings/arm/atmel-sysregs.txt      |   1 +
 .../devicetree/bindings/dma/atmel-xdma.txt         |   4 +-
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   2 +-
 .../devicetree/bindings/media/atmel-isi.txt        |   2 +-
 .../devicetree/bindings/mfd/atmel-gpbr.txt         |   4 +-
 .../devicetree/bindings/mfd/atmel-matrix.txt       |   1 +
 .../devicetree/bindings/mfd/atmel-smc.txt          |   1 +
 .../devicetree/bindings/mfd/atmel-tcb.txt          |   4 +-
 .../devicetree/bindings/mfd/atmel-usart.txt        |  11 +-
 .../devicetree/bindings/mtd/atmel-nand.txt         |   1 +
 .../devicetree/bindings/net/can/atmel-can.txt      |   3 +-
 .../bindings/rtc/atmel,at91rm9200-rtc.txt          |   3 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/at91-sam9x60ek.dts               | 647 +++++++++++++++++++
 arch/arm/boot/dts/sam9x60.dtsi                     | 691 +++++++++++++++++++++
 arch/arm/configs/at91_dt_defconfig                 |   4 +
 17 files changed, 1373 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sam9x60ek.dts
 create mode 100644 arch/arm/boot/dts/sam9x60.dtsi

-- 
2.7.4
