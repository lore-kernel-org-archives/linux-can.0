From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net 06/16] can: add missing attribute validation for
 termination
Date: Tue, 3 Mar 2020 20:58:30 +0100
Message-ID: <c5842943-f11b-0d42-d03d-71930a7ecc3e@hartkopp.net>
References: <20200303050526.4088735-1-kuba@kernel.org>
 <20200303050526.4088735-7-kuba@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200303050526.4088735-7-kuba@kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 03/03/2020 06.05, Jakub Kicinski wrote:
> Add missing attribute validation for IFLA_CAN_TERMINATION
> to the netlink policy.
> 
> Fixes: 12a6075cabc0 ("can: dev: add CAN interface termination API")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: Wolfgang Grandegger <wg@grandegger.com>
> CC: Marc Kleine-Budde <mkl@pengutronix.de>
> CC: Oliver Hartkopp <socketcan@hartkopp.net>
> CC: linux-can@vger.kernel.org
> ---
>   drivers/net/can/dev.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 6ee06a49fb4c..68834a2853c9 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -883,6 +883,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>   				= { .len = sizeof(struct can_bittiming) },
>   	[IFLA_CAN_DATA_BITTIMING_CONST]
>   				= { .len = sizeof(struct can_bittiming_const) },
> +	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
>   };
>   
>   static int can_validate(struct nlattr *tb[], struct nlattr *data[],

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Jakub for catching all these missing defs!

Best regards,
Oliver
