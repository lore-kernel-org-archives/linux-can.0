From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v1] can: j1939: transport: j1939_simple_recv(): ignore
 local J1939 messages send not by J1939 stack
Date: Wed, 18 Dec 2019 10:03:27 +0100
Message-ID: <c2e25142-8104-872e-3e33-63307a2d34ab@hartkopp.net>
References: <20191218084355.24398-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191218084355.24398-1-o.rempel@pengutronix.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>, dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de, wg@grandegger.com
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Oleksij,

On 18/12/2019 09.43, Oleksij Rempel wrote:
> In current J1939 stack implementation, we process all locally send
> messages as own messages. Even if it was send by CAN_RAW socket.
> 
> To reproduce it use following commands:
> testj1939 -P -r can0:0x80 &
> cansend can0 18238040#0123
> 
> This step will trigger false positive not critical warning:
> j1939_simple_recv: Received already invalidated message
> 
> With this patch we add additional check to make sure, related skb is own
> echo message.

in net/can/raw.c we check whether the CAN has been sent from that socket 
(an by default suppress our own transmitted data):

https://elixir.bootlin.com/linux/v5.4.3/source/net/can/raw.c#L124

would checking against the 'sk' work for you too?

What happens if someone runs a J1939 implementation on a CAN_RAW socket 
in addition to the in-kernel implementation? Can they talk to each other?

Regards,
Oliver

> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   net/can/j1939/socket.c    | 1 +
>   net/can/j1939/transport.c | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index f7587428febd..b9a17c2ee16f 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -398,6 +398,7 @@ static int j1939_sk_init(struct sock *sk)
>   	spin_lock_init(&jsk->sk_session_queue_lock);
>   	INIT_LIST_HEAD(&jsk->sk_session_queue);
>   	sk->sk_destruct = j1939_sk_sock_destruct;
> +	sk->sk_protocol = CAN_J1939;
>   
>   	return 0;
>   }
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 9f99af5b0b11..b135c5e2a86e 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -2017,6 +2017,10 @@ void j1939_simple_recv(struct j1939_priv *priv, struct sk_buff *skb)
>   	if (!skb->sk)
>   		return;
>   
> +	if (skb->sk->sk_family != AF_CAN ||
> +	    skb->sk->sk_protocol != CAN_J1939)
> +		return;
> +
>   	j1939_session_list_lock(priv);
>   	session = j1939_session_get_simple(priv, skb);
>   	j1939_session_list_unlock(priv);
> 
