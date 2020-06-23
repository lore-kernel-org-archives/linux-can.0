From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp25xxfd: add listen-only mode
Date: Tue, 23 Jun 2020 09:40:48 +0200
Message-ID: <10e4e6f0-d400-fd7f-5c99-33637cdc8dbc@pengutronix.de>
References: <20200622122047.9494-1-dev.kurt@vandijck-laurijssen.be>
 <24a81519-9628-6626-77e6-22dbd5253954@pengutronix.de>
 <20200623051527.GE3077@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbgFWHkw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jun 2020 03:40:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83BCC061573
        for <linux-can@vger.kernel.org>; Tue, 23 Jun 2020 00:40:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jndY2-0002Yv-KO
        for linux-can@vger.kernel.org; Tue, 23 Jun 2020 09:40:50 +0200
Received: from [IPv6:2a03:f580:87bc:d400:789c:8c3:eaa5:9d1b] (unknown [IPv6:2a03:f580:87bc:d400:789c:8c3:eaa5:9d1b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EAD3851FAA5
        for <linux-can@vger.kernel.org>; Tue, 23 Jun 2020 07:40:49 +0000 (UTC)
In-Reply-To: <20200623051527.GE3077@x1.vandijck-laurijssen.be>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

On 6/23/20 7:15 AM, Kurt Van Dijck wrote:
> On ma, 22 jun 2020 15:38:03 +0200, Marc Kleine-Budde wrote:
>> On 6/22/20 2:20 PM, Kurt Van Dijck wrote:
>>> This commit enables listen-only mode, which works internally like CANFD mode.
>>
>> Does the controller distinguish between CAN-2.0 listen only and CAN-FD listen
>> only mode?
> 
> Nope, Listen-only is a 3rd mode, and from the manual, it's similar to
> CANFD mode.
>>
>> If listen only means CAN-FD...should we add a check to open() if CAN_CTRLMODE_FD
>> and CAN_CTRLMODE_LISTENONLY is both set (or unset).
> 
> The difference between CAN-FD and CAN-2.0 is in CAN-2.0, the chip will
> send error frames on CAN-FD frame.
> That looks obvious.
> In listen-only mode, no acks or error-frames are sent, so the difference
> is not really relevant in listen-only mode.

ACK

> On the host side however, in listen-only mode with no CAN_CTRLMODE_FD,
> you could find CAN-FD packets in your socket.
> I think we could improve and filter them out in software during the
> receive handler.
> If we think that is necessary.

ACK

> It would strictly be correct, but I tend to be a bit more tolerant on
> the input, and discard the difference.
> That's why I didn't add the code. and because it's usually easy to make
> mistakes and it easily becomes a monster.

ACK

>> Please compile with #define DEBUG and look in dmesg the size of the objects in
>> the mailbox. Maybe it's worth not allocating any TEF and TX mailbox and using
>> more RX instead.
> and have runtime defined sizes. I'm not convinced that this improves the
> driver. I'm sure it makes it more complex.

The driver already has different sized RX and TX objects depending on CAN-2.0
and CAN-FD modes. (8 vs. 64 bytes of data). And it uses 8 TX and 32 RX object
for CAN-2.0, while it's 4 TX and 16 RX for CAN-FD.

But you're right, optimization for listen only can be done later.

>> We have to convert the driver from using a bit mask to modulo to get from the
>> tail and head to the actual index inside the RAM.
> 
> I confess not having studied the chip nor your driver in that detail.
> Your plan sounds good. I would not postpone submitting the driver for
> improvements like that, given that other approaches exists in vendor
> kernels.
> It sounds like a next iteration to me.

ACK. Currently the driver only supports a power-of-2 for RX and TX mailboxes.
With converting from a mask to a modulo, this would increase the RX mailboxes
from 16 to 22 in the CAN-FD mode.

I've added your patch with minor modifications to the series, mostly changing
the order of CAN_CTRLMODE_LISTENONLY and CAN_CTRLMODE_FD.

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
