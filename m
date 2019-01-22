From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 09/11] dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
Date: Mon, 21 Jan 2019 19:15:15 -0600
Message-ID: <20190122011515.GA4487@bogus>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben Whitten <ben.whitten@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-can@v
List-Id: linux-can.vger.kernel.org

On Wed, 16 Jan 2019 18:37:52 +0000, Fabrizio Castro wrote:
> According to the latest information, the clock options for CAN on RZ/G2
> are the same as the ones available on R-Car Gen3
> 
> Fixes: 868b7c0f43e6 ("dt-bindings: can: rcar_can: Add r8a774a1 support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
