From: Lars Susaas <larssusaas@gmail.com>
Subject: Re: Setting CAN FD data bitrate with libsocketcan
Date: Thu, 14 Sep 2017 21:41:57 +0200
Message-ID: <CALHGA=tafdy24Bz8uahCH5Ht+vGRJ1w1LyF1_STw4kK1zgX10Q@mail.gmail.com>
References: <68f4de55-c98a-3081-a2fe-084e01df73b8@gmx.de> <CALHGA=tEn1r1XPW6hCSA0n_cHb-XVhZA9yT0e6FHVqP+vz0G9A@mail.gmail.com>
 <5f0be713-a0e0-aadf-dad4-72a92ab31c4d@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:56289 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdINTl7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Sep 2017 15:41:59 -0400
Received: by mail-vk0-f53.google.com with SMTP id i1so163378vke.12
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2017 12:41:58 -0700 (PDT)
In-Reply-To: <5f0be713-a0e0-aadf-dad4-72a92ab31c4d@gmx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Andr=C3=A9_Hartmann?= <aha_1980@gmx.de>
Cc: linux-can@vger.kernel.org

Hi Andr=C3=A9,


On Tue, Sep 12, 2017 at 9:26 PM, Andr=C3=A9 Hartmann <aha_1980@gmx.de> wrot=
e:
> I will definitely have a look this weekend. Have you considered upstreami=
ng
> your changes back to libsocketcan?

Very nice if you have the time to check it out.
I definitely want to upstream, but i think it needs more testing and
maybe a cleanup of comments and code before that time.

My plan was first to get my changes to canFestival done and then turn
my focus to libsocketcan, but if other people have the need for
libsocketcan with can FD support i that will change :)

Best regards
Lars
