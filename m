From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 08/14] can: af_can: can_rx_register(): use max() instead
 of open coding it
Date: Thu, 24 Aug 2017 15:28:10 +0200
Message-ID: <36e76b44-3e3a-f5fc-46f4-77ccabca5d8f@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-9-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:33182 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdHXN2L (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:28:11 -0400
In-Reply-To: <20170802174434.4689-9-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> This patch replaces an open coded max by the proper kernel define max().
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Oliver Hartkopp <soketcan@hartkopp.net>

> ---
>   net/can/af_can.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index cb079d2dcde2..e3df12cd2cae 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -498,8 +498,8 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
>   		dev_rcv_lists->entries++;
>   
>   		can_pstats->rcv_entries++;
> -		if (can_pstats->rcv_entries_max < can_pstats->rcv_entries)
> -			can_pstats->rcv_entries_max = can_pstats->rcv_entries;
> +		can_pstats->rcv_entries_max = max(can_pstats->rcv_entries_max,
> +						  can_pstats->rcv_entries);
>   	} else {
>   		kmem_cache_free(rcv_cache, rcv);
>   		err = -ENODEV;
> 
