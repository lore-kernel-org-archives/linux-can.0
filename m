From: Doug Zobel <restart334@gmail.com>
Subject: Restricting permissions to CAN sockets
Date: Mon, 8 May 2017 10:20:25 -0500
Message-ID: <CAL26GymsvEouJWpLDRi25N9HNDN2D=XfNppZPhFdqv_VWD5UPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35458 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755594AbdEHPU0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 May 2017 11:20:26 -0400
Received: by mail-qk0-f178.google.com with SMTP id a72so38566082qkj.2
        for <linux-can@vger.kernel.org>; Mon, 08 May 2017 08:20:26 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Is there a way to restrict permissions to the socket interface
provided by socketcan?  Perhaps something like iptables but for CAN?
I'd like to restrict access to the CAN bus to a single application on
the system.
