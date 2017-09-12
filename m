From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: Setting CAN FD data bitrate with libsocketcan
Date: Tue, 12 Sep 2017 21:26:24 +0200
Message-ID: <5f0be713-a0e0-aadf-dad4-72a92ab31c4d@gmx.de>
References: <68f4de55-c98a-3081-a2fe-084e01df73b8@gmx.de>
 <CALHGA=tEn1r1XPW6hCSA0n_cHb-XVhZA9yT0e6FHVqP+vz0G9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:58705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdILT01 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 12 Sep 2017 15:26:27 -0400
In-Reply-To: <CALHGA=tEn1r1XPW6hCSA0n_cHb-XVhZA9yT0e6FHVqP+vz0G9A@mail.gmail.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lars Susaas <larssusaas@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Lars,

thanks for your answer.

Am 10.09.2017 um 13:25 schrieb Lars Susaas:
>> However, I did not find a possibility to set the CAN FD data bitrate.
>> Is there a way or does no such function exist yet? If it does not exist, are
>> there plans to support it?
> 
> Hi,
> 
> Was looking for the same thing a little while back.
> Did not find it, so i made some changes to libsocketcan as part of my
> work on canFestival (canOpen stack)

Ah Ok, I like to use it for QtSerialBus [1]. Therefore I'm a bit limited 
with including 3rd party libraries (licenses and so) and we decided to 
use the system-wide libsocketcan. Which now turns out to miss (at least) 
one feature.

> You can check out work here:
> https://bitbucket.org/nimrof/canfestival-3-asc/src/53f18ae80f39901b61ddf6d04b9358893ac518db/drivers/can_socket?at=canfd
> 
> Just copy the following files into libsocketcan:
> can_netlink.h
> libsocketcan.c
> libsocketcan.h
> 
> Its yet testet that well, so may contain bugs.
> 
> To set the databaudrate you have to set baudrate first with
> 'can_set_bitrate' then you can use 'can_set_data_bitrate'.

I will definitely have a look this weekend. Have you considered 
upstreaming your changes back to libsocketcan?

Best regards,
André

[1] http://code.qt.io/cgit/qt/qtserialbus.git/
