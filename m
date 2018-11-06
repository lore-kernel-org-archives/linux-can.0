From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: phy: phy-of-simple: Document new binding
Date: Tue, 6 Nov 2018 14:55:54 -0600
Message-ID: <CAL_Jsq+tMKb6e69dfz9B1g3yy+a+sPTM0edJ51x6+hWEMAu8CA@mail.gmail.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com> <20181102192616.28291-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102192616.28291-3-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-can.vger.kernel.org

On Fri, Nov 2, 2018 at 2:23 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add documentation for the generic simple phy implementation.

We don't do 'simple' or 'generic' bindings.

> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  .../devicetree/bindings/phy/phy-of-simple.txt | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-of-simple.txt
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-of-simple.txt b/Documentation/devicetree/bindings/phy/phy-of-simple.txt
> new file mode 100644
> index 000000000000..696f2763395c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-of-simple.txt
> @@ -0,0 +1,29 @@
> +Generic simple phy device tree binding
> +--------------------------------------
> +
> +A good number of phy implementations merely read dts properties,
> +enable clocks, regulators or do resets without having a dedicated register
> +map. This binding implements a generic phy driver which can be used for
> +such simple implementations and avoid boilerplate code duplication.

Sure, but then latter some needs certain timing/ordering of those
controls or some other DT additions. 'generic' or 'simple' never work
out for bindings. By all means though, write a simple/generic phy
driver. Just make it understand an explicit list of compatible
strings. Then when a phy turns out to be not so simple, we can write a
driver for it with changing the DT.

> +Required Properties:
> +-  compatible  : must be "simple-phy"
> +-  phy-cells    : must be 0

#phy-cells

> +
> +Optional Properties:
> +-  bus-width   : generic bus-width. Must be positive.
> +-  max-bitrate : generic max-bitrate. Must be positive.
> +-  pwr         : phandle to phy pwr regulator node.

That's not the regulator binding.

> +
> +Example:
> +
> +The following example is a can transceiver implemented as a generic phy.
> +It has a max-bitrate property and a pwr regulator.
> +
> +
> +transceiver1: can-transceiver {
> +       compatible = "simple-phy";
> +       max-bitrate = <5000000>;
> +       pwr-supply = <&transceiver1_fixed>;
> +       #phy-cells = <0>;
> +};
> --
> 2.18.0
>
