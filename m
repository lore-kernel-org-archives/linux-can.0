From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] can: j1939: fix double free in j1939_netdev_start
Date: Fri, 17 Jul 2020 14:44:10 +0200
Message-ID: <20200717124410.GA32124@pengutronix.de>
References: <20200710134536.4399-1-trix@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200710134536.4399-1-trix@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: trix@redhat.com
Cc: robin@protonic.nl, linux@rempel-privat.de, kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org, ecathinds@gmail.com, lkp@intel.com, bst@pengutronix.de, maxime.jayat@mobile-devices.fr, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Tom,

On Fri, Jul 10, 2020 at 06:45:36AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this error
> 
> j1939/main.c:292:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(priv);
>         ^~~~~~~~~~~
> 
> The problem block of code is
> 
> 	ret = j1939_can_rx_register(priv);
> 	if (ret < 0)
> 		goto out_priv_put;
> 
> 	return priv;
> 
>  out_priv_put:
> 	j1939_priv_set(ndev, NULL);
> 	dev_put(ndev);
> 	kfree(priv);
> 
> When j1939_can_rx_register fails, it frees priv via the
> j1939_priv_put release function __j1939_priv_release.

In j1939_can_rx_register()...

| static int j1939_can_rx_register(struct j1939_priv *priv)
| {
| 	struct net_device *ndev = priv->ndev;
| 	int ret;

... the function in entered with ref counter == 1.
(Due to kref_init(&priv->kref); in j1939_priv_create())

|
| 	j1939_priv_get(priv);

... then the ref counter is increased by 1, resulting in 2.

| 	ret = can_rx_register(dev_net(ndev), ndev, J1939_CAN_ID, J1939_CAN_MASK,
| 			      j1939_can_recv, priv, "j1939", NULL);
| 	if (ret < 0) {
| 		j1939_priv_put(priv);

And in case of an error, the ref counter is decreased by one again.

| 		return ret;
| 	}
|
| 	return 0;
| }

So we cannot see why clang thinks the memory is double free()d.

> Since j1939_priv_put is used widely, remove the second
> free from j1939_netdev_start.

We might replace the manual kfree() and dev_put() by the dropping the
last ref count and rely on the automatic cleanup.

> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  net/can/j1939/main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 137054bff9ec..991a74bc491b 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -289,7 +289,6 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
>   out_priv_put:
>  	j1939_priv_set(ndev, NULL);
>  	dev_put(ndev);
> -	kfree(priv);
>  
>  	return ERR_PTR(ret);
>  }

regards,
Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
