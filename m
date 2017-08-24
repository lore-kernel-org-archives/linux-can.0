From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 06/14] can: af_can: rename find_rcv_list() to
 can_rcv_list_find()
Date: Thu, 24 Aug 2017 15:11:03 +0200
Message-ID: <068ceb4d-7a02-9a8a-2e1a-c4a2782310ca@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-7-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:23688 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdHXNLE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2017 09:11:04 -0400
In-Reply-To: <20170802174434.4689-7-mkl@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
> This patch add the commonly used prefix "can_" to the find_rcv_list()
> function and add the "find" to the end, as the function returns a struct
> rcv_list. This improves the overall readability of the code.

The function should be named according to it's natural function.

If you want to move it to some kind of 'can' namespace I would suggest

find_can_rcv_list()

> -		rl = find_rcv_list(&can_id, &mask, dev_rcv_lists);
> +		rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);

find_... is better to understand than can_...

And this is a local function not visible to anyone else outside of 
af_can.c .

Regards,
Oliver

