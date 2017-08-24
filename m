From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 12/14] can: introduce CAN midlayer private and allocate it
 automatically
Date: Thu, 24 Aug 2017 15:51:14 +0200
Message-ID: <baa3ade5-0d0d-d504-17a7-7f24c0866219@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-13-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:14945 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752220AbdHXNvQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:51:16 -0400
In-Reply-To: <20170802174434.4689-13-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Already commented this:

On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:

>   include/linux/can/can-ml.h | 23 +++++++++++++++++++++++

Need another name.


> diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
> new file mode 100644
> index 000000000000..2786b04251ea
> --- /dev/null
> +++ b/include/linux/can/can-ml.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (C) 2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#ifndef CAN_ML_H
> +#define CAN_ML_H
> +

Need some documentation about this weird include.

> +#include "../../net/can/af_can.h"
> +
> +struct can_ml_priv {
> +	struct can_dev_rcv_lists dev_rcv_lists;
> +};
> +
> +#endif /* CAN_ML_H */
> 

Regards,
Oliver
