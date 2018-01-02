From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] flex_can: Correct the checking for frame length in
 flexcan_start_xmit()
Date: Tue, 2 Jan 2018 12:17:03 +0100
Message-ID: <01a2ed6c-b0f7-4cef-6967-5210045e7d7e@hartkopp.net>
References: <1514864658-13194-1-git-send-email-phu.luuan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:15872 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbeABLRR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Jan 2018 06:17:17 -0500
In-Reply-To: <1514864658-13194-1-git-send-email-phu.luuan@nxp.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luu An Phu <phu.luuan@nxp.com>, wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, stefan-gabriel.mirea@nxp.com



On 01/02/2018 04:44 AM, Luu An Phu wrote:
> From: "phu.luuan" <phu.luuan@nxp.com>
> 
> The flexcan_start_xmit() function compares the frame length with data register
> length to write frame content into data[0] and data[1] register. Data register
> length is 4 bytes and frame maximum length is 8 bytes.
> 
> Fix the check that compares frame length with 3. Because the register length
> is 4.
> 
> Signed-off-by: Luu An Phu <phu.luuan@nxp.com>

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks for this improvement!

Best regards,
Oliver

> ---
>   drivers/net/can/flexcan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 0626dcf..760d2c0 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -526,7 +526,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   		data = be32_to_cpup((__be32 *)&cf->data[0]);
>   		flexcan_write(data, &priv->tx_mb->data[0]);
>   	}
> -	if (cf->can_dlc > 3) {
> +	if (cf->can_dlc > 4) {
>   		data = be32_to_cpup((__be32 *)&cf->data[4]);
>   		flexcan_write(data, &priv->tx_mb->data[1]);
>   	}
> 
