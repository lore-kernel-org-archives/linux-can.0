From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Fri, 4 Jan 2019 15:29:55 +0100
Message-ID: <89a70b60-5ee7-3661-70c3-461cf13c1f98@hartkopp.net>
References: <20190104141757.27245-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190104141757.27245-1-mkl@pengutronix.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Muyu Yu <ieatmuttonchuan@gmail.com>, Marcus Meissner <meissner@suse.de>, Michal Kubecek <mkubecek@suse.cz>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hi Marc,

On 1/4/19 3:17 PM, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Muyu Yu provided a POC where user root with CAP_NET_ADMIN can create a CAN
> frame modification rule that makes the data length code a higher value than
> the available CAN frame data size. In combination with a configured checksum
> calculation where the result is stored relatively to the end of the data
> (e.g. cgw_csum_xor_rel) the tail of the skb (e.g. frag_list pointer in
> skb_shared_info) can be rewritten which finally can cause a system crash.
> 
> Michael Kubecek suggested to drop frames that have a DLC exceeding the
> available space after the modification process and provided a patch that can
> handle CAN FD frames too. Within this patch we also limit the length for the
> checksum calculations to the maximum of Classic CAN data length (8).
> 
> CAN frames that are dropped by these additional checks are counted with the
> CGW_DELETED counter which indicates misconfigurations in can-gw rules.
> 
> This fixes CVE-2019-3701.
> 
> Reported-by: Muyu Yu <ieatmuttonchuan@gmail.com>
> Reported-by: Marcus Meissner <meissner@suse.de>
> Suggested-by: Michal Kubecek <mkubecek@suse.cz>
> Tested-by: Muyu Yu <ieatmuttonchuan@gmail.com>
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: linux-stable <stable@vger.kernel.org> # >= v3.2
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
> 
> I've removed the else from dlc length check. Keeps the code and the
> patch more readable.
> 
> Marc
> 
>   net/can/gw.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index faa3da88a127..bb85d815f092 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -416,13 +416,28 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
>   		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
>   
> -	/* check for checksum updates when the CAN frame has been modified */
> +	/* Has the CAN frame been modified? */
>   	if (modidx) {
> -		if (gwj->mod.csumfunc.crc8)
> +		/* get available space for the processed CAN frame type */
> +		int max_len = nskb->len - offsetof(struct can_frame, data);
> +
> +		/* dlc may have changed, make sure it fits to the CAN frame */
> +		if (cf->can_dlc > max_len)
> +			goto out_delete;
> +
> +		/* check for checksum updates in classic CAN length only */
> +		if (gwj->mod.csumfunc.crc8) {
> +			if (cf->can_dlc > 8)
> +				goto out_delete;
> +
>   			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
> +		}
>   
> -		if (gwj->mod.csumfunc.xor)
> +		if (gwj->mod.csumfunc.xor) {
> +			if (cf->can_dlc > 8)
> +				goto out_delete;
>   			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);

Can you please introduce a blank line after the goto statement as you 
did in the code above?

The rest is fine to me.

Thanks for the improvement!

Best,
Oliver

> +		}
>   	}
>   
>   	/* clear the skb timestamp if not configured the other way */
> @@ -434,6 +449,14 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   		gwj->dropped_frames++;
>   	else
>   		gwj->handled_frames++;
> +
> +	return;
> +
> + out_delete:
> +	/* delete frame due to misconfiguration */
> +	gwj->deleted_frames++;
> +	kfree_skb(nskb);
> +	return;
>   }
>   
>   static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
> 
