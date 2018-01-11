From: Yousof Ebneddin Hamidi <youebned@gmail.com>
Subject: Any thing against non-blocking socketCan?
Date: Thu, 11 Jan 2018 09:03:57 +0100
Message-ID: <CAM=RW1+MsQt=Qz6bJdokBXB3A_CRcqnVPMXeFRRtXKbJt-84xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:45032 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeAKIEA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jan 2018 03:04:00 -0500
Received: by mail-lf0-f48.google.com with SMTP id w23so1698898lfd.11
        for <linux-can@vger.kernel.org>; Thu, 11 Jan 2018 00:03:59 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

Hi

Thank you for your support.

I was trying to use signal driven socket CAN which as far as I
understood it is not a good idea. Because the correct way of doing it
is similar to reading the flags of the fd.

Just I want to check with you if it is ok to make a non-blocking
socket and reads it always and when the read was successful, the data
is being processed.
OR
I should use the socketCan exactly like what is happening in candump?

the non-blocking socketCan seems to work nicely. but I want to know
your opinion if there is something against it.

Best regards
Yousof
