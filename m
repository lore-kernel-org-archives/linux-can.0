From: Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH v4 1/2] can: kvaser_usb: Simplify struct
 kvaser_msg_cardinfo
Date: Fri, 16 Feb 2018 16:13:34 +0100
Message-ID: <21d4c4b6-db32-e048-3109-17dd453f0a84@kvaser.com>
References: <20180216134107.9096-1-jimmyassarsson@gmail.com>
 <92aa2d7a-875e-322f-b1b9-b1a1a1c139d2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34474 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754656AbeBPPNj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 10:13:39 -0500
Received: by mail-lf0-f47.google.com with SMTP id l191so4492431lfe.1
        for <linux-can@vger.kernel.org>; Fri, 16 Feb 2018 07:13:39 -0800 (PST)
In-Reply-To: <92aa2d7a-875e-322f-b1b9-b1a1a1c139d2@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Jimmy Assarsson <jimmyassarsson@gmail.com>, linux-can@vger.kernel.org

On 2018-02-16 15:20, Marc Kleine-Budde wrote:
> On 02/16/2018 02:41 PM, Jimmy Assarsson wrote:
>> serial_number_high can be removed from the struct since it is never used in
>> the USBcan II firmware.
>>
>> Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
> 
> Applied to can.
> 
> tnx,
> Marc

I really appreciate you taking the time to help me :) Thanks!
Jimmy
