From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: af_can: Fix Spectre v1 vulnerability
Date: Sun, 23 Dec 2018 20:02:18 +0100
Message-ID: <f0c42e0b-7d10-be7e-4b52-82567cf747eb@hartkopp.net>
References: <20181221212229.GA32635@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181221212229.GA32635@embeddedor>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

After *trying* to follow the discussion on ...

https://marc.info/?l=linux-kernel&m=154554485324143&w=2
[PATCH] net: core: Fix Spectre v1 vulnerability

... I'm still not sure whether af_can.c needs this enhancement or not.

Just waiting for the end of the discussion :-)

Thanks to the experts!

Oliver

On 12/21/18 10:22 PM, Gustavo A. R. Silva wrote:
> protocol is indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> net/can/af_can.c:115 can_get_proto() warn: potential spectre issue 'proto_tab' [w]
> 
> Fix this by sanitizing protocol before using it to index proto_tab.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   net/can/af_can.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 1684ba5b51eb..cade7250c6d4 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -59,6 +59,7 @@
>   #include <linux/can/core.h>
>   #include <linux/can/skb.h>
>   #include <linux/ratelimit.h>
> +#include <linux/nospec.h>
>   #include <net/net_namespace.h>
>   #include <net/sock.h>
>   
> @@ -136,6 +137,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
>   
>   	if (protocol < 0 || protocol >= CAN_NPROTO)
>   		return -EINVAL;
> +	protocol = array_index_nospec(protocol, CAN_NPROTO);
>   
>   	cp = can_get_proto(protocol);
>   
> 
