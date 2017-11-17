From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 6/7] can: rcar_can: document r8a77995 (R-Car D3)
 compatibility strings
Date: Fri, 17 Nov 2017 07:39:01 -0800
Message-ID: <20171117153900.7is6baf4wtb4acly@verge.net.au>
References: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1510915289-15059-7-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58951 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965045AbdKQPjF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Nov 2017 10:39:05 -0500
Content-Disposition: inline
In-Reply-To: <1510915289-15059-7-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org, magnus.damm@gmail.com, chris.paterson2@renesas.com, ramesh.shanmugasundaram@bp.renesas.com

On Fri, Nov 17, 2017 at 11:41:28AM +0100, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> index 06bb7cc..f7d0358 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -11,6 +11,7 @@ Required properties:
>  	      "renesas,can-r8a7794" if CAN controller is a part of R8A7794 SoC.
>  	      "renesas,can-r8a7795" if CAN controller is a part of R8A7795 SoC.
>  	      "renesas,can-r8a7796" if CAN controller is a part of R8A7796 SoC.
> +	      "renesas,can-r8a77995" if CAN controller is a part of R8A77995 SoC.
>  	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device.
>  	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 compatible device.
>  	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
> @@ -25,12 +26,12 @@ Required properties:
>  - pinctrl-0: pin control group to be used for this controller.
>  - pinctrl-names: must be "default".
>  
> -Required properties for "renesas,can-r8a7795" and "renesas,can-r8a7796"
> -compatible:
> -In R8A7795 and R8A7796 SoCs, "clkp2" can be CANFD clock. This is a div6 clock
> -and can be used by both CAN and CAN FD controller at the same time. It needs to
> -be scaled to maximum frequency if any of these controllers use it. This is done
> -using the below properties:
> +Required properties for "renesas,can-r8a7795", "renesas,can-r8a7796" and
> +"renesas,can-r8a77995" compatible:

Not strictly related to this patch, but aren't these requirements also
applicable to "renesas,rcar-gen3-can"?

> +In R8A7795, R8A7796 and R8A77995 SoCs, "clkp2" can be CANFD clock. This is a
> +div6 clock and can be used by both CAN and CAN FD controller at the same
> +time. It needs to be scaled to maximum frequency if any of these
> +controllers use it. This is done using the below properties:
>  
>  - assigned-clocks: phandle of clkp2(CANFD) clock.
>  - assigned-clock-rates: maximum frequency of this clock.
> -- 
> 2.7.4
> 
