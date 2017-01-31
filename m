From: saber mesgary <smesgary@gmail.com>
Subject: cansend linux system memoryleak
Date: Tue, 31 Jan 2017 19:52:01 +0330
Message-ID: <CAJc8+a+Vu794K2wnvpKONQakt3Vn61w2Kdzj0-etYgwWpVvrHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33033 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdAaQWm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2017 11:22:42 -0500
Received: by mail-oi0-f47.google.com with SMTP id w204so217547883oiw.0
        for <linux-can@vger.kernel.org>; Tue, 31 Jan 2017 08:22:42 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,
I'm developing a software for an embedded system. I should use Can for
communicate with other devices.
When i send can messages using cansend, i have memory leak on system.

for example:
cansend can0 5A1#11.22.33.44.55.66.77.88

I don't have any running software and I can see memory leak in top,
free memory decrease and used memory increase. this problem stops when
i make can port down using:
ifconfig can0 down

Thanks
