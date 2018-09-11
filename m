From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/3][can-next] can: rcar_can: Fix erroneous
 registration
Date: Tue, 11 Sep 2018 15:31:10 +0200
Message-ID: <20180911133110.hwlqzwltdkngdcvp@verge.net.au>
References: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1536576195-11520-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536576195-11520-2-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Mon, Sep 10, 2018 at 11:43:13AM +0100, Fabrizio Castro wrote:
> Assigning 2 to "renesas,can-clock-select" tricks the driver into
> registering the CAN interface, even though we don't want that.
> This patch improves one of the checks to prevent that from happening.
> 
> Fixes: 862e2b6af9413b43 ("can: rcar_can: support all input clocks")
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
