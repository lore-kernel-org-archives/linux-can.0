From: "Bremer Henning" <h.bremer@tu-braunschweig.de>
Subject: Measuring latency of CAN messages in SocketCAN
Date: Thu, 06 Oct 2016 10:37:57 +0200
Message-ID: <web-11102383@rz.tu-bs.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailfront2.rz.tu-bs.de ([134.169.12.133]:49052 "EHLO tu-bs.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965141AbcJFJiI (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 6 Oct 2016 05:38:08 -0400
Received: from [194.31.198.72] (account y0058345@tu-braunschweig.de)
  by tu-braunschweig.de (CommuniGate Pro WEBUSER 6.1.11)
  with HTTP id 11102239 for linux-can@vger.kernel.org; Thu, 06 Oct 2016 10:37:57 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I am using SocketCAN on a Beaglebone Black with Debian (Wheezy). I 
have my Beaglebone plugged in a CAN-Network of 5 microcontrollers. Now 
I would like to measure the time one message needs to be delivered 
from my beaglebone to another microcontroller via CAN depending on the 
priority (ID) of the sent message.
Is there a way to do this in SocketCAN?

Thank you!

Best regards
Henning
