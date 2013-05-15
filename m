From: Ernast Sevo <ersevs@gmail.com>
Subject: command ip -details -statistics link show wlan0
Date: Wed, 15 May 2013 14:58:03 -0400
Message-ID: <CAOD0pe=EMt3+ymJMwT+gOUbFZN7_R8exkh36G5457O61GoV4UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:63706 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012Ab3EOS6E (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 14:58:04 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so4577880iea.3
        for <linux-can@vger.kernel.org>; Wed, 15 May 2013 11:58:03 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

 I am quite new to socket can and I had a question about the output of
the command: ip -details -statistics link show can0. When I run the
above command I get the following output:

re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0
    RX: bytes  packets  errors  dropped overrun mcast
    3956387    948121    11      0           11          0
    TX: bytes  packets  errors  dropped carrier collsns
    100        44       0       0       0       0


I see that I received 11 errors packets (all of them being rx overrun
errors) and that no packets were dropped. Does the dropped field refer
to packets lost in userspace (i.e because they weren't being read fast
enough and the socket receive buffer overflowed) or does the dropped
packet field refer to dropped packets being dropped somewhere other
than userspace?

Thanks,

Ernast
