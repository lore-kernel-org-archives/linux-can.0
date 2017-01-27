From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: J1939: put_session BUG_ON
Date: Fri, 27 Jan 2017 09:47:55 +0100
Message-ID: <CAA7hF3yAMSbd1HM79N12vfw0VKa96nCJsMLgcOA-=Oomqv-Qpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36690 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754314AbdA0Ir4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 27 Jan 2017 03:47:56 -0500
Received: by mail-oi0-f48.google.com with SMTP id u143so153210928oif.3
        for <linux-can@vger.kernel.org>; Fri, 27 Jan 2017 00:47:56 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

Hi,

i'm using old j1939 way on a project (with modified iproute2)
and my client detect some problem when making some robustness test (weird
test and not
available test in my mind).

on the board, we have two can interface, with j1939 on, and source adress
0x4a on each.
the 2 can interace are plugged together (this is the weird stuff for me)

from an external canalyzer, we send a pgn request
18ea4a01x 0xcd 0xfe 0x00

on this, the client application wants to answer a segmented frame on both
interfaces
so on each interface we send a rts message (pgn 0xEC00) with the same SA.

nobody answer with the CTS message, and so my interface wants to send abort
message.

and at this step i have a kernel BUG in transport/put_session function
BUG_ON(!list_empty(&session->list));

Would you have an idea of what could lead to this behaviour?
What is the goal of this line code?

I've tested with and without rtpatch with the same behaviour.

Another question, on my board we have rtpatch, and so the in(interrupt
function allways return 0 (as with rtpatch interrupt are kernel threads).
Is this point can lead to some problem?

Thanks in advance for your help
Best regards
Laurent
