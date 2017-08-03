From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 3 Aug 2017 07:03:17 +0200
Message-ID: <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:31835 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdHCFDY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Aug 2017 01:03:24 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

Hello Marc,

On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> Hello,
> 
> while reviwing and cleaning up the j1939 stack I digged a bit deeper into
> af_can and raw implementation.
> 
> The first patch adds a missing error check and will probably go into -stable.

ack.
I'm currently working on an additional missing check for register of 
netdev notifier ...

> Patches 2-8 change some struct and variable names, making the code more
> readble, IMHO.

I'm not convinced on this part.
Where have you seen, that naming variables identical to the structs is 
common or better readable?

> Patch 9 removed the need for struct raw_sock::ifindex from the raw sock, by
> using struct sock::sk_bound_dev_if from the generic socket structure.

Have a bad feeling on that - will comment later.

> Patch 10: Checks if can_family is AF_CAN in raw's bind function.
fine.

> Patch 11: Cleans up the newly integrated CAN net namespace support.

need to review

> Patches 13-14: Where to put the per device protocol specific memory? af_can
> allocated it's memory during a netdev_notifier call, life cycle proves to be
> rather complicated (see remove_on_zero_entries, etc...), adding the j1939
> memory makes it even more compilcated. So I decided to allocate the memory
> during the allocation if net_device. And this seems to work. More details in
> the individual patches.

'Seems to work' sounds frightening. There was a racy reason to have that 
implementation as-is. Although this approach sounds interesting. Need to 
review too.

I'm currently pretty busy at work.
Please to not push these things without my ACK (as we had it with the 
namespace support where I crashed my easter holiday to fix/implement all 
the missing stuff to fit the merge window).

Thanks,
Oliver

