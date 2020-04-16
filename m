From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: Remove cases of 'allOf' containing a
 '$ref'
Date: Thu, 16 Apr 2020 08:22:31 +0100
Message-ID: <20200416072231.GT2167633@dell>
References: <20200416005549.9683-1-robh@kernel.org>
 <20200416005549.9683-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200416005549.9683-2-robh@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Linus
List-Id: linux-can.vger.kernel.org

On Wed, 15 Apr 2020, Rob Herring wrote:

> json-schema versions draft7 and earlier have a weird behavior in that
> any keywords combined with a '$ref' are ignored (silently). The correct
> form was to put a '$ref' under an 'allOf'. This behavior is now changed
> in the 2019-09 json-schema spec and '$ref' can be mixed with other
> keywords. The json-schema library doesn't yet support this, but the
> tooling now does a fixup for this and either way works.
> 
> This has been a constant source of review comments, so let's change this
> treewide so everyone copies the simpler syntax.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/cpus.yaml         |  81 +++---
>  .../devicetree/bindings/arm/l2c2x0.yaml       |  87 +++---
>  .../devicetree/bindings/arm/psci.yaml         |  15 +-
>  .../bindings/arm/samsung/exynos-chipid.yaml   |   5 +-
>  .../bus/allwinner,sun50i-a64-de2.yaml         |   5 +-
>  .../bindings/clock/fixed-factor-clock.yaml    |   5 +-
>  .../bindings/connector/usb-connector.yaml     |  28 +-
>  .../bindings/crypto/st,stm32-hash.yaml        |   9 +-
>  .../allwinner,sun4i-a10-display-engine.yaml   |   7 +-
>  .../display/allwinner,sun4i-a10-tcon.yaml     |   5 +-
>  .../bindings/display/panel/panel-common.yaml  |   5 +-
>  .../devicetree/bindings/dma/dma-common.yaml   |   3 +-
>  .../devicetree/bindings/dma/ti/k3-udma.yaml   |  18 +-
>  .../devicetree/bindings/eeprom/at24.yaml      |  11 +-
>  .../devicetree/bindings/example-schema.yaml   |  17 +-
>  .../bindings/hwmon/adi,ltc2947.yaml           |  32 +--
>  .../devicetree/bindings/hwmon/ti,tmp513.yaml  |  21 +-
>  .../devicetree/bindings/i2c/st,stm32-i2c.yaml |   9 +-
>  .../bindings/iio/adc/adi,ad7124.yaml          |   5 +-
>  .../bindings/iio/adc/lltc,ltc2496.yaml        |   3 +-
>  .../bindings/iio/adc/microchip,mcp3911.yaml   |   7 +-
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  |  31 +-
>  .../bindings/iio/light/tsl2772.yaml           |  13 +-
>  .../bindings/iio/temperature/adi,ltc2983.yaml |  56 ++--
>  .../input/allwinner,sun4i-a10-lradc-keys.yaml |   5 +-
>  .../devicetree/bindings/input/input.yaml      |   9 +-
>  .../interrupt-controller/arm,gic-v3.yaml      |  39 ++-
>  .../devicetree/bindings/iommu/arm,smmu.yaml   |   3 +-
>  .../devicetree/bindings/leds/common.yaml      |  13 +-
>  .../devicetree/bindings/leds/leds-gpio.yaml   |   3 +-
>  .../bindings/leds/rohm,bd71828-leds.yaml      |  10 +-
>  .../bindings/mailbox/st,stm32-ipcc.yaml       |   5 +-
>  .../bindings/media/amlogic,gx-vdec.yaml       |   6 +-
>  .../media/amlogic,meson-gx-ao-cec.yaml        |   3 +-
>  .../devicetree/bindings/media/rc.yaml         | 265 +++++++++---------
>  .../bindings/media/renesas,vin.yaml           |   7 +-
>  .../memory-controllers/exynos-srom.yaml       |  14 +-
>  .../nvidia,tegra124-emc.yaml                  |   9 +-
>  .../nvidia,tegra124-mc.yaml                   |   3 +-
>  .../nvidia,tegra30-emc.yaml                   |   9 +-
>  .../memory-controllers/nvidia,tegra30-mc.yaml |   3 +-

>  .../bindings/mfd/allwinner,sun4i-a10-ts.yaml  |  20 +-
>  .../bindings/mfd/st,stm32-timers.yaml         |  33 ++-
>  .../devicetree/bindings/mfd/st,stpmic1.yaml   |   9 +-
>  .../devicetree/bindings/mfd/syscon.yaml       |   5 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml |   4 +-
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   |  77 +++--
>  .../bindings/mmc/mmc-controller.yaml          |  37 ++-
>  .../bindings/mmc/rockchip-dw-mshc.yaml        |   6 +-
>  .../bindings/mmc/synopsys-dw-mshc-common.yaml |  14 +-
>  .../mtd/allwinner,sun4i-a10-nand.yaml         |  13 +-
>  .../bindings/mtd/nand-controller.yaml         |  27 +-
>  .../bindings/net/can/bosch,m_can.yaml         |  59 ++--
>  .../bindings/net/ethernet-controller.yaml     |  34 +--
>  .../devicetree/bindings/net/qca,ar803x.yaml   |  17 +-
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  22 +-
>  .../bindings/net/ti,cpsw-switch.yaml          |   3 +-
>  .../bindings/net/ti,davinci-mdio.yaml         |   7 +-
>  .../bindings/pci/intel-gw-pcie.yaml           |   7 +-
>  .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  12 +-
>  .../pinctrl/aspeed,ast2400-pinctrl.yaml       |  37 ++-
>  .../pinctrl/aspeed,ast2500-pinctrl.yaml       |  45 ++-
>  .../pinctrl/aspeed,ast2600-pinctrl.yaml       | 108 ++++---
>  .../bindings/pinctrl/fsl,imx8mp-pinctrl.yaml  |  31 +-
>  .../bindings/pinctrl/intel,lgm-io.yaml        |   4 +-
>  .../bindings/pinctrl/pinmux-node.yaml         |   3 +-
>  .../bindings/pinctrl/st,stm32-pinctrl.yaml    |  56 ++--
>  .../bindings/power/amlogic,meson-ee-pwrc.yaml |   3 +-
>  .../devicetree/bindings/pwm/pwm-samsung.yaml  |  11 +-
>  .../bindings/regulator/gpio-regulator.yaml    |  35 ++-
>  .../bindings/regulator/mps,mpq7920.yaml       |  31 +-
>  .../bindings/regulator/regulator.yaml         |   5 +-
>  .../regulator/rohm,bd71828-regulator.yaml     |  34 +--
>  .../bindings/regulator/st,stm32-booster.yaml  |   3 +-
>  .../regulator/st,stm32mp1-pwr-reg.yaml        |   3 +-
>  .../bindings/remoteproc/st,stm32-rproc.yaml   |   9 +-
>  .../bindings/reset/intel,rcu-gw.yaml          |   3 +-
>  .../devicetree/bindings/riscv/cpus.yaml       |  20 +-
>  .../devicetree/bindings/rtc/st,stm32-rtc.yaml |   9 +-
>  .../devicetree/bindings/serial/pl011.yaml     |  10 +-
>  .../devicetree/bindings/serial/rs485.yaml     |  26 +-
>  .../bindings/serial/samsung_uart.yaml         |   5 +-
>  .../bindings/sound/adi,adau7118.yaml          |  20 +-
>  .../sound/allwinner,sun4i-a10-codec.yaml      |  41 ++-
>  .../bindings/sound/qcom,wcd934x.yaml          |   3 +-
>  .../bindings/spi/renesas,sh-msiof.yaml        |  42 ++-
>  .../bindings/spi/spi-controller.yaml          |  14 +-
>  .../devicetree/bindings/spi/spi-pl022.yaml    |  55 ++--
>  .../devicetree/bindings/spi/spi-sifive.yaml   |  14 +-
>  .../bindings/thermal/qcom-tsens.yaml          |   7 +-
>  .../bindings/timer/arm,arch_timer_mmio.yaml   |   7 +-
>  91 files changed, 881 insertions(+), 1103 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
