From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Date: Thu, 6 Aug 2020 08:43:45 -0600
Message-ID: <20200806144345.GA822372@bogus>
References: <cover.1596408856.git.pisa@cmp.felk.cvut.cz>
 <701442883f2b439637ff84544745725bdee7bcf8.1596408856.git.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <701442883f2b439637ff84544745725bdee7bcf8.1596408856.git.pisa@cmp.felk.cvut.cz>
Sender: netdev-owner@vger.kernel.org
To: pisa@cmp.felk.cvut.cz
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, mkl@pengutronix.de, socketcan@hartkopp.net, wg@grandegger.com, davem@davemloft.net, mark.rutland@arm.com, c.emde@osadl.org, armbru@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com, ondrej.ille@gmail.com, jnovak@fel.cvut.cz, jara.beran@gmail.com, porazil@pikron.com
List-Id: linux-can.vger.kernel.org

On Mon, Aug 03, 2020 at 08:34:50PM +0200, pisa@cmp.felk.cvut.cz wrote:
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> The device-tree bindings for open-source CAN FD IP core
> which design started at Department of Measurement
> at Faculty of Electrical Engineering
> of Czech Technical University in Prague.
> The IP core main author is Ondrej Ille who continues
> on the core development even after finishing the studies.
> 
> The CTU CAN FD IP core main repository
> 
>   https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
> 
> The list of related CAN bus projects which we participate in
> 
>    http://canbus.pages.fel.cvut.cz/
> 
> The commit text again to make checkpatch happy.
> 
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  .../devicetree/bindings/net/can/ctu,ctucanfd.yaml  | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
> new file mode 100644
> index 000000000000..b74bfc951062
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/ctu,ctucanfd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CTU CAN FD Open-source IP Core Device Tree Bindings
> +
> +description: |
> +  Open-source CAN FD IP core developed at the Czech Technical University in Prague
> +
> +  The core sources and documentation on project page
> +    [1] sources : https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
> +    [2] datasheet : https://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/Progdokum.pdf
> +
> +  Integration in Xilinx Zynq SoC based system together with
> +  OpenCores SJA1000 compatible controllers
> +    [3] project : https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top
> +  Martin Jerabek dimploma thesis with integration and testing
> +  framework description
> +    [4] PDF : https://dspace.cvut.cz/bitstream/handle/10467/80366/F3-DP-2019-Jerabek-Martin-Jerabek-thesis-2019-canfd.pdf
> +
> +maintainers:
> +  - Pavel Pisa <pisa@cmp.felk.cvut.cz>
> +  - Ondrej Ille <ondrej.ille@gmail.com>
> +  - Martin Jerabek <martin.jerabek01@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: ctu,ctucanfd
> +          - const: ctu,canfd-2

The order is supposed to be be most specific compatible first, but this 
seems backwards given 'ctu,ctucanfd' alone is allowed.

> +      - const: ctu,ctucanfd
> +
> +  reg:
> +    description:
> +      mapping into bus address space, offset and size

No need to describe common properties unless you have something specific 
to this device to say.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      interrupt source. For Zynq SoC system, format is <(is_spi) (number) (type)>
> +      where is_spi defines if it is SPI (shared peripheral) interrupt,
> +      the second number is translated to the vector by addition of 32
> +      on Zynq-7000 systems and type is IRQ_TYPE_LEVEL_HIGH (4) for Zynq.

That's all outside the scope of this binding.

> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      phandle of reference clock (100 MHz is appropriate
> +      for FPGA implementation on Zynq-7000 system).
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ctu_can_fd_0: can@43c30000 {
> +      compatible = "ctu,ctucanfd";
> +      interrupts = <0 30 4>;
> +      clocks = <&clkc 15>;
> +      reg = <0x43c30000 0x10000>;
> +    };
> -- 
> 2.11.0
> 
