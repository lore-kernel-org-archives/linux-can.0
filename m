From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: net: can: Convert M_CAN to json-schema
Date: Mon, 3 Feb 2020 14:26:25 +0000
Message-ID: <20200203142625.GA19020@bogus>
References: <20200124155542.2053-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200124155542.2053-1-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Cc: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sriram.dash-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Fri, Jan 24, 2020 at 04:55:42PM +0100, Benjamin Gaignard wrote:
> Convert M_CAN bindings to json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
> ---
>  .../bindings/net/can/can-transceiver.txt           |  24 ----
>  .../devicetree/bindings/net/can/m_can.txt          |  75 ----------
>  .../devicetree/bindings/net/can/m_can.yaml         | 151 +++++++++++++++++++++
>  3 files changed, 151 insertions(+), 99 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt

No chance other controllers aren't going to have a transceiver?

>  delete mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
>  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.yaml

bosch,m_can.yaml

> diff --git a/Documentation/devicetree/bindings/net/can/m_can.yaml b/Documentation/devicetree/bindings/net/can/m_can.yaml
> new file mode 100644
> index 000000000000..efdbed81af29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/m_can.yaml
> @@ -0,0 +1,151 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/m_can.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch MCAN controller Bindings
> +
> +description: Bosch MCAN controller for CAN bus
> +
> +maintainers:
> +  -  Sriram Dash <sriram.dash-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> +
> +properties:
> +  compatible:
> +    const: bosch,m_can
> +
> +  reg:
> +    items:
> +      - description: M_CAN registers map
> +      - description: message RAM
> +
> +  reg-names:
> +    items:
> +      - const: m_can
> +      - const: message_ram
> +
> +  interrupts:
> +    items:
> +      - description: interrupt line0
> +      - description: interrupt line1
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: int0
> +      - const: int1
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    items:
> +      - description: peripheral clock
> +      - description: bus clock
> +
> +  clock-names:
> +    items:
> +      - const: hclk
> +      - const: cclk
> +
> +  bosch,mram-cfg:
> +    description: |
> +                 Message RAM configuration data.
> +                 Multiple M_CAN instances can share the same Message RAM
> +                 and each element(e.g Rx FIFO or Tx Buffer and etc) number
> +                 in Message RAM is also configurable, so this property is
> +                 telling driver how the shared or private Message RAM are
> +                 used by this M_CAN controller.
> +
> +                 The format should be as follows:
> +                 <offset sidf_elems xidf_elems rxf0_elems rxf1_elems rxb_elems txe_elems txb_elems>
> +                 The 'offset' is an address offset of the Message RAM where
> +                 the following elements start from. This is usually set to
> +                 0x0 if you're using a private Message RAM. The remain cells
> +                 are used to specify how many elements are used for each FIFO/Buffer.
> +
> +                 M_CAN includes the following elements according to user manual:
> +                 11-bit Filter	0-128 elements / 0-128 words
> +                 29-bit Filter	0-64 elements / 0-128 words
> +                 Rx FIFO 0	0-64 elements / 0-1152 words
> +                 Rx FIFO 1	0-64 elements / 0-1152 words
> +                 Rx Buffers	0-64 elements / 0-1152 words
> +                 Tx Event FIFO	0-32 elements / 0-64 words
> +                 Tx Buffers	0-32 elements / 0-576 words
> +
> +                 Please refer to 2.4.1 Message RAM Configuration in Bosch
> +                 M_CAN user manual for details.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/int32-matrix

Looks like uint32-array based on the constraints.

> +      - items:
> +         items:
> +           - description: The 'offset' is an address offset of the Message RAM
> +                          where the following elements start from. This is usually
> +                          set to 0x0 if you're using a private Message RAM.
> +             default: 0
> +           - description: 11-bit Filter 0-128 elements / 0-128 words
> +             minimum: 0
> +             maximum: 128
> +           - description: 29-bit Filter 0-64 elements / 0-128 words
> +             minimum: 0
> +             maximum: 64
> +           - description: Rx FIFO 0 0-64 elements / 0-1152 words
> +             minimum: 0
> +             maximum: 64
> +           - description: Rx FIFO 1 0-64 elements / 0-1152 words
> +             minimum: 0
> +             maximum: 64
> +           - description: Rx Buffers 0-64 elements / 0-1152 words
> +             minimum: 0
> +             maximum: 64
> +           - description: Tx Event FIFO 0-32 elements / 0-64 words
> +             minimum: 0
> +             maximum: 32
> +           - description: Tx Buffers 0-32 elements / 0-576 words
> +             minimum: 0
> +             maximum: 32
> +        maxItems: 1
> +
> +  can-transceiver:
> +    type: object
> +
> +    properties:
> +      max-bitrate:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: a positive non 0 value that determines the max speed that
> +                     CAN/CAN-FD can run.
> +        minimum: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - bosch,mram-cfg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx6sx-clock.h>
> +    can@20e8000 {
> +      compatible = "bosch,m_can";
> +      reg = <0x020e8000 0x4000>, <0x02298000 0x4000>;
> +      reg-names = "m_can", "message_ram";
> +      interrupts = <0 114 0x04>, <0 114 0x04>;
> +      interrupt-names = "int0", "int1";
> +      clocks = <&clks IMX6SX_CLK_CANFD>,
> +               <&clks IMX6SX_CLK_CANFD>;
> +      clock-names = "hclk", "cclk";
> +      bosch,mram-cfg = <0x0 0 0 32 0 0 0 1>;
> +
> +      can-transceiver {
> +        max-bitrate = <5000000>;
> +      };
> +    };
> +
> +...
> -- 
> 2.15.0
> 
