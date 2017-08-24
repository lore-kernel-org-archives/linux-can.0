From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 10/14] can: raw: raw_bind: bail out if can_family is not
 AF_CAN
Date: Thu, 24 Aug 2017 15:40:48 +0200
Message-ID: <58b8814f-a859-217b-7d58-6d652fee337d@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-11-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:35327 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbdHXNkt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:40:49 -0400
In-Reply-To: <20170802174434.4689-11-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> Until now CAN raw's bind() doesn't check if the can_familiy in the
> struct sockaddr_can is set to AF_CAN. This patch adds the missing check.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Agreed :-)

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
>   net/can/raw.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 80a1545bf51a..014874b11def 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -399,6 +399,8 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>   
>   	if (len < sizeof(*addr))
>   		return -EINVAL;
> +	if (addr->can_family != AF_CAN)
> +		return -EINVAL;
>   
>   	lock_sock(sk);
>   
> 
