From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V1 2/2] Documentation: can: flexcan: Add stop-mode
 property to device tree
Date: Wed, 24 Oct 2018 18:57:06 -0500
Message-ID: <20181024235706.GA22938@bogus>
References: <20181023051449.2116-1-qiangqing.zhang@nxp.com>
 <20181023051449.2116-3-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181023051449.2116-3-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "A.s. Dong" <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

On Tue, Oct 23, 2018 at 05:17:10AM +0000, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> The FlexCAN controller can parse the stop-mode property to enable CAN
> self wakeup feature.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index bfc0c433654f..b5ccfc9c14fb 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -24,6 +24,14 @@ Optional properties:
>                if this property is present then controller is assumed to be big
>                endian.
>  
> +- stop-mode: register bits of stop mode control, the format is

Should have a vendor prefix: fsl,stop-mode

> +			<&gpr req_gpr req_bit ack_gpr ack_bit>.
> +			gpr is the phandle to general purpose register node.
> +			req_gpr is the gpr register offset of CAN stop request.
> +			req_bit is the bit offset of CAN stop request.
> +			ack_gpr is the gpr register offset of CAN stop acknowledge.
> +			ack_bit is the bit offset of CAN stop acknowledge.
> +
>  Example:
>  
>  	can@1c000 {
> -- 
> 2.17.1
> 
