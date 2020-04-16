From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: Clean-up schema indentation formatting
Date: Thu, 16 Apr 2020 08:20:18 +0100
Message-ID: <20200416072018.GS2167633@dell>
References: <20200416005549.9683-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200416005549.9683-1-robh@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-pci@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-remoteproc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-s
List-Id: linux-can.vger.kernel.org

On Wed, 15 Apr 2020, Rob Herring wrote:

> Fix various inconsistencies in schema indentation. Most of these are
> list indentation which should be 2 spaces more than the start of the
> enclosing keyword. This doesn't matter functionally, but affects running
> scripts which do transforms on the schema files.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/altera.yaml       |  6 +-
>  .../amlogic/amlogic,meson-gx-ao-secure.yaml   |  2 +-
>  .../devicetree/bindings/arm/bitmain.yaml      |  2 +-
>  .../devicetree/bindings/arm/nxp/lpc32xx.yaml  |  9 ++-
>  .../bindings/arm/socionext/uniphier.yaml      | 26 ++++----
>  .../bindings/arm/stm32/st,mlahb.yaml          |  2 +-
>  .../bindings/arm/stm32/st,stm32-syscon.yaml   |  6 +-
>  .../bindings/ata/faraday,ftide010.yaml        |  4 +-
>  .../bindings/bus/allwinner,sun8i-a23-rsb.yaml |  4 +-
>  .../clock/allwinner,sun4i-a10-gates-clk.yaml  |  8 +--
>  .../devicetree/bindings/clock/fsl,plldig.yaml | 17 +++--
>  .../devicetree/bindings/clock/qcom,mmcc.yaml  | 16 ++---
>  .../bindings/connector/usb-connector.yaml     |  6 +-
>  .../crypto/allwinner,sun4i-a10-crypto.yaml    | 14 ++--
>  .../bindings/crypto/allwinner,sun8i-ce.yaml   | 16 ++---
>  .../bindings/crypto/amlogic,gxl-crypto.yaml   |  2 +-
>  .../display/allwinner,sun4i-a10-hdmi.yaml     | 40 ++++++------
>  .../display/allwinner,sun4i-a10-tcon.yaml     | 58 ++++++++---------
>  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 28 ++++----
>  .../display/allwinner,sun8i-a83t-dw-hdmi.yaml | 10 +--
>  .../bindings/display/bridge/lvds-codec.yaml   | 18 +++---
>  .../display/panel/sony,acx424akp.yaml         |  2 +-
>  .../display/panel/xinpeng,xpp055c272.yaml     |  4 +-
>  .../bindings/display/renesas,cmm.yaml         | 16 ++---
>  .../devicetree/bindings/dma/ti/k3-udma.yaml   |  8 +--
>  .../bindings/gpio/brcm,xgs-iproc-gpio.yaml    |  2 +-
>  .../bindings/gpu/arm,mali-midgard.yaml        | 18 +++---
>  .../devicetree/bindings/gpu/vivante,gc.yaml   |  2 +-
>  .../devicetree/bindings/i2c/i2c-rk3x.yaml     | 10 +--
>  .../bindings/iio/adc/adi,ad7124.yaml          |  4 +-
>  .../bindings/iio/adc/lltc,ltc2496.yaml        |  6 +-
>  .../input/allwinner,sun4i-a10-lradc-keys.yaml |  4 +-
>  .../bindings/input/touchscreen/goodix.yaml    |  2 +-
>  .../bindings/interconnect/qcom,msm8916.yaml   |  4 +-
>  .../bindings/interconnect/qcom,msm8974.yaml   |  4 +-
>  .../bindings/interconnect/qcom,qcs404.yaml    |  4 +-
>  .../allwinner,sun7i-a20-sc-nmi.yaml           | 12 ++--
>  .../intel,ixp4xx-interrupt.yaml               |  8 +--
>  .../interrupt-controller/st,stm32-exti.yaml   | 12 ++--
>  .../bindings/iommu/samsung,sysmmu.yaml        | 10 +--
>  .../bindings/mailbox/st,stm32-ipcc.yaml       |  2 +-
>  .../media/allwinner,sun4i-a10-csi.yaml        | 28 ++++----
>  .../bindings/media/amlogic,gx-vdec.yaml       | 14 ++--
>  .../bindings/media/renesas,ceu.yaml           | 28 ++++----
>  .../bindings/media/renesas,vin.yaml           |  8 +--
>  .../devicetree/bindings/media/ti,vpe.yaml     |  2 +-
>  .../memory-controllers/fsl/imx8m-ddrc.yaml    |  6 +-

>  .../bindings/mfd/st,stm32-lptimer.yaml        |  4 +-
>  .../bindings/mfd/st,stm32-timers.yaml         |  4 +-
>  .../devicetree/bindings/mfd/syscon.yaml       | 12 ++--

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   |  2 +-
>  .../bindings/mmc/rockchip-dw-mshc.yaml        | 16 ++---
>  .../bindings/mmc/socionext,uniphier-sd.yaml   | 14 ++--
>  .../devicetree/bindings/mtd/denali,nand.yaml  |  4 +-
>  .../net/allwinner,sun8i-a83t-emac.yaml        |  4 +-
>  .../bindings/net/can/bosch,m_can.yaml         | 52 +++++++--------
>  .../bindings/net/renesas,ether.yaml           |  4 +-
>  .../bindings/net/ti,cpsw-switch.yaml          | 12 ++--
>  .../bindings/net/ti,davinci-mdio.yaml         | 27 ++++----
>  .../bindings/phy/intel,lgm-emmc-phy.yaml      |  2 +-
>  .../devicetree/bindings/pwm/pwm-samsung.yaml  | 16 ++---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   |  2 +-
>  .../reset/brcm,bcm7216-pcie-sata-rescal.yaml  |  4 +-
>  .../devicetree/bindings/rtc/st,stm32-rtc.yaml | 38 +++++------
>  .../bindings/serial/amlogic,meson-uart.yaml   | 16 ++---
>  .../devicetree/bindings/serial/rs485.yaml     | 17 ++---
>  .../bindings/soc/amlogic/amlogic,canvas.yaml  | 10 +--
>  .../bindings/sound/renesas,fsi.yaml           | 16 ++---
>  .../bindings/spi/qcom,spi-qcom-qspi.yaml      | 10 +--
>  .../devicetree/bindings/spi/renesas,hspi.yaml |  4 +-
>  .../devicetree/bindings/spi/spi-pl022.yaml    |  2 +-
>  .../bindings/spi/st,stm32-qspi.yaml           |  4 +-
>  .../allwinner,sun4i-a10-system-control.yaml   | 64 +++++++++----------
>  .../bindings/thermal/amlogic,thermal.yaml     | 10 +--
>  .../bindings/timer/arm,arch_timer.yaml        |  4 +-
>  .../bindings/timer/arm,arch_timer_mmio.yaml   |  4 +-
>  .../devicetree/bindings/usb/dwc2.yaml         |  8 +--
>  77 files changed, 450 insertions(+), 450 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
