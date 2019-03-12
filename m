From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Date: Tue, 12 Mar 2019 10:54:53 -0500
Message-ID: <20190312155453.GA24561@bogus>
References: <cover.1551287365.git.pisa@cmp.felk.cvut.cz>
 <2b529d1574916b50e7647281af87df33442b7549.1551287365.git.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2b529d1574916b50e7647281af87df33442b7549.1551287365.git.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: pisa@cmp.felk.cvut.cz
Cc: devicetree@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com, davem@davemloft.net, mark.rutland@arm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com, ondrej.ille@gmail.com
List-Id: linux-can.vger.kernel.org

On Wed, Feb 27, 2019 at 06:26:29PM +0100, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 108 +++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
> new file mode 100644
> index 000000000000..fea9c08b79ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
> @@ -0,0 +1,108 @@
> +Memory mapped CTU CAN FD open-source IP core
> +
> +The core sources and documentation on project page
> +
> +  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
> +  http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/Progdokum.pdf
> +
> +Integration in Xilinx Zynq SoC based system together with
> +OpenCores SJA1000 compatible controllers
> +
> +  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top
> +
> +Martin Jerabek's dimploma thesis with integration and testing
> +framework description
> +
> + https://dspace.cvut.cz/bitstream/handle/10467/80366/F3-DP-2019-Jerabek-Martin-Jerabek-thesis-2019-canfd.pdf
> +
> +Required properties:
> +
> +- compatible : should be one of "ctu,ctucanfd", "ctu,canfd-2".
> +      The "canfd-2" has been reserved for older revision of the IP core.
> +      The revision can be read from the IP core register as well.
> +
> +- reg = <(baseaddr) (size)> : specify mapping into physical address
> +      space of the processor system.
> +
> +- interrupts : property with a value describing the interrupt source
> +      required for the CTU CAN FD. For Zynq SoC system format is
> +      <(is_spi) (number) (type)> where is_spi defines if it is SPI
> +      (shared peripheral) interrupt, the second number is translated
> +      to the vector by addition of 32 on Zynq-7000 systems and type
> +      is IRQ_TYPE_LEVEL_HIGH (4) for Zynq.
> +
> +- interrupt-parent = <&interrupt-controller-phandle> :
> +      is required for Zynq SoC to find map interrupt
> +      to the correct controller

Remove as this is implied and could be in a parent node.

> +
> +- clocks: phandle of reference clock (100 MHz is appropriate
> +      for FPGA implementation on Zynq-7000 system).
> +
> +Optional properties:
> +
> +- clock-names: not used in actual design but if more clocks are used
> +      by cores then "can_clk" would be clock source name for the clocks
> +      used to define CAN time-quanta.
> +
> +Example when integrated to Zynq-7000 system DTS:
> +
> +        / {
> +            /* ... */
> +            amba: amba {
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +                compatible = "simple-bus";
> +
> +                ctu_can_fd_0: ctu_can_fd@43c30000 {

can@...

> +                    compatible = "ctu,ctucanfd";
> +                    interrupt-parent = <&intc>;
> +                    interrupts = <0 30 4>;
> +                    clocks = <&clkc 15>;
> +                    reg = <0x43c30000 0x10000>;
> +                };
> +            };
> +        };
> +
> +
> +Example when used as DTS overlay on Zynq-7000 system:
> +
> +
> +// Device Tree Example: Full Reconfiguration without Bridges

Drop this example. Overlays are outside the scope of bindings.

> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +    fragment@0 {
> +        target-path = "/fpga-full";
> +
> +        __overlay__ {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            firmware-name = "system.bit.bin";
> +        };
> +    };
> +
> +    fragment@1 {
> +        target-path = "/amba";
> +        __overlay__ {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +
> +            ctu_can_fd_0: ctu_can_fd@43c30000 {
> +                compatible = "ctu,ctucanfd";
> +                interrupt-parent = <&intc>;
> +                interrupts = <0 30 4>;
> +                clocks = <&clkc 15>;
> +                reg = <0x43c30000 0x10000>;
> +            };
> +            ctu_can_fd_1: ctu_can_fd@43c70000 {
> +                compatible = "ctu,ctucanfd";
> +                interrupt-parent = <&intc>;
> +                interrupts = <0 31 4>;
> +                clocks = <&clkc 15>;
> +                reg = <0x43c70000 0x10000>;
> +            };
> +        };
> +    };
> +};
> -- 
> 2.11.0
> 
