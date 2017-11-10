From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: can: rcar_can: document r8a774[35] can
 support
Date: Fri, 10 Nov 2017 15:23:01 -0600
Message-ID: <20171110212301.jbxti6n5ab5hs7xw@rob-hp-laptop>
References: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1510067449-17017-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:49622 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdKJVXC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Nov 2017 16:23:02 -0500
Content-Disposition: inline
In-Reply-To: <1510067449-17017-2-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>

On Tue, Nov 07, 2017 at 03:10:42PM +0000, Fabrizio Castro wrote:
> Document "renesas,can-r8a7743" and "renesas,can-r8a7745" compatible
> strings. Since the fallback compatible string ("renesas,rcar-gen2-can")
> activates the right code in the driver, no driver change is needed.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
