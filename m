From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2] ARM: dts: at91: sama5d2: add m_can nodes
Date: Wed, 19 Apr 2017 15:07:42 +0200
Message-ID: <75f97593-1c22-c116-3321-9c87d6eb8a1d@free-electrons.com>
References: <20170419084606.27543-1-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40924 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763063AbdDSNHp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Apr 2017 09:07:45 -0400
In-Reply-To: <20170419084606.27543-1-wenyou.yang@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wenyou Yang <wenyou.yang@atmel.com>, Nicolas.Ferre@Microchip.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: devicetree@vger.kernel.org, Wenyou Yang <wenyou.yang@microchip.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 19/04/2017 10:46, Wenyou Yang wrote:
> Add nodes to support the Controller Area Network(M_CAN) on SAMA5D2.
> The version of M_CAN IP core is 3.1.0 (CREL = 0x31040730).
> 
> As said in SAMA5D2 datasheet, the CAN clock is recommended to use
> frequencies of 20, 40 or 80 MHz. To achieve these frequencies,
> PMC GCLK3 must select the UPLLCK(480 MHz) as source clock and
> divide by 24, 12, or 6. So, the "assigned-clock-rates" property
> has three options: 20000000, 40000000, and 80000000.
> The "assigned-clock-parents" property should be referred to utmi
> fixedly.
> 
> The MSBs [bits 31:16] of the CAN Message RAM for CAN0 and CAN1 are
> default configured in 0x00200000. To avoid conflict with SRAM map
> for PM, change them to 0x00210000 in the AT91Bootstrap via setting
> the CAN Memories Address-based Register(SFR_CAN) of SFR.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> The patch is tested on SAMA5D2 Xplained and based on the patch set,
>  1. [PATCH v4 1/7] can: m_can: Disabled Interrupt Line 1
>     http://marc.info/?l=linux-can&m=149165343604033&w=2
> 
> Changes in v2:
>  - Configures 10 TX Event FIFO elements and 10 TX Buffers/FIFO slots,
>    because the TXE FIFO is needed to be configured.
>  - Configure the offset of Message RAM for CAN1 followed from CAN0's.
> 


I've tested with the v4 patch series of Mario Hüttel on a SAMA5D2
Xplained and did the following:

# ip link set can0 down
# ip link set can0 up type can bitrate 125000
# cansend can0 500#1E.10.10

Last line at least 10 times, every message is received on my computer.
Same with can1. Tested with candump can0 as well, everything looks fine.

Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Thanks,
Quentin


>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 24 +++++++++++++
>  arch/arm/boot/dts/sama5d2.dtsi              | 56 +++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 9f7f8a7d8ff9..2f19b08dc226 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -257,6 +257,12 @@
>  				status = "okay";
>  			};
>  
> +			can0: can@f8054000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_can0_default>;
> +				status = "okay";
> +			};
> +
>  			uart3: serial@fc008000 {
>  				atmel,use-dma-rx;
>  				atmel,use-dma-tx;
> @@ -321,6 +327,18 @@
>  					bias-disable;
>  				};
>  
> +				pinctrl_can0_default: can0_default {
> +					pinmux = <PIN_PC10__CANTX0>,
> +						 <PIN_PC11__CANRX0>;
> +					bias-disable;
> +				};
> +
> +				pinctrl_can1_default: can1_default {
> +					pinmux = <PIN_PC26__CANTX1>,
> +						 <PIN_PC27__CANRX1>;
> +					bias-disable;
> +				};
> +
>  				pinctrl_charger_chglev: charger_chglev {
>  					pinmux = <PIN_PA12__GPIO>;
>  					bias-disable;
> @@ -468,6 +486,12 @@
>  				};
>  
>  			};
> +
> +			can1: can@fc050000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_can1_default>;
> +				status = "okay";
> +			};
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 22332be72140..383ca9307edf 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -762,6 +762,18 @@
>  						atmel,clk-output-range = <0 83000000>;
>  					};
>  
> +					can0_clk: can0_clk {
> +						#clock-cells = <0>;
> +						reg = <56>;
> +						atmel,clk-output-range = <0 83000000>;
> +					};
> +
> +					can1_clk: can1_clk {
> +						#clock-cells = <0>;
> +						reg = <57>;
> +						atmel,clk-output-range = <0 83000000>;
> +					};
> +
>  					classd_clk: classd_clk {
>  						#clock-cells = <0>;
>  						reg = <59>;
> @@ -890,6 +902,18 @@
>  						#clock-cells = <0>;
>  						reg = <55>;
>  					};
> +
> +					can0_gclk: can0_gclk {
> +						#clock-cells = <0>;
> +						reg = <56>;
> +						atmel,clk-output-range = <0 80000000>;
> +					};
> +
> +					can1_gclk: can1_gclk {
> +						#clock-cells = <0>;
> +						reg = <57>;
> +						atmel,clk-output-range = <0 80000000>;
> +					};
>  				};
>  			};
>  
> @@ -1144,6 +1168,22 @@
>  				clocks = <&clk32k>;
>  			};
>  
> +			can0: can@f8054000 {
> +				compatible = "bosch,m_can";
> +				reg = <0xf8054000 0x4000>, <0x210000 0x4000>;
> +				reg-names = "m_can", "message_ram";
> +				interrupts = <56 IRQ_TYPE_LEVEL_HIGH 7>,
> +					     <64 IRQ_TYPE_LEVEL_HIGH 7>;
> +				interrupt-names = "int0", "int1";
> +				clocks = <&can0_clk>, <&can0_gclk>;
> +				clock-names = "hclk", "cclk";
> +				assigned-clocks = <&can0_gclk>;
> +				assigned-clock-parents = <&utmi>;
> +				assigned-clock-rates = <40000000>;
> +				bosch,mram-cfg = <0x0 0 0 32 0 0 10 10>;
> +				status = "disabled";
> +			};
> +
>  			spi1: spi@fc000000 {
>  				compatible = "atmel,at91rm9200-spi";
>  				reg = <0xfc000000 0x100>;
> @@ -1305,6 +1345,22 @@
>  				status = "okay";
>  			};
>  
> +			can1: can@fc050000 {
> +				compatible = "bosch,m_can";
> +				reg = <0xfc050000 0x4000>, <0x210000 0x4000>;
> +				reg-names = "m_can", "message_ram";
> +				interrupts = <57 IRQ_TYPE_LEVEL_HIGH 7>,
> +					     <65 IRQ_TYPE_LEVEL_HIGH 7>;
> +				interrupt-names = "int0", "int1";
> +				clocks = <&can1_clk>, <&can1_gclk>;
> +				clock-names = "hclk", "cclk";
> +				assigned-clocks = <&can1_gclk>;
> +				assigned-clock-parents = <&utmi>;
> +				assigned-clock-rates = <40000000>;
> +				bosch,mram-cfg = <0x1100 0 0 32 0 0 10 10>;
> +				status = "disabled";
> +			};
> +
>  			chipid@fc069000 {
>  				compatible = "atmel,sama5d2-chipid";
>  				reg = <0xfc069000 0x8>;
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
