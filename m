From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH AUTOSEL 5.6 068/129] slcan: Don't transmit uninitialized stack data in padding
Date: Wed, 15 Apr 2020 12:09:08 -0500
Message-ID: <87h7xkisln.fsf@x220.int.ebiederm.org>
References: <20200415113445.11881-1-sashal@kernel.org>
        <20200415113445.11881-68-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200415113445.11881-68-sashal@kernel.org> (Sasha Levin's
        message of "Wed, 15 Apr 2020 07:33:43 -0400")
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>, Kees Cook <keescook@chromium.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, security@kernel.org, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
List-Id: linux-can.vger.kernel.org


How does this differ from Greg's backports of this patches?

Sasha Levin <sashal@kernel.org> writes:

> From: Richard Palethorpe <rpalethorpe@suse.com>
>
> [ Upstream commit b9258a2cece4ec1f020715fe3554bc2e360f6264 ]
>
> struct can_frame contains some padding which is not explicitly zeroed in
> slc_bump. This uninitialized data will then be transmitted if the stack
> initialization hardening feature is not enabled (CONFIG_INIT_STACK_ALL).
>
> This commit just zeroes the whole struct including the padding.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Fixes: a1044e36e457 ("can: add slcan driver for serial/USB-serial CAN adapters")
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: linux-can@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: security@kernel.org
> Cc: wg@grandegger.com
> Cc: mkl@pengutronix.de
> Cc: davem@davemloft.net
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/can/slcan.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index a3664281a33fc..4dfa459ef5c73 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -148,7 +148,7 @@ static void slc_bump(struct slcan *sl)
>  	u32 tmpid;
>  	char *cmd = sl->rbuff;
>  
> -	cf.can_id = 0;
> +	memset(&cf, 0, sizeof(cf));
>  
>  	switch (*cmd) {
>  	case 'r':
> @@ -187,8 +187,6 @@ static void slc_bump(struct slcan *sl)
>  	else
>  		return;
>  
> -	*(u64 *) (&cf.data) = 0; /* clear payload */
> -
>  	/* RTR frames may have a dlc > 0 but they never have any data bytes */
>  	if (!(cf.can_id & CAN_RTR_FLAG)) {
>  		for (i = 0; i < cf.can_dlc; i++) {
