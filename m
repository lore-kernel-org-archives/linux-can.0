From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 net-next] dt-bindings: can: rcar_can: document
 r8a77965 support
Date: Mon, 20 Aug 2018 14:37:02 -0500
Message-ID: <20180820193702.GA18715@bogus>
References: <20180820144910.13210-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180820144910.13210-1-erosca@de.adit-jv.com>
Sender: netdev-owner@vger.kernel.org
Cc: Simon Horman <horms+renesas@verge.net.au>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, linux-renesas-soc@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu Rosca <rosca.eugeniu@gmail.com>
List-Id: linux-can.vger.kernel.org

On Mon, 20 Aug 2018 16:49:10 +0200, Eugeniu Rosca wrote:
> From: Eugeniu Rosca <rosca.eugeniu@gmail.com>
> 
> Document the support for rcar_can on R8A77965 SoC devices.
> Add R8A77965 to the list of SoCs which require the "assigned-clocks" and
> "assigned-clock-rates" properties (thanks, Sergei).
> 
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
> Changes in v3:
>  - [Simon Horman] Added more recipients.
>  - [Simon Horman] Dropped redundant "can" word in summary line.
>  - [Simon Horman] Added Reviewed-by.
>  - [Kieran Bingham] Added Reviewed-by.
> Changes in v2:
>  - [Kieran Bingham] Simplified commit description. Rewrapped text.
>  - [Sergei Shtylyov] Replaced footnotes with inline text.
>  - Pushed all dt-bindings patches to the beginning of the series.
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
