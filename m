From: Pavel Kirienko <pavel.kirienko.list@gmail.com>
Subject: TX timestamping
Date: Thu, 20 Mar 2014 20:28:08 +0400
Message-ID: <CAGfq0uugZi8+BrF_D1cLXjVZ9nePuKeX2fQ5c9vLGRiYQO0RQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:36477 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041AbaCTQ2J (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Mar 2014 12:28:09 -0400
Received: by mail-ve0-f170.google.com with SMTP id pa12so1227741veb.1
        for <linux-can@vger.kernel.org>; Thu, 20 Mar 2014 09:28:08 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi linux-can,

What are my options to get the hardware TX timestamp of an outgoing
CAN frame? I couldn't find complete manual for that, but here's what I
googled so far:

1. Use generic socket timestamping, as described in the network man
(http://os1a.cs.columbia.edu/lxr/source/Documentation/networking/timestamping.txt?a=x86);

2. Read my own frames back through CAN_RAW_RECV_OWN_MSGS, supposedly
RX timestamps of the loopbacked frames will be the same as their TX
timestamps.

Are these the correct methods?

Thanks in advance,
Pavel.
