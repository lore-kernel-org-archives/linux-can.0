From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Setting CAN FD data bitrate with libsocketcan
Date: Sat, 9 Sep 2017 20:08:02 +0200
Message-ID: <68f4de55-c98a-3081-a2fe-084e01df73b8@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:52139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdIISIC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 9 Sep 2017 14:08:02 -0400
Received: from [192.168.2.107] ([46.90.120.169]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwJFG-1dNlqJ1Dig-0181WJ for
 <linux-can@vger.kernel.org>; Sat, 09 Sep 2017 20:08:01 +0200
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

libsocketcan [1] allows to set the CAN bus bitrate from an application 
with can_set_bitrate().

However, I did not find a possibility to set the CAN FD data bitrate.
Is there a way or does no such function exist yet? If it does not exist, 
are there plans to support it?

Thanks in advance,
André

[1] https://git.pengutronix.de/cgit/tools/libsocketcan/
