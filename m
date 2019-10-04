From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: Re: [PATCH 2/6] net: can: xilinx_can: Fix flags field initialization
 for axi can and canps
Date: Fri, 4 Oct 2019 17:32:52 +0300
Message-ID: <d1bedb13-f66f-b0fd-bd6d-9f95b64fc405@bitwise.fi>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
 <1552908766-26753-3-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1552908766-26753-3-git-send-email-appana.durga.rao@xilinx.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, mkl@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, davem@davemloft.net, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

On 18.3.2019 13.32, Appana Durga Kedareswara rao wrote:
> AXI CAN IP and CANPS IP supports tx fifo empty feature, this patch updates
> the flags field for the same.
>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> ---
>  drivers/net/can/xilinx_can.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 2de51ac..22569ef 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -1428,6 +1428,7 @@ static const struct dev_pm_ops xcan_dev_pm_ops = {
>  };
>  
>  static const struct xcan_devtype_data xcan_zynq_data = {
> +	.flags = XCAN_FLAG_TXFEMP,
>  	.bittiming_const = &xcan_bittiming_const,
>  	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
>  	.btr_sjw_shift = XCAN_BTR_SJW_SHIFT,

Thanks for catching this, this line seemed to have been incorrectly
removed by my 9e5f1b273e ("can: xilinx_can: add support for Xilinx CAN
FD core").

But:

> @@ -1435,6 +1436,7 @@ static const struct xcan_devtype_data xcan_zynq_data = {
>  };
>  
>  static const struct xcan_devtype_data xcan_axi_data = {
> +	.flags = XCAN_FLAG_TXFEMP,
>  	.bittiming_const = &xcan_bittiming_const,
>  	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
>  	.btr_sjw_shift = XCAN_BTR_SJW_SHIFT,


Are you sure this is right?
In the documentation [1] there does not seem to be any TXFEMP interrupt,
it would be interrupt bit 14 but AXI CAN 5.0 seems to only go up to 11.

Or maybe it is undocumented or there is a newer version somewhere?

[1]
https://www.xilinx.com/support/documentation/ip_documentation/can/v5_0/pg096-can.pdf

-- 
Anssi Hannula / Bitwise Oy
+358 503803997
