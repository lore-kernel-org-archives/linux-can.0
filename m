From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 04/14] can: af_can: give variable holding the CAN per
 device receive lists a sensible name
Date: Thu, 24 Aug 2017 15:03:37 +0200
Message-ID: <7225d783-b4b6-3d65-1f3b-13138c896718@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-5-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:23807 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdHXNDi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:03:38 -0400
In-Reply-To: <20170802174434.4689-5-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> This patch gives the variables holding the CAN receive filter lists a
> better name by renaming them from "d" to "dev_rcv_lists".
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   net/can/af_can.c | 87 ++++++++++++++++++++++++++++----------------------------
>   1 file changed, 43 insertions(+), 44 deletions(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 2b12f713f4ca..43f4f51d5a73 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -381,7 +381,7 @@ static unsigned int effhash(canid_t can_id)
>    *  Reduced can_id to have a preprocessed filter compare value.
>    */
>   static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
> -					struct can_dev_rcv_lists *d)
> +					struct can_dev_rcv_lists *dev_rcv_lists)

					struct can_dev_rcv_lists *cdrl)

Ok. 'd' might be too short and not be easy to bring into connection with 
can_dev_rcv_lists ... but 'dev_rcv_lists' smells like just another 
structure definition an not a handy variable name, like e.g. cdrl ;-)

Regards,
Oliver

