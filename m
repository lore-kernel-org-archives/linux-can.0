From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: sja1000: Fix error location forwarding
Date: Sun, 3 Apr 2016 11:32:17 +0200
Message-ID: <5700E321.3020504@hartkopp.net>
References: <20160401191645.36722a06@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:16626 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcDCJcp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 3 Apr 2016 05:32:45 -0400
In-Reply-To: <20160401191645.36722a06@brick.gerasiov.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Gerasiov <gq@cs.msu.su>, linux-can@vger.kernel.org

Hello Alexander,

you are right. Thanks for the fix.

On 04/01/2016 06:16 PM, Alexander Gerasiov wrote:
> According to SJA1000 documentation the location of error is available
> regardless of an error type. Therefore it should always be forwarded to
> SocketCAN.
> 
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@lvk.cs.msu.su>
> Signed-off-by: Alexander GQ Gerasiov <gq@cs.msu.su>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Best regards,
Oliver

> ---
>  drivers/net/can/sja1000/sja1000.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
> index 8dda3b7..9f10779 100644
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -438,6 +438,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>  
>                 cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
>  
> +               /* set error type */
>                 switch (ecc & ECC_MASK) {
>                 case ECC_BIT:
>                         cf->data[2] |= CAN_ERR_PROT_BIT;
> @@ -449,9 +450,12 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
>                         cf->data[2] |= CAN_ERR_PROT_STUFF;
>                         break;
>                 default:
> -                       cf->data[3] = ecc & ECC_SEG;
>                         break;
>                 }
> +
> +               /* set error location */
> +               cf->data[3] = ecc & ECC_SEG;
> +
>                 /* Error occurred during transmission? */
>                 if ((ecc & ECC_DIR) == 0)
>                         cf->data[2] |= CAN_ERR_PROT_TX;
> 
