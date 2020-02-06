From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindinsg: net: can: Convert can-transceiver to
 json-schema
Date: Thu, 6 Feb 2020 19:05:26 +0000
Message-ID: <20200206190526.GA29141@bogus>
References: <20200203150353.23903-1-benjamin.gaignard@st.com>
 <20200203150353.23903-2-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200203150353.23903-2-benjamin.gaignard@st.com>
Sender: netdev-owner@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, mark.rutland@arm.com, sriram.dash@samsung.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Mon, Feb 03, 2020 at 04:03:52PM +0100, Benjamin Gaignard wrote:
> Convert can-transceiver property to json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/net/can/can-transceiver.txt           | 24 ----------------------
>  .../bindings/net/can/can-transceiver.yaml          | 23 +++++++++++++++++++++
>  2 files changed, 23 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt
>  create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/can/can-transceiver.txt b/Documentation/devicetree/bindings/net/can/can-transceiver.txt
> deleted file mode 100644
> index 0011f53ff159..000000000000
> --- a/Documentation/devicetree/bindings/net/can/can-transceiver.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Generic CAN transceiver Device Tree binding
> -------------------------------
> -
> -CAN transceiver typically limits the max speed in standard CAN and CAN FD
> -modes. Typically these limitations are static and the transceivers themselves
> -provide no way to detect this limitation at runtime. For this situation,
> -the "can-transceiver" node can be used.
> -
> -Required Properties:
> - max-bitrate:	a positive non 0 value that determines the max
> -		speed that CAN/CAN-FD can run. Any other value
> -		will be ignored.
> -
> -Examples:
> -
> -Based on Texas Instrument's TCAN1042HGV CAN Transceiver
> -
> -m_can0 {
> -	....
> -	can-transceiver {
> -		max-bitrate = <5000000>;
> -	};
> -	...
> -};
> diff --git a/Documentation/devicetree/bindings/net/can/can-transceiver.yaml b/Documentation/devicetree/bindings/net/can/can-transceiver.yaml
> new file mode 100644
> index 000000000000..73bb084a45a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/can-transceiver.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/can-transceiver.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CAN transceiver Bindings
> +
> +description: CAN transceiver generic properties bindings
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +properties:
> +  can-transceiver:
> +    type: object

I think we want to drop this (or define $nodename) and then do:

can-transceiver:
  $ref: can-transceiver.yaml#

in the users.

> +
> +    properties:
> +      max-bitrate:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: a positive non 0 value that determines the max speed that
> +                     CAN/CAN-FD can run.
> +        minimum: 1
> -- 
> 2.15.0
> 
