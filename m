From: Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH] net: spi: fix a potential NULL pointer dereference
Date: Fri, 22 Mar 2019 22:10:36 -0500
Message-ID: <5465C285-BE0C-4FEF-B732-18B5A8F44C8D@umn.edu>
References: <20190310075735.3392-1-kjlu@umn.edu>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190310075735.3392-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Wei Liu <wei.liu2@citrix.com>, Joe Perches <joe@perches.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



> On Mar 10, 2019, at 1:57 AM, Kangjie Lu <kjlu@umn.edu> wrote:
> 
> In case alloc_workqueue fails to allocate the work queue and
> returns NULL, the fix releases the resources and returns
> -ENOMEM.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> drivers/net/can/spi/mcp251x.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index e90817608645..2737b9a20dfe 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -962,6 +962,14 @@ static int mcp251x_open(struct net_device *net)
> 
> 	priv->wq = alloc_workqueue("mcp251x_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
> 				   0);
> +	if (unlikely(!priv->wq)) {
> +		dev_err(&spi->dev, "failed to allocate work queue\n");
> +		mcp251x_power_enable(priv->transceiver, 0);
> +		close_candev(net);
> +		ret = -ENOMEM;
> +		goto open_unlock;
> +	}
> +

Can someone review this patch?


> 	INIT_WORK(&priv->tx_work, mcp251x_tx_work_handler);
> 	INIT_WORK(&priv->restart_work, mcp251x_restart_work_handler);
> 
> -- 
> 2.17.1
> 
