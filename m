From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 3/3] can: mcp25xxfd: add gpiolib support for GPIO0/1
 (aka. INT0/INT1)
Date: Mon, 29 Jan 2018 13:39:42 -0600
Message-ID: <20180129193942.wvexhlnzoux6i5cr@rob-hp-laptop>
References: <20180119074140.25931-1-kernel@martin.sperl.org>
 <20180119074140.25931-4-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45093 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeA2Tjq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Jan 2018 14:39:46 -0500
Content-Disposition: inline
In-Reply-To: <20180119074140.25931-4-kernel@martin.sperl.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kernel@martin.sperl.org
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Mark Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Marcel Birthelmer <Marcel.Birthelmer@microchip.com>, Sukkin Pang <skp@skpang.co.uk>, Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

On Fri, Jan 19, 2018 at 07:41:40AM +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add GPIOLIB support to mcp25xxfd.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> 
> ---
> Changelog:
>   V1 -> V2: implemented GPIOLIB support as per feedback
> 
> ---
> .../bindings/net/can/microchip,mcp25xxfd.txt       |   2 +
>  drivers/net/can/spi/mcp25xxfd.c                    | 185 +++++++++++++++++++++
>  2 files changed, 187 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.txt
> index 691dd6220bd7..716b0a16ecb2 100644
> --- a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.txt
> @@ -7,6 +7,7 @@ Required properties:
>   - clocks: The clock feeding the CAN controller.
>   - interrupt-parent: The parent interrupt controller.
>   - interrupts: Should contain IRQ line for the CAN controller.
> + - gpio-controller: Marks the device node as a GPIO controller

This belongs in patch 1. The binding describes the h/w, not what a 
driver currently supports.

> 
>  Optional properties:
>   - vdd-supply: Regulator that powers the CAN controller.
> @@ -26,4 +27,5 @@ Example:
>  		interrupts = <13 0x8>;
>  		vdd-supply = <&reg5v0>;
>  		xceiver-supply = <&reg5v0>;
> +		gpio-controller;
>  	};
