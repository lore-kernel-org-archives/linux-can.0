From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: Are there any netfilter modules for use with Socket CAN
Date: Sun, 26 Apr 2020 22:15:36 +0200
Message-ID: <202004262215.36557.pisa@cmp.felk.cvut.cz>
References: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgDZUro (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Apr 2020 16:47:44 -0400
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20B05C061A0F
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 13:47:43 -0700 (PDT)
In-Reply-To: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Lev R. Oshvang ." <levonshe@gmail.com>
Cc: linux-can@vger.kernel.org, Rostislav =?utf-8?q?Lisov=C3=BD?= <lisovy@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>

Dear Lev,

On Sunday 26 of April 2020 14:07:08 Lev R. Oshvang . wrote:
> >From my google search I did not find any netfilter /iptable rule which
>
> allows to filter on CAN fields,  message ID and other.
> Please point me in the right direction.

I am not sure if this can help, but Rostislav Lisovy
has implemented linux-devel/net/sched/em_canid.c
which has been merged around Linux kernel version 3.6
and is still there. It allows to classify CAN frames
for purpose of queening disciplines. There is report
with documentation how to use it

https://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

I am not sure if this can be used for netfilter.

For sure CAN Gateway allows separation of real and virtual
can network and full control on IDs which are passed.

Best wishes,
                Pavel
--
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://dce.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
