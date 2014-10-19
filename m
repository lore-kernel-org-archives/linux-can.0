From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 08/15] can: rx-fifo: fix long lines
Date: Sun, 19 Oct 2014 23:18:03 +0200
Message-ID: <20141019211803.GA428@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
 <1412956020-21489-9-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52551 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaJSVSM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 19 Oct 2014 17:18:12 -0400
Content-Disposition: inline
In-Reply-To: <1412956020-21489-9-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

On Fri, Oct 10, 2014 at 05:46:53PM +0200, David Jander wrote:
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/net/can/dev.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 22a3955..3e1160a 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -301,17 +301,21 @@ static unsigned int can_rx_fifo_inc(struct can_rx_fifo *fifo, unsigned int *val)
>  static u64 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
>  {
>  	if (fifo->inc)
> -		return ~0LLU >> (64 + fifo->low_first - fifo->high_first) << fifo->low_first;
> +		return ~0LLU >> (64 + fifo->low_first - fifo->high_first)
> +			     << fifo->low_first;

In the kernel, a line usually doesn't start with an operator. Please keep it in
the original line.

>  	else
> -		return ~0LLU >> (64 - fifo->low_first + fifo->high_first) << (fifo->high_first + 1);
> +		return ~0LLU >> (64 - fifo->low_first + fifo->high_first)
> +			     << (fifo->high_first + 1);
>  }
>  
>  static u64 can_rx_fifo_mask_high(struct can_rx_fifo *fifo)
>  {
>  	if (fifo->inc)
> -		return ~0LLU >> (64 + fifo->high_first - fifo->high_last - 1) << fifo->high_first;
> +		return ~0LLU >> (64 + fifo->high_first - fifo->high_last - 1)
> +			     << fifo->high_first;
>  	else
> -		return ~0LLU >> (64 - fifo->high_first + fifo->high_last - 1) << fifo->high_last;
> +		return ~0LLU >> (64 - fifo->high_first + fifo->high_last - 1)
> +			     << fifo->high_last;
>  }
>  
>  static int can_rx_fifo_read_napi_frame(struct can_rx_fifo *fifo, int index)

Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
