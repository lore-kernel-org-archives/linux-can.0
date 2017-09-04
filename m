From: =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Subject: Newbie question on which kernel repository a patch should be based
Date: Mon, 4 Sep 2017 11:51:29 +0200
Message-ID: <c24071cd-52b5-1544-1521-e42a777acaee@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxp01.htp-tel.de ([212.59.41.8]:43841 "EHLO mxpout01.htp-tel.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753422AbdIDKCC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 4 Sep 2017 06:02:02 -0400
Received: from mxpin02.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout01.htp-tel.de with ESMTPS id v849pX7L010064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-can@vger.kernel.org>; Mon, 4 Sep 2017 11:51:33 +0200 (CEST)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin02.htp-tel.de with ESMTPS id v849pW5v028719
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-can@vger.kernel.org>; Mon, 4 Sep 2017 11:51:33 +0200 (CEST)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

I would like to provide a small bug fix patch for the esd_usb2.c
SocketCAN driver for the esd CAN-USB/2 CAN device.

Should I base the patch on the linux-can or against the linux-can-next
git repository?

Also can you give me some advice whom I should include in the CC: list
of the patch email?

Thanks in advance for your assistance.

Best regards,
    Stefan Mätje

