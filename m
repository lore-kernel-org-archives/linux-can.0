From: Elenita Hinds <ecathinds@gmail.com>
Subject: J1939: Unable to receive and transmit multi-frame messages
Date: Mon, 17 Feb 2020 14:49:18 -0600
Message-ID: <CAHChkrtxFyzZz2yTAOvui=-j5QA3=2_Qoe6whWe+TDzZJk4QVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lj1-f178.google.com ([209.85.208.178]:36414 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgBQUtc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Feb 2020 15:49:32 -0500
Received: by mail-lj1-f178.google.com with SMTP id r19so20363312ljg.3
        for <linux-can@vger.kernel.org>; Mon, 17 Feb 2020 12:49:31 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

Back when I was using just the J1939 branch (before it got re-written
and mainlined), I was able to receive and transmit multi-frame
messages.  Upgrading to kernel v5.4, this is no longer the case.

For the receive part, it is failing in j1939_tp_im_involved_anydir()
call, which is the first thing called by j1939_tp_recv(). The socket
is set to promiscuous mode; has no problem receiving ALL the  8-byte
long messages but fails on longer ones. There should not be any
difference with how the socket is setup as far as the message length
goes  but is there a new step needed in order to receive the
multi-frame messages as well?

The  same question applies for the transmit side.

Thanks for the help!

--elenita
