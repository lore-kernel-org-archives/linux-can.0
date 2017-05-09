From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3] ARM: dts: at91: sama5d2: add m_can nodes
Date: Tue, 9 May 2017 13:24:53 +0200
Message-ID: <20170509112453.t3v3bxdrwooa4h6b@piout.net>
References: <20170424011217.2530-1-wenyou.yang@atmel.com>
 <b893b543-bfb6-823d-e111-877a31f44170@Microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b893b543-bfb6-823d-e111-877a31f44170-P1yVeZNtzML3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Yang, Wenyou" <Wenyou.Yang-P1yVeZNtzML3oGB3hsPCZA@public.gmane.org>
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Nicolas.Ferre-P1yVeZNtzML3oGB3hsPCZA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Hartkopp <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-can.vger.kernel.org

On 09/05/2017 at 16:27:36 +0800, Yang, Wenyou wrote:
> 
> 
> On 2017/4/24 9:12, Wenyou Yang wrote:
> > Add nodes to support the Controller Area Network(M_CAN) on SAMA5D2.
> > The version of M_CAN IP core is 3.1.0 (CREL = 0x31040730).
> > 
> > As said in SAMA5D2 datasheet, the CAN clock is recommended to use
> > frequencies of 20, 40 or 80 MHz. To achieve these frequencies,
> > PMC GCLK3 must select the UPLLCK(480 MHz) as source clock and
> > divide by 24, 12, or 6. So, the "assigned-clock-rates" property
> > has three options: 20000000, 40000000, and 80000000.
> > The "assigned-clock-parents" property should be referred to utmi
> > fixedly.
> > 
> > The MSBs [bits 31:16] of the CAN Message RAM for CAN0 and CAN1 are
> > default configured in 0x00200000. To avoid conflict with SRAM map
> > for PM, change them to 0x00210000 in the AT91Bootstrap via setting
> > the CAN Memories Address-based Register(SFR_CAN) of SFR.
> > 
> > Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> > Tested-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> 
> Do you have any comments?

No but this was too late for the previous release and v4.12-rc1 is not
tagged yet so I can't base the dt branch on it.

> > ---
> > The patch is tested on SAMA5D2 Xplained and based on the patch set,
> >   1. [PATCH v4 1/7] can: m_can: Disabled Interrupt Line 1
> >      http://marc.info/?l=linux-can&m=149165343604033&w=2
> > 
> > Changes in v3:
> >   - Add Tested-by tag.
> >   - Change the number of Rx Rx Buffers, Tx Buffers and Tx Event FIFO
> >     to maximum.
> > 
> > Changes in v2:
> >   - Configures 10 TX Event FIFO elements and 10 TX Buffers/FIFO slots,
> >     because the TXE FIFO is needed to be configured.
> >   - Configure the offset of Message RAM for CAN1 followed from CAN0's.
> > 
> >   arch/arm/boot/dts/at91-sama5d2_xplained.dts | 24 +++++++++++++
> >   arch/arm/boot/dts/sama5d2.dtsi              | 56 +++++++++++++++++++++++++++++
> >   2 files changed, 80 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > index 9f7f8a7d8ff9..2f19b08dc226 100644
> > --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > @@ -257,6 +257,12 @@
> >   				status = "okay";
> >   			};
> > +			can0: can@f8054000 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&pinctrl_can0_default>;
> > +				status = "okay";
> > +			};
> > +
> >   			uart3: serial@fc008000 {
> >   				atmel,use-dma-rx;
> >   				atmel,use-dma-tx;
> > @@ -321,6 +327,18 @@
> >   					bias-disable;
> >   				};
> > +				pinctrl_can0_default: can0_default {
> > +					pinmux = <PIN_PC10__CANTX0>,
> > +						 <PIN_PC11__CANRX0>;
> > +					bias-disable;
> > +				};
> > +
> > +				pinctrl_can1_default: can1_default {
> > +					pinmux = <PIN_PC26__CANTX1>,
> > +						 <PIN_PC27__CANRX1>;
> > +					bias-disable;
> > +				};
> > +
> >   				pinctrl_charger_chglev: charger_chglev {
> >   					pinmux = <PIN_PA12__GPIO>;
> >   					bias-disable;
> > @@ -468,6 +486,12 @@
> >   				};
> >   			};
> > +
> > +			can1: can@fc050000 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&pinctrl_can1_default>;
> > +				status = "okay";
> > +			};
> >   		};
> >   	};
> > diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> > index 22332be72140..7e00fa21373e 100644
> > --- a/arch/arm/boot/dts/sama5d2.dtsi
> > +++ b/arch/arm/boot/dts/sama5d2.dtsi
> > @@ -762,6 +762,18 @@
> >   						atmel,clk-output-range = <0 83000000>;
> >   					};
> > +					can0_clk: can0_clk {
> > +						#clock-cells = <0>;
> > +						reg = <56>;
> > +						atmel,clk-output-range = <0 83000000>;
> > +					};
> > +
> > +					can1_clk: can1_clk {
> > +						#clock-cells = <0>;
> > +						reg = <57>;
> > +						atmel,clk-output-range = <0 83000000>;
> > +					};
> > +
> >   					classd_clk: classd_clk {
> >   						#clock-cells = <0>;
> >   						reg = <59>;
> > @@ -890,6 +902,18 @@
> >   						#clock-cells = <0>;
> >   						reg = <55>;
> >   					};
> > +
> > +					can0_gclk: can0_gclk {
> > +						#clock-cells = <0>;
> > +						reg = <56>;
> > +						atmel,clk-output-range = <0 80000000>;
> > +					};
> > +
> > +					can1_gclk: can1_gclk {
> > +						#clock-cells = <0>;
> > +						reg = <57>;
> > +						atmel,clk-output-range = <0 80000000>;
> > +					};
> >   				};
> >   			};
> > @@ -1144,6 +1168,22 @@
> >   				clocks = <&clk32k>;
> >   			};
> > +			can0: can@f8054000 {
> > +				compatible = "bosch,m_can";
> > +				reg = <0xf8054000 0x4000>, <0x210000 0x4000>;
> > +				reg-names = "m_can", "message_ram";
> > +				interrupts = <56 IRQ_TYPE_LEVEL_HIGH 7>,
> > +					     <64 IRQ_TYPE_LEVEL_HIGH 7>;
> > +				interrupt-names = "int0", "int1";
> > +				clocks = <&can0_clk>, <&can0_gclk>;
> > +				clock-names = "hclk", "cclk";
> > +				assigned-clocks = <&can0_gclk>;
> > +				assigned-clock-parents = <&utmi>;
> > +				assigned-clock-rates = <40000000>;
> > +				bosch,mram-cfg = <0x0 0 0 64 0 0 32 32>;
> > +				status = "disabled";
> > +			};
> > +
> >   			spi1: spi@fc000000 {
> >   				compatible = "atmel,at91rm9200-spi";
> >   				reg = <0xfc000000 0x100>;
> > @@ -1305,6 +1345,22 @@
> >   				status = "okay";
> >   			};
> > +			can1: can@fc050000 {
> > +				compatible = "bosch,m_can";
> > +				reg = <0xfc050000 0x4000>, <0x210000 0x4000>;
> > +				reg-names = "m_can", "message_ram";
> > +				interrupts = <57 IRQ_TYPE_LEVEL_HIGH 7>,
> > +					     <65 IRQ_TYPE_LEVEL_HIGH 7>;
> > +				interrupt-names = "int0", "int1";
> > +				clocks = <&can1_clk>, <&can1_gclk>;
> > +				clock-names = "hclk", "cclk";
> > +				assigned-clocks = <&can1_gclk>;
> > +				assigned-clock-parents = <&utmi>;
> > +				assigned-clock-rates = <40000000>;
> > +				bosch,mram-cfg = <0x1100 0 0 64 0 0 32 32>;
> > +				status = "disabled";
> > +			};
> > +
> >   			chipid@fc069000 {
> >   				compatible = "atmel,sama5d2-chipid";
> >   				reg = <0xfc069000 0x8>;
> 
> Best Regards,
> Wenyou Yang

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
