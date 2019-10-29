From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: can: Convert Allwinner A10 CAN controller
 to a schema
Date: Tue, 29 Oct 2019 11:59:26 -0500
Message-ID: <20191029165926.GA13915@bogus>
References: <20191022154745.41865-1-mripard@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191022154745.41865-1-mripard@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Maxime Ripard <mripard@kernel.org>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Tue, 22 Oct 2019 17:47:45 +0200, Maxime Ripard wrote:
> The older Allwinner SoCs have a CAN controller that is supported in Linux,
> with a matching Device Tree binding.
> 
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../net/can/allwinner,sun4i-a10-can.yaml      | 51 +++++++++++++++++++
>  .../devicetree/bindings/net/can/sun4i_can.txt | 36 -------------
>  2 files changed, 51 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/allwinner,sun4i-a10-can.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/sun4i_can.txt
> 

Applied, thanks.

Rob
