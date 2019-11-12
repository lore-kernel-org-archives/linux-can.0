From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 1/9] can: af_can: export can_sock_destruct()
Date: Tue, 12 Nov 2019 12:37:24 +0100
Message-ID: <20191112113724.pff6atmyii5ri4my@pengutronix.de>
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
 <20191112111600.18719-2-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112111600.18719-2-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com, netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello,

On Tue, Nov 12, 2019 at 12:15:52PM +0100, Oleksij Rempel wrote:
> In j1939 we need our own struct sock::sk_destruct callback. Export the
> generic af_can can_sock_destruct() that allows us to chain-call it.
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  include/linux/can/core.h | 1 +
>  net/can/af_can.c         | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/can/core.h b/include/linux/can/core.h
> index 8339071ab08b..e20a0cd09ba5 100644
> --- a/include/linux/can/core.h
> +++ b/include/linux/can/core.h
> @@ -65,5 +65,6 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
>  			      void *data);
>  
>  extern int can_send(struct sk_buff *skb, int loop);
> +void can_sock_destruct(struct sock *sk);
>  
>  #endif /* !_CAN_CORE_H */
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 5518a7d9eed9..128d37a4c2e0 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -86,11 +86,12 @@ static atomic_t skbcounter = ATOMIC_INIT(0);
>  
>  /* af_can socket functions */
>  
> -static void can_sock_destruct(struct sock *sk)
> +void can_sock_destruct(struct sock *sk)
>  {
>  	skb_queue_purge(&sk->sk_receive_queue);
>  	skb_queue_purge(&sk->sk_error_queue);
>  }
> +EXPORT_SYMBOL(can_sock_destruct);

If the users are only expected to be another can module, it might make
sense to use a namespace here?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
