From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] can: m_can: Update documentation to mention new
 fixed transceiver binding
Date: Thu, 3 Aug 2017 12:07:35 -0500
Message-ID: <20170803170735.qntnxpx5olghzmbu@rob-hp-laptop>
References: <20170724230521.1436-1-fcooper@ti.com>
 <20170724230521.1436-4-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36453 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdHCRHh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Aug 2017 13:07:37 -0400
Content-Disposition: inline
In-Reply-To: <20170724230521.1436-4-fcooper@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, quentin.schulz@free-electrons.com, dev.kurt@vandijck-laurijssen.be, andrew@lunn.ch, sergei.shtylyov@cogentembedded.com, socketcan@hartkopp.net

On Mon, Jul 24, 2017 at 06:05:20PM -0500, Franklin S Cooper Jr wrote:
> Add information regarding fixed transceiver binding. This is especially
> important for MCAN since the IP allows CAN FD mode to run significantly
> faster than what most transceivers are capable of.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
> Version 2 changes:
> Drop unit address
> 
>  Documentation/devicetree/bindings/net/can/m_can.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
> index 9e33177..e4abd2c 100644
> --- a/Documentation/devicetree/bindings/net/can/m_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/m_can.txt
> @@ -43,6 +43,11 @@ Required properties:
>  			  Please refer to 2.4.1 Message RAM Configuration in
>  			  Bosch M_CAN user manual for details.
>  
> +Optional properties:
> +- fixed-transceiver	: Fixed-transceiver subnode describing maximum speed

This is a node, not a property. Sub nodes should have their own section.

> +			  that can be used for CAN and/or CAN-FD modes.  See
> +			  Documentation/devicetree/bindings/net/can/fixed-transceiver.txt
> +			  for details.
>  Example:
>  SoC dtsi:
>  m_can1: can@020e8000 {
> @@ -64,4 +69,9 @@ Board dts:
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_m_can1>;
>  	status = "enabled";
> +
> +	fixed-transceiver {
> +		max-arbitration-speed = <1000000>;
> +		max-data-speed = <5000000>;
> +	};
>  };
> -- 
> 2.10.0
> 
