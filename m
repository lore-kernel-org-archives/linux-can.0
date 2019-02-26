From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH net-next] can: kvaser_usb: Use struct_size() in
 alloc_candev()
Date: Mon, 25 Feb 2019 18:48:21 -0600
Message-ID: <1220cd8d-913f-934b-9c4d-26f4012c3150@embeddedor.com>
References: <20190208031035.GA2665@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208031035.GA2665@embeddedor>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi all,

Friendly ping:

Who can take this?

Thanks
--
Gustavo

On 2/7/19 9:10 PM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = alloc(sizeof(struct foo) + count * sizeof(void *));
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = alloc(struct_size(instance, entry, count));
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> index c89c7d4900d7..0f1d3e807d63 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
> @@ -643,8 +643,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev,
>  			return err;
>  	}
>  
> -	netdev = alloc_candev(sizeof(*priv) +
> -			      dev->max_tx_urbs * sizeof(*priv->tx_contexts),
> +	netdev = alloc_candev(struct_size(priv, tx_contexts, dev->max_tx_urbs),
>  			      dev->max_tx_urbs);
>  	if (!netdev) {
>  		dev_err(&dev->intf->dev, "Cannot alloc candev\n");
> 
