From: Lars Susaas <larssusaas@gmail.com>
Subject: Re: Setting CAN FD data bitrate with libsocketcan
Date: Sun, 10 Sep 2017 13:25:59 +0200
Message-ID: <CALHGA=tEn1r1XPW6hCSA0n_cHb-XVhZA9yT0e6FHVqP+vz0G9A@mail.gmail.com>
References: <68f4de55-c98a-3081-a2fe-084e01df73b8@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36366 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdIJL0A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 10 Sep 2017 07:26:00 -0400
Received: by mail-vk0-f42.google.com with SMTP id v203so7380205vkv.3
        for <linux-can@vger.kernel.org>; Sun, 10 Sep 2017 04:26:00 -0700 (PDT)
In-Reply-To: <68f4de55-c98a-3081-a2fe-084e01df73b8@gmx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andr=C3=A9_Hartmann?= <aha_1980@gmx.de>
Cc: linux-can@vger.kernel.org

> However, I did not find a possibility to set the CAN FD data bitrate.
> Is there a way or does no such function exist yet? If it does not exist, are
> there plans to support it?

Hi,

Was looking for the same thing a little while back.
Did not find it, so i made some changes to libsocketcan as part of my
work on canFestival (canOpen stack)

You can check out work here:
https://bitbucket.org/nimrof/canfestival-3-asc/src/53f18ae80f39901b61ddf6d04b9358893ac518db/drivers/can_socket?at=canfd

Just copy the following files into libsocketcan:
can_netlink.h
libsocketcan.c
libsocketcan.h

Its yet testet that well, so may contain bugs.

To set the databaudrate you have to set baudrate first with
'can_set_bitrate' then you can use 'can_set_data_bitrate'.

Feedback welcome

best regards
Lars
