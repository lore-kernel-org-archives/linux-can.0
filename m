From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 1/2] net, can, ifi: fix "write buffer full" error
Date: Thu, 8 Feb 2018 20:22:54 +0100
Message-ID: <dfae1bda-9ccd-6a48-95f9-e061c1bd3828@denx.de>
References: <20180208064748.17985-1-hs@denx.de>
 <59322f7d-4207-a5a4-89b5-dff1634e4183@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:49856 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHUJl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 15:09:41 -0500
In-Reply-To: <59322f7d-4207-a5a4-89b5-dff1634e4183@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Heiko Schocher <hs@denx.de>, linux-can@vger.kernel.org
Cc: Markus Marb <markus@marb.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

On 02/08/2018 03:46 PM, Marc Kleine-Budde wrote:
> On 02/08/2018 07:47 AM, Heiko Schocher wrote:
>> the driver reads in the ISR first the IRQpending register,
>> and clears after that in a write *all* bits in it.
>>
>> It could happen that the isr register raise bits between
>> this 2 register accesses, which leads in lost bits ...
>>
>> In case it clears "TX message sent successfully", the driver
>> never sends any Tx data, and buffers to userspace run over.
>>
>> Fixed this:
>> clear only the bits in the IRQpending register, the
>> driver had read.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Applied both to linux-can.

Can you also apply them to stable, so they get into 4.9.x etc ?

Thanks!

-- 
Best regards,
Marek Vasut
