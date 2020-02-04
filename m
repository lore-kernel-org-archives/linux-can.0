From: "Lev R. Oshvang ." <levonshe@gmail.com>
Subject: Help to set up can net interface on Dell 3200 Intel Atom
Date: Tue, 4 Feb 2020 15:07:37 +0200
Message-ID: <CAP22eLHKe=0FEoS3DfRK8Oi6k2xntCvxQPVpXhau_bnuOAs71A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-il1-f179.google.com ([209.85.166.179]:38169 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBDNHs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2020 08:07:48 -0500
Received: by mail-il1-f179.google.com with SMTP id f5so15787813ilq.5
        for <linux-can@vger.kernel.org>; Tue, 04 Feb 2020 05:07:48 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi All,

I have with DELL 3002 Edge server
It has can and can_raw drivers loaded at boot time
It does not have /boot/config.txt file

Unfortunately, I do not have kernel sources and kernel config file is
not present in /proc, so I do not know which exactly chip is on b
oard and board specs says only:

(CAN2.0 A/B/FD) 1Mbps (CAN2.0), 5Mbps (CAN-FD).


I tried to set it up but get the following error


root@5HCF902:~# ip link add dev can0 type can
RTNETLINK answers: Operation not supported


Thanks in advance.
