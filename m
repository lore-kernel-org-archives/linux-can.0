From: Chris Morgan <chmorgan@gmail.com>
Subject: canfd through slcan via SocketCAN
Date: Sun, 16 Feb 2020 08:43:22 -0500
Message-ID: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk1-f178.google.com ([209.85.222.178]:38742 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBPNnZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 16 Feb 2020 08:43:25 -0500
Received: by mail-qk1-f178.google.com with SMTP id z19so13758928qkj.5
        for <linux-can@vger.kernel.org>; Sun, 16 Feb 2020 05:43:25 -0800 (PST)
Received: from ?IPv6:2601:18c:600:dc42:7d5e:e4de:7ed8:d90b? ([2601:18c:600:dc42:7d5e:e4de:7ed8:d90b])
        by smtp.gmail.com with ESMTPSA id a2sm4884280qka.75.2020.02.16.05.43.23
        for <linux-can@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2020 05:43:23 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello.

I=E2=80=99m looking at options to add canfd support to embedded =
processors via serial using slcan. I=E2=80=99d like the devices to be =
available via socketcan. Looking at the slcan driver it looks like the =
MTU is something around 30 bytes and there isn=E2=80=99t any mention of =
canfd in the driver or in the userspace utilities. Am I missing =
something with this support? If slcan doesn=E2=80=99t support canfd yet =
is anyone working to add any?

Regards,
Chris
