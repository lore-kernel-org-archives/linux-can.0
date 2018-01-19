From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: j1939 ACL
Date: Fri, 19 Jan 2018 09:49:34 -0800
Message-ID: <CANGgnMauq7P1JbOF0jRksC1whJF9u4Cu=AuMVDoK6-wVEdgGSw@mail.gmail.com>
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <53295b55-bf98-4a59-08d2-ce19516e9084@smile.fr> <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:44145 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932305AbeASRt4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Jan 2018 12:49:56 -0500
Received: by mail-yw0-f172.google.com with SMTP id x62so919366ywg.11
        for <linux-can@vger.kernel.org>; Fri, 19 Jan 2018 09:49:55 -0800 (PST)
In-Reply-To: <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: =?UTF-8?Q?R=C3=A9my_Dziemiaszko?= <remy.dziemiaszko@smile.fr>, Oleksij Rempel <ore@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

On Fri, Jan 19, 2018 at 3:14 AM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> Hi
>
> thank you all!
>
> after playing with jacd i have a bit more questions:
> - do any one already using kernel j1939? any suggestions or request for
> changes?

We've got a userspace version which predates the kernel version.  At
this point, it's too hard for us to change.

> - is jacd used for productions systems? is it enough to have it in the
> usersapce? timing issues?

It's been a couple years since I read the relevant parts of the
standard in detail, but IIRC, you are supposed to send out a RQST for
the ACL to the source address you are trying to claim.  You then wait
1.25 seconds and send out your ACL.  You then have the address if
nobody sends back an ACL within 0.25 seconds.

Those timeouts are very long.  Userspace can hit them without any issue.

Austin
