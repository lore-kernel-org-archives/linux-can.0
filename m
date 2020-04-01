From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] slcan: Don't transmit uninitialized stack data in
 padding
Date: Wed, 1 Apr 2020 21:41:09 +0200
Message-ID: <4ec16ff5-7126-ffa2-491f-520606a038a9@hartkopp.net>
References: <20200401100639.20199-1-rpalethorpe@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200401100639.20199-1-rpalethorpe@suse.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Richard Palethorpe <rpalethorpe@suse.com>, linux-can@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, security@kernel.org, wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
List-Id: linux-can.vger.kernel.org



On 01/04/2020 12.06, Richard Palethorpe wrote:
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

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>


> ---
> 
> V2: Reviewed by Kees and Fixes tag added.
> 
> As mentioned in V1; The following unfinished test can reproduce the bug:
> https://github.com/richiejp/ltp/blob/pty-slcan/testcases/kernel/pty/pty04.c
> 
> 
>   drivers/net/can/slcan.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index a3664281a33f..4dfa459ef5c7 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -148,7 +148,7 @@ static void slc_bump(struct slcan *sl)
>   	u32 tmpid;
>   	char *cmd = sl->rbuff;
>   
> -	cf.can_id = 0;
> +	memset(&cf, 0, sizeof(cf));
>   
>   	switch (*cmd) {
>   	case 'r':
> @@ -187,8 +187,6 @@ static void slc_bump(struct slcan *sl)
>   	else
>   		return;
>   
> -	*(u64 *) (&cf.data) = 0; /* clear payload */
> -
>   	/* RTR frames may have a dlc > 0 but they never have any data bytes */
>   	if (!(cf.can_id & CAN_RTR_FLAG)) {
>   		for (i = 0; i < cf.can_dlc; i++) {
> 
