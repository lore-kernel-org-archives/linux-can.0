From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: FYI: feature request for Qt's support for SocketCAN
Date: Wed, 8 May 2013 13:52:35 +0200
Message-ID: <CAGm1_kufhXUa6c3HD=y6axzzjd7zRT=XAYnyuCc7427r+_cRhg@mail.gmail.com>
References: <CAGm1_kvp5v8Zh2JVzYx5onTMfTC6Z2qs0eN6744VcwBK9kpmrQ@mail.gmail.com>
 <201305081322.54162.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39154 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab3EHLw4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2013 07:52:56 -0400
Received: by mail-bk0-f46.google.com with SMTP id w5so836571bku.33
        for <linux-can@vger.kernel.org>; Wed, 08 May 2013 04:52:55 -0700 (PDT)
In-Reply-To: <201305081322.54162.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Fanda Vacek <fanda.vacek@volny.cz>

Dear Pavel,

On Wed, May 8, 2013 at 1:22 PM, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
> Dear Yegor,
>
> On Wednesday 08 May 2013 12:24:55 Yegor Yefremov wrote:
>> Here the ticket:
>>
>> https://bugreports.qt-project.org/browse/QTBUG-31058
>
> I am not sure if some of our effort can be reused,
> but we have implemented QT based CAN/CANopen monitor
> and test tool during more university thesis and semester
> works projects.
>
> It is part of the OrtCAN repository.
>
> http://ortcan.sourceforge.net/qcanalyzer/
>
> QCANanalyzer provides infrastructure which can receive
> and send CAN messages over SocketCAN and LinCAN drivers API
> or remote connection to the CAN interface equipped target over
> TCP/IP is possible. The later version can connect even to the
> CANopen access provider (CANblaster in our case) which
> can access CANopen object dictionary again through both
> SockedCAN and LinCAN interfaces.
>
> The solution is not perfect (yet) but quite significant time
> has been laid to build basic infrastructure.
>
> If you find reply usesfull, please, place it as the follow up
> in the RFE.

Will do. Do you have some students willing to implement this as their
Bachelor/Master Thesis?

I found this thread from 2009:
http://www.qtforum.de/forum/viewtopic.php?t=8852 in German. It seems,
that many devs are wanting such functionality.

Yegor
