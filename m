From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH V1 3/4] can: add can_is_canfd_skb() API
Date: Wed, 05 Nov 2014 10:39:16 +0100
Message-ID: <5459F044.3090902@hartkopp.net>
References: <1415174326-6623-1-git-send-email-b29396@freescale.com> <1415174326-6623-3-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:17295 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaKEJja (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Nov 2014 04:39:30 -0500
In-Reply-To: <1415174326-6623-3-git-send-email-b29396@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com, varkabhadram@gmail.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05.11.2014 08:58, Dong Aisheng wrote:
> The CAN device drivers can use it to check if the frame to send is on
> CAN FD mode or normal CAN mode.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
>   include/linux/can/dev.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 6992afc..fe3be29 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -99,6 +99,11 @@ inval_skb:
>   	return 1;
>   }
>
> +static inline int can_is_canfd_skb(struct sk_buff *skb)
> +{
> +	return skb->protocol == htons(ETH_P_CANFD);

return skb->len == CANFD_MTU;

Please take the length as distinction as we do it in linux/net/can/ too.

You can add my

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

in the updated post then.

Regards,
Oliver

